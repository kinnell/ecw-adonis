class AddPrivacyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :visible, :boolean, :default => true
  end
end
