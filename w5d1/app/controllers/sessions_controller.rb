class SessionsController < ApplicationController

  def create
    @user = User.find_by_credentials(session_params[:username], session_params[:password])
    if @user
      login(@user)
      redirect_to user_url(@user)
    else
      flash[:errors] = ["cannot log in"]
      render :new
    end
  end

  def destroy
    logout
    render :new
  end

  def session_params
    params.require(:user).permit(:username, :password)
  end
end
