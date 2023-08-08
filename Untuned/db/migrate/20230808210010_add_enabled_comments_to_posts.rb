class AddEnabledCommentsToPosts < ActiveRecord::Migration[7.0]
  def change
    add_column :posts, :comments_enabled, :boolean
  end
end
