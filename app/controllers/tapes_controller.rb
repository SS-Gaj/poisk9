class TapesController < ApplicationController
  before_action :set_tape, only: [:show, :edit, :update, :destroy]

  # GET /tapes
  # GET /tapes.json
  def index
    @tapes = Tape.all
  end

  # GET /tapes/1
  # GET /tapes/1.json
  def show
  end

  # GET /tapes/new
  def new
#    @tape = Tape.new
    @agent = Mechanize.new
    my_site = 1   # "Економична правда"
    # для отладки жестко задаю один раздел 
    
    my_url = 'https://www.epravda.com.ua'
    my_section = [
      '/tags/bitcoin/', 
      '/tags/59a7b3ae95270/', 
      '/tags/59b0191ec5009/', 
      '/news/', 
      '/tags/finansi/', 
      '/tags/it-tekhnologiji/'
      ]
    my_section.each do |sec|
      rss_new(my_url, sec, my_site)
    end
    redirect_to tapes_path	#tapes#index
   
  end

  # GET /tapes/1/edit
  def edit
  end

  # POST /tapes
  # POST /tapes.json
  def create
    @tape = Tape.new(tape_params)

    respond_to do |format|
      if @tape.save
        format.html { redirect_to @tape, notice: 'Tape was successfully created.' }
        format.json { render :show, status: :created, location: @tape }
      else
        format.html { render :new }
        format.json { render json: @tape.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /tapes/1
  # PATCH/PUT /tapes/1.json
  def update
    respond_to do |format|
      if @tape.update(tape_params)
        format.html { redirect_to @tape, notice: 'Tape was successfully updated.' }
        format.json { render :show, status: :ok, location: @tape }
      else
        format.html { render :edit }
        format.json { render json: @tape.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /tapes/1
  # DELETE /tapes/1.json
  def destroy
    @tape.destroy
    respond_to do |format|
      format.html { redirect_to tapes_url, notice: 'Tape was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tape
      @tape = Tape.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def tape_params
      params.require(:tape).permit(:tp_site, :tp_date, :tp_article, :tp_url, :tp_status, :tp_tag, :tp_comments)
    end
    
    def rss_new(my_url, my_section, my_site)   #serch links site
    page = @agent.get(my_url + my_section)
    isx_status = 0
    #links_site = page.links_with(text: /(крипто)|(біткоїн)|(фінтех)|(блокчейн)|(Bitcoin)|(платіжн.+систем)/)
#    links_site = page.links_with(text: /itcoin/)
    all_links = page.links()

      all_links.each do |art|
            need_art = false
            tag_art = " "
	    if art.text() =~ /(Б|б)іткоїн/
	      need_art = true
	      tag_art = 'bitcoin'
	    elsif art.text() =~ /(B|b)itcoin/
	      need_art = true
	      tag_art = 'bitcoin'
	    elsif art.text() =~ /(К|к)рипто/
	      need_art = true
	      tag_art = 'krypto'
	    elsif art.text() =~ /(Ф|ф)ін(Т|т)ех/
	      need_art = true
	      tag_art = 'FinTech'
	    elsif art.text() =~ /(Б|б)локчейн/
	      need_art = true
	      tag_art = 'blockChain'
	    elsif art.text() =~ /(П|п)латіжн.+систем/
	      need_art = true
	      tag_art = 'PaySys'
	    else
	    end   #if art.text() =~ /(Б|біткоїн)/

      if need_art == true      
        d1 = /20\d\d\/\d\d\/\d+/.match(art.href)
#        byebug
        tape = Tape.new(tp_site: my_site, 
                        tp_status: isx_status, 
                        tp_url: my_url + art.href(), 
                        tp_article: art.text(), 
                        tp_tag: tag_art, 
                        tp_date: Date.parse(d1.to_s), 
                        tp_comments: d1)
        tape.save
      end   #if need_art == true      
#        byebug
      end # each
    end #def rss_new
end
