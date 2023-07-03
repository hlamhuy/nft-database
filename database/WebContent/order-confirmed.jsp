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
	.receipt {
		font-size: 25px;
		text-align: center;
		color: #ccffcc;
		margin: auto;
	}
	.receipt-details {
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
        
        	// add to transactions
        	statement.executeUpdate("insert into transactions(nft_id, from_user, to_user, trans_type, price) values"
    			+"('" + nft_id + "', (select nft_owner from listings where nft_id='" + nft_id + "'), '" + email + "', 's', (select price from listings where nft_id='" + nft_id + "'));");
        	
        	// retrieve latest trans ID
        	resultSet = statement.executeQuery("select trans_id from transactions ORDER BY trans_id DESC LIMIT 1;");
        	if (resultSet.next()) {
        		trans_id = resultSet.getInt(1);
        	}
        	// update current owner of nft
        	statement.executeUpdate("update nfts set nft_owner='" + email + "' where nft_id='" + nft_id + "';");
        	
        	// update nft count of curent user
        	statement.executeUpdate("update user set nft_owned"
						+ "=(select count(nft_owner) from nfts where nft_owner='" + email + "') "
						+ "where email='" + email + "';");
        	// update balance of current user
        	statement.executeUpdate("update user set balance"
						+ "=((select balance from (select * from user) as balance where email='" + email + "')"
						+ "-(select price from (select * from listings) as price where nft_id='" + nft_id + "')) where email='" + email + "';");
        	
        	// remove from listings
        	statement.executeUpdate("DELETE FROM listings WHERE nft_id='" + nft_id + "';");
        	
        	
			String getData ="select balance, nft_owned from user where email = '" + email + "';";
			resultSet = statement.executeQuery(getData);
			while(resultSet.next()){ 
		%>
		
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
			Order Confirmation
		</h2>
		<div class="receipt">
		<p>
			Congratulations! You have successfully purchased an NFT!
		</p>
		<p>
			Below is the detail of the NFT you just bought:
		</p>
			<div class="receipt-details">
				<%  String receipt = "select trans_id, from_user, trans_time, price, nfts.nft_id, nfts.nft_name, nfts.url from transactions join nfts on transactions.nft_id=nfts.nft_id where trans_id='" + trans_id + "';";
					resultSet = statement.executeQuery(receipt);
					while(resultSet.next()){
						
					
				%>
				<h4> Transaction #<%= trans_id %></h4>
				Customer: ${fName} ${lName} <br>
				Time: <%= resultSet.getString("trans_time") %>
				
				<br><hr>
				NFT ID: <%= resultSet.getString("nft_id") %> <br>
				NFT Name: <%= resultSet.getString("nft_name") %> <br>
				URL: <%= resultSet.getString("url") %> <br>
				From User: <%= resultSet.getString("from_user") %> <br>
				Price: <%= resultSet.getString("price") %>
				<%} %>
			</div>
		</div>
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