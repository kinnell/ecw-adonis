jQuery(function() {


  Morris.Line({
    element: "weight_chart",
    data: $("#weight_chart").data("weighins"),
    xkey: ["created_at"],
    ykeys: ["weight"],
    labels: ["Weight"],
    xLabel: ["day"],
    xLabelFormat: function(date) {
      return (date.getMonth() + 1) + "/" + date.getDate() + "/" + date.getFullYear(); 
    },
    postUnits: [" lbs"],
    dateFormat: function(date) {
      var d;
      d = new Date(date);
      return (d.getMonth() + 1) + "/" + d.getDate() + "/" + d.getFullYear();
    },
  });

  Morris.Line({
    element: "percent_chart",
    data: $("#percent_chart").data("weighins"),
    xkey: ["created_at"],
    ykeys: ["percent_change"],
    labels: ["Percent Change"],
    xLabels: ["day"],
    postUnits: ["%"],
    dateFormat: function(date2) {
      var d;
      d = new Date(date2);
      return (d.getMonth() + 1) + "/" + d.getDate() + "/" + d.getFullYear();
    },
    xLabelFormat: function(date2) {
      return (date2.getMonth() + 1) + "/" + date2.getDate() + "/" + date2.getFullYear(); 
    },
  });

});

