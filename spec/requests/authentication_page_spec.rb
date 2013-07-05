require 'spec_helper'
include SessionsHelper

#TODO: нужны тесты провеяющие мои бефо фильтры
#(допуск к реге по инвайту, редирект на мейн пейдж и доступ к реге, редирект на профайл и доступ к остальным страницам)
describe 'Authentication' do
  subject {page}

  describe 'sign in page' do
    before {visit signin_path}

    it {should have_selector('.wrapper-content-header', text: 'Log in')}
    it {should have_selector('.wrapper-content-body', text: 'Welcome!!!')}

    #TODO: тесты для юзера и его настроек находятся в следующем разделе учебника, т.ч. не торопимся...
    describe 'with invalid info' do
      before {click_button 'Sign in'}
      it {should have_selector('.wrapper-content-header', text: 'Log in')}
      it {should have_selector('.b-errors')}
    end

    describe 'with valid info' do
      let(:user) {FactoryGirl.create(:user)}
      before do
        fill_in 'Email', with: user.email
        fill_in 'Password', with: user.password
        click_button 'Sign in'
      end

      #TODO: следующая строка должна быть такова: it {should have_content(user.name)}
      it {should have_content(user.name)}
      it {should have_link('Log out', href: signout_path)}
      #TODO: следующий тест - так сделан, т.к. нужно переделать эдит юзер пас на работу с кьюрент юзером
      #TODO: нужно поиском убедится, что User.first больше ни где не используется
      #TODO: элит_юзер_пас нужно переделать в роутах, что бы он не брал айдишник, а брал кьюрент юзера и потом поменять путь здесь и в юзер/индекс
      it {should have_link('Edit profile', href: 'edit_user_path')}
      it {should_not have_link('Log in form')}
      it {should_not have_selector('.b-errors')}

      describe 'followed by sign out' do
        before {click_link 'Log out'}
        it {should have_selector('.wrapper-content-header', text: 'Log in')}
      end
    end
  end

end