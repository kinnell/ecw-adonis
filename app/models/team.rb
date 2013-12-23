class Team < ActiveRecord::Base
	has_many :users

	def membership
		User.all.where(team_id: id)
	end

end
