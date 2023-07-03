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
<title>Transfer NFT</title>
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
			Portfolio			
		</h2>
		
		
		
		<table class="tables">
					
					<tr>
							<th>ID</th>
							<th>Name</th>
							<th>Image URL</th>
							<th>Creator</th>
							<th>Current Owner</th>
							<th>Mint Date</th>
					</tr>
					<%					 
						//connection = DriverManager.getConnection("jdbc:mysql://jariok.com:3306/testdb?allowPublicKeyRetrieval=true&useSSL=false&user=john&password=pass1234");
						statement=connection.createStatement();
						String sql1 ="SELECT * FROM nfts where nft_owner='" + email + "';";
						resultSet = statement.executeQuery(sql1);
						while(resultSet.next()){
					%>
							<tr style="text-align:center">
									<td><%=resultSet.getInt("nft_id") %></td>
									<td><%=resultSet.getString("nft_name") %></td>
									<td><%=resultSet.getString("url") %></td>
									<td><%=resultSet.getString("creator") %></td>
									<td><%=resultSet.getString("nft_owner") %></td>
									<td><%=resultSet.getString("mint_time") %></td>
							</tr>
					<% 	}
					%>
			</table>
	
		<div class="form-container">
		<h2>
			Transfer an NFT to another user			
		</h2>
		<form action="transfer-nft.jsp">
			<div>
				<label>
					ID 
				</label>
				<br>
				<input class="input" name="nft_id" type="text" onfocus="this.value=''">
			</div>
			<div>
				<label>
					Recipient's email 
				</label>
				<br>
				<input class="input" name="receiver" type="text" onfocus="this.value=''">
			</div>					
			<br>
			<button class="submit" type="submit" value="submit">
					Transfer
			</button>		
		</form>
		
		
			<%
  			 	String nft_id = request.getParameter("nft_id");				
   				String receiver = request.getParameter("receiver");
   				
          		int updateQuery = 0;
	 			if(nft_id!=null && receiver!=null){	 		 
	     			if(!nft_id.trim().equals("") && !receiver.trim().equals("")) {
	                 	try {
	                 		String validInputCheck1 = "select * from nfts where nft_owner='" + email + "' and nft_id='" + nft_id + "';";
	                 		resultSet = statement.executeQuery(validInputCheck1);
	    					if (!resultSet.isBeforeFirst() ) { %>
	    						<p class="failed">You are not the owner of NFT ID <%= nft_id %> </p> 
	    					<%} 
	    					else 
	    					{
             					connection = DriverManager.getConnection("jdbc:mysql://jariok.com:3306/testdb?allowPublicKeyRetrieval=true&useSSL=false&user=john&password=pass1234");
              				
             				
             					String updateOwner = "update nfts set nft_owner='" + receiver + "' where nft_id='" + nft_id + "';";
             					String insertTransaction = "insert into transactions(nft_id, from_user, to_user, trans_type, price) values ('" + nft_id + "','" + email + "', '" + receiver + "', 't', 0);";
             					statement = connection.createStatement();              							  				
              					updateQuery = statement.executeUpdate(updateOwner);
              					updateQuery = statement.executeUpdate(insertTransaction);
                            	if (updateQuery != 0) {    
                            		statement =  (Statement) connection.createStatement();
                            	
                            		// update nft count of sender
                            		statement.executeUpdate("update user set nft_owned = (select count(nft_owner) from nfts where nft_owner='" + email + "') where email='" + email + "';");
                            		// update nft count of receiver
                            		statement.executeUpdate("update user set nft_owned = (select count(nft_owner) from nfts where nft_owner='" + receiver + "') where email='" + receiver + "';");
                            		// take nft off listings
                            		statement.executeUpdate("delete from listings where nft_id='" + nft_id + "';");
                            		%>
                            			<p class="success">
                            			Successfully transfer your NFT to <%= receiver%>!
                            			</p>  
                            		<%                
              					}
	    					}
            			} catch (Exception ex) {
            				System.out.println(ex.getMessage());
            				System.out.println("Unable to connect to batabase."); 
            				%>
                    		<p class="failed">
                    		Error: unable to transfer your NFT!
                    		</p>  
                    	<% 
               			} finally {
                			// close all the connections.
                			statement.close();
                			connection.close();
            			}
	  				}
	     			else {
		 				%> <p class="failed">Cannot accept empty input </p> <% 
		 			}
				}
			%>
		</div>
	</div>	
</body>