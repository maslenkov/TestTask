require 'spec_helper'

describe Invite do

  before {@invite = Invite.new}

  subject {@invite}

  it {should respond_to(:invite)}
  it {should respond_to(:status)}

  it 'should have status true on creating' do
    @invite.status.should eq true
  end

  it 'must have 8 chars in invite' do
    @invite.invite.should have(8).characters
  end

  it 'should have unique invite' do
    should be_valid
    @invite.save
    another_invite = Invite.new
    another_invite.invite = @invite.invite
    another_invite.should_not be_valid
  end

  after {@invite.destroy}
  #pending "add some examples to (or delete) #{__FILE__}"
end
