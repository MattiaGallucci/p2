/**
 * 
 */
function checkNomeCognome(inputtxt) {
	var nome = /^[A-Za-z]+$/;
	if(inputtxt.value.match(nome)) 
		return true

	return false;	
}


function checkEmail(inputtxt) {
    var email = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (inputtxt.value.match(email)) 
        return true;

    return false;   
}


function checkData(inputtxt) {
	var data =  /^\d{1,2}-\d{1,2}-\d{4}$/;
	if(inputtxt.value.match(data)) 
		return true;
	
	return false;	
}


function checkUserName(inputtxt) {
	var userName = /^[A-Za-z0-9]+$/;
	if(inputtxt.value.match(userName)) 
		return true;
	
	return false;	
}


function checkPassword(inputtxt) {
	var password = /^(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}$/;
	if(inputtxt.value.match(password)) 
		return true;
	
	return false;	
}


function validate(obj) {	
	var valid = true;	
	
	var nome = document.getElementsByName("nome")[0];
	if(!checkNomeCognome(nome)) {
		valid = false;
		document.getElementById("errNome").innerHTML = "nome non valido" ;
		errNome.style.color = "red";
	} else {
		document.getElementById("errNome").innerHTML = "" ;
	}
	
	var cognome = document.getElementsByName("cognome")[0];
	if(!checkNomeCognome(cognome)) {
		valid = false;
		document.getElementById("errCognome").innerHTML = "cognome non valido";
		errCognome.style.color = "red";

		} else {
			document.getElementById("errCognome").innerHTML = "";
	}
	
	var email = document.getElementsByName("email")[0];
	if(!checkEmail(email)) {
		valid = false;
		document.getElementById("errEmail").innerHTML = "email non valida";
		errEmail.style.color = "red";
		}
		else {
			document.getElementById("errEmail").innerHTML = "";	
		}		
	
	var data = document.getElementsByName("nascita")[0];
	if(!checkData(data)) {
		valid = false;
		document.getElementById("errNascita").innerHTML = "data non valida";
		errNascita.style.color = "red";
		} else {
			document.getElementById("errNascita").innerHTML = "";
		}		
	
	var user = document.getElementsByName("us")[0];
	if(!checkUserName(user)) {
		valid = false;
		document.getElementById("errUser").innerHTML = "username non valida";
		errUser.style.color = "red";
		}
		else {
		document.getElementById("errUser").innerHTML = "";
		}		
	
	var pw = document.getElementsByName("pw")[0];
	if(!checkPassword(pw)) {
		valid = false;
		document.getElementById("errPass").innerHTML = "password non valida";
		errPass.style.color = "red";
		}
		else {
			document.getElementById("errPass").innerHTML = "";
		}			
	
	
	if(valid)
		obj.submit();	
}


function myFunction(x) {
  		x.style.background = "yellow";
		}
		