class AlbumsController < ApplicationController
  before_action :check_login

  def new
    @album = Album.new
    render :new
  end

  def create
    @album = Album.new(album_params)
    if @album.save
      redirect_to band_url(@album.band)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] = @album.errors.full_messages
      render :new
    end
  end

  def edit
    @album = Album.find(params[:id])
    render :edit
  end

  def update
    @album = Album.find(params[:id])
    if @album.update(album_params)
      render album_url(@album)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] = @album.errors.full_messages
      render :edit
    end
  end

  def show
    @album = Album.find(params[:id])
    render :show
  end

  def destroy
    @album = Album.find(params[:id])
    @band = @album.band
    @album.destroy
    redirect_to band_url(@band)
  end

  private

  def album_params
    params.require(:album).permit(:title, :year, :live, :band_id)
  end
end
