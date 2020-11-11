<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Train Reservation</title>
</head>
<style>
.button {
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
<body class = "Login">
Login 
<div style="text-align: center;">
<form action="Logincredentials.jsp" method = "post">
  <label >Email</label><br>
  <input type="text" name="email" ><br>
  <label >Password</label><br>
  <input type="password" name="password" ><br><br>
  <input type="submit" class ="button" value="Log in">
  <input type="submit" class ="button" value="Sign up">
</form> 
</div>
</body>
</html>