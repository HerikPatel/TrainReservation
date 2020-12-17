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
	String train_id = request.getParameter("train_id"); 
	train_id = " " + train_id;
	System.out.println(train_id);
	String origin = request.getParameter("Origin"); 
	String destination = request.getParameter("Destination"); 
	String Departure = request.getParameter("Departure"); 
	String Departure_time = request.getParameter("Departure_time"); 
	String Arrival = request.getParameter("Arrival"); 
	String Arrival_time = request.getParameter("Arrival_time");
	String fare = request.getParameter("fare"); 
	String transit_line_name = request.getParameter("transit_line_name"); 
	 ResultSet rs;


String str = "";
if(transit_line_name.length()>1)
{
	
	str = "update Schedule set transit_line_name = '"+ transit_line_name+"' where id ="+id;
	st.executeUpdate(str);
}
if(train_id.length()>1)
{
	str = "update Schedule set train_id = '"+ train_id+"' where id ="+id;
	//System.out.println(str);
	st.executeUpdate(str);

}
if(origin.length()>1)
{
	 rs = st.executeQuery("select * from Stations  where station_name ='" + origin + "'");
	    if (rs.next()) {
	    
	    }
	    else
	    {
	    	str = "INSERT INTO Stations (station_name,city,state) values('"+origin+ "',null ,null)";
	    	//System.out.println(str);
	    	st.executeUpdate(str); 	
	    }
	str = "update Schedule set origin = '"+ origin+"' where id ="+id;
	//System.out.println(str);
	st.executeUpdate(str);
}
if(destination.length()>1)
{
	rs = st.executeQuery("select * from Stations  where station_name ='" + destination + "'");
    if (rs.next()) {
    
    }
    else
    {
    	str = "INSERT INTO Stations (station_name,city,state) values('"+destination+ "',null ,null)";
    	//System.out.println(str);
    	st.executeUpdate(str); 	
    }
	str = "update Schedule set destination = '"+ destination+"' where id ="+id;
	//System.out.println(str);
	st.executeUpdate(str);
}if(Departure.length()>1)
{
	Departure = Departure.substring(0,4)+Departure.substring(5,7)+Departure.substring(8,10);
	str = "update Schedule set Departure = '"+ Departure+"' where id ="+id;
	st.executeUpdate(str);
}
if(Departure_time.length()>1)
{
	Departure_time = Departure_time.substring(0,2)+Departure_time.substring(3,5);

	str = "update Schedule set Departure_time = '"+ Departure_time+"' where id ="+id;
	//System.out.println(str);
	st.executeUpdate(str);
}if(Arrival.length()>1)
{
	Arrival = Arrival.substring(0,4)+Arrival.substring(5,7)+Arrival.substring(8,10);

	str = "update Schedule set Arrival = '"+ Arrival+"' where id ="+id;
	//System.out.println(str);
	st.executeUpdate(str);
}if(Arrival_time.length()>1)
{
	Arrival_time = Arrival_time.substring(0,2)+Arrival_time.substring(3,5);
	str = "update Schedule set Arrival_time = '"+ Arrival_time+"' where id ="+id;
	//System.out.println(str);
	st.executeUpdate(str);
}if(fare.length()>1)
{
	str = "update Schedule set fare = '"+ fare+"' where id ="+id;
	//System.out.println(str);
	st.executeUpdate(str);
}
response.sendRedirect("TrainSchedule.jsp");

	 
}

catch(Exception ex){
	response.sendRedirect("TrainSchedule.jsp");

}

%>
</body>
</html>