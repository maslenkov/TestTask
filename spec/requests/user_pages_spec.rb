require 'spec_helper'

describe 'User pages' do

  subject {page}

  describe 'sign up page' do
    #TODO: тест на сообщения об ошибках
    #TODO: тест перехода после регистрации на верную страницу
    before {@invite = FactoryGirl.create(:invite)}
    describe 'with invite' do
      describe 'which invalid' do
        before do
          visit signup_path('a' + @invite.invite)
        end
        it {should have_content('Welcome!!!')}
      end
      describe 'which is closed' do
        before do
          @invite.status = false
          @invite.save
          visit signup_path('')
        end
        it {should have_content('Welcome!!!')}
        after do
          @invite.status = true
          @invite.save
        end
      end
    end

    #TODO: можно добавить проверку того, что инвайт закрывается.
    describe 'with valid invite' do
      before(:all) {@user = FactoryGirl.build(:user)}

      #TODO: для правильного сигнап паса должен быть объявлен инвайт
      before {visit signup_path(@invite.invite)}

      let(:submit) {'Register'}

      describe 'success rendering of registration form' do
        it {should_not have_content('Welcome!!!')}
        it {should have_button(submit)}
      end

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
  end

  describe 'for unsignin users' do
    #
  end

  describe 'for singin users' do

    let(:user) {FactoryGirl.create(:user)}

    before do
      #TODO: нужно разобраться с заполнением тестовой базы, потому что иначе не понятно, как вообще операться на имющееся модели, бд, фабрики и т.п.
      visit signin_path
      fill_in 'Email', with: user.email
      fill_in 'Password', with: user.password
      click_button 'Sign in'
    end
    describe 'profile page' do
      #TODO: Этот тест падает, мол у выбранного пользователя нет айди(скорее всего рспек не использует сессию)
      it {should_not have_selector('.b-errors')}
      it {should have_selector('div', text: user.name)}
      it {should have_selector('div', text: user.email)}
    end
    describe 'edit' do
      before {visit '/users/edit'}

      describe 'page' do
        it {should have_selector('div', text: 'Edit profile:')}
        it {should have_button('Update')}
      end

      describe 'with invalid information' do
        before {click_button 'Update'}

        it {should have_selector('.b-errors')}
      end

      #TODO: нужны тесты и возможность для обновления данных без смены пароля
      describe 'with valid information' do
        let(:new_name) {'New Name'}
        let(:new_email) {'new@email.com'}
        before do
          fill_in 'Name', with: new_name
          fill_in 'Email', with: new_email
          fill_in 'Password', with: user.password
          fill_in 'Repeat password', with: user.password_confirmation
          click_button 'Update'
        end
        it {should_not have_selector('.b-errors')}
        it {should have_content(new_name)}
        it {should have_content(new_email)}
      end
    end
  end
end