class SessionsController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.find_by_credentials(params[:user][:name], params[:user][:password])
    if @user
      login! @user
      redirect_to subs_url
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << 'no.'
      render :new
    end
  end

  def destroy
    logout!
    redirect_to subs_url
  end
end
