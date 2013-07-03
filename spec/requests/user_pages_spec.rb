require 'spec_helper'

describe 'User pages' do

  subject {page}

  describe 'sign up page' do
    visit signup_path
    fill_in 'name', with: 'Example User'
    fill_in 'email', with: 'Example@example.example'
    fill_in 'password', with: 'password'
    fill_in 'password', with: 'password'
    click_button 'Register'
  #
  end

  #describe 'profile page' do
  #  before {visit users_path}
  #  it {should have_selector('div', User.first.name)}
  #  it {should have_selector('div', User.first.email)}
  #end
end