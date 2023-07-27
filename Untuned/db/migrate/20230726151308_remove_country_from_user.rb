class RemoveCountryFromUser < ActiveRecord::Migration[7.0]
  def change
    remove_column :users, :country, :string
  end
end
