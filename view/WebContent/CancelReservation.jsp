<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
	<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Cancel Reservation</title>
</head>
<body>


<% 
try{
	String ses2=(String)session.getAttribute("type");
	  System.out.println(ses2);
	 
	    if(ses2 != null)
	    {
	  	if(!ses2.equals("C"))
	 	{
	          response.sendRedirect("logout.jsp");
	    }
	    }
	    
	    else
	    {
	  	  System.out.println("Redirecting to login page");
	          response.sendRedirect("index.jsp");
	    }
	    String email = (String)session.getAttribute("email");
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement st = con.createStatement();

	String resnum = request.getParameter("resnum");
	if(resnum != null){
		String query = String.format("DELETE FROM reservationdetails WHERE reservation_number = %s;", resnum);
		String queryTwo = String.format("DELETE FROM reservation WHERE reservation_number = %s;", resnum);
		int resDetailDelete = st.executeUpdate(query);
		if(resDetailDelete > 0){
			int resDelete = st.executeUpdate(queryTwo);
			if(resDelete > 0){
				out.println("Successfully canceled, <a href='ManageReservations.jsp'>Go back to reservation list</a>");
			}else{
				out.println("Something went wrong, <a href='ManageReservations.jsp'>Go back to reservation list</a>");
			}
		}else{
			out.println("Something went wrong, <a href='ManageReservations.jsp'>Go back to reservation list</a>");
		}
		
	}else{
		out.println("Something went wrong, <a href='ManageReservations.jsp'>Go back to reservation list</a>");
	}
	 
}

catch(Exception ex){
	System.out.println(ex.toString());
	System.out.println("Login failed");
}



%>



</body>
</html>