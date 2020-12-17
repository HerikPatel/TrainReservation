<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.cs336.pkg.*"%>
<%@ page import="java.io.*,java.util.*,java.sql.*"%>
<%@ page import="javax.servlet.http.*,javax.servlet.*"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Home Page</title>
<h1 style = "text-align : center">Welcome <%= (String)session.getAttribute("name") %></h1>
</head>

<body>

<table style="margin-left: auto; margin-right:auto;">
<tr>
<td>
<button onclick="chat()" style="border-radius:24px;background-color: #00ffff;">Chat with a representative</button>
</td>
<td>
<button onclick="manageRes()" style="border-radius:24px;background-color: #00ffff;float: right;">Manage Reservations</button>
</td>
<td>
<button onclick="faq()" style="border-radius:24px;background-color: #00ffff;float: right;">FAQ</button>
</td>
<td>
<form action="logout.jsp">
  <input style="border-radius:24px;background-color: #00ffff;" type="submit" value="logout">
</form>
</td>
</tr>
</table>

<br><br>
  <div style="padding-left: 25%;"> 
  <form action="SearchbyStationcustomer.jsp">
    <input type="radio"  name="typeofstation" id="origin" value="origin" required>
    <label for="origin">Origin</label>
    <input type="radio" name="typeofstation" id="destination" value="destination">
     <label for="destination">Destination</label>
  <input style="border-radius:24px" type="text" id="station" name="station" placeholder="Station "size=50 >
    <input style="border-radius:24px" type="date" id="date" name="date"  "size=30 required >
  
  <input style="border-radius:24px;background-color: #00ffff;" type="submit" value="Search">
</form> 
<br><br><br>
    </div>
</body>
<script >
function chat() {
	  location.replace("AskQuestion.jsp")
	}
function faq() {
	  location.replace("FAQ.html")
	}
function manageRes() {
	location.replace("ManageReservations.jsp")
}
</script>

</html>