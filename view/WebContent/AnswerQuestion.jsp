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
  #subdiv{
padding: 10px;
 border-radius: 24px;
  background: #00ffff;
width: max-content;
  font-size: 27px;
}
#ans{
  display: flex;
  flex-direction: row-reverse;
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
<title>Answer Question</title>
<h1 style ="  text-align: center;">Answer Question</h1>
</head>
<body>
<a href="UnansweredQuestion.jsp">
<img border="0" alt="go back" src="back.png" width="25" height="10">
Go back
</a>
<br><br>
<div id ="chat"> 
<% 
	String id = request.getParameter("id");
	String answer = request.getParameter("answer");
try{
	ApplicationDB db = new ApplicationDB();	
	Connection con = db.getConnection();
	Statement stmt = con.createStatement();
    Statement st = con.createStatement();

	 ResultSet rs;
	 String ques = "select * from question where id="+ id;
	    rs = st.executeQuery(ques);

		while(rs.next())
		{
	    	%>
		    	<div id ="ques"> <%= rs.getString("ques") %> </div>			    	
		    
		    <% 	String ans=rs.getString("ans");
		    if(!ans.equals("none"))
	    	{
	        %>
		    	<div id="ans"> <div id="subdiv"><%= rs.getString("ans") %></div></div>			    	
		    <%			    	
		    }
		    
		    
		}
		if(answer!=null)
		{
			if(answer.length()>2)
			{
				String update = "update question set ans='"+answer+"' where id="+id;
				st.executeUpdate(update);
				response.sendRedirect("AnswerQuestion.jsp?id="+id);

			}
		}
}

catch(Exception ex){
	System.out.println("Fail");
}
%>
    </div>

 <div id="chatinput">
  <input  style="border-radius:24px; font-size: 27px;" type="text" id="answer" name="answer" placeholder="Describe Answer in less than 600 characters "size=99>
  <button style="border-radius:24px; font-size: 27px; background-color: #00ffff;" onclick="myFunction()">Send</button>
  </div>
</body>
<script>
function myFunction() {
	  var x = document.getElementById("answer").value;
	location.replace("AnswerQuestion.jsp?id="+<%= id%>+"&answer="+ x)
}
</script>
</html>