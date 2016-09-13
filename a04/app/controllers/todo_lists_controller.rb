class TodoListsController < ApplicationController
  def new
    @todo_list = TodoList.new
    if current_user
      render :new
    else
      redirect_to new_session_url
    end
  end

  def create
    @todo_list = TodoList.new(todo_list_params)
    if current_user
      @todo_list.user_id = current_user.id
      if @todo_list.save
        redirect_to todo_list_url(@todo_list)
      else
        flash[:errors] = @todo_list.errors.full_messages
        render :new
      end
    else
      redirect_to new_session_url
    end
  end

  def index
    if current_user
      render :index
    else
      redirect_to new_session_url
    end
  end

  def show
    @todo_list = TodoList.find_by_id(params[:id])
    if current_user == @todo_list.user
      render :show
    else
      redirect_to new_session_url
    end
  end

  def edit
    @todo_list = TodoList.find_by_id(params[:id])
    if current_user == @todo_list.user
      render :edit
    else
      redirect_to new_session_url
    end
  end

  def update
    @todo_list = TodoList.find_by_id(params[:id])
    if @todo_list.update(todo_list_params)
      redirect_to todo_list_url(@todo_list)
    else
      render :edit
    end
  end

  def todo_list_params
    params.require(:todo_list).permit(:name, :description)
  end
end
