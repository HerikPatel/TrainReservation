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
<title>Insert title here</title>
</head>
<h1 style = "text-align : center">Route for <%= request.getParameter("trainsitline")%></h1>
<body>
<% String train_id =  request.getParameter("train_id");
	
//System.out.println(station);
%>
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
     <th> </th>
    
  </tr>

    
  <%

  	
  try{
	  
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
	    Statement st = con.createStatement();
	    int start =0 ,end =0;

		 ResultSet rs;
		    rs = st.executeQuery("select * from Schedule where train_id = "+  train_id + "");
		   
		    while (rs.next()) {
		    	start = rs.getInt("train_id");
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
		        <td> <a href="MakeReservation.jsp?scheduleid=<%= rs.getString("id") %>"> Book </a> </td>
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