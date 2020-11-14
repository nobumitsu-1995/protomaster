class ApplicationController < ActionController::Base
  before_action :set_current_user

  def set_current_user
    if session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
    end
  end

  def authenticate_user
    if @current_user == nil
      flash[:notice] = "ログインしてください"
      redirect_to("/user/login_form")
    end
  end

  def forbid_login_user
    if @current_user
      flash[:notice] = "すでにログインしています。"
      redirect_to("/")
    end
  end

end
