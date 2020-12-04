<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
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
	String password = request.getParameter("psw");
	String passwordRepeat = request.getParameter("psw-repeat");
	String username = request.getParameter("username");
	String firstname = request.getParameter("firstname");
	String lastname = request.getParameter("lastname");
	if(password.equals(passwordRepeat)) {
		String insert = "INSERT INTO customer(email,password,username,firstname,lastname,accountype) value('"+email+"','"+password+"','"+username+"','"+firstname+"','"+lastname+"','C')";
		stmt.executeUpdate(insert); 
		System.out.println(insert);

		con.close();
		out.println("Account Created, please <a href='index.jsp'>login.</a>");
	} else {
		out.println("Password fields do not match, please <a href='Signup.jsp'> try again.</a>");
	}
	 
}

catch(Exception ex){
	System.out.println("Registration failed, please <a href='Signup.jsp'>try again.</a>");
}



%>
</body>
</html>