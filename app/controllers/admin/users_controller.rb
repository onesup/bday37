class Admin::UsersController < ApplicationController
  layout 'admin'
  before_action :authenticate_user!
  def index
    @users = User.order("id desc").page(params[:page]).per(200)
    @user_counts = User.count_by_device_type
  end
  
  def couponused
    @coupon_used_users = User.coupon_used_users.page(params[:page]).per(200)
    @coupon_used_counts = User.coupon_used_counts
  end
  
end
