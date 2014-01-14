class Team < ActiveRecord::Base
	has_many :users

	default_scope { order("teams.id ASC") }

	include MathHelper

	def self.withUsers() joins(:users).distinct end

	def size() users.size end
	def hasUsers() users.present? end
	def hasUsersWithWeighins() users.withWeighins.present? end

	def firstWeight() users.withWeighins.map{|u| u.firstWeight}.sum end
	def currentWeight() users.withWeighins.map{|u| u.currentWeight}.sum end		

	def weightChange(wt = currentWeight) wt - firstWeight end
	def weightPercentChange(wt = currentWeight) if hasUsersWithWeighins then percentChange(firstWeight,wt) else 0 end end

	def printWeightPercentChange() formatWeightChange("#{weightPercentChange}%").html_safe end


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
