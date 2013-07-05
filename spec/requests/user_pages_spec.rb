require 'spec_helper'

describe 'User pages' do

  subject {page}

  describe 'sign up page' do
    #TODO: тест на сообщения об ошибках
    #TODO: тест перехода после регистрации на верную страницу
    before(:all) {@user = FactoryGirl.build(:user)}

    before {visit signup_path}

    let(:submit) {'Register'}

    describe 'with invalid input' do
      it 'should not create user' do
        #TODO: здесь должна быть как в автер сейвинг юзер проверка того, что отображается ошибка, а не просмотры бд
        expect {click_button submit}.not_to change(User, 'count')
      end
    end

    describe 'with valid input' do
    #TODO: нужно добавить тест проверки инвайта
      before do
        fill_in 'Name', with: @user.name
        fill_in 'Email', with: @user.email
        fill_in 'Password', with: @user.password
        fill_in 'Repeat password', with: @user.password_confirmation
        click_button submit
      end
      describe 'after saving user' do
        #TODO: заметим, что само содержимое страницв проверяется в разделе профайл пейдж
        it {should_not have_selector('.b-errors')}
        it {should have_link('Edit profile')}
      end
    end
  end

  describe 'for unsignin users' do
    #
  end

  describe 'for singin users' do

    let(:registered_user) {FactoryGirl.create(:user)}

    before do
      #TODO: нужно разобраться с заполнением тестовой базы, потому что иначе не понятно, как вообще операться на имющееся модели, бд, фабрики и т.п.
      visit signin_path
      fill_in 'Email', with: registered_user.email
      fill_in 'Password', with: registered_user.password
      click_button 'Sign in'
    end
    describe 'profile page' do
      #TODO: Этот тест падает, мол у выбранного пользователя нет айди(скорее всего рспек не использует сессию)
      it {should_not have_selector('.b-errors')}
      it {should have_selector('div', text: registered_user.name)}
      it {should have_selector('div', text: registered_user.email)}
    end
  end
end