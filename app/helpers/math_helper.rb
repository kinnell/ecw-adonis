module MathHelper

	def percentChange(firstInt, secondInt) (100*(secondInt-firstInt).to_f/firstInt.to_f).round(2) end

	def weighinWeek(date) if date < Time.parse("08/01/2014") then 0 else ((date - Time.parse("05/01/2014"))/604800).ceil end end

end