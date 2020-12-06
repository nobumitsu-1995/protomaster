class UserController < ApplicationController
  before_action :forbid_login_user , {only: [:login_form, :login]}
  before_action :authenticate_user , {only: [:edit, :show, :update, :destroy, :logout]}

  def create
    if @current_user && @current_user.admin_user == 1
      @user = User.new
    else
      flash[:notice] = "管理者権限を持っていません。"
      redirect_to("/")
    end
  end

  def edit
    @user = User.find_by(id: session[:user_id])
  end

  def login_form
    @user = User.new
  end

  def show
    @user = User.find_by(id: session[:user_id])
  end

  def update
    @user = User.find_by(id: session[:user_id])
    @user.number = params[:number]
    @user.name = params[:name]
    @user.password_digest = params[:password_digest]
    if @user.save
      flash[:notice] = "ユーザー情報を編集しました。"
      redirect_to("/user/show")
    else
      flash[:notice] = "ユーザー情報の編集に失敗しました。"
      render("user/show")
    end
  end

  def destroy
    @user = User.find_by(id: session[:user_id])
    if @user.authenticate(params[:password_digest])
      session[:user_id] = nil
      @user.destroy
      flash[:notice] = "ユーザー情報を削除しました。"
      redirect_to("/")
    else
      flash[:notice] = "ユーザー情報の削除に失敗しました。"
      redirect_to("/user/show")
    end
  end

  def login
    @user = User.find_by(number: params[:number])
    if @user && @user.authenticate(params[:password_digest])
      session[:user_id] = @user.id
      flash[:notice] = "ログインしました。"
      redirect_to("/")
    else
      @user = User.new(number: params[:number] , password_digest: params[:password_digest])
      flash[:notice] = "社員番号とパスワードが一致しませんでした。"
      render("home/top")
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = "ログアウトしました。"
    redirect_to("/")
  end

  def signin
    if @current_user.admin_user == 1
      @user = User.new(
        number: params[:number],
        name: params[:name],
        password: params[:password_digest]
      )
      if @user.save
        flash[:notice] = "ユーザー登録を完了しました。社員番号:#{@user.number},名前:#{@user.name}"
        redirect_to("/")
      else
        render "user/create"
      end
    else
      flash[:notice] = "管理者権限を持っていません。"
      redirect_to("/")
    end
  end


end
