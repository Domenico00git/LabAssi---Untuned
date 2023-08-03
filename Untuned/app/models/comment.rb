class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  acts_as_votable

  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "id", "post_id", "updated_at", "user_id", "votes_for_id_eq" ]
  end

  def self.ransackable_associations(auth_object = nil)
    ["post", "user"]
  end

end
