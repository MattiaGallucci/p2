<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="UTF-8" import="it.unisa.model.ProdottoBean, java.util.*"%>

<%
	ArrayList<?> products = (ArrayList<?>) request.getSession().getAttribute("products");
	if(products == null) {
		response.sendRedirect("../catalogo?action=admin");	
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
	<meta charset="ISO-8859-1">
	<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">
	<title>Gestione catalogo</title>
</head>

<body>

	<%@ include file="../fragments/header.jsp" %>
	<%@ include file="../fragments/menu.jsp" %>
	
	
	<div id="main" class="clear">
	
	<h2>GESTIONE CATALOGO</h2>
	
		<%
			if (products != null && products.size() != 0) {%>
				
				<table class = "ordini">
				<tr>
					<th>Nome</th>
					<th>Piattaforma</th>
					<th>Quantità</th>
					<th>Azione</th>
				</tr>
			<% Iterator<?> it = products.iterator();
				while (it.hasNext()) {
					ProdottoBean bean = (ProdottoBean) it.next();
		%>
		
		<tr>
			<td><%=bean.getNome()%></td>
			<td><%=bean.getPiattaforma()%></td>
			<td><%=bean.getQuantita()%></td>
			<td><a href="ModificaProdotto.jsp?prodotto=<%=bean.getIdProdotto()%>"><button>Modifica</button></a></td>
		</tr>

		<%}%></table>
				
			<%} else {
		%>
		
			<h2>No products available</h2>
		<%
			}
		%>
			<br><br>
			
		<div class="center">
			<a href="AddProdotto.jsp"><button>Aggiungi prodotto</button></a>
		</div>
		
	</div>
	
		<%@ include file="../fragments/footer.jsp" %>
	
</body>
</html>