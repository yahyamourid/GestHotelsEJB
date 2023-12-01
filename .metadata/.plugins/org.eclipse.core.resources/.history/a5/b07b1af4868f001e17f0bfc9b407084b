<%@page import="entities.Ville"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>

	<form action="VilleController">
		Nom : <input type="text" name="ville" /> <br>
		<button>Enregistrer</button>
	</form>

	<%
	if (request.getAttribute("villes") != null) {
		List<Ville> villes = (List<Ville>) request.getAttribute("villes");
		for (Ville v : villes) {
	%>
	<%=v.getId() + " " + v.getNom()%><br>
	<%
	}
	}
	%>
	
	<h1>Liste des villes : </h1>
    <ul>
        <c:forEach items="${villes}" var="v">
            <li>${v.id} - ${v.nom}</li>
        </c:forEach>
    </ul>
</body>
</html>