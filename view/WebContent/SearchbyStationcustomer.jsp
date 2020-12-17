<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<html>
<style>
table ,td, th {
  text-align: left;
  padding: 8px;
}

</style>
<head>
<meta charset="ISO-8859-1">
<title>Schedule</title>
</head>
<% String station =  request.getParameter("station");  %>
<h1 style = "text-align : center">Schedule for <%= station %></h1>
<body>
<table style="width:100%">
  <tr>
    <th>ID</th>
         <th>Train ID</th>
    
    <th>Transit Line Name</th>
    <th>Origin</th>
    <th>Destination</th>
    <th>Departure</th>
    <th>Departure Time</th>
    <th>Arrival</th>
    <th>Arrvial Time</th>
    <th>Fare</th>
     <th>View Route</th>
    
  </tr>

    
  <%

  	
  try{
	  
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
	    Statement st = con.createStatement();
	    String typeofstation =  request.getParameter("typeofstation");
		String date = request.getParameter("date");
		date = date.substring(0,4)+date.substring(5,7)+date.substring(8,10);
System.out.print(date);
		String sqlquery = "";
		if(typeofstation.equals("origin"))
	     	sqlquery = "select * from Schedule where origin='"+station+"' AND Departure ='"+date+"'";
		
		else
	     	sqlquery = "select * from Schedule where destination='"+station+"' AND Departure ='"+date+"'";

		 ResultSet rs;
		 
		    rs = st.executeQuery(sqlquery);
		   
		    while (rs.next()) {
		    	String dep = rs.getString("Departure_time");
		    	dep=dep.substring(0,5);
		    	String arr = rs.getString("Arrival_time");
		    	arr=arr.substring(0,5);

		   %>
		    	
		    	<tr>
		        <td> <%= rs.getString("id") %></td>
		        		       <td><%= rs.getString("train_id") %></td>
		        
		        <td><%= rs.getString("transit_line_name") %></td>	
		        <td><%= rs.getString("origin") %></td>
		        <td><%= rs.getString("destination") %></td>	        
		        <td><%= rs.getString("Departure") %></td>
		         <td><%= dep %></td>
		          <td><%= rs.getString("Arrival") %></td>
		         <td><%= arr %></td>
		         <td><%= rs.getString("fare") %></td>
		        <td> <a href="RouteDetails.jsp?train_id=<%= rs.getString("train_id") %>&trainsitline=<%= rs.getString("transit_line_name") %>"> View Route </a> </td>
		      </tr>	
		   <% }
		 
	}

	catch(Exception ex){
        response.sendRedirect("Customerhomepage.jsp");

	}
  
  %>
</table>
</body>
</html>