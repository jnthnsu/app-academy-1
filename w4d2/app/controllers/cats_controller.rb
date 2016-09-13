class CatsController < ApplicationController
  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find_by_id(params[:id])
    render :show
  end

  def edit
    @cat = Cat.find_by_id(params[:id])
    render :edit
  end

  def create
    @cat = Cat.create(cat_params)
    if @cat
      render :index
    else
      render json: @cat.errors.full_messages
    end
  end

  def update
    @cat = Cat.find_by_id(params[:id])
    if @cat.update(cat_params)
      render :show
    else
      render json: @cat.errors.full_messages
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :sex, :color, :description, :birth_date)
  end
end
