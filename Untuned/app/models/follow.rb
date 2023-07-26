class Follow < ApplicationRecord

  extend ActsAsFollower::FollowerLib
  extend ActsAsFollower::FollowScopes

  # NOTE: Follows belong to the "followable" and "follower" interface
  belongs_to :followable, polymorphic: true
  belongs_to :follower,   polymorphic: true

  def block!
    self.update_attribute(:blocked, true)
  end

  def self.ransackable_attributes(auth_object = nil)
    ["blocked", "created_at", "followable_id", "followable_type", "follower_id", "follower_type", "id", "updated_at"]
  end

end
