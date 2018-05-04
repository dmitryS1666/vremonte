class RequestsController < ApplicationController
  before_action :load_request, only: %i[show edit update destroy]

  def index
    @requests = Request.all
  end

  def show;  end

  def new
    @request = Request.new
  end

  def edit;  end

  def create
    @request = Request.new(request_params)

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
    @request.destroy
    redirect_to @request
  end

  private

  def load_request
    @request = Request.find(params[:id])
  end

  def request_params
    params.require(:request).permit(:title, :body, :owner_id)
  end

end
