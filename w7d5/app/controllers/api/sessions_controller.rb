class Api::SessionsController < ApplicationController
  def create
    @user = User.find_by_credentials(params[:user][:username], params[:user][:password])
    if @user
      login @user
      render @user
    else
      render json: 'No.'
    end
  end

  def destroy
    if current_user
      logout
      render json: {}
    else
      render json: 'No.'
    end
  end
end
