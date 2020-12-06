<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<%
try{
	 String ses2=(String)session.getAttribute("type");

	 if(!ses2.equals("R"))
		{
	        response.sendRedirect("logout.jsp");
		}
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
    Statement st = con.createStatement();
	String id = request.getParameter("id"); 
	String Origin = request.getParameter("Origin"); 
	String Destination = request.getParameter("Destination"); 
	String Departure = request.getParameter("Departure"); 
	String Departure_time = request.getParameter("Departure_time"); 
	String Arrival = request.getParameter("Arrival"); 
	String Arrival_time = request.getParameter("Arrival_time");
	String fare = request.getParameter("fare"); 
	String transit_line_name = request.getParameter("transit_line_name"); 


String str = "";
if(transit_line_name.length()>1)
{
	str = "update TSchedule set transit_line_name = '"+ transit_line_name+"' where id ="+id;
	System.out.println(str);
	st.executeUpdate(str);
}
if(Origin.length()>1)
{
	str = "update TSchedule set Origin = '"+ Origin+"' where id ="+id;
	System.out.println(str);
	st.executeUpdate(str);
}
if(Destination.length()>1)
{
	str = "update TSchedule set Destination = '"+ Destination+"' where id ="+id;
	System.out.println(str);
	st.executeUpdate(str);
}if(Departure.length()>1)
{
	Departure = Departure.substring(0,4)+Departure.substring(5,7)+Departure.substring(8,10);
	str = "update TSchedule set Departure = '"+ Departure+"' where id ="+id;
	st.executeUpdate(str);
}
if(Departure_time.length()>1)
{
	Departure_time = Departure_time.substring(0,2)+Departure_time.substring(3,5);

	str = "update TSchedule set Departure_time = '"+ Departure_time+"' where id ="+id;
	System.out.println(str);
	st.executeUpdate(str);
}if(Arrival.length()>1)
{
	Arrival = Arrival.substring(0,4)+Arrival.substring(5,7)+Arrival.substring(8,10);

	str = "update TSchedule set Arrival = '"+ Arrival+"' where id ="+id;
	System.out.println(str);
	st.executeUpdate(str);
}if(Arrival_time.length()>1)
{
	Arrival_time = Arrival_time.substring(0,2)+Arrival_time.substring(3,5);
	str = "update TSchedule set Arrival_time = '"+ Arrival_time+"' where id ="+id;
	System.out.println(str);
	st.executeUpdate(str);
}if(fare.length()>1)
{
	str = "update TSchedule set fare = '"+ fare+"' where id ="+id;
	System.out.println(str);
	st.executeUpdate(str);
}
response.sendRedirect("TrainSchedule.jsp");

	 
}

catch(Exception ex){
	
}

%>
</body>
</html>