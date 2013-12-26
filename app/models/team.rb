class Team < ActiveRecord::Base
	has_many :users

	def membership
		User.all.where(team_id: id)
	end

	def teamPercentLoss
		initialWeight = 0
		finalWeight = 0

		membership.each do |user|
			initialWeight += user.weighins.first.weight
			finalWeight += user.weighins.last.weight
		end

		return (100*(finalWeight.to_f-initialWeight.to_f)/(initialWeight.to_f)).round(2)
	end

end
