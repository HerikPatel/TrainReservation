<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
	<%@ page import="java.io.*,java.util.*,java.sql.*, java.text.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Ticket Reservation</title>
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

	String amtStandard = request.getParameter("standard").equals("") ? "0" : request.getParameter("standard");
	String amtDisabled = request.getParameter("disabled").equals("") ? "0" : request.getParameter("disabled");
	String amtSenior = request.getParameter("senior").equals("") ? "0" : request.getParameter("senior");
	String amtChild = request.getParameter("child").equals("") ? "0" : request.getParameter("child");
	String scheduleId = request.getParameter("scheduleId");
	if(scheduleId == null || scheduleId.equals("")){
		out.println("Something went wrong, <a href='SearchReservations.jsp'> Go back to search. </a>");
	}else {
		int totalTickets = Integer.parseInt(amtStandard) + Integer.parseInt(amtDisabled) + Integer.parseInt(amtSenior) + Integer.parseInt(amtChild);
		String query = String.format("SELECT t.id, t.total_seats FROM Train t WHERE t.id = (SELECT s.train_id FROM Schedule s WHERE s.id = %s)", scheduleId);
		System.out.println(query);
		ResultSet rs = st.executeQuery(query);
		int numSeats = 0, numTaken = 0;
		int trainId = -1;
		if(rs.next()){
			numSeats = rs.getInt("total_seats");
			trainId = rs.getInt("id");
		}else{
			numSeats = -1;
		}
		
		String queryTwo = String.format("SELECT COUNT(reservation_number) as 'purchased' FROM reservationdetails WHERE schedule_id = %s", scheduleId);
		System.out.println(queryTwo);
		ResultSet rst = st.executeQuery(queryTwo);
		if(rst.next()){
			numTaken = rst.getInt("purchased");
		}else{
			numTaken = -1;
		}
		
		if(numSeats == -1||numTaken == -1|| !((numSeats - numTaken) >=totalTickets)){
			session.setAttribute("ticketAvailable", "block");
			response.sendRedirect("MakeReservation.jsp?scheduleid="+scheduleId);
		}
		
		String queryThree = String.format("SELECT fare FROM Schedule WHERE id = %s", scheduleId);
		System.out.println(queryThree);
		ResultSet rstTwo = st.executeQuery(queryThree);
		Double fare = 0.0;
		if(rstTwo.next()){
			fare = rstTwo.getDouble("fare");
			System.out.println(fare);
			java.util.Calendar now = java.util.Calendar.getInstance();
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			String nowDate = sdf.format(now.getTime());
			System.out.println(nowDate);
			Double disabledFare = fare *0.5;
			Double seniorFare = fare *0.65;
			Double childFare = fare *0.75;
			int standard = Integer.parseInt(amtStandard);
			int disabled = Integer.parseInt(amtDisabled);
			int senior = Integer.parseInt(amtSenior);
			int child = Integer.parseInt(amtChild);
			int id = 0;
			for(int i = 0; i < totalTickets; i++){
				Statement stmt = con.createStatement();
				if(standard > 0) {
					String insertReservationQuery = String.format("INSERT INTO reservation(reservation_date,total_fare,email) VALUES('%s', %s, '%s');",nowDate, fare.toString(), email);
					stmt.executeUpdate(insertReservationQuery, Statement.RETURN_GENERATED_KEYS);
					ResultSet rsKeys = stmt.getGeneratedKeys();
			        if (rsKeys.next()){
			            id =rsKeys.getInt(1);
			        }
			        rsKeys.close();
					String insertReservationDetailsQuery = String.format("INSERT INTO reservationdetails VALUES(%s,%s,%s,%s)", Integer.toString(id), scheduleId, Integer.toString(trainId), fare.toString());
					st.executeUpdate(insertReservationDetailsQuery);
					standard--;
				}else if(disabled > 0){
					String insertReservationQuery = String.format("INSERT INTO reservation(reservation_date,total_fare,email) VALUES('%s', %s, '%s');",nowDate, disabledFare.toString(), email);
					stmt.executeUpdate(insertReservationQuery, Statement.RETURN_GENERATED_KEYS);
					ResultSet rsKeys = stmt.getGeneratedKeys();
			        if (rsKeys.next()){
			            id =rsKeys.getInt(1);
			        }
			        rsKeys.close();
					String insertReservationDetailsQuery = String.format("INSERT INTO reservationdetails VALUES(%s,%s,%s,%s)",Integer.toString(id), scheduleId, Integer.toString(trainId), disabledFare.toString());
					st.executeUpdate(insertReservationDetailsQuery);
					disabled--;
				}else if(senior > 0){
					String insertReservationQuery = String.format("INSERT INTO reservation(reservation_date,total_fare,email) VALUES('%s', %s, '%s');",nowDate, seniorFare.toString(), email);
					stmt.executeUpdate(insertReservationQuery, Statement.RETURN_GENERATED_KEYS);
					ResultSet rsKeys = stmt.getGeneratedKeys();
			        if (rsKeys.next()){
			            id =rsKeys.getInt(1);
			        }
			        rsKeys.close();
					String insertReservationDetailsQuery = String.format("INSERT INTO reservationdetails VALUES(%s,%s,%s,%s)",Integer.toString(id), scheduleId, Integer.toString(trainId), seniorFare.toString());
					st.executeUpdate(insertReservationDetailsQuery);
					senior--;
				}else if(child > 0){
					String insertReservationQuery = String.format("INSERT INTO reservation(reservation_date,total_fare,email) VALUES('%s', %s, '%s');",nowDate, childFare.toString(), email);
					stmt.executeUpdate(insertReservationQuery, Statement.RETURN_GENERATED_KEYS);
					ResultSet rsKeys = stmt.getGeneratedKeys();
			        if (rsKeys.next()){
			            id =rsKeys.getInt(1);
			        }
			        rsKeys.close();
					String insertReservationDetailsQuery = String.format("INSERT INTO reservationdetails VALUES(%s,%s,%s,%s)",Integer.toString(id), scheduleId, Integer.toString(trainId), childFare.toString());
					st.executeUpdate(insertReservationDetailsQuery);
					child--;
				}
				stmt.close();
			}
			out.println("Tickets reserved, return <a href='Customerhomepage.jsp'>Home.</a>");
		}
	}
	 
}

catch(Exception ex){
	System.out.println(ex.toString());
	System.out.println("Login failed");
}



%>



</body>
</html>