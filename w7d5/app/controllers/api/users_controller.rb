class Api::UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      login @user
      render @user
    else
      render @user.errors.full_messages
    end
  end

  private

  def user_params
    params.require(:user).permit(:username, :password)
  end
end
