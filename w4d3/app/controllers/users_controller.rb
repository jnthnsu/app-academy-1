class UsersController < ApplicationController
  before_action :redirect_to_index

  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      login @user
      redirect_to cats_url
      flash[:errors] = ['you\'re logged in!']
    else
      flash.now[:errors] = ['invalid login.']
      render :new
    end
  end

  private

  def user_params
    params.require(:user).permit(:user_name, :password_digest, :session_token, :password)
  end
end
