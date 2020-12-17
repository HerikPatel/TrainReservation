<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Portal - Revenue</title>
</head>
<body>
<h2 style ="  text-align: center;">List Revenue by Customer/Transit Line (back to <a href="AdminConsole.jsp">Admin Portal</a>)</h2>    
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
	  	String innerQuery = "SELECT s.transit_line_name, rrdc.reservation_number, rrdc.fare, rrdc.firstname, rrdc.lastname FROM (SELECT rrd.schedule_id, rrd.reservation_number,"+
		  	" rrd.fare, c.firstname, c.lastname FROM (SELECT rd.schedule_id, rd.reservation_number, r.email, rd.fare FROM reservationdetails rd INNER JOIN reservation r ON rd.reservation_number = "+
		  	"r.reservation_number) rrd INNER JOIN customer c ON rrd.email = c.email) rrdc INNER JOIN Schedule s ON rrdc.schedule_id = s.id";
	  	String queryTwo;
	  	String transitLine,fullName;
	  	if(hasParams){
	  		String firstname, lastname;
	  		transitLine = request.getParameter("transitLine");
	  		firstname = request.getParameter("firstName");
	  		lastname = request.getParameter("lastName");
	  		if(!transitLine.equals("ALL")) {
	  			innerQuery+= " WHERE s.transit_line_name = '" + transitLine + "'";
	  		}
	  		if(!firstname.equals("") && !lastname.equals("")){
	  			innerQuery+= " AND rrdc.firstname = '" + firstname + "'";
	  			innerQuery+= " AND rrdc.lastname = '" + lastname + "'";
	  			fullName = firstname + " " + lastname;
	  		}else{
	  			fullName = "ALL";
	  		}
	  		queryTwo = innerQuery + ";";
	  		
	  	}else {
	  		transitLine = "ALL";
	  		fullName = "ALL";
	  		queryTwo = innerQuery + ";";
	  	}
	  	
	  	String queryOne = String.format("SELECT SUM(x.fare) as 'SUM' FROM (%s) x;", innerQuery);
	  	System.out.println(queryOne);
	  	System.out.println(queryTwo);
	  	ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
	    Statement st = con.createStatement();
		 
		  ResultSet rs;
		rs = st.executeQuery("SELECT transit_line_name FROM Schedule");
		    
		   %>
		   <div style="margin-left: 25%; margin-right: 25%;"> 
				  <form action="RevenueList.jsp">
				  <select name="transitLine" id="transitLine" style="margin-right:2%">
				  	<option value="ALL">All Stations</option>
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
		   <table style="width:100%">
		   	<tr style="text-align:center; margin-top: 50pt;">
			    <td>Transit Line:</td>
			    <td><%=transitLine%></td>
			  </tr>
			  <tr style="text-align:center; margin-top: 50pt;">
			  	<td>Full Name:</td>
			  	<td><%=fullName%></td>
			  </tr>
			  
		   <%
		   ResultSet rst;
		    rst = st.executeQuery(queryOne);
		    if (rst.next()) {
		   %>
		    	
		    	<tr style="text-align:center">
		        <td>Total Revenue</td>	
		        <td><%= rst.getDouble("SUM") %></td>	
		        
		      </tr>	
		   	</table>
		    <%
		 
		    }
  
  
  }
	catch(Exception ex){
		
	}
  
  %>
  			
</table>
</body>
</html>