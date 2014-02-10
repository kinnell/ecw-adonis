class AddUsersCountToTeams < ActiveRecord::Migration
  def change
  		add_column :teams, :users_count, :integer, default: 0, null: false

  		Team.find_each(select: 'id') do |result|
  			Team.reset_counters(result.id, :users)
  		end
  end
end