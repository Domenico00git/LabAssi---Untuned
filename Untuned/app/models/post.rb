class Post < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :content, presence: true, length: { maximum: 200 }
  validates :label, presence: true, length: { maximum: 20 }

  acts_as_followable

end
