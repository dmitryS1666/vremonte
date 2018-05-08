class CommentsController < ApplicationController
  # before_action :set_context, only: [:create]

  after_action :publish_comment, only: [:create]

  def create
    # authorize Comment
    # @comment = @context.comments.create(
    #     comment_params.merge(user: current_user)
    # )
    @comment = Comment.new(comment_params)
    render @comment
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end

  def publish_comment
    return if @comment.errors.any?
  end
end
