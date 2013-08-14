class User < ActiveRecord::Base
  has_secure_password

  has_many :posts
  has_many :comments

  def authenticate(unencrypted_password)
    BCrypt::Password.new(password_digest) == unencrypted_password && self
  end


end
