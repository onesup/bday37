class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  def index
    @users = User.order("id desc").page(params[:page]).per(200)
  end
end
