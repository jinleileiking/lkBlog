# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all
  helper_method :current_user_session, :current_user
  filter_parameter_logging :password, :password_confirmation
  before_filter :find_all_pages

  def getBookCollection()
    url = 'http://api.douban.com/people/jinleileiking/collection?cat=book&status=read&max-results=100'
    #    Net::HTTP.version_1_2
    #    open(url)do|http|
    #      atom = http.read

    atom = Net::HTTP.get(URI(url))

    @table = []
    doc=REXML::Document.new(atom)
    
    tmp = 0
    doc.elements.each("//entry/db:subject/title") do |e|
      #      gbk = to_gbk(e.text)
      #      p gbk
      #      Iconv.iconv("UTF-8//IGNORE","GB2312//IGNORE",e.text)
      @table[tmp] = {:title => e.text}
      tmp = tmp +1
    end

    tmp = 0
    doc.elements.each("//entry/db:subject/link") do |e|
      if e.attributes["rel"] == "alternate"
        @table[tmp] = @table[tmp].merge({:href => e.attributes["href"]})
        tmp = tmp +1
      end
    end
    return @table
  end

  def getMovieCollection()
    url = 'http://api.douban.com/people/jinleileiking/collection?cat=movie&status=watched&max-results=100'
    #    Net::HTTP.version_1_2
    #    open(url)do|http|
    #      atom = http.read

    atom = Net::HTTP.get(URI(url))

    @table = []
    doc=REXML::Document.new(atom)

    tmp = 0
    doc.elements.each("//entry/db:subject/title") do |e|
      #      gbk = to_gbk(e.text)
      #      p gbk
      #      Iconv.iconv("UTF-8//IGNORE","GB2312//IGNORE",e.text)
      @table[tmp] = {:title => e.text}
      tmp = tmp +1
    end

    tmp = 0
    doc.elements.each("//entry/db:subject/link") do |e|
      if e.attributes["rel"] == "alternate"
        @table[tmp] = @table[tmp].merge({:href => e.attributes["href"]})
        tmp = tmp +1
      end
    end
    return @table
  end

  def find_all_pages
    @page_all = Page.all
  end
  
  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end
    
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.record
  end
    
  def require_user
    unless current_user
      return_to_index("请登录")
      return false
    end
  end

  def require_no_user
    if current_user
      return_to_index("请注销")
      return false
    end
  end
    

  def return_to_index(msg = nil)
    flash[:notice] = msg if msg
    redirect_to articles_url
  end

end
