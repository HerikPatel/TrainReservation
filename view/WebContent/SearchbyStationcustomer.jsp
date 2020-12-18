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
<% String station =  request.getParameter("station"); 
String typeofstation =  request.getParameter("typeofstation");
String date = request.getParameter("date");
String order = request.getParameter("order") == null || request.getParameter("order").equals("") ? "ALL" : request.getParameter("order");
%>

<body>
<h1 style = "text-align : center">Schedule for <%= station %></h1>
<div style="margin-left:48%; margin-right:auto">
<form action="SearchbyStationcustomer.jsp" method="GET">
	<select name="order" id="order">
					<option value="ALL">Sort By</option>
				  	<option value="Arrival">Arrival Time</option>
				  	<option value="Departure">Departure Time</option>
				  	<option value="fare">Fare</option>
	</select>
	<input type="hidden" id="station" name="station" value="<%=station%>">
	<input type="hidden" id="typeofstation" name="typeofstation" value="<%=typeofstation%>">
	<input type="hidden" id="date" name="date" value="<%=date%>">
	<input style="border-radius:24px;background-color: #00ffff;" type="submit" value="Search">
</form>
</div>
<a href="Customerhomepage.jsp">
<img border="0" alt="go back" src="back.png" width="25" height="10">
Go back
</a>
<br><br>
  <div style="text-align : center"> 
  
</div>
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
    <th>Arrival Time</th>
    <th>Fare</th>
     <th>View Route</th>
    
  </tr>

    
  <%

	date = date.substring(0,4)+date.substring(5,7)+date.substring(8,10);
  	
  try{
	  
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
	    Statement st = con.createStatement();
	    
		String sqlquery = "";
		if(typeofstation.equals("origin"))
	     	sqlquery = "select * from Schedule where origin='"+station+"' AND Departure ='"+date+"'";
		
		else
	     	sqlquery = "select * from Schedule where destination='"+station+"' AND Departure ='"+date+"'";
		
		if(order.equals("Arrival")){
			sqlquery+=" ORDER BY Arrival, Arrival_time;";
		}else if(order.equals("Departure")){
			sqlquery+=" ORDER BY Departure, Departure_time;";
		}else if(order.equals("fare")){
			sqlquery+=" ORDER BY fare;";
		}else{
			sqlquery+=";";
		}
		 ResultSet rs;
		 System.out.println(sqlquery);
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
		        <td> <a href="RouteDetails.jsp?train_id=<%= rs.getString("id") %>&trainsitline=<%= rs.getString("transit_line_name") %>&fare=<%= rs.getString("fare") %>"> View Route </a> </td>
		      </tr>	
		   <% }
		 
	}

	catch(Exception ex){
        response.sendRedirect("Customerhomepage.jsp");
        
	}
  
  %>
</table>
</body>
<script>

</script>
</html>