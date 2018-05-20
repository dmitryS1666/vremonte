class CommentsController < ApplicationController
  after_action :publish_comment, only: [:create]

  authorize_resource
  respond_to :html, :json

  def create
    @comment = Comment.new(comment_params)
    @comment.request_id = params[:request_id]
    @comment.user = current_user
    @comment.save
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def publish_comment
    return if @comment.errors.any?
    ActionCable.server.broadcast(
        'comments',
        ApplicationController.render(
            partial: 'comments/comment',
            locals: { comment: @comment}
        )
    )
  end
end
