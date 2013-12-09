class CreateWeighins < ActiveRecord::Migration
  def change
    create_table :weighins do |t|
      t.integer :weight

      t.timestamps
    end
  end
end
