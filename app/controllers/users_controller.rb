class UsersController < ApplicationController
  before_action :authenticate_user!, except: %i(index show edit)
  before_action :load_user, only: %i(show edit update destroy)

  authorize_resource
  respond_to :html, :json

  def index
    @users = User.all
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    @user.destroy if current_user
    redirect_to new_user_session_path
  end

  private
  def user_params
    params.require(:user).permit(:email)
  end

  def load_user
    # @user = User.find(current_user.id)
    @user = User.find(params[:id])
  end

end