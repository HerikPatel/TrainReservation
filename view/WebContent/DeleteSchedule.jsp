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
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
    Statement st = con.createStatement();
	String id = request.getParameter("id"); 

String str = "Delete from Route  WHERE schedule_id = "+id+";";
//System.out.println(str);
st.executeUpdate(str);

str = "Delete from reservationdetails  WHERE schedule_id = "+id+";";
st.executeUpdate(str);


str = "Delete from Schedule  WHERE id = "+id+";";
stmt.executeUpdate(str);


response.sendRedirect("TrainSchedule.jsp");

	 
}

catch(Exception ex){
	
	response.sendRedirect("TrainSchedule.jsp");

}

%>
</body>
</html>