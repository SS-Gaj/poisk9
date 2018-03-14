class BandsController < ApplicationController
  before_action :set_band, only: [:show, :edit, :update, :destroy]

  # GET /bands
  # GET /bands.json
  def index
    @bands = Band.all
  end

  # GET /bands/1
  # GET /bands/1.json
  def show
  end

  # GET /bands/new
  def new
    agent = Mechanize.new
    str_search = "фондовые биржи"
    num_search = 1
    num_page = 1
    page = agent.get('http://google.com/')
    google_form = page.form('f')
    google_form.q = str_search
    google_form.ie = 'windows-1251'
    page = agent.submit(google_form)
    num_page = rss_new(page, num_search, num_page)
    link_next = page.links.find { |l| l.text =~ /Уперед/ }
    for i in [1..10] do
      break if link_next == nil
      page = link_next.click
      num_page = rss_new(page, num_search, num_page)
      link_next = page.links.find { |l| l.text =~ /Уперед/ }
#      i += 1
    end  
    redirect_to bands_path	#bands#index
  end

  # GET /bands/1/edit
  def edit
  end

  # POST /bands
  # POST /bands.json
  def create
    @band = Band.new(band_params)

    respond_to do |format|
      if @band.save
        format.html { redirect_to @band, notice: 'Band was successfully created.' }
        format.json { render :show, status: :created, location: @band }
      else
        format.html { render :new }
        format.json { render json: @band.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bands/1
  # PATCH/PUT /bands/1.json
  def update
    respond_to do |format|
      if @band.update(band_params)
        format.html { redirect_to @band, notice: 'Band was successfully updated.' }
        format.json { render :show, status: :ok, location: @band }
      else
        format.html { render :edit }
        format.json { render json: @band.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bands/1
  # DELETE /bands/1.json
  def destroy
    @band.destroy
    respond_to do |format|
      format.html { redirect_to bands_url, notice: 'Band was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_band
      @band = Band.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def band_params
      params.require(:band).permit(:bn_head, :bn_url, :bn_anonce, :bn_tema, :bn_rang, :bn_coment)
    end
    
    def rss_new(page, tema, num_page)   #skrab(words)
      doc = Nokogiri::HTML(page.body)
      div_cite = doc.css("cite")
      div_text = []
      div_cite.each do |cite|
        div_text.push(cite.text.strip)
      end
      div_uri = []
      div_text.each do |uri|
#        byebug if num_page>1
        if uri.class == String
          unless uri !~ /\A(https?:\/\/)*[^\/]+\//    #/\A[^\/]+\//
            id_name = /\A(https?:\/\/)*[^\/]+\//.match(uri)    #/\A[^\/]+\//.match(uri)
          else
            id_name = uri
          end
          div_uri.push(id_name.to_s)
        end #if uri.class == String
#        byebug      
      end
      div_uri.each do |rec|
        band = Band.new(bn_url: rec, bn_tema: tema)
        band.save
      end
#           byebug
      return num_page += 1
    end
end
