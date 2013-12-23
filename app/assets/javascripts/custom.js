jQuery(function() {
  Morris.Line({
    element: "weight_chart",
    data: $("#weight_chart").data("weighins"),
    xkey: "created_at",
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
    dateFormat: function(date) {
      var d;
      d = new Date(date);
      return (d.getMonth() + 1) + "/" + d.getDate() + "/" + d.getFullYear();
    },
    xLabelFormat: function(date) {
      return (date.getMonth() + 1) + "/" + date.getDate() + "/" + date.getFullYear(); 
      },
  });

});