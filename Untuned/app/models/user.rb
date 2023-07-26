class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts
  validates :username, presence: true, uniqueness: true, length: { minimum: 5}

  acts_as_follower
  acts_as_followable

  def self.ransackable_attributes(auth_object = nil)
    ["birthdate", "country", "created_at", "email", "encrypted_password", "id", "lastname", "name", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at", "username", "admin"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["followings", "follows", "posts"]
  end



end
