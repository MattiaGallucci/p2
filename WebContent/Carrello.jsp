<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="java.util.*,it.unisa.model.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Carrello</title>
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">

</head>
<body>

	<%@ include file="./fragments/header.jsp" %>
	<%@ include file="./fragments/menu.jsp" %>
	
	<div id="main" class="clear">
	
	<% 	Carrello cart = (Carrello) request.getSession().getAttribute("cart");
		if(cart != null && !cart.isEmpty()){%>
		
		<h2>CARRELLO</h2>
		<table>
		<tr>
			<th></th>
			<th>Nome</th>
			<th>Quantità</th>
			<th>Prezzo totale</th>
			<th></th>
		</tr>
		<% 
			ArrayList<ItemCarrello> prodcart = cart.getProdotti(); 	
		   for(ItemCarrello itemcart: prodcart){
		%>
		<tr>
			<td><img src="<%=itemcart.getProdotto().getImmagine()%>" height="100" width="100"></td>
			<td><%=itemcart.getProdotto().getNome()%></td>
			<td> <form action="carrello">
					<input type="hidden" name="Id" value="<%=itemcart.getId()%>">
					<input type="hidden" name="page" value="Carrello.jsp">
					<select name="qnt" id="qnt">
						<%for(int i = 0; i < itemcart.getProdotto().getQuantita();i++) {%>
						<option value="<%=i+1%>" <%if( (i+1)==itemcart.getQuantitaCarrello()){ %> selected="selected" <%} %>> <%=i+1%> </option> <%} %>
						
					</select>
					<input type="submit" value="update">
				</form>
			</td>
			<td><%=String.format("%.2f",itemcart.getTotalPrice())%>&euro;</td>
			<td><a href="carrello?action=deleteC&id=<%=itemcart.getId()%>&page=Carrello.jsp"><button>X</button></a></td>
		</tr>
		<% } %>
	</table><br>
	<span class="price">Totale provvisorio: &euro;<%=String.format("%.2f",cart.calcolaCosto())%></span>
		
	<div class="center">
			<a <%if(request.getSession().getAttribute("currentSessionUser")!= null){ %>
					href="account?page=Checkout.jsp"> <%}else{%>href="Login.jsp?action=checkout"> <%} %><button>Acquista</button> </a>
		</div>
	
	<%}else{%> 
		<h2>Carrello vuoto</h2>
		<%} %>
		<br><br>
		
		</div>
		
		<%@ include file="./fragments/footer.jsp" %>
		
</body>
</html>