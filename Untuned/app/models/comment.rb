class Comment < ApplicationRecord
  belongs_to :post
  belongs_to :user

  acts_as_votable

  after_create_commit :notify_recipient
  before_destroy :cleanup_notifications 
  
  has_noticed_notifications model_name: 'Notification'

  validates :body, presence: true, length: { minimum: 1}

  private

  def notify_recipient
    # Crea oggetto CommentNotification con i parametri passati e lo "consegna" all'autore del post se non è autore del commento
    if post.user_id != self.user_id
      CommentNotification.with(comment: self, post: post).deliver_later(post.user)
    end

    # Crea oggetto CommentNotification con i parametri passati e lo "consegna" ai follower del post tranne all'autore del commento se anche questo segue il post
    post.followers.each do |follower|
      if follower.id != self.user_id
        CommentNotification.with(comment: self, post: post).deliver_later(follower)
      end
    end
  end

  def cleanup_notifications
    notifications_as_comment.destroy_all 
  end


  def self.ransackable_attributes(auth_object = nil)
    ["body", "created_at", "id", "post_id", "updated_at", "user_id", "votes_for_id_eq" ]
  end
  def self.ransackable_associations(auth_object = nil)
    ["post", "user"]
  end

end
