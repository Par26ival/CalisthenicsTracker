class HomePageController < ApplicationController
  def index
  end

  def login
  end

  def register
    @user = User.new
  end

  def create_user
    @user = User.new(user_params)

    if @user.save
      sign_in(@user)  # DEVlSE auto-login
      flash[:notice] = "Welcome, #{@user.username}!"
      redirect_to root_path
    else
      flash[:alert] = @user.errors.full_messages.join(", ")
      render :register, status: :unprocessable_entity
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
