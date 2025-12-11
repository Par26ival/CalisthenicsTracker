class Users::SessionsController < Devise::SessionsController
  def create
    # Must match both email AND username
    user = User.find_by(email: params[:user][:email], username: params[:user][:username])

    if user && user.valid_password?(params[:user][:password])
      flash[:notice] = "Welcome back, #{user.username}!"
      sign_in(user)
      redirect_to root_path
    else
      flash[:alert] = "Invalid username, email, or password."
      redirect_to login_path
    end
  end
end
