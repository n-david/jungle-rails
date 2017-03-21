require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do
    context 'when creating a user' do

      context 'when password and password_confirmation are blank' do
        it 'is not valid' do
          @user = User.new(name: 'David', email: 'david@test.com')
          expect(@user).to_not be_valid
        end
      end

      context 'when password and password_confirmation do not match' do
        it 'is not valid' do
          @user = User.new(name: 'David', email: 'david@test.com', password: '123abc', password_confirmation: '123ab')
          expect(@user.password_digest).to_not eql(@user.password_confirmation)
        end
      end

      context 'when password is less than three characters' do
        it 'is not valid' do
          @user = User.new(name: 'David', email: 'david@test.com', password: 'ab', password_confirmation: 'ab')
          expect(@user).to_not be_valid
        end
      end

      it 'is not valid when email already exists' do
        @user = User.create(name: 'a', email: 'a@test.com', password: 'aaa', password_confirmation: 'aaa')
        @user2 = User.new(name: 'b', email: 'a@TEST.com', password: 'aaa', password_confirmation: 'aaa')
        expect(@user2).to_not be_valid
      end

      it 'is not valid when email is blank' do
        @user = User.new(name: 'David', email: nil, password: '123abc', password_confirmation: '123abc')
        expect(@user).to_not be_valid
      end

      it 'is not valid when name is blank' do
        @user = User.new(name: nil, email: 'david@test.com', password: '123abc', password_confirmation: '123abc')
        expect(@user).to_not be_valid
      end

    end
  end

  describe '.authenticate_with_credentials' do
    before(:all) do
      @user = User.create(name: 'David', email: 'david@test.com', password: '123', password_confirmation: '123')
    end

    context 'when user enters all parameters correctly' do
      it 'authenticates the user' do
        expect(User.authenticate_with_credentials('david@test.com', '123')).to_not be_nil
      end
    end

    context 'when user enters nonexistent email' do
      it 'fails to authenticates the user' do
        expect(User.authenticate_with_credentials('nonexistent@email.com', '123')).to be_nil
      end
    end

    context 'when user enters wrong password' do
      it 'fails to authenticates the user' do
        expect(User.authenticate_with_credentials('david@test.com', '456')).to be_nil
      end
    end

    context 'when user types spaces before or after email' do
      it 'authenticates the user' do
        expect(User.authenticate_with_credentials('  david@test.com   ', '123')).to_not be_nil
      end
    end

    context 'when user types in wrong case for email' do
      it 'authenticates the user' do
        expect(User.authenticate_with_credentials('david@TEST.com', '123')).to_not be_nil
      end
    end

  end

end
