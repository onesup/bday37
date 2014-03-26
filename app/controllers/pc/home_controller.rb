class Pc::HomeController < ApplicationController
  def index
    @user = User.new
  end
end
