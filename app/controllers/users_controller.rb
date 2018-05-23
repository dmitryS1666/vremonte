class UsersController < ApplicationController
  before_action :authenticate_user!, except: [:show]
  before_action :load_user, only: %i(show edit destroy)

  authorize_resource
  respond_to :html, :json

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
    redirect_to root_path
  end

  private
  def load_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email)
  end

end