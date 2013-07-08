require 'spec_helper'
include SessionsHelper

describe 'Authentication' do
  subject {page}

  describe 'sign in page' do
    before {visit signin_path}

    it {should have_selector('.wrapper-content-header', text: 'Log in')}
    it {should have_selector('.wrapper-content-body', text: 'Welcome!!!')}

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

      it {should have_content(user.name)}
      it {should have_link('Log out', href: signout_path)}
      it {should have_link('Edit profile', href: '/users/edit')}
      it {should_not have_link('Log in form')}
      it {should_not have_selector('.b-errors')}

      describe 'for signed-in users' do
        describe 'visiting signin page' do
          before {visit '/signin'}
          it {should have_content(user.name)}
          it {should have_link('Log out')}
        end
        describe 'visiting signin page' do
          before {visit '/signup'}
          it {should have_content(user.name)}
          it {should have_link('Log out')}
        end
      end

      describe 'followed by sign out' do
        before {click_link 'Log out'}
        it {should have_selector('.wrapper-content-header', text: 'Log in')}

        describe 'for non-signed-in users' do
          describe 'visiting the profile page' do
            before {visit '/users'}
            it {should have_content('Welcome!!!')}
          end
          describe 'visiting the edit page' do
            before {visit '/users/edit'}
            it {should have_content('Welcome!!!')}
          end
        end
      end
    end
  end

end