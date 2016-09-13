class UsersController < ApplicationController
  def create
    @user = User.new(user_params)
    if @user.save
      login @user
      redirect_to todo_lists_url
    else
      flash[:errors] = @user.errors.full_messages
      render :new
    end
  end

  def user_params
    params.require(:user).permit(:nickname, :password)
  end
end
