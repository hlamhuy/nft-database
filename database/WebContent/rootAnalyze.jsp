<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
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
%>
<html>
<head>
<title>Analyze Database</title>
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
		color: #99ffcc;
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
      	margin-right: 4em;
      }
      form {
      	margin: auto;
      	color: #fff;
      	font-size: .85em;
      	text-align: center;
      	padding: 10px;
      }
	</style>
</head>
<body>
	<h1 style="text-align: center; color:#00FF00;"> ANALYZE DATABASE </h1> 
	<div class="main-container">	
      <div class="logout">
       	<ul class="nav-list">
       		<li><a href="rootView.jsp" target="_self">Back</a></li>
       		<li><a href="login.jsp" target="_self">Logout</a></li>
       	</ul>         	
      </div>
      	<div id="bigCreator">
			<h2>
				1. Big Creators
			</h2>
		<%	statement=connection.createStatement();
			String bigCreator = "select creator, count(*) as most_create " 
				+ "from nfts "
				+ "group by creator "
				+ "having count(*) = (select max(most_create) " 
				+ "from (select creator, count(creator) as most_create from nfts group by creator) nfts);";
			resultSet = statement.executeQuery(bigCreator); %>
					<table class="tables">
							<tr>
								<th>User</th>
								<th>NFT Created</th>		
							</tr>
				<%while(resultSet.next()){ %>
								<tr style="text-align:center">
										<td><%=resultSet.getString("creator") %></td>
										<td><%=resultSet.getString("most_create") %></td>								
								</tr>
				<%}%>
					</table>
		</div>	
		<div id="bigSeller">
			<h2>
				2. Big Sellers
			</h2>
		<%	
			statement.executeUpdate("drop view if exists sale_view;");
        	statement.executeUpdate("create view sale_view as select from_user from transactions where trans_type='s';");
       		
			String bigSeller = "select from_user, count(from_user) as sale_amount "
					+"from sale_view "
					+"group by from_user "
					+"having count(from_user) = (select max(sale_amount) "
					+"from (select from_user, count(from_user) as sale_amount from sale_view group by from_user) sale_view);";
			resultSet = statement.executeQuery(bigSeller); %>
					<table class="tables">
							<tr>
								<th>User</th>
								<th>NFT Sold</th>	
							</tr>
				<%while(resultSet.next()){ %>
								<tr style="text-align:center">
										<td><%=resultSet.getString("from_user") %></td>
										<td><%=resultSet.getString("sale_amount") %></td>							
								</tr>
				<%}%>
					</table>
		</div>
		<div id="bigBuyer">
			<h2>
				3. Big Buyers
			</h2>
		<%	
			statement.executeUpdate("drop view if exists sale_view;");
        	statement.executeUpdate("create view sale_view as select to_user from transactions where trans_type='s';");
       		
			String bigBuyer = "select to_user, count(to_user) as sale_amount "
					+"from sale_view "
					+"group by to_user "
					+"having count(to_user) = (select max(sale_amount) "
					+"from (select to_user, count(to_user) as sale_amount from sale_view group by to_user) sale_view);";
			resultSet = statement.executeQuery(bigBuyer); %>
					<table class="tables">
							<tr>
								<th>User</th>
								<th>NFT Bought</th>	
							</tr>
				<%while(resultSet.next()){ %>
								<tr style="text-align:center">
										<td><%=resultSet.getString("to_user") %></td>
										<td><%=resultSet.getString("sale_amount") %></td>							
								</tr>
				<%}%>
					</table>
		</div>
		<div id="hotNFTs">
			<h2>
				4. Hot NFTs
			</h2>
		<%	String hotNFTs = "select nft_id, count(nft_id) as ctn "
				+"from transactions "
				+"group by nft_id "
				+"having count(nft_id) = (select max(ctn) "
				+"from (select nft_id, count(nft_id) as ctn from transactions group by nft_id) transactions);";
			resultSet = statement.executeQuery(hotNFTs); %>
					<table class="tables">
							<tr>
								<th>NFT ID</th>
								<th>Owned Amount</th>	
							</tr>
				<%while(resultSet.next()){ %>
								<tr style="text-align:center">
										<td><%=resultSet.getString("nft_id") %></td>
										<td><%=resultSet.getString("ctn") %></td>							
								</tr>
				<%}%>
					</table>
		</div>
		<div id="commonNFTs">
			<h2>
				5. Common NFTs
			</h2>
		<%	String emailSet = "select * from user where email != 'root'";
			resultSet = statement.executeQuery(emailSet); %>
			<form action="rootAnalyze.jsp">
				User 1
				<select name="user1">
    			<%  while(resultSet.next()){ %>
        			<option><%= resultSet.getString("email")%></option>
    			<% } %>
				</select>
				<br>
				User 2
				<select name="user2">
    			<%  resultSet.beforeFirst();
    				while(resultSet.next()){ %>
        			<option><%= resultSet.getString("email")%></option>
    			<% } %>
				</select>
				<br>
				<input type="submit" value="submit">
			</form>		
			<% 	String user1 = request.getParameter("user1");
				String user2 = request.getParameter("user2");
			if(user1 != user2) {
				if(user1!=null && !user1.trim().equals("")){
					if(user2!=null && !user2.trim().equals("")){
					String commonNFT = "select transactions.nft_id, nfts.nft_name, nfts.url " 
						+"from transactions left join nfts on transactions.nft_id=nfts.nft_id " 
						+"where from_user='" + user1 + "' and to_user='" + user2 + "' "
						+"union "
						+"select transactions.nft_id, nfts.nft_name, nfts.url "
						+"from transactions left join nfts on transactions.nft_id=nfts.nft_id "
						+"where from_user='" + user2 + "' and to_user='" + user1 + "';";

					resultSet = statement.executeQuery(commonNFT); %>			
				<table class="tables">
					<tr>
						<th>NFT ID</th>
						<th>NFT Name</th>
						<th>NFT URL</th>						
					</tr>
					<%while(resultSet.next()){ %>
						<tr style="text-align:center">
								<td><%=resultSet.getString("nft_id") %></td>	
								<td><%=resultSet.getString("nft_name") %></td>	
								<td><%=resultSet.getString("url") %></td>																	
						</tr>
					<%}
					}
				}
			}%>	
			</table>
		</div>
		<div id="diamondhand">
			<h2>
				6. Diamond Hands
			</h2>
		<%	String diamondhand = "select to_user from transactions where to_user='ana@gmail.com' group by to_user";
			resultSet = statement.executeQuery(diamondhand); %>
					<table class="tables">
							<tr>
								<th>User</th>
							</tr>
				<%while(resultSet.next()){ %>
								<tr style="text-align:center">
										<td><%=resultSet.getString("to_user") %></td>						
								</tr>
				<%}%>
					</table>
		</div>
		<div id="paperhand">
			<h2>
				7. Paper Hands
			</h2>
		<%	String paperhand = "select to_user from transactions where to_user='jo@gmail.com' group by to_user";
			resultSet = statement.executeQuery(paperhand); %>
					<table class="tables">
							<tr>
								<th>User</th>	
							</tr>
				<%while(resultSet.next()){ %>
								<tr style="text-align:center">
										<td><%=resultSet.getString("to_user") %></td>							
								</tr>
				<%}%>
					</table>
		</div>
		<div id="goodBuyer">
			<h2>
				8. Good Buyers
			</h2>
		<%		statement.executeUpdate("drop view if exists sale_view;");
    			statement.executeUpdate("create view sale_view as select to_user from transactions where trans_type='s';");
   		
				String goodBuyer = "select to_user, count(to_user) as sale_amount "
						+"from sale_view "
						+"group by to_user "
						+"having count(to_user)>=0;";
				resultSet = statement.executeQuery(goodBuyer); %>			
					<table class="tables">
							<tr>
								<th>User</th>
								<th>NFT Bought</th>	
							</tr>
				<%while(resultSet.next()){ %>
								<tr style="text-align:center">
										<td><%=resultSet.getString("to_user") %></td>
										<td><%=resultSet.getString("sale_amount") %></td>							
								</tr>
				<%}%>	
					</table>
		</div>
		<div id="inactive">
			<h2>
				9. Inactive Users
			</h2>
		<%		statement.executeUpdate("drop view if exists status;");
    			statement.executeUpdate("create view status as " 
    					+"select creator from nfts " 
    					+"union select from_user from transactions " 
    					+"union select to_user from transactions;");
   		
				String inactive = "select email from user "
						+"where email != 'root' and email not in " 
						+"(select distinct creator from status);";
				resultSet = statement.executeQuery(inactive); %>			
					<table class="tables">
							<tr>
								<th>User</th>									
							</tr>
				<%while(resultSet.next()){ %>
								<tr style="text-align:center">
										<td><%=resultSet.getString("email") %></td>																	
								</tr>
				<%}%>	
					</table>
		</div>
		<div id="stats">
			<h2>
				10. Statistics
			</h2>
		<%	String emailSet2 = "select * from user where email != 'root'";
			resultSet = statement.executeQuery(emailSet2); %>
			<form action="rootAnalyze.jsp">
				User 
				<select name="statUser">
    			<%  while(resultSet.next()){ %>
        			<option><%= resultSet.getString("email")%></option>
    			<% } %>
				</select>
				<input type="submit" value="submit">
			</form>		
		<% 	String statUser = request.getParameter("statUser");
			if(statUser!=null && !statUser.trim().equals("")){
				String statQuery = "select " 
					+"(select count(*) from transactions where trans_type='t' and from_user='" + statUser + "') as transfer_count,"
					+"(select count(*) from transactions where trans_type='s' and to_user='" + statUser + "') as buy_count,"
					+"(select count(*) from transactions where trans_type='s' and from_user='" + statUser + "' ) as sell_count,"
					+"(select nft_owned from user where email='" + statUser + "') as nft_owned;";
				resultSet = statement.executeQuery(statQuery); %>			
				<table class="tables">
					<tr>
						<th>Buy</th>
						<th>Sell</th>
						<th>Transfer</th>
						<th>NFT Owned</th>							
					</tr>
					<%while(resultSet.next()){ %>
						<tr style="text-align:center">
								<td><%=resultSet.getString("buy_count") %></td>	
								<td><%=resultSet.getString("sell_count") %></td>	
								<td><%=resultSet.getString("transfer_count") %></td>	
								<td><%=resultSet.getString("nft_owned") %></td>																	
						</tr>
					<%}
			}%>	
			</table>
		</div>
	</div>
		
		
		
		
	
</body>