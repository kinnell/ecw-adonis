module WeighinsHelper
	include ActionView::Helpers::TextHelper

	def printWeight(wt = weight) return pluralize(wt, "lb") end

	def printCreatedAt(tm = created_at) return tm.in_time_zone('Eastern Time (US & Canada)').strftime("%A, %B %-d, %Y %-I:%M %p %Z") end
	
	def printWeightChange() formatWeightChange("#{pluralize(weightChange, "lb")}").html_safe end

	def printWeightPercentChange() formatWeightChange("#{weightPercentChange}%").html_safe end

	def printWeightChangeStatement() colorWeightChange("#{printWeightChange} (#{printWeightPercentChange})").html_safe end

	
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
