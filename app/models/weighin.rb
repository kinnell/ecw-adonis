class Weighin < ActiveRecord::Base
	belongs_to :user
	validates :weight, presence: true, numericality: { greater_than: 0 }

	def firstWeight() Weighin.by_user(user)[0].weight end

	def weighinNum
		Weighin.by_user(user).each_with_index do |wt, i|
			return (i+1) if wt.id == id
		end
	end

	def allWeightPercentTotalChanges
		weightPercentTotalChanges = Array.new(Weighin.by_user(user).length)

		Weighin.by_user(user).each_with_index do |wt, i|
			weightPercentTotalChanges[i] = wt.weightPercentTotalChange
		end

		return weightPercentTotalChanges

	end

	def previousWeight
		if weighinNum == 1
			return weight
		else
			return Weighin.by_user(user)[weighinNum-2].weight
		end
	end

	def weightChange() weight - previousWeight end
	def weightTotalChange() weight - firstWeight end

	def weightPercentChange() (100*(weightChange.to_f)/previousWeight.to_f).round(2) end
	def weightPercentTotalChange() (100*(weightTotalChange.to_f)/firstWeight.to_f).round(2) end

	
	def printWeightChange() printWeight(weightChange, weightPercentChange) end
	def printWeightTotalChange() printWeight(weightTotalChange, weightPercentTotalChange) end


	def printWeight wtChange, wtPercentChange
		if weightTotalChange < 0
			("<font color=green>" + printLbs(wtChange) + " <b>(" + printSign(wtPercentChange) + "%)</b></font>").html_safe
		elsif weightTotalChange == 0
			("<font color=black>" + printLbs(wtChange) + " <b>(" + printSign(wtPercentChange) + "%)</b></font>").html_safe
		elsif (weightTotalChange > 0)
			("<font color=red>" + printLbs(wtChange) + " <b>(" + printSign(wtPercentChange) + "%)</b></font>").html_safe
		end
	end

	def printLbs wt
		if wt == 1
			(printSign(wt) + " lb")
		else
			(printSign(wt) + " lbs")
		end	
	end

	def printSign num
		if num >= 0
			return ("+" + num.to_s)
		else
			return num.to_s
		end
	end

	def printCreatedAt() return created_at.strftime("%A, %B %-d, %Y %-I:%M %p") end

	def self.by_user(user)
		where(user: user)
	end

	def self.allWeightPercentTotalChanges(user)
		weightPercentTotalChanges = Array.new(Weighin.by_user(user).length)

		Weighin.by_user(user).each_with_index do |wt, i|
			weightPercentTotalChanges[i] = Hash(created_at: wt.created_at, percent_change: wt.weightPercentTotalChange)
		end

		return weightPercentTotalChanges

	end
 










end

