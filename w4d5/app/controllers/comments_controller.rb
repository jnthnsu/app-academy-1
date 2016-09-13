class CommentsController < ApplicationController
  before_action :current_user, except: [:show]

  def new
    @comment = Comment.new
    @post = Post.find(params[:id])
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      redirect_to post_url(@comment.post)
    else
      flash.now[:errors] ||= []
      flash.now[:errors] += @comment.errors.full_messages
      render :new
    end
  end

  def show
    @comment = Comment.find(params[:id])
  end

  private

  def comment_params
    params.require(:comment).permit(:content, :post_id, :user_id, :parent_comment_id)
  end
end
