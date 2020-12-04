<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>

<!DOCTYPE html>
<html>
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
<body class="Login">
<div style="text-align: center;"><br>
		<h3>User Registration Form</h3>
		<form action="Registeruser.jsp" method = "post">
 			 <label >Email</label><br>
 			 <input type="text" name="email"  required><br>
  			<label >Password</label><br>
  			<input type="password" name="psw"  required><br>
  			<label >Repeat Password</label><br>
  			<input type="password" name="psw-repeat" required><br>
  		    <label >Username</label><br>
 			 <input type="text" name="username"  required><br>
 			<label >First Name</label><br>
 			 <input type="text" name="firstname"  required><br>
 			 <label >Last Name</label><br>
 			 <input type="text" name="lastname"  required><br><br>
  			<input type="submit" class ="loginbutton" name="button" value="Submit">
		</form><br>
		<br>
		<a href="index.jsp">Go back to home page.</a>
</div>

</body>
</html>
