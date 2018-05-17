require 'rails_helper'

feature 'User sign in', %q{
			In order to be able to ask question
			As an user
			I want to be able to sign in
		} do

  scenario 'Refistered user try to sign in' do
    User.create!(email: 'user@mail.com', password: '12345678')

    visit new_user_session_path
    fill_in 'Email', with: 'user@mail.com'
    fill_in 'Password', with: '12345678'
    click_on 'Войти'

    expect(page).to have_content 'Signed in successfully.'
    expect(current_path).to eq root_path
  end

  scenario 'Non-registered user try to sign in' do
    visit new_user_session_path
    fill_in 'Email', with: 'wrong@mail.com'
    fill_in 'Password', with: '12345678'
    click_on 'Войти'

    expect(page).to have_content 'Invalid email or password.'
    expect(current_path).to eq new_user_session_path
  end

end