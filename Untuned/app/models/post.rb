class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :delete_all

  validates :user, presence: true
  validates :content, presence: true 
  validates :label, presence: true

  acts_as_followable
  acts_as_votable

  has_noticed_notifications model_name: 'Notification'
  has_many :notifications, through: :user,  dependent: :destroy

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "label", "updated_at", "user_id", "votes_for_id_eq", "comments_id_eq","notifications_id_eq"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["followings", "user"]
  end

end
