<%@page import="entities.Hotel"%>
<%@page import="java.awt.Window"%>
<%@page import="dao.IDaoLocale"%>
<%@page import="jakarta.ejb.EJB"%>
<%@page import="entities.Ville"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
	
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<script src="https://cdn.tailwindcss.com"></script>
 <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<meta charset="ISO-8859-1">
<title>Gestion-hotels</title>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
<script>

        function confirmDelete(id) {
            Swal.fire({
                title: 'Confirmation de suppression',
                text: '�tes-vous s�r de vouloir supprimer cet Hotel ?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Oui, supprimer',
                cancelButtonText: 'Annuler'
            }).then((result) => {
                if (result.isConfirmed) {
                    window.location.href = 'HotelController?op=Delete&idH=' + id;
                }
            });
        }
        function reload() {
            window.location.href = 'HotelController';
        }
        function Tri(id) {
        	window.location.href = 'HotelController?op=Tri&idV=' + id;
		}
    </script>
   
</head>

<%
if(request.getAttribute("villes") == null && request.getAttribute("hotels") == null){
	response.sendRedirect("HotelController");
}
String action = request.getParameter("action");
boolean modif = false; 
String nom = "";
String adresse = "";
String telephone = "";
String hotelId = "";
String villeId = "";

if (action != null && action.equals("modifier")) {
    villeId = request.getParameter("idV");
    hotelId = request.getParameter("idH");
    nom = request.getParameter("nom");
    adresse = request.getParameter("adresse");
    telephone =request.getParameter("telephone");
    modif = true; 
}

    
%>

<body class= "bg-gray-300 flex flex-col items-center stify-center">
<%@include file="sidBar.jsp" %>
<button class="absolute top-3 right-3" onclick="reload()">    <i class="bi bi-arrow-clockwise text-3xl text-sky-500"></i>
</button>
	<div class="flex flex-col items-center justify-center w-5/6 ml-[160px] ">
	<%
	if (!modif){
	%>
		<form action="HotelController"
			class="flex flex-col justify-center rounded-xl bg-white shadow-lg w-5/6 items-center mx-auto mt-10 mb-1 ">

			<p class="font-semibold text-center py-3 text-white text-xl bg-[#6883BC] w-full rounded-t-xl py-1 mb-3">Ajouter
				un hotel</p>

			<div class="flex gap-5 justify-center items-end mb-5">
				<div>
					<p class="text-sm text-gray-700">Nom:</p>
					<input type="text" name="nom" value=""
						placeholder="Entrer le nom de l'hotel"
						class="rounded  text-sm py-2 px-3 my-2 bg-gray-50 border border-gray-300 focus:outline-none focus:ring focus:border-sky-500 " />
				</div>
				<div>
					<p class="text-sm text-gray-700">Adresse:</p>
					<input type="text" name="adresse" value=""
						placeholder="Entrer l'adresse "
						class="rounded  text-sm py-2 px-3 my-2 bg-gray-50 border border-gray-300 focus:outline-none focus:ring focus:border-sky-500 " />
				</div>
				<div>
					<p class="text-sm text-gray-700">Telephone:</p>
					<input type="text" name="telephone" value=""
						placeholder="Entrer le telephone"
						class="rounded  text-sm py-2 px-3 my-2 bg-gray-50 border border-gray-300 focus:outline-none focus:ring focus:border-sky-500 " />
				</div>
				<div >
				<p class="text-sm text-gray-700">Ville:</p>
                                <select name="idV" class="rounded  text-sm py-2 px-3 my-2 bg-gray-50 border border-gray-300 focus:outline-none focus:ring focus:border-sky-500 ">
                                    <%
                                    if(request.getAttribute("villes") != null){
                                    	List<Ville> villes = (List<Ville>) request.getAttribute("villes") ;
                                   		 for (Ville v : villes) {%>
                                    		<option value="<%=v.getId()%>"><%=v.getNom()%></option>
                                    <%
                                    }
                                    }%>

                                </select>

                            </div>
				<div
					class="flex text-sm mx-auto px-4 py-2  mb-2.5  cursor-pointer  rounded-xl text-white bg-[#6883BC]   hover:bg-[#5777BC]">
					<input type="submit"
						value="Ajouter" name="op" class="cursor-pointer" />

				</div>

			</div>

		</form>
<%
} else{ 
%>
<form action="HotelController"
			class="flex flex-col justify-center rounded-xl bg-white shadow-lg w-5/6 items-center mx-auto mt-10 mb-4 ">

			<p class="font-semibold text-center py-3 text-white text-xl bg-[#6883BC] w-full rounded-t-xl py-1 mb-3">Modifier
				un hotel</p>
				 <input type="hidden" name="idH" value="<%= hotelId%>"/>
			<div class="flex gap-5 justify-center items-end mb-5">
				<div>
					<p class="text-sm text-gray-700">Nom:</p>
					<input type="text" name="nom" value="<%= nom %>"
						placeholder="Entrer le nom de l'hotel"
						class="rounded  text-sm py-2 px-3 my-2 bg-gray-50 border border-gray-300 focus:outline-none focus:ring focus:border-sky-500 " />
				</div>
				<div>
					<p class="text-sm text-gray-700">Adresse:</p>
					<input type="text" name="adresse" value="<%=adresse %>"
						placeholder="Entrer le nom l'adresse"
						class="rounded  text-sm py-2 px-3 my-2 bg-gray-50 border border-gray-300 focus:outline-none focus:ring focus:border-sky-500 " />
				</div>
				<div>
					<p class="text-sm text-gray-700">Telephone:</p>
					<input type="text" name="telephone" value="<%= telephone %>"
						placeholder="Entrer le telephone"
						class="rounded  text-sm py-2 px-3 my-2 bg-gray-50 border border-gray-300 focus:outline-none focus:ring focus:border-sky-500 " />
				</div>
				<div >
				<p class="text-sm text-gray-700">Ville:</p>
                                <select name="idV" class="rounded  text-sm py-2 px-3 my-2 bg-gray-50 border border-gray-300 focus:outline-none focus:ring focus:border-sky-500 ">
                                    <%
                                    if(request.getAttribute("villes") != null){
                                    	List<Ville> villes = (List<Ville>) request.getAttribute("villes") ;
                                   		 for (Ville v : villes) {
                                   			boolean isSelected = (Integer.parseInt(villeId) == v.getId() );
                                   		 %>
                                    		<option value="<%=v.getId()%>" <%= isSelected ? "selected" : "" %>><%=v.getNom()%></option>
                                    <%
                                    }
                                    }%>

                                </select>

                            </div>
				<div
					class="flex text-sm mx-auto px-4 py-2  mb-2.5  cursor-pointer  rounded-xl text-white bg-[#6883BC]   hover:bg-[#5777BC]">
					<input type="submit"
						value="Modifier" name="op" class="cursor-pointer" />

				</div>

			</div>

		</form>
<%} %>
		<div
			class="flex flex-col justify-center rounded  w-full items-center mx-auto mb-24 mt-1 p-6 ">
			
				<div class="flex justify-center gap-5 items-center bg-white w-2/4 rounded-xl mb-2">
						<p>Tri par ville : </p>
						<select name="idV" class="rounded  text-sm py-2 px-3 my-2 bg-gray-50 border border-gray-300 focus:outline-none focus:ring focus:border-sky-500 " onchange="Tri(this.value)">
						<option>Choisir une ville</option>
                                    <%
                                    if(request.getAttribute("villes") != null){
                                    	List<Ville> villes = (List<Ville>) request.getAttribute("villes") ;
                                   		 for (Ville v : villes) {%>
                                    		<option  value="<%=v.getId()%>"><%=v.getNom()%></option>
                                    <%
                                    }
                                    }%>

                                </select>
					</div>
			<div
				class=" rounded w-5/6 m-5  grid grid-cols-3 gap-14 ">

				


				<%
				if (request.getAttribute("hotels") != null) {
					List<Hotel> hotels = (List<Hotel>) request.getAttribute("hotels");
					for (Hotel h : hotels) {
				%>
				<div class="flex flex-col items-center  shadow-lg w-full justify-between rounded-xl bg-white">
					<span class="py-3 px-1.5 w-full text-center rounded-t-xl text-sm bg-[#6883BC] opacity-70 text-white font-semibold"><%=h.getNom().toUpperCase()%>
					<span class="text-[12px] text-[#6883BC] bg-white px-2 py-1 mx-3 rounded-2xl"><%=h.getVille().getNom()%></span>
					</span>
					<span class="flex flex-col w-5/6 text-gray-700 text-sm">
						<span class="flex items-center py-2">
							<i class="bi bi-pin-map mr-2 text-[#6883BC] "></i>
							<p><%=h.getAdresse()%></p>
						</span>
						<span class="flex items-center py-2">
							<i class="bi bi-telephone-fill mr-2 text-[#6883BC]"></i>
							<p><%=h.getTelephone()%></p>
						</span>
						<span class="flex justify-between px-10 pb-1">
							<p class=" text-[#6883BC] hover:scale-125 "><a href="#" onclick="confirmDelete(<%= h.getId()%>)"><i class="bi bi-trash-fill "></i></a></p>
                    		<p class="text-[#6883BC] hover:scale-125"><a href="?action=modifier&idH=<%=h.getId()%>&nom=<%=h.getNom() %>&adresse=<%= h.getAdresse()%>&telephone=<%= h.getTelephone() %>&idV=<%= h.getVille().getId() %>" ><i class="bi bi-pencil-square"></i></a></p>
						</span>
					</span>
					
				</div>
				<%
				}
				}
				%>

			</div>
		</div>
</body>
</html>