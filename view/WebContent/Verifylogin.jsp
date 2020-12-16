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
	
	if(email.equals("admin") && password.equals("admin123")){
		session.setAttribute("type", "A");
		session.setAttribute("username", "admin");
		session.setAttribute("invalidPassword", "none");
		response.sendRedirect("AdminConsole.jsp");
	}else {
		ResultSet rs;
		Statement st = con.createStatement();
		String type;
		if(email.contains("@")){
			rs = st.executeQuery("select * from customer where email='" + email + "' and password='" + password + "'");
			type = "C";
		}else {
			rs = st.executeQuery("select * from employee where username='" + email + "' and password='" + password + "'");
			type = "R";
		}
	    if (rs.next()) {
	    	session.setAttribute("type", type);
	        session.setAttribute("invalidPassword", "none");
	        if(type.equals("R")) {
	        	session.setAttribute("username", email);
	        	response.sendRedirect("TrainSchedule.jsp");
	        }else {
	        	session.setAttribute("email", email);
	        	response.sendRedirect("home.jsp");
	        	System.out.println("Redirecting to home, there is no logic for customers yet.");
	        }
	    } else {
	        session.setAttribute("invalidPassword", "block");
	        response.sendRedirect("index.jsp");
	    }
	 
	}
}
catch(Exception ex){
	System.out.println("Login failed");
}



%>
</body>
</html>