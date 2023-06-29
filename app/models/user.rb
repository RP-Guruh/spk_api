class User < ApplicationRecord
    has_secure_password
  
    # Validations
    validates :fullname, presence: true
    validates :email, presence: true, uniqueness: true
    validates :username, presence: true, uniqueness: true
    validates :password, presence: true, length: { minimum: 6 }
  end
  