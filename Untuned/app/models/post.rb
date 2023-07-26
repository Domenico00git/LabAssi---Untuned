class Post < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :content, presence: true, length: { maximum: 200 }
  validates :label, presence: true, length: { maximum: 20 }

  acts_as_followable

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "dislike", "id", "label", "like", "updated_at", "user_id"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["followings", "user"]
  end

end
