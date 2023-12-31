<%@page import="java.util.regex.Matcher"%>
<%@page import="java.util.regex.Pattern"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>

<%
String url = request.getRequestURL().toString();
Pattern pattern = Pattern.compile("[^/]+\\.jsp");
Matcher matcher = pattern.matcher(url);
String nomFichierJSP = "";
if (matcher.find()) {
    nomFichierJSP = matcher.group();
}
%>

<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>sidebar</title>
        <script src="https://cdn.tailwindcss.com"></script>
        <!-- <script src="./tailwind3.js"></script> -->
        <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@200;300;400;500;600;800&display=swap"
              rel="stylesheet">
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
        
    </head>

    <body class=" font-[Poppins] bg-gray-200 ">
        <div class="sidebar  fixed top-0 bottom-0 lg:left-0 left-[-300px] duration-1000
               w-[160px] overflow-y-auto text-center  bg-white shadow h-screen m-2 rounded-xl" >


            <div class=" text-xl">
                <div class="py-6 px-2  flex justify-center items-center  mb-5 bg-[#6883BC] ">
                    <i class="bi bi-house text-white"></i>
                    <h1 class="ml-1 text-xl text-white font-semibold">GestHotels</h1>
                </div>

                <div class="p-2.5" >
                    
                    <div  class="p-2.5 mt-2 flex items-center  rounded-md px-4 <%if (nomFichierJSP.equals("hotel.jsp")){%>bg-gray-200 <%}%> duration-300  cursor-pointer  hover:bg-gray-200">
                        <i class="bi bi-building text-gray-900"></i>
                        <span class="text-[15px] ml-4 text-gray-900 "><a href="hotel.jsp">Hotels</a></span>
                    </div>
                    
                    <div class="p-2.5 mt-2 flex items-center rounded-md px-4 <%if (nomFichierJSP.equals("ville.jsp")){%>bg-gray-200 <%}%>duration-300 cursor-pointer  hover:bg-gray-200">
                        <i class="bi bi-geo-alt-fill text-gray-600"></i>
                        <span class="text-[15px] ml-4 text-gray-900"><a href="ville.jsp">Villes</a></span>
                    </div>
                    <div class="p-2.5 mt-2 flex items-center rounded-md px-4 <%if (nomFichierJSP.equals("statistiques.jsp")){%>bg-gray-200 <%}%>duration-300 cursor-pointer  hover:bg-gray-200">
                        <i class="bi bi-bar-chart text-gray-900"></i>
                        <span class="text-[15px] ml-4 text-gray-900"><a href="statistiques.jsp">Statistiques</a></span>
                    </div>
                </div>
            </div>
        </div>

        <script>
            function dropDown() {
                document.querySelector('#submenu').classList.toggle('hidden')
                document.querySelector('#arrow').classList.toggle('rotate-0')
            }
            dropDown()

            function Openbar() {
                document.querySelector('.sidebar').classList.toggle('left-[-300px]')
            }
        </script>


    </body>

</html>