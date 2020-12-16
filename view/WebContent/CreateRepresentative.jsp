<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Portal - Manage Representatives</title>
</head>
<body>

  <%

  	
  try{
	  String ses2=(String)session.getAttribute("type");
	  System.out.println(ses2);
	 
	    if(ses2 != null)
	    {
	  	if(!ses2.equals("A"))
	 	{
	          response.sendRedirect("logout.jsp");
	    }
	    }
	    
	    else
	    {
	  	  System.out.println("Redirecting to login page");
	          response.sendRedirect("index.jsp");
	    }
 		 }

	catch(Exception ex){
		
	}
	  	
	  %>
<h2 style ="  text-align: center;">Create Representative [back to <a href="ManageRepresentatives.jsp">Manage</a>]</h2>
<table style="width:80%; margin-left: auto; margin-right: auto;">
    
		    	<form action="CreateRep.jsp" method="POST">
		    	<tr style="margin-bottom:50pt">
		        <td><b>Social Security Number:</b></td> <td> <input type="text" id="ssn" name="ssn"></td>
		        </tr>
		        <tr style="margin-bottom:50pt">
		        <td><b>Username: </b></td> <td> <input type="text" id="username" name="username"></td>	
		        </tr>
		        <tr style="margin-bottom:50pt">
		        <td><b>Password: </b></td> <td> <input type="password" id="password" name="password"></td>	
		        </tr>
		        <tr style="margin-bottom:50pt">
		        <td><b>First Name:</b></td><td><input type="text" id="firstname" name="firstname"></td>
		        </tr>
		        <tr style="margin-bottom:50pt">
		        <td><b>Last Name:</b></td><td><input type="text" id="lastname" name="lastname"></td>	        
		        </tr>
		      	<tr style="margin-bottom:50pt">
		      	<td></td><td><input style="border-radius:24px;background-color: #00ffff;" type="submit" value="Submit"></form></td>
		  		</tr>	
		      

</table>
</body>
</html>