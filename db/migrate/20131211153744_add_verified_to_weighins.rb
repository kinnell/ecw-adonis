class AddVerifiedToWeighins < ActiveRecord::Migration
  def change
    add_column :weighins, :verified, :boolean, :default => false
  end
end
