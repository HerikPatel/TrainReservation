<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Admin Portal - Sales Report</title>
</head>
<body>
<h2 style ="  text-align: center;">Sales Report (back to <a href="AdminConsole.jsp">Admin Portal</a>)</h2>    
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
	  	boolean hasDates = false;
	  	while(en.hasMoreElements()){
	  		String paramName = (String) en.nextElement();
	  		if(paramName.equals("startDate")){
	  			hasDates = true;
	  			break;
	  		}
	  	}
	  	String startDate,endDate;
	  	if(hasDates){
	  		startDate= request.getParameter("startDate");
	  		endDate = request.getParameter("endDate");
	  	}else {
	  		startDate = "2020-11-01";
	  		endDate = "2020-12-01";
	  	}
	  	double totalRevenue = 0.0;
	  	ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
	    Statement st = con.createStatement();
	    String query = String.format("SELECT rdrr.transit_line_name, SUM(rdrr.fare) as 'Total' " +
	    		"FROM (SELECT transit_line_name, rdr.fare, rdr.reservation_date FROM Schedule s INNER JOIN  (SELECT rd.schedule_id, rd.fare, r.reservation_date " +
	    		"FROM reservationdetails rd INNER JOIN reservation r on rd.reservation_number = r.reservation_number) rdr ON s.id = rdr.schedule_id) rdrr WHERE rdrr.reservation_date between " + 
	    		"'%s'  and '%s' GROUP BY rdrr.transit_line_name;", startDate, endDate);
		 ResultSet rs;
		    rs = st.executeQuery(query);
		   %>
		   <h4 style ="  text-align: center;">Sales Report for <%=startDate%> - <%=endDate %></h4>
		   <table style="width:100%">
			  <tr>
			    <th>Transit Line Name</th>
			    <th>Total Revenue ($)</th>
			  </tr>
			  <div style="padding-left: 25%;"> 
				  <form action="SalesReport.jsp">
				  <input style="border-radius:24px; margin-right:10%;" type="text" id="station" name="startDate" placeholder="Start Date (ex. 2020-11-01)"size=25>
				  <input style="border-radius:24px; margin-right:2%;" type="text" id="station" name="endDate" placeholder="End Date (ex. 2020-12-01)"size=25>
				  <input style="border-radius:24px;background-color: #00ffff;" type="submit" value="Search">
				</form> 
				</div>
		   <%
		    while (rs.next()) {
				totalRevenue+= Double.parseDouble(rs.getString("Total"));
		   %>
		    	
		    	<tr style="text-align:center">
		        <td><%= rs.getString("transit_line_name") %></td>	
		        <td><%= rs.getDouble("Total") %></td> 
		      </tr>	
		   <% } %> 
		   <tr style="text-align:center; margin-top: 50pt;">
		        <td>Total</td>	
		        <td><%=totalRevenue %></td> 
		      </tr>	
		    <%
		 
	}

	catch(Exception ex){
		
	}
  
  %>
  			
</table>
</body>
</html>