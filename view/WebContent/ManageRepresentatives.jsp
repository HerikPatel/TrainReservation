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
<h2 style ="  text-align: center;">Manage Representatives (back to <a href="AdminConsole.jsp">Admin Portal</a>)</h2>
<h4 style ="  text-align: center;"><a href="CreateRepresentative.jsp">Create Representative</a></h4>
<table style="width:100%">
  <tr>
    <th>Email</th>
    <th>Username</th>
    <th>First Name</th>
    <th>Last Name</th>
    <th>Social Security Number</th>
    <th>Actions</th>
  </tr>
    
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
		    rs = st.executeQuery("select * from customer where accountype = 'R'");
		   
		    while (rs.next()) {

		   %>
		    	
		    	<tr style="text-align:center">
		        <td> <%= rs.getString("email") %></td>
		        <td><%= rs.getString("username") %></td>	
		        <td><%= rs.getString("firstname") %></td>
		        <td><%= rs.getString("lastname") %></td>	        
		        <td>NOT IN TABLE</td>
		         <td>
					<form action="EditRepresentative.jsp">
					  <input type="hidden" id="username" name="username" value="<%=rs.getString("username")%>">
					  <input style="border-radius:24px;background-color: #00ffff;" type="submit" value="Edit/Delete">
					</form> 
					
				 </td>
		        
		      </tr>	
		   <% }
		 
	}

	catch(Exception ex){
		
	}
  
  %>
</table>
</body>
</html>