require 'spec_helper'

describe 'admin/invites page' do
  before(:all) {@invite = FactoryGirl.create(:invite)}
  before {visit admin_invites_path}

  subject {page}

  it {should have_content('Send invite to:')}
  it {should have_button('Send')}
  it {should have_content(@invite.invite)}

  describe 'on submit' do
    describe 'with invalid email' do
      before do
        fill_in 'Email', with: 'bad_email'
        click_button('Send')
      end

      it {should have_selector('.b-errors')}
    end

    describe 'with valid email' do
      before do
        fill_in 'Email', with: 'example@example.example'
        click_button('Send')
      end

      it {should have_content(Invite.last.invite)}
      it {should_not have_selector('.b-errors')}
    end
  end
  describe 'on submit with valid email'

  after(:all) {@invite.destroy}
end
