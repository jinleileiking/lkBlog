class UsersController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update, :confirm, :destroy, :change]

  def index
    @user = User.find(:all, :conditions => "login != 'admin'")
  end

  def new
    @user = User.new
  end
  
  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "注册成功!"
      return_to_index
    else
      render :action => :new
    end
  end
  
  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end
  
  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "更改成功!"
      return_to_index
    else
      render :action => :edit
    end
  end

  def change
    @user = User.find(params[:id])
  end
  
  def confirm
    @user = User.find(params[:id])
    if params[:user][:isAdmin] == "1"
      params[:user][:isAdmin] = true
    else
      params[:user][:isAdmin] = false
    end

    if @user.update_attributes(params[:user])
      flash[:notice] = "更改成功!"
      return_to_index
    else
      render :action => :change
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:notice] = "删除成功!"
    return_to_index
  end
end
