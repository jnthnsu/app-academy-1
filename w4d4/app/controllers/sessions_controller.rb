class SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(params[:user][:email], params[:user][:password])

    if @user
      login @user
      @bands = Band.all
      redirect_to bands_url(@bands)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] << 'incorrect.'
      render :new
    end
  end

  def destroy
    user = current_user
    logout user
    render :new
  end
end
