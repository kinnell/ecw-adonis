class Weighin < ActiveRecord::Base
	include WeighinsHelper

	belongs_to :user, touch: true
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
		return weight if weighinNum == 1
		return Weighin.by_user(user)[weighinNum-2].weight
	end

	def weightChange() weight - previousWeight end
	def weightTotalChange() weight - firstWeight end

	def weightPercentChange() (100*(weightChange.to_f)/previousWeight.to_f).round(2) end
	def weightPercentTotalChange() (100*(weightTotalChange.to_f)/firstWeight.to_f).round(2) end
	
	def printWeightChange() printWeight(weightChange, weightPercentChange) end
	def printWeightTotalChange() printWeight(weightTotalChange, weightPercentTotalChange) end
	
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
 
 	def weighinWeek
 		return 0 if created_at < Time.parse("08/01/2014")
 		return ((created_at - Time.parse("05/01/2014"))/604800).ceil
 	end










end

