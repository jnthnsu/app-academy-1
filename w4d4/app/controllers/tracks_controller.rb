class TracksController < ApplicationController
  before_action :check_login

  def new
    @track = Track.new
    render :new
  end

  def create
    @track = Track.new(track_params)
    if @track.save
      redirect_to album_url(@track.album)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] = @track.errors.full_messages
      render :new
    end
  end

  def edit
    @track = Track.find(params[:id])
    render :edit
  end

  def update
    @track = Track.find(params[:id])
    if @track.update(track_params)
      redirect_to album_url(@track.album)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] = @track.errors.full_messages
      redirect_to :back
    end
  end

  def show
    @track = Track.find(params[:id])
    render :show
  end

  def destroy
    @track = Track.find(params[:id])
    @album = @track.album

    @track.destroy
    redirect_to album_url(@album)
  end

  private

  def track_params
    params.require(:track).permit(:name, :album_id, :bonus, :lyrics)
  end
end
