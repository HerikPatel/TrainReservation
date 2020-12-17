<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Train Reservation System - Make Reservation</title>
</head>
<body>
	<h2 style ="  text-align: center;">Make Reservation [back to <a href="Customerhomepage.jsp">Home</a>]</h2>
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
	    
	    String ticketAvailable = (String) session.getAttribute("ticketAvailable");
		if (ticketAvailable == null) {
			ticketAvailable = "none";
		}
	    
	    
	    String email = (String) session.getAttribute("email");
	    ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement st = con.createStatement();
		String scheduleId = (String) request.getParameter("scheduleid");
		System.out.println(scheduleId);
		
		String query = "SELECT transit_line_name, fare, origin, destination, Arrival, Arrival_time, Departure, Departure_time from Schedule WHERE id = "+scheduleId;
		
		ResultSet rs = st.executeQuery(query);
		if(!rs.next()) {
			%>
			<h2 style="text-align:center;"><font color="red">No Train Schedule Information found for this ID, <a href="Customerhomepage.jsp">Go Back to Home.</a></font></h2>
			<%
			
		}else{
			String transitLine = rs.getString("transit_line_name");
			String origin = rs.getString("origin");
			String destination = rs.getString("destination");
			String startTime = rs.getString("Departure") + " " + rs.getString("Departure_time");
			String endTime = rs.getString("Arrival") + " " + rs.getString("Arrival_time");
			Double fare = rs.getDouble("fare");
			Double disabledFare = fare *0.5;
			Double seniorFare = fare *0.65;
			Double childFare = fare *0.75;
			System.out.println(transitLine);
			%>
			<h4 style ="  text-align: center;"><%=transitLine %> (<%=startTime %> - <%=endTime %>)</h4>
			<table style="width:80%; margin-left: auto; margin-right: auto;">
				<tr style="margin-bottom:50pt">
				<td><b>Ticket Type</b></td>
				<td><b>Quantity</b></td>
				<td><b>One-Way Price/Round-Trip Price</b></td>
				</tr>
		    	<form action="CreateReservation.jsp" method="POST">
		    	<input type="hidden" id="scheduleId" name="scheduleId" value="<%=scheduleId%>">
		    	<tr style="margin-bottom:50pt">
		        <td><b>Standard:</b></td> <td> <input type="text" id="standard" name="standard" size="2"></td> <td><b>$<%=fare %>/$<%=fare*2 %></b></td>
		        </tr>
		        <tr style="margin-bottom:50pt">
		        <td><b>Disabled:</b></td> <td> <input type="text" id="disabled" name="disabled" size="2"></td> <td><b>$<%=disabledFare %>/$<%=disabledFare*2 %></</b></td>
		        </tr>
		        <tr style="margin-bottom:50pt">
		        <td><b>Senior:</b></td> <td> <input type="text" id="senior" name="senior" size="2"></td> <td><b>$<%=seniorFare %>/$<%=seniorFare*2 %></</b></td>
		        </tr>
		        <tr style="margin-bottom:50pt">
		        <td><b>Child:</b></td> <td> <input type="text" id="child" name="child" size="2"></td> <td><b>$<%=childFare %>/$<%=childFare*2 %></</b></td>
		        </tr>
		        <tr style="margin-bottom:50pt">
		        <td><b>Trip Type:</b></td><td><input type="radio" id="oneway" name="tripType" value="oneway"><label for="oneway">One-Way</label></td><td> <input type="radio" id="roundtrip" name="tripType" value="roundtrip"><label for="roundtrip">Round-Trip</label></td>
		        </tr>
		      	<tr style="margin-bottom:50pt">
		      	<td></td><td><input style="border-radius:24px;background-color: #00ffff;" type="submit" value="Submit"></form></td>
		  		</tr>	
		</table>
			<div style="text-align: center; color: red; display: <%=ticketAvailable%>">The Quantity of Tickets Selected is Not Available, Try again.</div>
		<br>
			
			<%
			
		}
		
		
	    
 		 }

	catch(Exception ex){
		
	}
	  	
	  %>

</body>
</html>