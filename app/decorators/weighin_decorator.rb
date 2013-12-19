class WeighinDecorator
	attr_reader :weighin 

	def initialize(weighin)
		@weighin = weighin
	end

	def printWeighin
		weighin.weight
	end


end