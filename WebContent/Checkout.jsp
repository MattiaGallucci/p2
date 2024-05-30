<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1" import="it.unisa.model.*, java.util.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
	<link href="${pageContext.request.contextPath}/css/style.css" rel="stylesheet" type="text/css">

<title>Checkout</title>
</head>
<body>

		<%@ include file="./fragments/header.jsp" %>
		<%@ include file="./fragments/menu.jsp" %>
		
		<% IndirizzoSpedizioneBean spedizione = (IndirizzoSpedizioneBean) request.getSession().getAttribute("spedizione");
			MetodoPagamentoBean pagamento = (MetodoPagamentoBean) request.getSession().getAttribute("pagamento");%>
	
		<div id="main" class="clear">

	<h2>Checkout</h2>
	<form action="Checkout" method="post" id="myform">
		
		<%if(spedizione!=null){ %>
		<div class="tableRow">
			<p class="heading">Dati spedizione:</p>
			<p></p>
		</div>
		<div class="tableRow">
			<p>Nome:</p>
			<p><input type="text" name="nome" value="<%= spedizione.getNome() %>" required/></p>
		</div>	
		<div class="tableRow">
			<p>Cognome:</p>
			<p><input type="text" name="cognome" value="<%= spedizione.getCognome() %>" required/></p>
		</div>
		<div class="tableRow">
			<p>telefono:</p>
			<p><input type="text" name="tel" value="<%= spedizione.getTelefono() %>" required/></p>
		</div>
		<div class="tableRow">
			<p>Indirizzo:</p>
			<p><input type="text"  name="ind" value="<%= spedizione.getIndirizzo() %>" required/></p>
		</div>
		<div class="tableRow">
			<p>Cap:</p>
			<p><input type="text" name="cap" value="<%= spedizione.getCap() %>" required/></p>
		</div>
		<div class="tableRow">
			<p>Provincia:</p>
			<p><input type="text" name="prov" value="<%= spedizione.getProvincia() %>" required/></p>
		</div>
		<div class="tableRow">
			<p>Città:</p>
			<p><input type="text" name="città" value="<%= spedizione.getCitta() %>" required/></p>
		</div>
		
		<%}else{ %> 
		<div class="tableRow">
			<p class="heading">Dati spedizione:</p>
			<p></p>
		</div>
		<div class="tableRow">
			<p>Nome:</p>
			<p><input type="text" name="nome" required/></p>
		</div>	
		<div class="tableRow">
			<p>Cognome:</p>
			<p><input type="text" name="cognome" required/></p>
		</div>
		<div class="tableRow">
			<p>telefono:</p>
			<p><input type="text" name="tel" required/></p>
		</div>
		<div class="tableRow">
			<p>Indirizzo:</p>
			<p><input type="text"  name="ind" required/></p>
		</div>
		<div class="tableRow">
			<p>Cap:</p>
			<p><input type="text" name="cap" required/></p>
		</div>
		<div class="tableRow">
			<p>Provincia:</p>
			<p><input type="text" name="prov" required/></p>
		</div>
		<div class="tableRow">
			<p>Città:</p>
			<p><input type="text" name="città" required/></p>
		</div>
		<%} %>
	
		<%if(pagamento!=null){ %>
		<div class="tableRow">
			<p class="heading">Dati pagamento:</p>
			<p></p>
		</div>
		<div class="tableRow">
			<p>Titolare carta:</p>
			<p><input type="text" name="tit" value="<%=pagamento.getTitolare()%>" required/></p>
		</div>	
		<div class="tableRow">
			<p>Numero:</p>
			<p><input type="text" name="numC" value="<%=pagamento.getNumero()%>" required/></p>
		</div>
		<div class="tableRow">
			<p>Scadenza:</p>
			<p><input type="date"  name="scad" value="<%=pagamento.getScadenza()%>" required/></p>
		</div>
		
		<%}else{ %>
		<div class="tableRow">
			<p class="heading">Dati pagamento:</p>
			<p></p>
		</div>
		<div class="tableRow">
			<p>Titolare carta:</p>
			<p><input type="text" name="tit" required/></p>
		</div>	
		<div class="tableRow">
			<p>Numero:</p>
			<p><input type="text" name="numC" required/></p>
		</div>
		<div class="tableRow">
			<p>Scadenza:</p>
			<p><input type="date"  name="scad" required/></p>
		</div>
		<%} %>
		<div class="tableRow">
			<p></p>
			<p><input type="submit" value="checkout"></p>
		</div>
		
	</form>
	</div>
	
	<%@ include file="./fragments/footer.jsp" %>
	
</body>
</html>