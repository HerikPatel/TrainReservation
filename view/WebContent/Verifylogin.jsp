<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
	<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>
<body>
<% 
try{
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();

	String email = request.getParameter("email");
	String password = request.getParameter("password");
    Statement st = con.createStatement();

	 ResultSet rs;
	    rs = st.executeQuery("select * from customer where email='" + email + "' and password='" + password + "'");
	    if (rs.next()) {
	    	String type = rs.getString("accountype");
	    	session.setAttribute("type", type);
	        session.setAttribute("email", email); // the username will be stored in the session
	        session.setAttribute("invalidPassword", "none");
	        if(type.equals("R")) {
	        	response.sendRedirect("TrainSchedule.jsp");
	        }else if(type.equals("A")) {
	        	response.sendRedirect("AdminConsole.jsp");
	        }else {
	        	response.sendRedirect("logout.jsp");
	        	System.out.println("Redirecting to login, there is no logic for customers yet.");
	        }
	    } else {
	        session.setAttribute("invalidPassword", "block");
	        response.sendRedirect("index.jsp");
	    }
	 
}

catch(Exception ex){
	System.out.println("Login failed");
}



%>
</body>
</html>