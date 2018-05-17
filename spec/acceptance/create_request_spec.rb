require 'rails_helper'

feature 'Create request', %q{
		In order to get answer from community
		As an authenticated user
		I want to be able to ask requests
	} do

  scenario 'Authenticated user creates request' do

    User.create!(email: 'user@mail.com', password: '12345678')

    visit new_user_session_path
    fill_in 'Email', with: 'user@mail.com'
    fill_in 'Password', with: '12345678'
    click_on 'Log in'

    visit requests_path
    click_on 'Ask request'
    fill_in 'Title', with: 'Test request'
    fill_in 'Body', with: 'text text'
    click_on 'Create'

    expect(page).to have_content 'Your request successfully created.'

  end

  scenario 'Non-authenticated user ties to create request' do
    visit request_path
    click_on 'Ask request'

    expect(page).to have_content'You need to sign in or sign up before continuing.'

  end

end