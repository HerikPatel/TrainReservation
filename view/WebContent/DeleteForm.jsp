<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
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
<%

String ses2=(String)session.getAttribute("type");
System.out.println(ses2);

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
<div style= " text-align: center;">
  <form action="DeleteSchedule.jsp">
             <label >Train ID</label><br>
  			<input  type="text" name="id"  required><br><br>
  <input style="border-radius:24px;background-color: #00ffff;" type="submit" value="Submit">
</form> 
</div>
</body>
</html>