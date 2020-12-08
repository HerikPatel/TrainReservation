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
  font-size: 20px;
}

</style>
<head>
<meta charset="ISO-8859-1">
<title>Customer List</title>
<h2 style ="  text-align: center;">Customer List</h2>

</head>
<body>
<table style="width:100%">
  <tr>
    <th>First Name</th>
    <th>Last Name</th>
  </tr>
  <%
  String ses2=(String)session.getAttribute("type");
	 
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
	
  try{
	 

		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
	    Statement st = con.createStatement();
		String date = request.getParameter("date");
		date = date.substring(0,4)+date.substring(5,7)+date.substring(8,10);
		String transit_line_name = request.getParameter("transit_line_name"); 
		
		String select = "select c.firstname , c.lastname from customer c , reservation r, reservationdetails rv, TSchedule t	where  c.email= r.email AND	r.reservation_number = rv.reservation_number AND rv.train_id=t.id AND t.transit_line_name='"+transit_line_name+"' AND t.Departure ="+date+" ;";

		 ResultSet rs;
		    rs = st.executeQuery(select);
		   
		    while (rs.next()) {
		    	
		   %>
		    	<tr>
		        <td> <%= rs.getString("firstname") %></td>
		        <td><%= rs.getString("lastname") %></td>			        
		      </tr>	
		   <% }
		 
	}

	catch(Exception ex){
	}
  
  %>
</table>
</body>
</html>