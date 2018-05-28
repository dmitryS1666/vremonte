class AnswersController < ApplicationController
  after_action :publish_answer, only: [:create]

  authorize_resource
  respond_to :html, :json

  def create
    @answer = Answer.new(answer_params)
    @answer.request_id = params[:request_id]
    @answer.user = current_user
    @answer.save
  end

  private

  def answer_params
    params.require(:answer).permit(:request, :user, :body)
  end

  def publish_answer
    return if @answer.errors.any?
    ActionCable.server.broadcast(
        'answers',
        ApplicationController.render(
            partial: 'answers/answer',
            locals: { answer: @answer}
        )
    )
  end
end
