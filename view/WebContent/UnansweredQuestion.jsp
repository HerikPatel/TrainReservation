<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Unanswered Question </title>
</head>
<body>
<% 
 try{
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
	    Statement st = con.createStatement();
	    String email ="admin1234";

		 ResultSet rs;
		    rs = st.executeQuery("select * from question");
		    while (rs.next()) 
			   {

		    	String ans=rs.getString("ans");
			    	if(ans.equals("none"))
			    	{
			    		%>
			    		<div><a href="AnswerQuestion.jsp?id=<%= rs.getString("id") %>"> <%= rs.getString("email") %></a></div>
			    		<%
				    }
		     	}		 
	}

	catch(Exception ex){
		System.out.println("Fail");
	}
  
%>

</body>
</html>