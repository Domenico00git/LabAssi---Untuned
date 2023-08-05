class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  acts_as_votable

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications 
  
  has_noticed_notifications model_name: 'Notification'

  private

  def notify_recipient
    CommentNotification.with(comment: self, post: post).deliver_later(post.user)
    CommentNotification.with(comment: self, post: post).deliver_later(post.followers)
  end

  def cleanup_notifications
    notifications_as_comment.destroy_all 
  end


  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "id", "updated_at", "user_id", "votes_for_id_eq" ]
  end

  def self.ransackable_associations(auth_object = nil)
    ["post", "user"]
  end

end
