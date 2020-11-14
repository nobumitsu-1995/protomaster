class HalfProductController < ApplicationController
  before_action :define_left_menu
  before_action :authenticate_user

  def new
    @hp = HalfProduct.new
  end

  def create
    @hp = HalfProduct.new(
      code: params[:code],
      name: params[:name],
      pigment: params[:pigment],
      pigment_per: params[:pigment_per],
      dispersant: params[:dispersant],
      dispersant_per: params[:dispersant_per]
    )
    if @hp.save
      flash[:notice] = "新しい半製品情報を登録しました。"
      redirect_to("/half_product/#{@hp.id}/show")
    else
      flash[:notice] = "登録に失敗しました。"
      render("half_product/new")
    end
  end

  def show
    @hp = HalfProduct.find_by(id: params[:id])
  end

  def index
    @hps = HalfProduct.all
  end

  def sort
    case params[:column]
    when "name"
      @hps = HalfProduct.where(name: params[:search_txt])
      @selected = "name"
      @text = params[:search_txt]
    when "code"
      @hps = HalfProduct.where(code: params[:search_txt])
      @selected = "code"
      @text = params[:search_txt]
    when "pigment"
      @hps = HalfProduct.where(pigment: params[:search_txt])
      @selected = "pigment"
      @text = params[:search_txt]
    when "dispersant"
      @hps = HalfProduct.where(dispersant: params[:search_txt])
      @selected = "dispersant"
      @text = params[:search_txt]
    else
      render("half_product/index")
    end
  end

  def sort_code
    @hps = HalfProduct.order("code")
  end

  def destroy
    @hp = HalfProduct.find_by(id: params[:id])
    if @hp.destroy
      flash[:notice] = "半製品情報を削除しました。"
      redirect_to("/half_product/index")
    else
      flash[:notice] = "正常に削除できませんでした。"
      render("half_product/show")
    end
  end

  def edit
    @hp = HalfProduct.find_by(id: params[:id])
  end

  def update
    @hp = HalfProduct.find_by(id: params[:id])
    @hp.code = params[:code]
    @hp.name = params[:name]
    @hp.pigment = params[:pigment]
    @hp.dispersant = params[:dispersant]
    @hp.pigment_per = params[:pigment_per]
    @hp.dispersant_per = params[:dispersant_per]
    if @hp.save
      flash[:notice] = "編集内容を保存しました。"
      redirect_to("/half_product/#{@hp.id}/show")
    else
      flash[:notice] = "編集の保存に失敗しました。"
      render("half_product/edit")
    end
  end

  def define_left_menu
    if session[:left_menu] != "half_product"
      session[:left_menu] = "half_product"
    end
  end

end
