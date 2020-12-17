<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Insert title here</title>
</head>
<a href="TrainSchedule.jsp">
<img border="0" alt="go back" src="back.png" width="25" height="10">
Go back
</a>
<br><br>
<body style= "">
<div style="  text-align: center;">
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
	
%>
  <form action="UpdateSchedule.jsp">
             <label > ID</label><br>
 			 <input type="text" name="id"  required><br>
 			              <label >Train ID</label><br>
 			 <input type="text" name="train_id"  ><br>
 			 
  			<label >Transit Line Name</label><br>
  			<input type="text" name="transit_line_name" ><br>
  			<label >Origin</label><br>
  			<input type="text" name="Origin" ><br>
  			<label >Destination</label><br>
  			<input type="text" name="Destination" ><br>
  			<label >Departure Format(YYYY/MM/DD)</label><br>
  			<input type="date" name="Departure" ><br>
  			<label >Departure Time</label><br>
  			<input type="time" name="Departure_time" ><br>
  			<label >Arrival Format(YYYY/MM/DD</label><br>
  			<input type="Date" name="Arrival" ><br>
  			<label >Arrival Time</label><br>
  			<input type="time" name="Arrival_time" ><br>
  			<label >Fare</label><br>
  			<input  type="text" name="fare" ><br><br>
  <input style="border-radius:24px;background-color: #00ffff;" type="submit" value="Submit">
</form> 
</div>
</body>
</html>