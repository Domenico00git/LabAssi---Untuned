class CreatePosts < ActiveRecord::Migration[7.0]
  def change
    create_table :posts do |t|
      t.references :user, null: false, foreign_key: true
      t.text :content
      t.integer :like
      t.integer :dislike
      t.string :label

      t.timestamps
    end
  end
end