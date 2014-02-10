class Team < ActiveRecord::Base
	include MathHelper

	has_many :users

	default_scope { order("teams.id ASC") }

	def self.withUsers() joins(:users).distinct end

	def size() users_count end
	def hasUsers() users.present? end
	def hasUsersWithWeighins() users.withWeighins.present? end

	def numWeighins() users.includes(:weighins).withWeighins.map{|u| u.weighins_count}.sum end

	def rank()
		Team.all.withUsers.includes(:users => :weighins).sort_by {|t| t.percentWeightChange }.index(self)+1
	end

	def firstWeight() users.includes(:weighins).withWeighins.map{|u| u.firstWeight}.sum end
	def currentWeight() users.includes(:weighins).withWeighins.map{|u| u.currentWeight}.sum end

	def weightChange(wt = currentWeight) wt - firstWeight end
	def percentWeightChange(wt = currentWeight) if hasUsersWithWeighins then percentChange(firstWeight,wt) else 0 end end

	def printPercentWeightChange() formatWeightChange("#{percentWeightChange}%").html_safe end

	private

	def formatWeightChange(str) colorWeightChange(signWeightChange(str)) end

	def colorWeightChange(str)
		if weightChange < 0 then wtColor = "green" elsif weightChange == 0 then wtColor = "black" else wtColor = "red" end
		return "<b><font color='#{wtColor}'>#{str}</font></b>"
	end

	def signWeightChange(str)
		if weightChange >= 0 then "+#{str}" else str end
	end

end
