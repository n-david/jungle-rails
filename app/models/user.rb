class User < ActiveRecord::Base

  has_secure_password
  has_many :reviews

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: 3 }

  def self.authenticate_with_credentials(email, password)
    @user = find_by_email(email.strip.downcase)
    @user && @user.authenticate(password) ? @user : nil
  end

end
