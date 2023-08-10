class UsersController < ApplicationController
  def show
    @user = User.find_by(username: params[:username])
  end
  
  private
  def user_params
    params.require(:user).permit(:name, :lastname, :birthdate, :image, :password, :password_confirmation, :current_password)
  end
end
