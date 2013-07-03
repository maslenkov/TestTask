require 'spec_helper'

describe 'User pages' do

  subject {page}

  describe 'sign up page' do
    before {visit signup_path}

    let(:submit) {'Register'}

    describe 'with invalid input' do
      it 'should not create user' do
        expect {click_button submit}.not_to change(User, 'count')
      end
    end

    describe 'with valid input' do
    #TODO: нужно добавить тест проверки инвайта
      before do
        fill_in 'name', with: 'Example User'
        fill_in 'email', with: 'Example@example.example'
        fill_in 'password', with: 'password'
        fill_in 'password', with: 'password'
      end
      it 'should create a user' do
        expect {click_button submit}.to change(User, :count).by(1)
      end
    end
  end

  #describe 'profile page' do
  #  before {visit users_path}
  #  it {should have_selector('div', User.first.name)}
  #  it {should have_selector('div', User.first.email)}
  #end
end