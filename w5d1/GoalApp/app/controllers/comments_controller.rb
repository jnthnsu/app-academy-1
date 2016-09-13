class CommentsController < ApplicationController
  before_action :check_login

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to :back
    else
      flash[:errors] = @comment.errors.full_messages
      redirect_to :back
    end
  end

  def comment_params
    params.require(:comment).permit(:body, :commentable_type, :commentable_id)
  end

end
