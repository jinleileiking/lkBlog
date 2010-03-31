class PagecontentsController < ApplicationController
  # GET /pagecontents
  # GET /pagecontents.xml
  before_filter :find_page, :find_pagecontents

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
#       :force_br_newlines => true, # 此选项强制编辑器将段落符号(P)替换成换行符(BR)。不建议用：ff下不好使，用了此选项后，输入内容的居中、清单或编号都被破坏。
      :plugins => %w{contextmenu paste media emotions table fullscreen}},
    :only => [:new, :edit, :show, :index, :create, :update])  # tiny_mce考虑的非常贴心，这里是限定哪些action中起用

  def find_page
    @page_id = params[:page_id]
    @page = Page.find(@page_id)
  end

  def find_pagecontents
    @pagecontents = @page.pagecontents
  end
  
  def index

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @pagecontents }
    end
  end
  
  # GET /pagecontents/new
  # GET /pagecontents/new.xml
  def new
    @pagecontent = Pagecontent.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @pagecontent }
    end
  end

  # GET /pagecontents/1/edit
  def edit
    @pagecontent = @page.pagecontents.find(params[:id])
  end

  # POST /pagecontents
  # POST /pagecontents.xml
  def create
    @pagecontent = Pagecontent.new(params[:pagecontent])
    @pagecontent.page = @page

    respond_to do |format|
      if @pagecontent.save
        flash[:notice] = 'Pagecontent was successfully created.'
        format.html { redirect_to(page_pagecontents_path(@page)) }
        format.xml  { render :xml => @pagecontent, :status => :created, :location => @pagecontent }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @pagecontent.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /pagecontents/1
  # PUT /pagecontents/1.xml
  def update
    @pagecontent = @page.pagecontents.find(params[:id])

    respond_to do |format|
      if @pagecontent.update_attributes(params[:pagecontent])
        flash[:notice] = 'Pagecontent was successfully updated.'
        format.html {redirect_to(page_pagecontents_path(@page)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @pagecontent.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /pagecontents/1
  # DELETE /pagecontents/1.xml
  def destroy
    @pagecontent = @page.pagecontents.find(params[:id])
    @pagecontent.destroy

    respond_to do |format|
      format.html { redirect_to(page_pagecontents_path(@page)) }
      format.xml  { head :ok }
    end
  end
end
