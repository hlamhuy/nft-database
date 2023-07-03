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
String nft_id = request.getParameter("nft_id");
int trans_id = 0;
%>
<html>
<head>
<title>Buy NFT</title>
	<style>		
	body {
    	background-color: #444444;
    	padding-bottom: 8em;
    }
	.main-container {
		max-width: 800px; 
		margin:auto;
	}	
	.form-container {
		width: 75%;
		text-align: center;
		margin: auto;
		
	}
	.form-container label{
		text-align: left;
		margin: auto;
		font-size: .85em;
		color: #fff;
	}
	.input{
		border: 1px solid;
		height: auto;
		width: 50%;
		margin: 0.5em 0;
		padding: 10px 10px;
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
		text-align: center;
		font-size: 30px;
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
	.info-container {
		font-size: 25px;
		text-align: center;
		color: #ccffcc;
		margin: auto;
	}
	.details {
		background-color: #ffffff;
		border: solid 2px #99ff99;
		text-align: left;
		color: #000000;
		padding: 2em;
		margin: auto;
		max-width: 50%;
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
	<%try {%>
	<div class="main-container">
		<div class="userinfo-container">
		<div class="userinfo">
        
			<% statement=connection.createStatement();
			String getData ="select balance, nft_owned from user where email = '" + email + "';";
			resultSet = statement.executeQuery(getData);
			while(resultSet.next()){ %>
			
		
        	User: <%= email %> <br>
        	Balance: <%= resultSet.getString("balance") %> $ETH <br>
       		Own: <%= resultSet.getString("nft_owned") %> NFT(s)
        
        	<%} %>
        
      </div>      	
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
			NFT Details
		</h2>
		<div class="info-container">
			<div class="details">
				<%  String details = "select * from nfts where nft_id='" + nft_id + "';";
					resultSet = statement.executeQuery(details);
					while(resultSet.next()){
				%>
				<h4> NFT #<%= nft_id %></h4>
				Name: <%= resultSet.getString("nft_name") %> <br>
				URL: <%= resultSet.getString("url") %> <br>
				Created By: <%= resultSet.getString("creator") %> <br>
				Current Owner: <%= resultSet.getString("nft_owner") %> <br>
				Mint Time: <%= resultSet.getString("mint_time") %> <br>
				<%} %>
			</div>
		</div>
		<h2>
			Activities
		</h2>
			<%  String activities = "select * from transactions where nft_id='" + nft_id + "';";
				resultSet = statement.executeQuery(activities);
				if(!resultSet.isBeforeFirst()) {
					%><p class="failed">This NFT has no activities</p> <%
				} else {%>
					<table class="tables">
							<tr>
								<th>NFT ID</th>
								<th>From</th>
								<th>To</th>
								<th>Type of Transaction</th>
								<th>Transaction Time</th>
								<th>Price</th>
							</tr>
					<%while(resultSet.next()){ %>
								<tr style="text-align:center">
										<td><%=resultSet.getString("nft_id") %></td>
										<td><%=resultSet.getString("from_user") %></td>
										<td><%=resultSet.getString("to_user") %></td>
										<td>
										<% String type = resultSet.getString("price");
										   if (type.equals("s")) {%> Sale <%}
										   else {%> Transfer <%};
										%>
										</td>
										<td><%=resultSet.getString("trans_time") %></td>	
										<td><%=resultSet.getString("price") %></td>
								</tr>
					<%}%>
						</table>
				<%}%>
	</div>
	<%} catch (Exception ex) {
            				System.out.println(ex.getMessage());
            				
            				%>
                    		<p>                    			
                    			<a style="text-color: #ffffff; text-decoration:none" href="activitypage.jsp" target="_self">
                    			Look like you got lost! <br>
                    			Click here to go to the main page!
                    			</a>
                    		</p>                      	 
               			
         <% } finally {
                			// close all the connections.                			
                			connection.close();
            }
        
        %>
	
</body>