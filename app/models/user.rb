class User < ApplicationRecord
  has_secure_password

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, presence: true, length: { minimum: 6 }
  validates :password_confirmation, presence: true

  def self.authenticate_with_credentials(email_address, password)
    normalized_email = email_address.strip
    #SQL SELECT statement will return an Array
    @user = User.find_by_sql(["SELECT * FROM users WHERE LOWER(email) = LOWER(?)", normalized_email])
    # If the user exists AND the password entered is correct.
    if @user.first && @user.first.authenticate(password)
      # If user is successfully authenticated, return an instance of the user
      @user.first
    else
      # If user's authentication fails, return nil
      nil
    end
  end
end
