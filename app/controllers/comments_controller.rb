class CommentsController < ApplicationController
  before_filter :find_article, :find_comments
  before_filter :require_user, :only => [:show, :edit, :update, :destroy]
  
  def find_article
    @article_id = params[:article_id]
    @article = Article.find(@article_id)
  end

  def find_comments
    @comments = @article.comments
  end

  def index
    @comment  = Comment.new

        respond_to do |format|
          format.html # index.html.erb
          format.xml  { render :xml => @comments }
        end
  end

  def edit
    @comment = @article.comments.find(params[:id])
  end

  def create
    @comment = Comment.new({:updated_at =>Time.now }.merge(params[:comment]))
    @comment.user = current_user
    @comment.article = @article
    
    respond_to do |format|
      if @comment.save
        flash[:notice] = '评论成功.'
        format.html { redirect_to(article_comments_url(@article)) }
        format.xml  { render :xml => @comments, :status => :created, :location => @comments }
      else
        flash[:notice] = '评论失败.请检查'
        format.html { redirect_to(article_comments_url(@article)) }
        format.xml  { render :xml => @comments.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @comment = @article.comments.find(params[:id])

    respond_to do |format|
      if @comment.update_attributes(params[:comment])
        flash[:notice] = '评论已修改.'
        format.html { redirect_to(article_comments_url(@article)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @comments.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    comment = @article.comments.find(params[:id])
    @article.comments.destroy(comment)

    respond_to do |format|
      format.html { redirect_to(article_comments_url(@article)) }
      format.xml  { head :ok }
    end
  end
end
