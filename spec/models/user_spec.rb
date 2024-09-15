require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Validations' do
    it 'should successfully register user with all four fields set' do
      @user = User.new(name: "John Doe", email: "johndoe@example.com", password: "Password", password_confirmation: "Password")
      @user.save

      expect(@user.errors.full_messages).to be_empty
    end

    it 'should show an error if password and password confirmation are not the same' do
      @user = User.new(name: "Jane Smith", email: "jsmith@example.com", password: "Purple24", password_confirmation: "purple24")
      @user.save

      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end

    it 'should show an error for empty user password' do
      @user = User.new(name: "Bob Brown", email: "bbrown@example.com", password: "", password_confirmation: "Password$")
      @user.save

      expect(@user.errors.full_messages).to include("Password can't be blank")
    end

    it 'should show an error for empty user password confirmation' do
      @user = User.new(name: "Hope Murphy", email: "hopeful_m@example.com", password: "Password@0", password_confirmation: "")
      @user.save

      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end

    it 'should show an error for empty user name' do
      @user = User.new(name: "", email: "grace.lee@example.com", password: "simplepass", password_confirmation: "simplepass")
      @user.save

      expect(@user.errors.full_messages).to include("Name can't be blank")
    end

    it 'should show an error for empty user email' do
      @user = User.new(name: "David Green", email: "", password: "thisisaverylongpassword123", password_confirmation: "thisisaverylongpassword123")
      @user.save

      expect(@user.errors.full_messages).to include("Email can't be blank")
    end

    it 'should show an error for user email already registered' do
      @user1 = User.create(name: "Jane Smith", email: "jsmith@example.COM", password: "Purple24", password_confirmation: "Purple24")

      @user = User.new(name: "Jennifer Smith", email: "JSMITH@EXAMPLE.com", password: "securepassword", password_confirmation: "securepassword")
      @user.save

      expect(@user.errors.full_messages).to include("Email has already been taken")
    end

    it 'should show an error for user password less than six characters' do
      @user = User.new(name: "Emily White", email: "emily.white@example.com", password: "pass2", password_confirmation: "pass2")
      @user.save

      expect(@user.errors.full_messages).to include("Password is too short (minimum is 6 characters)")
    end

  end
end
