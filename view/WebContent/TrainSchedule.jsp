<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
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
<body>
<h2 style ="  text-align: center;">Train Schedule</h2>
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
  <div style="padding-left: 25%;"> 
  <form action="SearchbyStation.jsp">
  <input style="border-radius:24px" type="text" id="station" name="station" placeholder="Enter Station Name "size=100>
  <input style="border-radius:24px;background-color: #00ffff;" type="submit" value="Search">
</form> 
    </div>
  <%
  try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
	    Statement st = con.createStatement();

		 ResultSet rs;
		    rs = st.executeQuery("select * from TSchedule");
		   
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
<div style ="  text-align: center;   font-size: 20px;">
<a href="UpdateForm.jsp">Edit</a>
<a href="DeleteForm.jsp">Delete</a><br><br>
  <form action="FAQ.html">
  <input style="border-radius:24px;background-color: #00ffff;" type="submit" value="FAQ">
</form>
 <form action="AskQuestion.jsp">
  <input style="border-radius:24px;background-color: #00ffff;" type="submit" value="AskQuestion">
</form> <form action="UnansweredQuestion.jsp">
  <input style="border-radius:24px;background-color: #00ffff;" type="submit" value="Unanswered Question">
</form>
</form> <form action="logout.jsp">
  <input style="border-radius:24px;background-color: #00ffff;" type="submit" value="logout">
</form>
<form action="Filter.jsp">
<label>Transit Line Name</label>
  <input style="border-radius:24px" type="text" name="transit_line_name" placeholder="Enter Transit Line Name "size=40>
  <label>Date</label>
  <input style="border-radius:24px" type="date"  name="date" placeholder="Enter Date "size=40>
<input style="border-radius:24px;background-color: #00ffff;" type="submit" value="Filter">
</form> 
</div>
</body>
</html>