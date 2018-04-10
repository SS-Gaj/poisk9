c1lass TapesController < ApplicationController
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

    # https://www.bloomberg.com/crypto
    my_site = 2   # "Bloomberg"
    my_url = 'https://www.bloomberg.com'
    my_section = [
      '/crypto'
      ]
    my_section.each do |sec|
      rss_new(my_url, sec, my_site)
    end

    # https://www.bloomberg.com/crypto
    my_site = 3   # "Сегодня"
    my_url = 'https://www.segodnya.ua'
    my_section = [
      '/economics.html'
      ]
    my_section.each do |sec|
      rss_seg(my_url, sec, my_site)
    end

    redirect_to tapes_path	#tapes#index
   
  end #new

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
      end #if
    end   #do
  end     #def

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
      end #if
    end   #do
  end     #def

  # DELETE /tapes/1
  # DELETE /tapes/1.json
  def destroy
    @tape.destroy
    respond_to do |format|
      format.html { redirect_to tapes_url, notice: 'Tape was successfully destroyed.' }
      format.json { head :no_content }
    end #do
  end   #def

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
        need_art = need_tag(art, my_site)
        
        if need_art == true
          if my_site == 1 
            d1 = /20\d\d\/\d\d\/\d+/.match(art.href)            
            comments_tape = d1.to_s
            date_tape = Date.parse(d1.to_s)
            url_tape = my_url + art.href()
            head_tape = art.text()
          elsif my_site == 2
            d1 = /20\d\d-\d\d-\d+/.match(art.href)
            comments_tape = d1.to_s
#            byebug
            date_tape = Date.parse(d1.to_s)
            url_tape = my_url + art.href()
            head_tape = art.text()
          end #if my_site == 1 
  #        byebug
          tape = Tape.new(tp_site: my_site, 
                          tp_status: isx_status, 
                          tp_url: url_tape, 
                          tp_article: head_tape, 
                          tp_tag: @tag_art, 
                          tp_date: date_tape, 
                          tp_comments: comments_tape)
          tape.save
        end   #if need_art == true      
#        byebug
      end # each
    end #def rss_new
    
    def rss_seg(my_url, my_section, my_site)   #serch links site
    page = @agent.get(my_url + my_section)
    isx_status = 0
    link_krypto = page.link_with(text: /Криптовалюта/, href: /kriptovalyuta/)
    page = link_krypto.click
    all_links = page.links()
    doc = Nokogiri::HTML(page.body)                           # читаю в Nokogiri ...
    div_block_article = doc.css("div[class=content-blocks]")  # ... и выбираю весь блок;
    all_links = div_block_article.css("a")
      all_links.each do |art|
        need_art = need_tag(art, my_site)
        if need_art == true
          if my_site == 1 
            d1 = /20\d\d\/\d\d\/\d+/.match(art.href)
            date_tape = Date.parse(d1.to_s)
            url_tape = my_url + art.href()
          elsif my_site == 2
            d1 = /20\d\d-\d\d-\d+/.match(art.href)
#            byebug
            date_tape = Date.parse(d1.to_s)
            url_tape = art.href()
          elsif my_site == 3
            my_href = art["href"]
            head_tape = art.css("h3").text()
            d2 = art.css("span[class=date]").text()
            d1 = date_rus(d2)
            date_tape = DateTime.parse(d1)
            comments_tape = d1.to_s
            url_tape = my_url + my_href
   	        if art["href"] =~ /fintech/
	            @tag_art = 'FinTech'
	          elsif art["href"] =~ /blockchain/
	            @tag_art = 'blockChain'
	          elsif art["href"] =~ /bitcoin/  #bitkoina
	            @tag_art = 'bitcoin'
	          elsif art["href"] =~ /bitkoin/  
	            @tag_art = 'bitcoin'
	          elsif art["href"] =~ /crypto/
	            @tag_art = 'krypto'
	          else
	          end   #if art["href"] =~ /fintech/
          end        #my_site == 1
#         byebug
          tape = Tape.new(tp_site: my_site, 
                          tp_status: isx_status, 
                          tp_url: url_tape, 
                          tp_article: head_tape, 
                          tp_tag: @tag_art, 
                          tp_date: date_tape, 
                          tp_comments: comments_tape)
          tape.save
        end   #if need_art == true      
#        byebug
      end # each
    end #def rss_seg

    def need_tag(art, my_site)
      need_art = false
      @tag_art = " "
      if my_site == 1 #"Економ.правда"
	      if art.text() =~ /(Б|б)іткоїн/
	        need_art = true
	        @tag_art = 'bitcoin'
	      elsif art.text() =~ /(B|b)itcoin/
	        need_art = true
	        @tag_art = 'bitcoin'
	      elsif art.text() =~ /(К|к)рипто/
	        need_art = true
	        @tag_art = 'krypto'
	      elsif art.text() =~ /(Ф|ф)ін(Т|т)ех/
	        need_art = true
	        @tag_art = 'FinTech'
	      elsif art.text() =~ /(Б|б)локчейн/
	        need_art = true
	        @tag_art = 'blockChain'
	      elsif art.text() =~ /(П|п)латіжн.+систем/
	        need_art = true
	        @tag_art = 'PaySys'
	      else
	      end   #if art.text() =~ /(Б|біткоїн)/
	    elsif my_site == 2  # Bloomberg
	      if art.href() =~ /articles/
          need_art = true
	        if art.href() =~ /bitcoin/
	          @tag_art = 'bitcoin'
	        elsif art.href() =~ /fintech/
	          @tag_art = 'FinTech'
	        elsif art.href() =~ /blockchain/
	          @tag_art = 'blockChain'
	        elsif art.href() =~ /crypto/
	          @tag_art = 'krypto'
	        else
	        end   #if art.href() =~ /bitcoin/
	      else
	        need_art = false
	      end #art.href() =~ /articles/
	    elsif my_site == 3  # "Сегодня"
          need_art = true
	    end   # my_site == 3  # "Сегодня"
	    return need_art
    end #def
    
    def date_rus(d2)
      if d2 =~ /Сегодня/
        d2.gsub!(/Сегодня/, Date.today.to_s)
      elsif d2 =~ /(М|м)арта/
        d2.gsub!(/(М|м)арта/, 'MAR')
      elsif d2 =~ /(А|а)преля/
        d2.gsub!(/(А|а)преля/, 'APR')
      end  # if d2 =~ /Сегодня/
      return d2
    end #    def date_rus(d2)

end
