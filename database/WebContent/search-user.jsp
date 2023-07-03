<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<%@ page import="java.sql.*" %> 
<%@ page import="java.lang.*" %>
<%@ page import="java.io.*" %>
<%@ page import="project4710.*" %>
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
<html>
<head>
<title>Search NFT</title>
	<style>		
	body {
    	background-color: #444444;
    	padding-bottom: 8em;
    }
	.main-container {
		max-width: 800px; 
		margin:auto;
	}	
	.form-container, .search-container {
		width: 100%;
		text-align: center;
		margin: auto;
		padding-bottom: 4em;
	}
	
	.form-container form{
		padding-top: 3em;
	}
	.buy-input{
		border: 1px solid;
		height: auto;
		width: 10%;
		margin: 0.5em 0;
		padding: 10px 10px;
	}
	.form-container label, .search-container label{
		text-align: left;
		margin: auto;
		font-size: .85em;
		color: #fff;
	}
	.search-input{
		border: 1px solid;
		height: auto;
		width: 50%;
		margin: 0.5em 0;
		padding: 10px 10px;
	}
	.search-button{
		border: 1px solid;
		height: auto;		
		margin: 0.5em 0;
		padding: 10px 10px;
		background-color: #ccffcc;
		cursor: pointer;
	}
	.submit {										
		width: 200px;
		height: 36px;
		border-radius: 18px;
		background-color: #99ff99;
		border: solid 1px transparent;
		color: #000000;
		font-size: 18px;
		font-weight: 300;
		cursor: pointer;		
	}
	.submit:hover {
		width: 200px;
		height: 36px;
		border-radius: 18px;
		background-color: transparent;
		border: solid 2px #99ff99;
		color: #99ff99;
		font-size: 18px;
		font-weight: 300;
	}
	
	h2 {
		padding-top: 2.5em;
		text-align: center;
		font-size: 25px;
		color: #ffffff;
	}		
	table, tr, th, td {
		margin-left: auto;
		margin-right: auto;
  		border: 1px solid ;  				
		border-collapse: collapse;
		padding: 1em;
	}
	table {
		background-color: #ffffe0;
	}
	.option-buttons {	
		display: inline-block;									
		padding: 5px 12px;
		border-radius: 10px;
		background-color: #99ff99;
		border: solid 1.5px transparent;
		color: #000000;		
		cursor: pointer;	
		text-decoration: none;
		margin: 0 0.4em 0 0.4em;	
	}
	
	.success {
      	text-align: center;
      	padding: 1em;
      	color: #023020;
      }
      .failed {
      	text-align: center;
      	padding: 1em;
      	color: #FF5555;
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
        color: #000000;
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
		<h2>
			User Finder
			
		</h2>
		<div class="search-container">
			<form class="search-form" action="search-user.jsp">
  				<input class="search-input" name="search-input" type="search" placeholder="Enter email of user you want to find..." autofocus required />
  				<button class="search-button" type="submit">Search</button>    
			</form>
		</div>
		<%	statement=connection.createStatement();
  			String search_input = request.getParameter("search-input");
  			if(search_input!=null && !search_input.trim().equals("")){
				String sql1 = "select * from user where email='" + search_input + "';";
				resultSet = statement.executeQuery(sql1);
					if (!resultSet.isBeforeFirst() ) { %>
						<p class="failed">There is no user with username '<%=search_input %>' </p> 
					<%} else {%>
						<table class="tables">							
							<%while(resultSet.next()){ %>
								<tr style="text-align:center">										
										<td><%=resultSet.getString("email") %></td>	
										<td>											
											<a class="option-buttons" href="info-user.jsp?searchEmail=<%=resultSet.getString("email") %>" target="_self">
												More Info
											</a>
										</td>								
								</tr>
							<%}%>
						</table>
	
						
	  								
						<%}	 						
					}%>
	</div>
	
</body>