class CatRentalRequestsController < ApplicationController
  def new
    @cats = Cat.all
    render :new
  end

  def create
    @request = CatRentalRequest.create(request_params)
    @cat = Cat.find_by_id(@request.cat_id)

    if @request
      redirect_to cat_url(@cat)
    else
      render json: @request.errors.full_messages
    end
  end

  def approve!
    @request = CatRentalRequest.find_by_id(params[:id])
    @request.approve!

    redirect_to :back
  end

  def deny!
    @request = CatRentalRequest.find_by_id(params[:id])
    @request.deny!

    redirect_to :back
  end


  private

  def request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date)
  end
end
