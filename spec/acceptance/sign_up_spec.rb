require 'rails_helper'

feature 'User sign up', %q{
			In order to be able to ask request
      As an user
			I want to be able to sign up
		} do

  scenario 'User try registere' do
    visit new_user_registration_path
    fill_in 'Email', with: 'user@mail.com'
    fill_in 'user_password', with: '123456'
    fill_in 'user_password_confirmation', with: '123456'
    click_on 'Зарегистрироваться'
  end

  scenario 'AvService try registere' do
    visit new_user_registration_path
    fill_in 'Email', with: 'user@mail.com'
    fill_in 'av_password', with: '123456'
    fill_in 'av_password_confirmation', with: '123456'
    fill_in 'av_description', with: 'Text text text text'
    click_on 'Зарегистрировать Автосервис'
  end

end