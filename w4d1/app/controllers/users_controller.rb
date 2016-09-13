class UsersController < ApplicationController
  def index
    @users = User.all
    render json: @users
  end

  def create
    @user = User.new(user_params)
    if @user.save
      render json: @user
    else
      render json: @user.errors.full_messages, status: :unprocessable_entity
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.update(user_params)

    render json: @user
  end

  def show
    @user = User.find_by(id: params[:id])

    render json: @user
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy

    render json: @user
  end

  def contacts
    @user = User.find_by(id: params[:id])
    @contacts = @user.contacts + @user.shared_contacts
    render json: @contacts
  end

  def favorites
    @user = User.find_by(id: params[:id])
    @contacts = @user.contacts.find_by(favorite: true)
    render json: @contacts
  end

  private

  def user_params
    params[:user].permit(:username)
  end
end
