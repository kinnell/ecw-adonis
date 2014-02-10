class AddWeighinsCountToUsers < ActiveRecord::Migration
  def change
  		add_column :users, :weighins_count, :integer, default: 0, null: false

  		User.find_each(select: 'id') do |result|
  			User.reset_counters(result.id, :weighins)
  		end
  end
end