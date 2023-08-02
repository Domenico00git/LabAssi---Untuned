class Post < ApplicationRecord
  belongs_to :user
  has_many :comments, dependent: :delete_all

  validates :user, presence: true
  validates :content, presence: true, length: { maximum: 500 }
  validates :label, presence: true, length: { maximum: 50 }

  acts_as_followable
  acts_as_votable

  def self.ransackable_attributes(auth_object = nil)
    ["content", "created_at", "id", "label", "updated_at", "user_id", "votes_for_id_eq", "comments_id_eq"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["followings", "user"]
  end

end
