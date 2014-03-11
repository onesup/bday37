class AddNameToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :phone, :string, :null => false
    add_column :users, :birthday, :datetime
  end
end
