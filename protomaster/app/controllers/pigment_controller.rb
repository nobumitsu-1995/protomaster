class PigmentController < ApplicationController
  before_action :define_left_menu
  before_action :authenticate_user

  def new
    @pig = Pigment.new
  end

  def create
    pig = Pigment.new(
      code: params[:code],
      name: params[:name],
      maker: params[:maker],
      pig_no: params[:pig_no],
      structure: params[:structure]
    )
    if pig.save
      flash[:notice] = "新規顔料を登録しました。"
      redirect_to("/pigment/#{pig.id}/show")
    else
      flash[:notice] = "登録に失敗しました。"
      render("pigment/new")
    end
  end

  def show
    @pig = Pigment.find_by(id: params[:id])
  end

  def index
    @pigs = Pigment.order(name: :asc)
  end

  def sort
    case params[:column]
    when "name"
      @pigs = Pigment.where(name: params[:search_txt])
      @selected = "name"
      @text = params[:search_txt]
    when "code"
      @pigs = Pigment.where(code: params[:search_txt])
      @selected = "code"
      @text = params[:search_txt]
    when "pig_no"
      @pigs = Pigment.where(pig_no: params[:search_txt])
      @selected = "pig_no"
      @text = params[:search_txt]
    when "structure"
      @pigs = Pigment.where(structure: params[:search_txt])
      @selected = "structure"
      @text = params[:search_txt]
    else
      render("pigment/index")
    end
  end

  def sort_code
    @pigs = Pigment.order("code")
  end

  def sort_maker
    @pigs = Pigment.order("maker")
  end

  def sort_pig_no
    @pigs = Pigment.order("pig_no")
  end

  def destroy
    @pig = Pigment.find_by(id: params[:id])
    if @pig.destroy
      flash[:notice] = "顔料情報を削除しました。"
      redirect_to("/pigment/index")
    else
      flash[:notice] = "正常に削除できませんでした。"
      render("pigment/show")
    end
  end

  def edit
    @pig = Pigment.find_by(id: params[:id])
  end

  def update
    @pig = Pigment.find_by(id: params[:id])
    @pig.code = params[:code]
    @pig.name = params[:name]
    @pig.maker = params[:maker]
    @pig.pig_no = params[:pig_no]
    @pig.structure = params[:structure]
    if @pig.save
      flash[:notice] = "編集内容を保存しました。"
      redirect_to("/pigment/#{@pig.id}/show")
    else
      flash[:notice] = "編集の保存に失敗しました。"
      render("pigment/edit")
    end
  end

  def define_left_menu
    if session[:left_menu] != "pigment"
      session[:left_menu] = "pigment"
    end
  end

end
