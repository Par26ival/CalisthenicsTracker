class HomePageController < ApplicationController

  def index
    @login_user = User.new
    @register_user = User.new
  end
end
