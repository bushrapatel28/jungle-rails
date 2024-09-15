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

  describe '.authenticate_with_credentials' do
    
    it 'should login a user with registered email and password' do
      @user = User.create(name: "Frank Black", email: "frank.black@example.com", password: "p@ssw0rd!", password_confirmation: "p@ssw0rd!")

      @session_user = User.authenticate_with_credentials("frank.black@EXAMPLE.com", "p@ssw0rd!")
      expect(@session_user).to eq(@user)
    end
    
    it 'should not authenticate user with invalid email' do
      @user = User.create(name: "Isabella Davis", email: "isabella.davis@example.com", password: "matching123", password_confirmation: "matching123")
      
      @session_user = User.authenticate_with_credentials("isabell.adavis@example.com", "matching123")
      expect(@session_user).to be_nil
    end
    
    it 'should not authenticate user with incorrect password' do
      @user = User.create(name: "Henry Moore", email: "henry.moore@example.com", password: "password2024!", password_confirmation: "p@ssw0rd!")
      
      @session_user = User.authenticate_with_credentials("henry.moore@example.com", "password!")
      expect(@session_user).to be_nil
    end
    
    it 'should login a user with leading and trailing spaces in the email' do
      @user = User.create(name: "Frank Black", email: "frank.black@example.com", password: "p@ssw0rd!", password_confirmation: "p@ssw0rd!")

      @session_user = User.authenticate_with_credentials(" frank.black@example.com ", "p@ssw0rd!")
      expect(@session_user).to eq(@user)
    end

    it 'should login a user with wrong case used in the email' do
      @user = User.create(name: "Frank Black", email: "frank.black@EXAMPLE.com", password: "p@ssw0rd!", password_confirmation: "p@ssw0rd!")

      @session_user = User.authenticate_with_credentials("fRank.black@example.COM", "p@ssw0rd!")
      expect(@session_user).to eq(@user)
    end

  end

end
