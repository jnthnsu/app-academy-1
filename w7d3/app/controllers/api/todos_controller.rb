class Api::TodosController < ApplicationController
  def index
    render json: Todo.all
  end

  def create
    @todo = Todo.new(todo_params)
    if @todo.save
      render json: @todo
    else
      flash.now[:errors] = @todo.errors.full_messages
      render :index
    end
  end

  def update
    @todo = Todo.find_by_id(params[:id])
    if @todo.update(todo_params)
      render json: @todo
    else
      flash.now[:errors] = @todo.errors.full_messages
      render json: @todo
    end
  end

  def destroy
    @todo = Todo.find_by_id(params[:id])
    @todo.destroy if @todo
    render :index
  end

  private

  def todo_params
    params.require(:todo).permit(:title, :body, :done)
  end
end
