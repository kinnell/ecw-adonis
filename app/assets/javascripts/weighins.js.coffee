# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/


jQuery ->
	Morris.Line
	  element: "weighins_chart"
	  data: $("#weighins_chart").data("weighins")
	  xkey: "created_at"
	  ykeys: ["weight"]
	  labels: ["Weight"]
	  xLabels: ["day"]
	  postUnits: [" lbs"]
	  dateFormat: (date) ->
	    d = new Date(date)
	    d.getDate() + "/" + (d.getMonth() + 1) + "/" + d.getFullYear()


	Morris.Line
	  element: "weighins_chart2"
	  data: $("#weighins_chart").data("weighins")
	  xkey: "created_at"
	  ykeys: ["weight"]
	  labels: ["Weight"]
	  xLabels: ["day"]
	  postUnits: [" lbs"]
	  dateFormat: (date) ->
	    d = new Date(date)
	    d.getDate() + "/" + (d.getMonth() + 1) + "/" + d.getFullYear()




