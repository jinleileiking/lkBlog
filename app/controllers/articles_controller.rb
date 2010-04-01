class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.xml
  #  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update, :destroy, :new, :create]
  before_filter :get_books, :get_movies
  
  uses_tiny_mce( :options => {
      :theme => 'advanced',  # 皮肤
      :language => 'zh',  # 中文界面
      :convert_urls => false, # 不转换路径，否则在插入图片或头像时，会转成相对路径，容易导致路径错乱。
      :theme_advanced_toolbar_location => "top",  # 工具条在上面
      :theme_advanced_toolbar_align => "left",
      :theme_advanced_resizing => true,  # 似乎不好使
      :theme_advanced_resize_horizontal => false,
      :paste_auto_cleanup_on_paste => true,
      # 工具条上的按钮布局
      :theme_advanced_buttons1 => %w{formatselect fontselect fontsizeselect forecolor backcolor bold italic underline strikethrough sub sup removeformat},
      :theme_advanced_buttons2 => %w{undo redo cut copy paste separator justifyleft justifycenter justifyright separator indent outdent separator bullist numlist separator link unlink image media emotions separator table separator fullscreen},
      :theme_advanced_buttons3 => [],
      # 字体列表中显示的字体
      :theme_advanced_fonts => %w{宋体=宋体;黑体=黑体;仿宋=仿宋;楷体=楷体;隶书=隶书;幼圆=幼圆;Andale Mono=andale mono,times;Arial=arial,helvetica,sans-serif;Arial Black=arial black,avant garde;Book Antiqua=book antiqua,palatino;Comic Sans MS=comic sans ms,sans-serif;Courier New=courier new,courier;Georgia=georgia,palatino;Helvetica=helvetica;Impact=impact,chicago;Symbol=symbol;Tahoma=tahoma,arial,helvetica,sans-serif;Terminal=terminal,monaco;Times New Roman=times new roman,times;Trebuchet MS=trebuchet ms,geneva;Verdana=verdana,geneva;Webdings=webdings;Wingdings=wingdings,zapf dingbats}, # 字体
      # :force_br_newlines => true, # 此选项强制编辑器将段落符号(P)替换成换行符(BR)。不建议用：ff下不好使，用了此选项后，输入内容的居中、清单或编号都被破坏。
      :plugins => %w{contextmenu paste media emotions table fullscreen}},
    :only => [:new, :edit, :show, :index, :create, :update])  # tiny_mce考虑的非常贴心，这里是限定哪些action中起用

  def get_books
    @books = getBookCollection()
  end

  def get_movies
    @movies = getMovieCollection()
  end

  def index
    @articles = Article.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @articles }
    end
  end

  # GET /articles/1
  # GET /articles/1.xml
  def show
    @article = Article.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/new
  # GET /articles/new.xml
  def new
    @article = Article.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @article }
    end
  end

  # GET /articles/1/edit
  def edit

    @article = Article.find(params[:id])
  end

  # POST /articles
  # POST /articles.xml
  def create

    if params[:article][:isShare] == "1"
      params[:article][:isShare] = true
    else
      params[:article][:isShare] = false
    end
    #    @article = Article.new(params[:article])
    #    @article = Article.new({:writer=>current_user.login,  :date =>Time.now }.merge(params[:article]))
    @article = Article.new({:date =>Time.now }.merge(params[:article]))
    @article.user = current_user
    respond_to do |format|
      if @article.save
        flash[:notice] = '写日记成功!'
        format.html { return_to_index }
        #        format.xml  { render :xml => @article, :status => :created, :location => @article }
      else
        format.html { render :action => "new" }
        #        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /articles/1
  # PUT /articles/1.xml
  def update

    if params[:article][:isShare] == "1"
      params[:article][:isShare] = true
    else
      params[:article][:isShare] = false
    end
    @article = Article.find(params[:id])

    respond_to do |format|
      if @article.update_attributes({:date =>Time.now }.merge(params[:article]))
        flash[:notice] = '更新成功'
        format.html {return_to_index }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @article.errors, :status => :unprocessable_entity }
      end
    end
  end


  # DELETE /articles/1
  # DELETE /articles/1.xml
  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html { redirect_to(articles_url) }
      format.xml  { head :ok }
    end
  end
end
