class CommentsController < ApplicationController
  after_action :publish_comment, only: [:create]

  def create
    @comment = Comment.new(comment_params)
    @comment.save
  end

  private

  def comment_params
    params.require(:comment).permit(:body, :request_id)
  end

  def publish_comment
    return if @comment.errors.any?
  end
end
