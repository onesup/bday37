class Pc::UsersController < ApplicationController
before_action :set_user, only: [:show, :edit, :update, :destroy]
  
  def create
    @user = User.new(user_params)
    # phone = params[:user][:phone_1]+"-"+params[:user][:phone_2]+"-"+params[:user][:phone_3]
    # @user.phone = phone
    birthday = params[:user][:birthday_year]+"-"+params[:user][:birthday_month]+"-"+params[:user][:birthday_day]
    @user.birthday = DateTime.parse(birthday)
    respond_to do |format|
      if @user.save!
        m=Message.send_to(@user)
        puts "@@@@@@@@@@@@@@@@@@@@@@"+m.id.to_s
        format.html { redirect_to pc_index_path, notice: 'User was successfully created.' }
        format.json { render json: {status: "success"}, status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :phone, :birthday)
    end
end
