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
    
  </tr>
  <div style="padding-left: 25%;"> 
  <form action="SearchbyStation.jsp">
  <input style="border-radius:24px" type="text" id="station" name="station" placeholder="Enter Station Name "size=100>
  <input style="border-radius:24px;background-color: #00ffff;" type="submit" value="Search">
</form> 
    </div>
    
  <%

  	
  try{
	  String ses2=(String)session.getAttribute("type");
	  System.out.println(ses2);
	 
	    if(ses2 != null)
	    {
	  	if(!ses2.equals("R"))
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
		    rs = st.executeQuery("select * from Schedule ");
		   
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