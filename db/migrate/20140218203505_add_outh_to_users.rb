class AddOuthToUsers < ActiveRecord::Migration
  def change
  	add_column :users, :provider, :string
  	add_column :users, :uid, :string
  	add_column :users, :outh_token, :string
  	add_column :users, :outh_expires_at, :datetime
  end
end
