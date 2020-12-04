<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*" %>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
	<head>
		<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
		<title>Login Page Group 26</title>
		<style>
			.loginbutton {
			  background-color: #00ffff;
			  border: none;
			  padding: 10px 22px;
			  text-align: center;
			  font-size: 13px;
			  cursor: pointer;
			  
			}
			.signupbutton {
			  background-color: #00ffff;
			  border: none;
			  padding: 10px 22px;
			  text-align: center;
			  font-size: 13px;
			  cursor: pointer;
			  
			}
			.Login{
			text-align: center;
			}
			.Newuser{
			text-align: center;
			
			}
		</style>
	</head>
<body class="Login">

<%

	String invalidPassword = (String) session.getAttribute("invalidPassword");
	if (invalidPassword == null) {
		invalidPassword = "none";
	}
	
	String email = (String) session.getAttribute("email");
	if (email != null) {
		response.sendRedirect("index.jsp");
	}
	
%>

Group 26 Project Deliverable #2
	<div style="text-align: center;"><br>
		<form action="Verifylogin.jsp" method = "post">
 			 <label >Email</label><br>
 			 <input type="text" name="email" ><br>
  			<label >Password</label><br>
  			<input type="password" name="password" ><br><br>
  			<input type="submit" class ="loginbutton" name="button" value="Log in">
		</form><br>
		<div style="color: red; display: <%=invalidPassword%>">INVALID LOGIN DETAILS, TRY AGAIN</div>
		<br>
New User Sign up here <br><br>
		<form action="Signup.jsp" method = "post">
  			<input type="submit" class ="loginbutton" name="button" value="Sign Up">
		</form><br>
	</div>

</body>
</html>