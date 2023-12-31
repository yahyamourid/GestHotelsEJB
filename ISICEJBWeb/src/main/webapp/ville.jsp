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
<link rel="stylesheet"
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.7.2/font/bootstrap-icons.css">
<meta charset="ISO-8859-1">
<title>Gestion-villes</title>
<script
	src="https://cdn.jsdelivr.net/npm/sweetalert2@11/dist/sweetalert2.all.min.js"></script>
<script>

        function confirmDelete(id) {
            Swal.fire({
                title: 'Confirmation de suppression',
                text: '�tes-vous s�r de vouloir supprimer cette ville ?',
                icon: 'warning',
                showCancelButton: true,
                confirmButtonText: 'Oui, supprimer',
                cancelButtonText: 'Annuler'
            }).then((result) => {
                if (result.isConfirmed) {
                    // L'utilisateur a confirm� la suppression, redirigez vers la page de suppression
                    window.location.href = 'VilleController?op=Delete&id=' + id;
                }
            });
        }
        function reload() {
            window.location.href = 'VilleController';
        }
    </script>

</head>

<%
if (request.getAttribute("villes") == null) {
	response.sendRedirect("VilleController");
}
String action = request.getParameter("action");
boolean modif = false;
String nom = "";
String villeId = "";

if (action != null && action.equals("modifier")) {
	villeId = request.getParameter("id");
	nom = request.getParameter("nom");
	modif = true;
}
%>

<body class="bg-gray-300 flex flex-col items-center stify-center">
	<%@include file="sidBar.jsp"%>
	<button class="absolute top-3 right-3" onclick="reload()">
		<i class="bi bi-arrow-clockwise text-3xl text-sky-500"></i>
	</button>
	<div
		class="flex flex-col items-center justify-center w-5/6 ml-[160px]  ">
		<%
		if (!modif) {
		%>
		<form action="VilleController"
			class="flex flex-col justify-center rounded-xl bg-white shadow-lg w-2/4 items-center mx-auto mt-10 mb-4 ">

			<p class="font-semibold text-center py-3 text-white text-xl bg-[#6883BC] w-full rounded-t-xl py-1 mb-1">Ajouter
				une ville</p>
			<div class="flex gap-2 justify-center items-end mb-5">
				<div>
					<p class="text-sm text-gray-700">Nom:</p>
					<input type="text" name="ville" value=""
						placeholder="Entrer le nom de la ville"
						class="rounded  text-sm py-2 px-3 my-2 bg-gray-50 border border-gray-300 focus:outline-none focus:ring focus:border-sky-500 " />
				</div>
				<div
					class="flex text-sm mx-auto px-4 py-2  mb-2.5  cursor-pointer  rounded-xl text-white bg-[#6883BC]   hover:bg-[#5777BC]">
					 <input type="submit"
						value="Ajouter" name="op" class="cursor-pointer" />

				</div>

			</div>

		</form>
		<%
		} else {
		%>
		<form action="VilleController"
			class="flex flex-col justify-center rounded-xl bg-white shadow-lg w-2/4 items-center mx-auto mt-10 mb-4 ">

			<p class="font-semibold text-center py-3 text-white text-xl bg-[#6883BC] w-full rounded-t-xl py-1 mb-1">Modifier
				une ville</p>
			<input type="hidden" name="id" value="<%=villeId%>" />
			<div class="flex gap-2 justify-center items-end mb-5">
				<div>
					<p class="text-sm text-gray-700">Nom:</p>
					<input type="text" name="ville" value="<%=nom%>"
						placeholder="Entrer le nom de la ville"
						class="rounded  text-sm py-2 px-3 my-2 bg-gray-50 border border-gray-300 focus:outline-none focus:ring focus:border-sky-500 " />
				</div>
				<div
					class="flex text-sm mx-auto px-4 py-2  mb-2.5  cursor-pointer  rounded-xl text-white bg-[#6883BC]   hover:bg-[#5777BC]">
					<input type="submit" value="Modifier" name="op" class="cursor-pointer" />

				</div>

			</div>

		</form>
		<%
		}
		%>
		<div
			class="flex flex-col justify-center rounded-xl bg-white shadow-lg w-10/12 items-center mx-auto mb-24 mt-10  ">
			<p class="font-semibold text-center py-3 text-white text-xl bg-[#6883BC] w-full rounded-t-xl py-1 mb-5">
			La lise des villes</p>
			<div
				class="bg-[#FDFDFD] border border-gray-200 rounded w-9/12  flex flex-col mb-6">

				<div
					class="flex items-center justify-between border-b mb-1 bg-gray-200 text-lg text-black font-semibold  ">
					<p class="p-2 text-center w-1/4">ID</p>
					<p class="p-2 text-center w-1/4">Nom</p>
					<p class="p-2 text-center w-1/4">Supprimer</p>
					<p class="p-2 text-center w-1/4">Modifier</p>
				</div>


				<%
				if (request.getAttribute("villes") != null) {
					List<Ville> villes = (List<Ville>) request.getAttribute("villes");
					for (Ville v : villes) {
				%>
				<div class="flex items-center justify-between  border-b ">
					<p class="p-2 text-center w-1/4"><%=v.getId()%></p>
					<p class="p-2 text-center w-1/4"><%=v.getNom()%></p>
					<p class="p-2 text-center w-1/4 text-red-500 hover:scale-125 ">
						<a href="#" onclick="confirmDelete(<%=v.getId()%>)"><i
							class="bi bi-trash-fill "></i></a>
					</p>
					<p class="p-2 text-center w-1/4 text-green-500 hover:scale-125">
						<a href="?action=modifier&id=<%=v.getId()%>&nom=<%=v.getNom()%>"><i
							class="bi bi-pencil-square"></i></a>
					</p>
				</div>
				<%
				}
				}
				%>

			</div>
		</div>
</body>
</html>