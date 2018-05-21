require 'rails_helper'

feature 'Create request', %q{
		In order to get executor your request
		As an authenticated user
		I want to be able to add requests
	} do

  given!(:user) { create(:user) }

  scenario 'Authenticated user creates request with valid attributes' do
    sign_in(user)

    visit requests_path
    click_on 'СОЗДАТЬ ЗАЯВКУ'
    fill_in 'Title', with: 'Test request'
    fill_in 'Body', with: 'text text'
    click_on 'Create'

    expect(page).to have_content 'Your request was successfully created'
    expect(page).to have_content user.requests.last.title
    expect(page).to have_content user.requests.last.body
  end

  scenario 'Authenticated user creates request with invalid attributes' do
    sign_in(user)

    visit requests_path
    click_on 'СОЗДАТЬ ЗАЯВКУ'
    fill_in 'Title', with: ''
    fill_in 'Body', with: 'text text'
    click_on 'Create'

    expect(page).to have_content "Title can't be blank"
  end

  scenario 'Non-authenticated user tries to create request' do
    visit requests_path
    click_on 'СОЗДАТЬ ЗАЯВКУ'

    expect(page).to_not have_content 'СОЗДАТЬ ЗАЯВКУ'
  end

  context 'mulitple sessions' do
    scenario "request appears on another user's page" do
      Capybara.using_session('user') do
        sign_in(user)
        visit requests_path
      end

      Capybara.using_session('guest') do
        visit requests_path
      end

      Capybara.using_session('user') do
        page.find("#add_request_btn").trigger('click')

        fill_in 'Title', with: 'Test request'
        fill_in 'Body', with: 'test text'
        click_on 'Save'
        expect(page).to have_content 'Test request'
        expect(page).to have_content 'test text'
      end

      Capybara.using_session('guest') do
        expect(page).to have_content 'Test request'
      end
    end
  end

end