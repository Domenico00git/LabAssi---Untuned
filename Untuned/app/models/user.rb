class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  has_many :posts
  validates :username, presence: true, uniqueness: true, length: { minimum: 5}

  acts_as_follower
  acts_as_followable

end
