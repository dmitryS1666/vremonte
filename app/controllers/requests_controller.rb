class RequestsController < ApplicationController
  before_action :authenticate_user!, except: [:index, :show]
  before_action :load_request, only: %i(show edit update destroy)
  after_action :publish_request, only: [:create]
  # after_action :delete_publish_request, only: [:destroy]

  authorize_resource
  respond_to :html, :json

  def index
    @requests = Request.all
  end

  def show
    @comments = @request.comments
    @answers = @request.answers
  end

  def new
    @request = Request.new
  end

  def edit; end

  def create
    @request = Request.new(request_params)
    @request.user = current_user
    if @request.save
      redirect_to @request
    else
      render :new
    end
  end

  def update
    if @request.update(request_params)
      redirect_to @request
    else
      render :edit
    end
  end

  def destroy
    @request.destroy if current_user.owner?(@request)
    redirect_to root_path
  end

  private

  def load_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:title, :body, :user_id)
  end

  def publish_request
    return if @request.errors.any?
    ActionCable.server.broadcast(
        'requests',
        ApplicationController.render(
            partial: 'requests/list',
            locals: { request: @request }
        )
    )
  end

  # TODO: create AC for destroy Request
  # def delete_publish_request
  #   return if @request.errors.any?
  #   ActionCable.server.broadcast(
  #       'requests',
  #       ApplicationController.render(
  #           partial: 'requests/list',
  #           locals: { request: @request.id }
  #       )
  #   )
  # end
end
