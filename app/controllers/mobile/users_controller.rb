class Mobile::UsersController < ApplicationController
  layout "mobile"
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def create
    
    phone = params[:user][:phone]
    unless User.exists?(phone: phone)
      @user = User.new(user_params)
      #birthday = params[:user][:birthday_year]+"-"+params[:user][:birthday_month]+"-"+params[:user][:birthday_day]
      @user.birthday = Time.new #DateTime.parse(birthday)
      respond_to do |format|
        if @user.save
          c = Coupon.new
          c.code = c.random_code
          c.user = @user
          c.save
          MessageJob.new.async.perform(c)
        
          device = "mobile"
          user_agent = UserAgent.parse(request.user_agent)
          device = "mobile" if user_agent.mobile?
          @log = AccessLog.new(ip: request.remote_ip, device: device)
          @log.user = @user
          @log.save
        
          format.html { redirect_to mobile_thank_you_path, notice: 'User was successfully created.' }
          format.json { render json: {status: "success"}, status: :created, location: @user }
        else
          format.html { render action: 'new' }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    else
      @user = User.find_by_phone(phone)
      respond_to do |format|
        device = "mobile"
        user_agent = UserAgent.parse(request.user_agent)
        device = "mobile" if user_agent.mobile?
        @log = AccessLog.new(ip: request.remote_ip, device: device)
        @log.user = @user
        @log.save
      
        format.html { redirect_to mobile_unique_error_path }
        format.json { render json: {status: "duplicated"}, status: :unprocessable_entity}
      end
    end
  end
  
  def new
    @user = User.new
  end
    
  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find(params[:id])
  end

  def error_redirect(errors)
    unless errors.get(:phone).index("has already been taken") == nil
      redirect_to mobile_unique_error_path()
    else
      redirect_to action: "new"
      
    end
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :phone, :birthday, :agree, :agree2)
  end
      
end