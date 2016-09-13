class SubsController < ApplicationController
  before_action :check_for_admin!, only: [:edit, :update]

  def show
    @sub = Sub.find(params[:id])
  end

  def new
    @sub = Sub.new
  end

  def create
    @sub = Sub.new(sub_params)
    @sub.user_id = current_user.id
    if @sub.save
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @sub.errors.full_messages
      render :new
    end
  end

  def edit
    @sub = Sub.find(params[:id])
  end

  def update
    @sub = Sub.find(params[:id])
    if @sub.update(sub_params)
      redirect_to sub_url(@sub)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @sub.errors.full_messages
      render :edit
    end
  end

  private

  def sub_params
    params.require(:sub).permit(:title, :description, :user_id)
  end

  def check_for_admin!
    @sub = Sub.find(params[:id])
    @sub.check_for_admin! current_user.id
  end
end
