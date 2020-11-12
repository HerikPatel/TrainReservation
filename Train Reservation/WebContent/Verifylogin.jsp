<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="logindetails.*"%>
	<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
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
	    rs = st.executeQuery("select * from logindetails where email='" + email + "' and password='" + password + "'");
	    if (rs.next()) {
	        session.setAttribute("email", email); // the username will be stored in the session
	        out.println("welcome " + email);
	    } else {
	        out.println("Invalid password <a href='login.jsp'>try again</a>");
	    }
	 
}

catch(Exception ex){
	System.out.println("Login failed");
}



%>
</body>
</html>