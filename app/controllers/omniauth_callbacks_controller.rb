class OmniauthCallbacksController < Devise::OmniauthCallbacksController
  before_action :sign_from_omniauth, only: %i[vkontakte sign_up]

  def vkontakte; end

  def sign_up; end

  private
  def sign_from_omniauth
    @user = User.find_for_oauth(auth)
    if @user&.persisted?
      sign_in_and_redirect @user, event: :authentication
      flash[:notice] = "Succes login!"
    else
      flash[:notice] = 'Email is required to compete sign up'
      session['devise.auth'] = { uid: auth.uid, provider: auth.provider }
      render 'common/confirm_mail', locals: { auth: auth }
    end
  end

  def auth
    request.env['omniauth.auth'] || OmniAuth::AuthHash.new(params_auth)
  end

  def params_auth
    session[:auth] ? params[:auth].merge(session[:auth]) : params[:auth]
  end
end