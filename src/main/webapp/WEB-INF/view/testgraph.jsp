<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>

<%@ page import="java.util.*" %>
<%@ page import="com.google.gson.Gson"%>
<%@ page import="com.google.gson.JsonObject"%>


<!-- 

https://canvasjs.com/jsp-charts/pie-chart/
https://www.jeejava.com/google-chart-using-jsp-servlet/   

https://www.fusioncharts.com/java-charts
 -->
 
<!DOCTYPE HTML>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<script src="https://canvasjs.com/assets/script/canvasjs.min.js"></script>
<script type="text/javascript">
window.onload = function() { 
	 
	var chart = new CanvasJS.Chart("chartContainer", {
		animationEnabled: true,
		title:{
			text: "Aluminium Demand by Sector - 2014"
		},
		legend: {
			verticalAlign: "center",
			horizontalAlign: "right"
		},
		data: [{
			type: "pie",
			showInLegend: true,
			indexLabel: "{y}%",
			indexLabelPlacement: "inside",
			legendText: "{label}: {y}%",
			toolTipContent: "<b>{label}</b>: {y}%",
			dataPoints : ${dataPoints}
		}]
	});
	chart.render();
	 
	}
</script>






</head>
<body>
<div id="chartContainer" style="height: 370px; width: 50%;"></div>




<html>
  <head>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['Work',     11],
          ['Eat',      2],
          ['Commute',  2],
          ['Watch TV', 2],
          ['Sleep',    7]
        ]);

        var options = {
          title: 'My Daily Activities',
          is3D: true,
        };

        var chart = new google.visualization.PieChart(document.getElementById('piechart_3d'));
        chart.draw(data, options);
      }
    </script>
  </head>
  <body>
    <div id="piechart_3d" style="width: 900px; height: 500px;"></div>
    
    <br>
    
    <html>
  <head>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load("current", {packages:["corechart"]});
      google.charts.setOnLoadCallback(drawChart);
      function drawChart() {
        var data = google.visualization.arrayToDataTable([
          ['Task', 'Hours per Day'],
          ['Work',     11],
          ['Eat',      2],
          ['Commute',  2],
          ['Watch TV', 2],
          ['Sleep',    7]
        ]);

        var options = {
          title: 'My Daily Activities',
          pieHole: 0.5,
        };

        var chart = new google.visualization.PieChart(document.getElementById('donutchart'));
        chart.draw(data, options);
      }
    </script>
  </head>
  <body>
    <div id="donutchart" style="width: 900px; height: 500px;"></div>
  </body>
    
    
    <html>
  <head>
    <script type="text/javascript" src="https://www.gstatic.com/charts/loader.js"></script>
    <script type="text/javascript">
      google.charts.load('current', {'packages':['corechart']});
      google.charts.setOnLoadCallback(drawVisualization);

      function drawVisualization() {
        // Some raw data (not necessarily accurate)
        var data = google.visualization.arrayToDataTable([
          ['Month', 'Bolivia', 'Ecuador', 'Madagascar', 'Papua New Guinea', 'Rwanda', 'Average'],
          ['2004/05',  165,      938,         522,             998,           450,      614.6],
          ['2005/06',  135,      1120,        599,             1268,          288,      682],
          ['2006/07',  157,      1167,        587,             807,           397,      623],
          ['2007/08',  139,      1110,        615,             968,           215,      609.4],
          ['2008/09',  136,      691,         629,             1026,          366,      569.6]
        ]);

        var options = {
          title : 'Monthly Coffee Production by Country',
          vAxis: {title: 'Cups'},
          hAxis: {title: 'Month'},
          seriesType: 'bars',
          series: {5: {type: 'line'}}
        };

        var chart = new google.visualization.ComboChart(document.getElementById('chart_div'));
        chart.draw(data, options);
      }
    </script>
  </head>
  <body>
    <div id="chart_div" style="width: 900px; height: 500px;"></div>
  </body>
  
  
  
  
  
  <br>
  <br>
  
  
  <%
Gson gsonObj = new Gson();
Map<Object,Object> map = null;
List<Map<Object,Object>> list = new ArrayList<Map<Object,Object>>();
 
map = new HashMap<Object,Object>(); map.put("label", "FY11"); map.put("y", 146.65); list.add(map);
map = new HashMap<Object,Object>(); map.put("label", "FY12"); map.put("y", 201.46); list.add(map);
map = new HashMap<Object,Object>(); map.put("label", "FY13"); map.put("y", 202.69); list.add(map);
map = new HashMap<Object,Object>(); map.put("label", "FY14"); map.put("y", 201.7); list.add(map);
map = new HashMap<Object,Object>(); map.put("label", "FY15"); map.put("y", 175.51); list.add(map);
map = new HashMap<Object,Object>(); map.put("label", "FY16"); map.put("y", 132.03); list.add(map);
 
String dataPoints = gsonObj.toJson(list);
%>
  
  
<script type="text/javascript">
window.onload = function() { 
 
var chart = new CanvasJS.Chart("chartContainer", {
	title: {
		text: "Imports of Ore and Minerals in India"
	},
	axisX: {
		title: "Fiscal Year"
	},
	axisY: {
		title: "Imports (in billion USD)"
	},
	data: [{
		type: "column",
		yValueFormatString: "$#,##0.0# billion",
		dataPoints: <%out.print(dataPoints);%>
	}]
});
chart.render();
 
}
</script>
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
</html>