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
<% String id =  request.getParameter("train_id");
		 String fare =  request.getParameter("fare");
	
//System.out.println(station);
%>
<h1 style = "text-align : center">Route for <%= request.getParameter("trainsitline")%></h1>
<h2 style = "text-align : center"> <a href="MakeReservation.jsp?scheduleid=<%= id %>"> Book </a></h2>
<body>
<a href="Customerhomepage.jsp">
<img border="0" alt="go back" src="back.png" width="25" height="10">
Go back
</a>
<br><br>

<table style="width:100%">
  <tr>

    <th>Origin</th>
    <th>Destination</th>
     
    
  </tr>

    
  <%

  
  try{
	 
	  
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
	    Statement st = con.createStatement();
	    int start =0 ,end =0;

		 ResultSet rs;
		    rs = st.executeQuery("select * from Route where schedule_id = "+ id + "");
		    System.out.print("select * from Route where schedule_id = "+ id + "");
		   
		    while (rs.next()) {

		   %>
		    	
		    	<tr>
		        <td> <%= rs.getString("arrival_station") %></td>
		        		       <td><%= rs.getString("departure_station") %></td>
		       
		      </tr>	
		   <% }
		 
	}

	catch(Exception ex){
        response.sendRedirect("Customerhomepage.jsp");

	}
  
  %>
</table>
<table style="width:100%">
    <th> </th>
    <th> </th>
    <tr>
		        <td>Total fare = <%= fare %></td>

		       
		        <td>  </td>
		      </tr>	
    
</table>
</body>
</html>