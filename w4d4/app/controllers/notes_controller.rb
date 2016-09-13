class NotesController < ApplicationController
  before_action :check_login
  before_action :check_author, only: :destroy

  def create
    @note = Note.new(note_params)
    @note.user = current_user
    if @note.save
      redirect_to track_url(@note.track)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] = @note.errors.full_messages
      redirect_to :back
    end
  end

  def destroy
    @note = Note.find(params[:id])
    @track = @note.track
    @note.destroy
    redirect_to track_url(@track)
  end

  private

  def note_params
    params.require(:note).permit(:body, :track_id)
  end

  def check_author
    Note.find(params[:id]).user == current_user
  end
end
