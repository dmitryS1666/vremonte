require_relative 'acceptance_helper'

feature 'Authorization from providers', %q{
  In order to work with Requsets
  As a user
  I want to registration using my other social network accounts
} do
  let(:user) { create(:user) }
  let(:email) { 'test@test.ru' }
  describe 'use Vk' do
    scenario 'User not register on the service, only Vk', js: true do
      mock_auth_hash(:vkontakte, nil)

      visit new_user_session_path
      click_on 'Войти при помощи Vkontakte'
      expect(page).to have_content 'Email is required to compete sign up'

      fill_in 'Email', with: email
      click_on 'Confim email'

      open_email(email)
      current_email.click_link 'Confirm my account'

      click_on 'Войти при помощи Vkontakte'
      expect(page).to have_content('Succes login!')
    end

    scenario 'Registred and authorized user to authenticate', js: true do
      auth = mock_auth_hash(:vkontakte, user.email)
      create(:authorization, user: user, provider: auth.provider, uid: auth.uid)

      visit new_user_session_path
      click_on 'Войти при помощи Vkontakte'

      expect(page).to have_content('Success login!')
    end
  end

end