class DropCommentTable < ActiveRecord::Migration[7.0]
  def self.down
    drop_table :comments
  end
end
