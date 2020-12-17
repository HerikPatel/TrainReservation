<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Console - Train Reservation System</title>
<style>
div.centre {
    display: block;
    margin-left: auto;
    margin-right: auto;
    margin-top: 0;
    margin-bottom: 0;
    align-content: center;
    text-align: center;
  }
  
  
  .btn-group .button {
    background-color: #00ffff;
    /* Green */
    border: none;
    color: black;
    padding: 15px 32px;
    text-align: center;
    font-size: 16px;
    cursor: pointer;
    display: inline-block;
    font-family: sans-serif;
  }
  
  .btn-group .button:hover {
    background-color: #3e8e41;
  }
</style>
</head>
<body>
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
		Statement st = con.createStatement();
%>

<h1 style="text-align: center">Admin Portal</h1>
<div class="centre">
    <div class="btn-group">
      <a href="ManageRepresentatives.jsp" class="button">Manage Representatives</a>
      <a href="SalesReport.jsp" class="button">Sales Reports</a>
      <a href="ReservationsList.jsp" class="button">Reservations</a>
      <a href="RevenueList.jsp" class="button">Revenue</a>
      <a href="logout.jsp" class="button">Log Out</a>
    </div>
</div>
<%
		String customerQuery = "SELECT c.firstname, c.lastname, x.email, x.amtTrips, x.amtSpent FROM (SELECT email, count(reservation_number) as 'amtTrips', sum(total_fare) as 'amtSpent' from reservation group by email) x "+
				"INNER JOIN customer c ON x.email = c.email WHERE x.amtSpent = (SELECT MAX(z.amtSpent) FROM (SELECT SUM(total_fare) as 'amtSpent' from reservation group by email) z);";
		ResultSet rs = st.executeQuery(customerQuery);
		

	if(rs.next()){
%>
<div class="centre" style="margin-top:40pt;">
    <h2>Best Customer: <%=rs.getString("firstname") %> <%=rs.getString("lastname") %> (<%=rs.getString("email") %>)</h2>
    <p><%=rs.getInt("amtTrips") %> Total Trips | $<%=rs.getDouble("amtSpent") %> Spent</p>
</div>

<div class="centre" style="margin-top:40pt;">
    <h2>Five Most Active Train Lines</h2>
    <ol style="text-align: center; list-style-position: inside; padding: 0;">
<%
	}
	String activeLineQuery = "SELECT x.amtTrips, s.transit_line_name FROM (SELECT COUNT(reservation_number) as 'amtTrips', "+
	"schedule_id FROM reservationdetails GROUP by schedule_id) x INNER JOIN Schedule s ON x.schedule_id = s.id ORDER BY x.amtTrips DESC;";
	ResultSet rst = st.executeQuery(activeLineQuery);
	int counter = 0;
	while(rst.next() && counter < 5) {
		
	%>
	<li> <%=rst.getString("transit_line_name") %> (<%=rst.getInt("amtTrips")%> Trips)</li>
	
	<%
	counter++;
	}
  }
catch(Exception ex) {
	
}
%>

        
    </ol>
</div>

</body>
</html>