require 'spec_helper'

describe User do

  before {@user = User.new(email: 'example@example.example', name: 'example', password: 'password', password_confirmation: 'password')}

  subject {@user}

  it {should respond_to(:email)}
  it {should respond_to(:name)}
  it {should respond_to(:phone)}
  it {should respond_to(:id)}
  it {should respond_to(:password_digest)}
  it {should respond_to(:password)}
  it {should respond_to(:password_confirmation)}
  it {should respond_to(:authenticate)}

  it {should be_valid}

  #TODO: делать ли проверку верности создания айди?(учитывая, что я использую его как токен для сессии - нужно)

  describe 'email' do
    describe 'when email is not present' do
      before {@user.email = '   '}
      it {should_not be_valid}
    end

    describe 'should be eql /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i' do
      describe 'when email format is invalid' do
        it 'should be invalid' do
          addresses = %w[user@foo,com user_at_foo.org with@to@bar.foo foo@bar+baz.com]
          addresses.each do |invalid_adress|
            @user.email = invalid_adress
            @user.should_not be_valid
          end
        end
      end
      describe 'when email format is valid' do
        it 'should be valid' do
          addresses = %w[user@foo.COM U_s-e.r@foo.org a_b@baz.ru]
          addresses.each do |valid_adress|
            @user.email = valid_adress
            @user.should be_valid
          end
        end
      end
    end

    describe 'when email address is already taken' do
      before do
        @_user = @user.dup
        @_user.email = @_user.email.capitalize
        @_user.save
      end

      it {should_not be_valid}

      after {@_user.destroy}
    end
  end

  describe 'when name is not present' do
    before {@user.name = '   '}
    it {should_not be_valid}
  end

  describe 'password' do
    describe 'when password is not present' do
      before {@user.password = @user.password_confirmation = '   '}
      it {should_not be_valid}
    end
    describe 'when password doesn\'t match confirmation' do
      before {@user.password_confirmation = 'mismatch'}
      it {should_not be_valid}
    end
    describe 'when password confirmation is nil' do
      before {@user.password_confirmation = nil}
      it {should_not be_valid}
    end
    describe 'return value of authenticate method' do
      before {@user.save}
      let(:found_user) {User.find_by_email(@user.email)}
      describe 'with valid password' do
        it {found_user.authenticate(@user.password).should be_true}
      end
      describe 'whit invalid password' do
        it {found_user.authenticate('invalid').should be_false}
      end
      after {@user.destroy}
    end
    describe 'with the password which too short' do
      before {@user.password = @user.password_confirmation = 'b' * 5}
      it {should be_invalid}
    end
  end

  describe 'phone should eql /\+?\d{11,12}/' do
    describe 'when phone format is invalid' do
      it 'should be invalid' do
        phones = %w[a012345678901 0123456789 0123456789012 01234567891d +0123456789]
        phones.each do |invalid_phone|
          @user.phone = invalid_phone
          should_not be_valid
        end
      end
    end

    describe 'when phone format is valid' do
      it 'should be valid' do
        phones = %w[+12345678901 12345678901]
        phones.each do |valid_phone|
          @user.phone = valid_phone
          should be_valid
        end
      end
    end
  end
end
