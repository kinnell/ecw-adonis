class AddUserIdToWeighins < ActiveRecord::Migration
  def change
    add_column :weighins, :user_id, :integer
    add_index :weighins, :user_id
  end
end
