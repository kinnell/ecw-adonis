module PrintHelper
	include ActionView::Helpers::TextHelper

	def format_time(tm) return tm.in_time_zone('Eastern Time (US & Canada)').strftime("%A, %B %-d, %Y %-I:%M %p %Z") end

	def format_weight(wt) return pluralize(wt, "lb") end

	def format_percentChange(pct)
		if pct < 0 then fColor = "green" elsif pct == 0 then fColor = "black" else fColor = "red" end
		if pct >= 0 then sign = "+" else sign = "" end
		return "<b><font color='#{fColor}'>#{sign}#{pct}%</font></b>".html_safe
	end

	def format_weightChange(wt)
		if wt < 0 then fColor = "green" elsif wt == 0 then fColor = "black" else fColor = "red" end
		if wt >= 0 then sign = "+" else sign = "" end
		return "<b><font color='#{fColor}'>#{sign}#{pluralize(wt, 'lb')}</font></b>".html_safe
	end

	def format_statement(wt, pct)
		if wt < 0 then fColor = "green" elsif wt == 0 then fColor = "black" else fColor = "red" end
		if wt >= 0 then sign = "+" else sign = "" end
		return "<b><font color='#{fColor}'>#{sign}#{pluralize(wt, 'lb')} (#{sign}#{pct}%)</font></b>".html_safe
	end

end
