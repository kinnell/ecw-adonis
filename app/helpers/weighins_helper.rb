module WeighinsHelper
	include ActionView::Helpers::TextHelper

	def printCreatedAt() return created_at.strftime("%A, %B %-d, %Y %-I:%M %p") end


	def printWeightPercentChange wtPercentChange
		pWeight = "<b>#{printSign(wtPercentChange)}%</b></font>"
		return ("<font color=green>" + pWeight).html_safe if wtPercentChange < 0
		return ("<font color=black>" + pWeight).html_safe if wtPercentChange == 0
		return ("<font color=red>" + pWeight).html_safe if wtPercentChange > 0	

	end

	def printWeight wtChange, wtPercentChange
		pWeight = "#{pluralize(wtChange, 'lb')} <b>(#{printSign(wtPercentChange)}%)</b></font>"
		return ("<font color=green>" + pWeight).html_safe if weightTotalChange < 0
		return ("<font color=black>" + pWeight).html_safe if weightTotalChange == 0
		return ("<font color=red>" + pWeight).html_safe if weightTotalChange > 0
		
	end

	def printSign num
		return "+#{num.to_s}" if num >= 0
		return num.to_s
	end

end
