class UserSessionsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => :destroy

#  def redirect_back_or_default(default)
#      redirect_to(session[:return_to] || default)
#      session[:return_to] = nil
#  end


  def new
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      flash[:notice] = "登录成功!"
      return_to_index
    else
      render :action => :new
    end
  end
  
  def destroy
    current_user_session.destroy
    flash[:notice] = "注销成功!"
    return_to_index
  end
end
