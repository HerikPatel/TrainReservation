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
	
	String username = request.getParameter("username");

%>
<h2 style ="  text-align: center;">Edit Representative (<%=username%>) [back to <a href="ManageRepresentatives.jsp">Manage</a>]</h2>
<table style="width:80%; margin-left: auto; margin-right: auto;">
    
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
	  	
	  
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
	    Statement st = con.createStatement();

		 ResultSet rs;
		    rs = st.executeQuery("select * from customer where username ='" + username + "'");
		   
		    if (rs.next()) {

		   %>
		    	<form action="UpdateRepresentative.jsp" method="POST">
		    	<tr style="margin-bottom:50pt">
		        <td><b>Email:</b></td> <td> <%= rs.getString("email") %><input type="hidden" id="email" name="email" value="<%=rs.getString("email")%>"></td>
		        </tr>
		        <tr style="margin-bottom:50pt">
		        <td><b>Username: </b></td> <td> <input type="text" placeholder="<%= rs.getString("username") %>" id="username" name="username"></td>	
		        </tr>
		        <tr style="margin-bottom:50pt">
		        <td><b>Password: </b></td> <td> <input type="text" placeholder="<%= rs.getString("password") %>" id="password" name="password"></td>	
		        </tr>
		        <tr style="margin-bottom:50pt">
		        <td><b>First Name:</b></td><td><input type="text" placeholder="<%= rs.getString("firstname") %>" id="firstname" name="firstname"></td>
		        </tr>
		        <tr style="margin-bottom:50pt">
		        <td><b>Last Name:</b></td><td><input type="text" placeholder="<%= rs.getString("lastname") %>" id="lastname" name="lastname"></td>	        
		        </tr>
		        <tr style="margin-bottom:50pt">
		        <td><b>Social Security Number:</b></td><td><input type="text" placeholder="NOT IN DATABASE YET" id="ssn" name="ssn"></td>
		        </tr>
		      	<tr style="margin-bottom:50pt">
		      	<td></td><td><input style="border-radius:24px;background-color: #00ffff;" type="submit" value="Edit"></form><form action="DeleteRepresentative.jsp">
					  <input type="hidden" id="email" name="email" value="<%=rs.getString("email")%>">
					  <input style="border-radius:24px;background-color: #00ffff;" type="submit" value="Delete User">
					</form> </td>
		  		</tr>	
		      
		   <% }
		 
	}

	catch(Exception ex){
		
	}
  
  %>
</table>
</body>
</html>