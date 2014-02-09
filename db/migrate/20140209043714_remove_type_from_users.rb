class RemoveTypeFromUsers < ActiveRecord::Migration
  def change
  		remove_column :users, :type
  		add_column :users, :auth_type, :string
  end
end
