class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(params[:user][:nickname], params[:user][:password])
    if @user
      login @user
      redirect_to todo_lists_url
    else
      flash[:errors] = ['invalid.']
      render :new
    end
  end

  def destroy
    logout
    redirect_to '/session/new'
  end
end
