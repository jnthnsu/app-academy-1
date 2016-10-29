class GoalsController < ApplicationController
  before_action :check_login

  def update
    @goal = Goal.find_by_id(params[:id])
    if @goal.update(goal_params) && @goal.user_id == current_user.id
      flash[:notice] = ['Goal updated!']
      render :show
    else
      flash[:errors] = @goal.errors.full_messages
      render :edit
    end
  end

  def create
    @goal = Goal.new(goal_params)
    @goal.user_id = current_user.id
    if @goal.save
      redirect_to goal_url(@goal)
    else
      flash[:errors] = @goal.errors.full_messages
      render :new
    end
  end

  def show
    @goal = Goal.find_by_id(params[:id])
  end

  def destroy
    @goal = Goal.find_by_id(params[:id])
    @goal.destroy
    redirect_to user_url(current_user)
  end

  def goal_params
    params.require(:goal).permit(:title, :details, :private, :complete)
  end

  def change_complete
    @goal = Goal.find_by_id(params[:id])
    @goal.update(complete: !@goal.complete)
    redirect_to :back
  end

  def cheer
    @goal = Goal.find_by_id(params[:id])
    if current_user.cheers >= 1
      @goal.update(cheers: @goal.cheers + 1)
      current_user.update(cheers: current_user.cheers - 1)
    end
    redirect_to :back
  end
end
