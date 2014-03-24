class Admin::CouponsController < ApplicationController
  def index
  end
  
  def send_message
    coupon = Coupon.find params[:id]
    coupon.send_message
    redirect_to admin_users_path
  end
  
end
