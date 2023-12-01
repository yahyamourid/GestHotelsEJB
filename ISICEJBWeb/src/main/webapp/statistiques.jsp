<%@page import="entities.Ville"%>
<%@page import="entities.Hotel"%>
<%@page import="java.util.List"%>
<%@ page import="com.google.gson.Gson"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Graphique des Hôtels par Ville</title>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
</head>
<%
if (request.getAttribute("villes") == null && request.getAttribute("hotels") == null) {
	response.sendRedirect("statsController");
}
List<Ville> villes = (List<Ville>) request.getAttribute("villes");
List<Hotel> hotels = (List<Hotel>) request.getAttribute("hotels");
%>
<body
	class="flex flex-col justify-center items-center w-5/6 h-full ml-[160px] bg-gray-200">
	<%@include file="sidBar.jsp"%>
	<div class="flex items-center justify-center gap-10 w-2/3 py-10 font-bold ">
		<span class="p-5 text-2xl text-white bg-green-400 rounded shadow-xl"><%=villes.size()%>
			Villes</span> 
		<span class="p-5 text-2xl text-white bg-indigo-400 rounded shadow-xl"><%=hotels.size()%>
			Hotels</span>
	</div>
	<div class="p-5 w-2/3 h-2/3 rounded shadow-xl bg-white">
		<canvas id="hotelChart"></canvas>
	</div>

	<script>
		var villes =
	<%=new Gson().toJson(villes)%>
		;
		var hotels =
	<%=new Gson().toJson(hotels)%>
		;
		var labels = [];
		var data = [];

		for (var i = 0; i < villes.length; i++) {
			labels.push(villes[i].nom);

			var count = 0;
			for (var j = 0; j < hotels.length; j++) {
				if (hotels[j].ville.id === villes[i].id) {
					count++;
				}
			}
			data.push(count);
		}

		var ctx = document.getElementById('hotelChart').getContext('2d');
		var myChart = new Chart(ctx, {
			type : 'bar',
			data : {
				labels : labels,
				datasets : [ {
					label : 'Nombre d\'Hôtels par Ville',
					data : data,
					backgroundColor : [ 'rgba(255, 99, 132',
							'rgba(54, 162, 235', 'rgba(255, 206, 86)',
							'rgba(75, 192, 192)', 'rgba(153, 102, 255)',
							'rgba(255, 159, 64)' ],
					borderColor : [ 'rgba(255, 99, 132, 1)',
							'rgba(54, 162, 235, 1)', 'rgba(255, 206, 86, 1)',
							'rgba(75, 192, 192, 1)', 'rgba(153, 102, 255, 1)',
							'rgba(255, 159, 64, 1)' ],

					borderWidth : 1
				} ]
			},
			options : {
				legend : {
					display : false
				},
				scales : {
					yAxes : [ {
						scaleLabel : {
							display : true,
							labelString : 'Nombre d\'hotel',
							fontStyle : 'bold',
							fontSize : 15
						},
						ticks : {
							beginAtZero : true,
							stepSize : 1
						}
					} ],
					xAxes : [ {
						scaleLabel : {
							display : true,
							labelString : 'Les villes',
							fontStyle : 'bold',
							fontSize : 15
						},

						animation : {
							duration : 10000,
							easing : 'easeOutBack'
						}
					} ]

				}
			}
		});
	</script>
</body>
</html>
