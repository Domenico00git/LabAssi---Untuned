class RemoveLikeAndDislikeFromPost < ActiveRecord::Migration[7.0]
  def change
    remove_column :posts, :like, :integer
    remove_column :posts, :dislike, :integer
  end
end
