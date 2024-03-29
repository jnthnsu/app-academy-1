class BandsController < ApplicationController
  before_action :check_login

  def index
    @bands = Band.all
    render :index
  end

  def new
    @band = Band.new
    render :new
  end

  def create
    @band = Band.new(band_params)
    if @band.save
      render :index
    else
      flash.now[:errors] ||= []
      flash.now[:errors] = @band.errors.full_messages
      render :new
    end
  end

  def edit
    @band = Band.find(params[:id])
    render :edit
  end

  def update
    @band = Band.find(params[:id])
    if @band.update(band_params)
      render :index
    else
      flash.now[:errors] ||= []
      flash.now[:errors] = @band.errors.full_messages
      render :edit
    end
  end

  def show
    @band = Band.find(params[:id])
    render :show
  end

  def destroy
    @band = Band.find(params[:id])
    @band.destroy
    render :index
  end

  private

  def band_params
    params.require(:band).permit(:name)
  end
end
