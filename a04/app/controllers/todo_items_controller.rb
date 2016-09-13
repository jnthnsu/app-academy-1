class TodoItemsController < ApplicationController
  def new
    @todo_list = TodoList.find_by_id(params[:todo_list])
    @todo_item = TodoItem.new
  end

  def create
    @todo_item = TodoItem.new(todo_item_params)
    if @todo_item.user == current_user
      @todo_item.save
      redirect_to todo_list_url(@todo_item.todo_list)
    else
      redirect_to todo_list_url(@todo_item.todo_list)
    end
  end

  def destroy
    @todo_item = TodoItem.find_by_id(params[:id])
    if @todo_item.user == current_user
      @todo_item.destroy
      redirect_to todo_list_url(@todo_item.todo_list)
    else
      redirect_to todo_list_url(@todo_item.todo_list)
    end
  end

  def todo_item_params
    params.require(:todo_item).permit(:body, :completed, :todo_list_id)
  end
end
