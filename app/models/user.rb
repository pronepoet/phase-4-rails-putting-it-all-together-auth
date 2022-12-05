class User < ApplicationRecord
    has_secure_password
    has_many :recipes
    validates :user, presence: true, uniqueness: true
end
