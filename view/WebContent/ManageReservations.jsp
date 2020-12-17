<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Customer - Manage Reservations</title>
</head>
<body>
<h2 style ="  text-align: center;">Manage Reservations (back to <a href="Customerhomepage.jsp">Home</a>)</h2>
<div style="margin-left:48%; margin-right:auto">
<form action="ManageReservations.jsp">
	<select name="tranType" id="tranType">
				  	<option value="ALL">All Transactions</option>
				  	<option value="no">Future Trips</option>
				  	<option value="yes">Past Trips</option>
	</select>
	<input style="border-radius:24px;background-color: #00ffff;" type="submit" value="Search">
</form>
</div>
<table style="width:100%">
  <tr>
    <th>Reservation Number</th>
    <th>Reservation Date</th>
    <th>Transit Line</th>
    <th>Origin</th>
    <th>Destination</th>
    <th>Departure</th>
    <th>Arrival</th>
    <th>Fare</th>
    <th>Actions</th>
  </tr>
    
  <%

  	
  try{
	  String ses2=(String)session.getAttribute("type");
	  System.out.println(ses2);
	 
	    if(ses2 != null)
	    {
	  	if(!ses2.equals("C"))
	 	{
	          response.sendRedirect("logout.jsp");
	    }
	    }
	    
	    else
	    {
	  	  System.out.println("Redirecting to login page");
	          response.sendRedirect("index.jsp");
	    }
		String email = (String)session.getAttribute("email");	  	
	  	String tranType = (String)request.getParameter("tranType");
	  	System.out.println(tranType);
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
	    Statement st = con.createStatement();
		    java.util.Date reservationDate;
			java.util.Date now = java.util.Calendar.getInstance().getTime();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String today = sdf.format(now);
			ResultSet rs;
			 String query = "SELECT rd.reservation_number, r.reservation_date, rd.fare, s.transit_line_name, s.origin, s.destination, s.Departure, s.Departure_time, s.Arrival, "+
			 "s.Arrival_time FROM reservationdetails rd INNER JOIN reservation r ON rd.reservation_number = r.reservation_number INNER JOIN Schedule s ON rd.schedule_id = s.id WHERE r.email = '"+
			 email + "'";
			 if(tranType == null || tranType.equals("ALL")) {
				 
			 }else if(tranType.equals("yes")){
				 query+= " AND s.Departure < '";
				 query+=today;
				 query+="'";
			 }else{
				 query+= " AND s.Departure >= '";
				 query+=today;
				 query+="'";
			 }
			 query+=";";
			 System.out.println(query);
			    rs = st.executeQuery(query);
			
			
		    while (rs.next()) {
		    	 reservationDate = rs.getDate("Departure");
		    	 

		   %>
		    	
		    	<tr style="text-align:center">
		        <td><%= rs.getString("reservation_number") %></td>	
		        <td><%= rs.getString("reservation_date") %></td>
		        <td><%= rs.getString("transit_line_name") %></td>	        
		        <td><%= rs.getString("origin") %></td>
		        <td><%= rs.getString("destination") %></td>
		        <td><%= rs.getString("Departure") + " " + rs.getString("Departure_time")%></td>	        
		        <td><%= rs.getString("Arrival") + " " + rs.getString("Arrival_time") %></td>
		        <td><%= rs.getDouble("fare") %></td>
		        
		   <% 
		   if(reservationDate.after(now)){
	    		 %>
	    		 <td>
					<form action="CancelReservation.jsp">
					  <input type="hidden" id="resnum" name="resnum" value="<%=rs.getString("reservation_number")%>">
					  <input style="border-radius:24px;background-color: #00ffff;" type="submit" value="Cancel">
					</form> 
					
				 </td>
	    		 </tr>
	    		 <%
	    	 }else{
	    		 %>
	    		 <td>
	    		 	Unable to Cancel
	    		 </td>
	    		 </tr>
	    		 <%
	    	 }
		    
		    }
		 
	}

	catch(Exception ex){
		
	}
  
  %>
</table>
</body>
</html>