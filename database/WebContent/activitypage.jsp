<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %> 
<%@ page import="java.sql.*" %> 
<%@ page import="java.lang.*" %>
<%@ page import="java.io.*" %>
<%@page import="project4710.*" %>
<%
try {
Class.forName("com.mysql.cj.jdbc.Driver");
} catch (ClassNotFoundException e) {
e.printStackTrace();
}

Connection connection = DriverManager.getConnection("jdbc:mysql://jariok.com:3306/testdb?allowPublicKeyRetrieval=true&useSSL=false&user=john&password=pass1234");
Statement statement = null;
ResultSet resultSet = null;
PreparedStatement pstatement = null;
String email = (String)request.getSession().getAttribute("email");
%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Activity page</title>
    <style>
    body {
    	background-color: #444444;
    }
    .main-container {
		max-width: 800px; 
		margin:auto;
	}	
      .buttons-container {
        text-align: center;
        margin-top: 50px; 
        margin: 0 10% 0;
        padding: 10%;
      }
      .main-button {
        padding: 5%;
      }

      .buttons-container button {
        padding: 5%;
        height: 4em; 
        width: 70%; 
        font-size: 1em; 											
        background: #009900; 
        color: #ffffff;						
        cursor: pointer;;
      }

      .main-container button:hover{											
        background: #ffffff; 
        color: #009900;						
        cursor: pointer;
        font-size: 1em;        
        border-color: #000000;
      }
      .userinfo-container {
      	margin: auto;
      	display: block;
      	max-width: 70%;
      	border: solid;
      	border-radius: 18px;
      	background-color: #ccffcc;
     }
     .userinfo {
      	text-align: center; 
      	font-size: 2em; 
      	margin-top: 0.25em; 
      	margin-bottom: 0.25em;
     }
      .logout {
        text-align: center;
        cursor:pointer;
        
        
      }
      .logout a {
        text-decoration: none;
        color: #ffffff;
      }
      .logout a:hover {
        text-decoration: none;
        color: #ff8000;
      }
      .nav-list li{
      	display: inline;
      	max-width: 120%;
      	margin-right: 2em;
      }
    </style>
	</head>
	
  <body>
    <h1 style="text-align: center; color:#00FF00;"> REAL NFT TRADING </h1> 
    <div class="main-container">		
      <div class="userinfo-container">
		<p class="userinfo">
        <%					 
			statement=connection.createStatement();
			String getData ="select balance, nft_owned from user where email = '" + email + "';";
			resultSet = statement.executeQuery(getData);
			while(resultSet.next()){ 
		%>
		
        	User: <%= email %> <br>
        	Balance: <%= resultSet.getString("balance") %> $ETH <br>
       		Own: <%= resultSet.getString("nft_owned") %> NFT(s)
        
        <%} %>
        
        
        
      </p>      	
      </div>
      <div class="logout">
        <ul class="nav-list">
       		<li><a href="activitypage.jsp" target="_self">Main Page</a></li>
       		<li><a href="info-user.jsp?searchEmail=<%=email%>" target="_self">Profile</a></li>
       		<li><a href="user-minted.jsp" target="_self">Minted NFT</a></li>
       		<li><a href="user-purchased.jsp" target="_self">Purchased NFT</a></li>
       		<li><a href="user-sold.jsp" target="_self">Sold NFT</a></li>
       		<li><a href="login.jsp" target="_self">Logout</a></li>
       	</ul> 	
      </div>
      <div class="buttons-container">      	
        <div class="main-button">
          <form action="search-user.jsp">
            <button type="submit">
			  	  	SEARCH USER
			      </button>
          </form>
        </div>
        <div class="main-button">
          <form action="search-nft.jsp">
            <button type="submit">
			  	  	SEARCH NFT
			      </button>
          </form>
        </div>
        <div class="main-button">
          <form action="sell-nft.jsp">
            <button type="submit">
			  	  	SELL
			      </button>
          </form>
        </div>
        <div class="main-button">
          <form action="create-nft.jsp">
            <button type="submit">
			  	  	CREATE
			      </button>
          </form>
        </div>
        <div class="main-button">
          <form action="transfer-nft.jsp">
            <button type="submit">
              		TRANSFER
            </button>
          </form>
        </div>
      </div>
     </div>
</html>