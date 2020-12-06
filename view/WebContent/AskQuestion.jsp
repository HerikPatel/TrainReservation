<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<style>

#chatinput {
position: absolute;
  bottom: 10px;
  }

#ans{
  display: flex;
  flex-direction: row-reverse;
  
}
#subdiv{
padding: 10px;
 border-radius: 24px;
  background: #00ffff;
width: max-content;
  font-size: 27px;
}
#ques{
  padding: 10px;
 border-radius: 24px;
  background: #73AD21;
width: max-content;
  font-size: 27px;
  }
</style>
<head>
<meta charset="ISO-8859-1">
<title>Chat with Representative</title>

</head>
<body>
<div id ="chat"> 
<% 
 try{
	    String email =(String)session.getAttribute("email");
if(email == null)
{
    response.sendRedirect("index.jsp");
}
		ApplicationDB db = new ApplicationDB();	
		Connection con = db.getConnection();
		Statement stmt = con.createStatement();
	    Statement st = con.createStatement();
	    String question = request.getParameter("question"); 
	    int id=0;

		 ResultSet rs;
		    rs = st.executeQuery("select * from question");
		   while (rs.next()) 
		   {
		    	id = rs.getInt("id");
	     	}
		    rs = st.executeQuery("select * from question where email='"+email+"'");
		    while (rs.next()) 
			   {
		    	%>
			    	<div id ="ques"> <%= rs.getString("ques") %> </div>			    	
			    
			    <% 	String ans=rs.getString("ans");
			    	if(!ans.equals("none"))
			    	{
			    %>
				    	<div id="ans"> <div id="subdiv"> <%= rs.getString("ans") %> </div></div>			    	
				    <%			    	
				    }
		     	}
		    if(question!=null)
		    {
		    	if(question.length()>2)
		    	{
		    		id++;
				String insert = "insert into question(email,ques,ans,who,id) value('"+email+"','"+question+"','none','c',"+id+")";
				stmt.executeUpdate(insert); 
		    	}
				response.sendRedirect("AskQuestion.jsp");
		    }
		 
	}

	catch(Exception ex){
		response.sendRedirect("AskQuestion.jsp");
	}
  
%>
    </div>

  <div id="chatinput">
    <form action="AskQuestion.jsp">
  <input  style="border-radius:24px; font-size: 27px;" type="text" id="station" name="question" placeholder="Describe Question in less than 600 characters "size=100>
  <input style="border-radius:24px; font-size: 27px; background-color: #00ffff;" type="submit" value="Send">
</form> 

  </div>
</body>
</html>