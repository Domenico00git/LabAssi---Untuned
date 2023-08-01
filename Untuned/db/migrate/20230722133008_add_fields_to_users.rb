class AddFieldsToUsers < ActiveRecord::Migration[7.0]
  def change
    add_column :users, :username, :string
    add_index :users, :username, unique: true
    add_column :users, :name, :string
    add_column :users, :lastname, :string
    add_column :users, :birthdate, :date
  end
end
