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
  }
	catch(Exception ex) {
		
	}
	  
		//ApplicationDB db = new ApplicationDB();	
		//Connection con = db.getConnection();
		//Statement stmt = con.createStatement();
	    //Statement st = con.createStatement();
%>

<h1 style="text-align: center">Admin Portal</h1>
<div class="centre">
    <div class="btn-group">
      <a href="ManageRepresentatives.jsp" class="button">Manage Representatives</a>
      <a class="button">Sales Reports</a>
      <a class="button">Reservations</a>
      <a class="button">Revenue</a>
      <a href="logout.jsp" class="button">Log Out</a>
    </div>
</div>

<div class="centre" style="margin-top:40pt;">
    <h2>Best Customer: insert Name here</h2>
    <p>X Total Trips | $X Spent | X different lines traveled</p>
</div>

<div class="centre" style="margin-top:40pt;">
    <h2>Five Most Active Train Lines</h2>
    <ol style="text-align: center; list-style-position: inside; padding: 0;">
        <li> Station One</li>
        <li> Station Two</li>
        <li> Station Three</li>
        <li> Station Four</li>
        <li> Station Five</li>
    </ol>
</div>

</body>
</html>