class Pc::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  skip_before_action  :verify_authenticity_token
  
  def create    
    phone = params[:user][:phone]
    device = "pc"
    user_agent = UserAgent.parse(request.user_agent)
    device = "mobile" if user_agent.mobile?

    @user = User.new(user_params)
    birthday = "2014-"+params[:user][:birthday_month]+"-"+params[:user][:birthday_day]
    @user.birthday = DateTime.parse(birthday)
    @user.device = device
    respond_to do |format|
      if @user.save
        coupon = Coupon.new
        coupon.code = coupon.random_code
        coupon.user = @user
        coupon.save
        MessageJob.new.async.perform(coupon)
      
        @log = AccessLog.new(ip: request.remote_ip, device: device)
        @log.user = @user
        @log.save
      
        format.html { redirect_to pc_index_path, notice: 'User was successfully created.' }
        format.json { render json: {status: "success"}, status: :created   }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def delete
    test_users = [
      "010-6418-4332", "010-2515-4373", "010-9911-1804", 
      "010-2740-7375", "010-7599-0897", "010-4727-1051"
    ]
    @users = User.where(test_users)
    @users.destroy_all
    respond_to do |format|
      format.html { redirect_to root_path }
      format.json { head :no_content }
    end
  end
    
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :phone, :birthday, :agree, :agree2)
    end
end
