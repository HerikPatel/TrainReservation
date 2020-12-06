<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<style>
table ,td, th {
  text-align: left;
  padding: 8px;
}

</style>
<head>
<meta charset="ISO-8859-1">
<%
String station = request.getParameter("station"); 

%>
<title >Schedule </title>
<h1 style ="  text-align: center;">Schedule For <%= station %> </h1>
</head>
<body>
<table style="width:100%">
  <tr>
    <th>Train ID</th>
    <th>Transit Line Name</th>
    <th>Origin</th>
    <th>Destination</th>
    <th>Departure</th>
    <th>Departure Time</th>
    <th>Arrival</th>
    <th>Arrvial Time</th>
    <th>Fare</th>
  </tr>

  <%
  try{
	  String ses2=(String)session.getAttribute("type");

	  if(!ses2.equals("R"))
	  {
	      response.sendRedirect("logout.jsp");
	  }

		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
	    Statement st = con.createStatement();

		 ResultSet rs;
		    rs = st.executeQuery("select * from TSchedule where Origin='"+station+"' OR Destination='"+station+"'");
		   
		    while (rs.next()) {
		    	
		    	String dep = rs.getString("Departure_time");
		    	dep=dep.substring(0,5);
		    	String arr = rs.getString("Arrival_time");
		    	arr=arr.substring(0,5);

		   %>
		    	
		    	<tr>
		        <td> <%= rs.getString("id") %></td>
		        <td><%= rs.getString("transit_line_name") %></td>	
		        <td><%= rs.getString("Origin") %></td>
		        <td><%= rs.getString("Destination") %></td>	        
		        <td><%= rs.getString("Departure") %></td>
		         <td><%= dep %></td>
		          <td><%= rs.getString("Arrival") %></td>
		         <td><%= arr %></td>
		         <td><%= rs.getString("fare") %></td>
		        
		      </tr>	
		   <% }
		 
	}

	catch(Exception ex){
		
	}
  
  %>
</table>
</body>
</html>
