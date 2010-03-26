class ArticlesController < ApplicationController
  # GET /articles
  # GET /articles.xml
  #  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update, :destroy, :new, :create]
  
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
