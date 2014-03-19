class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  def index
    @users = User.order("id desc").page(params[:page]).per(200)
  end
  
  def couponused
    @couponusedusers = User.includes(:coupon).where(:coupons =>{:status => "used"}).order("coupons.updated_at DESC").page(params[:page]).per(200)
  end
end
