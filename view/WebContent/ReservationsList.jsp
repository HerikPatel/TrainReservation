<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Portal - Reservations List</title>
</head>
<body>
<h2 style ="  text-align: center;">List of Reservations (back to <a href="AdminConsole.jsp">Admin Portal</a>)</h2>    
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
	  	Enumeration<String> en = request.getParameterNames();
	  	boolean hasParams = false;
	  	while(en.hasMoreElements()){
	  		String paramName = (String) en.nextElement();
	  		if(paramName.equals("transitLine")){
	  			hasParams = true;
	  			break;
	  		}
	  	}
	  	String query = "SELECT s.transit_line_name, rdrc.firstname, rdrc.lastname, rdrc.email, rdrc.reservation_number, rdrc.reservation_date, rdrc.fare FROM"+
		  		" (SELECT rc.reservation_number, rc.reservation_date, rc.firstname, rc.lastname, rc.email, rd.schedule_id, rd.fare FROM (SELECT r.reservation_number, "+
		  		"r.reservation_date, c.firstname, c.lastname, c.email FROM reservation r INNER JOIN customer c ON r.email = c.email) rc INNER JOIN reservationdetails rd ON "+
		  		"rc.reservation_number = rd.reservation_number)rdrc INNER JOIN Schedule s ON rdrc.schedule_id = s.id";
	  	if(hasParams){
	  		String transitLine, firstname, lastname;
	  		transitLine = request.getParameter("transitLine");
	  		firstname = request.getParameter("firstName");
	  		lastname = request.getParameter("lastName");
	  		if(!transitLine.equals("ALL")){
	  			query+= " WHERE s.transit_line_name = '" + transitLine + "'";
	  		}
	  		if(!firstname.equals("") && !lastname.equals("")){
	  			query+= " AND rdrc.firstname = '" + firstname + "'";
	  			query+= " AND rdrc.lastname = '" + lastname + "'";
	  		}
	  		query+=";";
	  	}else {
	  		query+=";";
	  	}
	  	System.out.println(query);
	  	ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
	    Statement st = con.createStatement();
		 
		  ResultSet rs;
		rs = st.executeQuery("SELECT transit_line_name FROM Schedule");
		    
		   %>
		   <table style="width:100%">
			  <tr>
			  	<th>Reservation #</th>
			    <th>Reservation Date</th>
			    <th>Transit Line Name</th>
			    <th>Customer First Name</th>
			    <th>Customer Last Name</th>
			    <th>Customer Email</th>
			    <th>Total Fare</th>
			  </tr>
			  <div style="padding-left: 25%;"> 
				  <form action="ReservationsList.jsp">
				  <select name="transitLine" id="transitLine" style="margin-right:2%">
				  <option value="ALL">All Transit Lines</option>
				  <%
		    		while (rs.next()) {
				  %>
					<option value="<%=rs.getString("transit_line_name") %>"><%=rs.getString("transit_line_name") %></option>
				  <%
		  			}%>
				  </select>
				  <input style="border-radius:24px; margin-right:2%;" type="text" id="firstName" name="firstName" placeholder="Customer First Name (leave blank for all)"size=30>
				  <input style="border-radius:24px; margin-right:2%;" type="text" id="lastName" name="lastName" placeholder="Customer Last Name (leave blank for all)"size=30>
				  <input style="border-radius:24px;background-color: #00ffff;" type="submit" value="Search">
				</form> 
				</div>
		   <%
		   ResultSet rst;
		    rst = st.executeQuery(query);
		    while (rst.next()) {
		   %>
		    	
		    	<tr style="text-align:center">
		        <td><%= rst.getString("reservation_number") %></td>	
		        <td><%= rst.getString("reservation_date") %></td>	
		        <td><%= rst.getString("transit_line_name") %></td>	
		        <td><%= rst.getString("firstname") %></td>	
		        <td><%= rst.getString("lastname") %></td>
		        <td><%= rst.getString("email") %></td>	
		        <td><%= rst.getDouble("fare") %></td> 
		      </tr>	
		   
		    <%
		 
		    }}
	catch(Exception ex){
		
	}
  
  %>
  			
</table>
</body>
</html>