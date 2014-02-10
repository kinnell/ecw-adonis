module MathHelper

	def percentChange(firstInt, secondInt) (100*(secondInt-firstInt).to_f/firstInt.to_f).round(2) end

end