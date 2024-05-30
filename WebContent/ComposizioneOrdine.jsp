<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="it.unisa.model.*, java.util.*"%>

<%
	ArrayList<ProdottoBean> prodotti = (ArrayList<ProdottoBean>) request.getSession().getAttribute("products");
	if(prodotti == null) {
		response.sendRedirect("./catalogo?page=ComposizioneOrdine.jsp");		
		return;
	}
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">
<title>Dettagli ordine</title>
</head>
<body>
	<%@ include file="./fragments/header.jsp" %>
	<%@ include file="./fragments/menu.jsp" %>
	
	<div id="main" class="clear">
	
		<%ArrayList<ComposizioneBean> composizione = (ArrayList<ComposizioneBean>) request.getSession().getAttribute("composizione");	
		if(composizione!=null){
		%>
		
		<h2> ORDINE #<%=composizione.get(0).getIdOrdine() %></h2>
		<table class = "ordini">
		<tr>
			<th>Prodotto</th>
			<th>Quantità</th>
			<th>Prezzo Unitario</th>
			<th>Prezzo totale</th>
			<th>Iva</th>
		</tr>
		<%	String nomeP = null;
			double prezzoUnitario = 0;
		
		   for(ComposizioneBean comp : composizione){ 
			   for(ProdottoBean p: prodotti){
				   if(p.getIdProdotto()==comp.getIdProdotto()){
					   nomeP = p.getNome();
					   prezzoUnitario = p.getPrezzo();
				   }
			   }
		%>
		
		<tr>
			<td> <%= nomeP%></td>
			<td> <%= comp.getQuantita()%></td>
			<td> &euro;<%= prezzoUnitario%></td>
			<td>  &euro;<%= String.format("%.2f",comp.getPrezzoTotale())%></td>
			<td> <%= comp.getIva()%></td>
		</tr>
		
		<%}%>
		</table>
		    <% } %>
		
		
		
	</div>
	
	<%@ include file="./fragments/footer.jsp" %>
</body>
</html>