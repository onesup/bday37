class Mobile::UsersController < ApplicationController
  layout "mobile"
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def create
    @user = User.new(user_params)
    # phone = params[:user][:phone_1]+"-"+params[:user][:phone_2]+"-"+params[:user][:phone_3]
    # @user.phone = phone
    birthday = params[:user][:birthday_year]+"-"+params[:user][:birthday_month]+"-"+params[:user][:birthday_day]
    @user.birthday = DateTime.parse(birthday)
    respond_to do |format|
      if @user.save
        c = Coupon.new
        c.code = c.random_code
        c.user = @user
        c.save
        m = Message.send_to(c)
       
        puts "@@@@@@@@@@@@@@@@@@@@@@"+m.id.to_s
        format.html { redirect_to mobile_thank_you_path, notice: 'User was successfully created.' }
        format.json { render json: {status: "success"}, status: :created, location: @user }
      else
        format.html { error_redirect(@user.errors) }
        format.json { render json: @user.errors, status: :unprocessable_entity }
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
      redirect_to mobile_unique_error_path
    else
      redirect_to action: "new"
      
    end
  end


  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :phone, :birthday, :agree)
  end
      
end