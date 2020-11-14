class HomeController < ApplicationController
  before_action :define_left_menu

  def top
    @user = User.new
  end

  def define_left_menu
    if session[:left_menu]
      session[:left_menu] = nil
    end
  end
end
