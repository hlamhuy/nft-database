<%@page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>

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

<!DOCTYPE html>
<html>
	<head>
		<meta charset="ISO-8859-1">
		<title>Root page</title>
		<style>
			.checker {
				text-align: center;
				padding: 4em;	
			}
			.init {										
				width: 200px;
				height: 36px;
				border-radius: 18px;
				background-color: #1c89ff;
				border: solid 1px transparent;
				color: #fff;
				font-size: 18px;
				font-weight: 300;
				cursor: pointer;
			}
			.init:hover {
				width: 200px;
				height: 36px;
				border-radius: 18px;
				background-color: transparent;
				border: solid 2px #1c89ff;
				color: #1c89ff;
				font-size: 18px;
				font-weight: 300;
			}
			.analyze {
			 text-align:center;
			}
			
			.analyze-buttons {	
			padding: 5px 12px;
		border-radius: 10px;
		background-color: #99ff99;
		border: solid 1.5px transparent;
		color: #000000;		
		cursor: pointer;	
		text-decoration: none;
			
	}
			.logout {
			padding: 0.5em;
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
			body {
				background-color: #444444;
				padding-bottom: 8em;
				}
		</style>
	</head>
	<body>
		<div class="checker">
			<form action = "initialize">
				<input class="init" type="submit" value="Initialize the Database"/>
			</form>					
			<div class="logout">
        		<a href="login.jsp" target="_self" >
          			Log Out
        		</a>	
      		</div>
		</div>
		<div>
			<div class="analyze">
			<a class="analyze-buttons" href="rootAnalyze.jsp" target="_self">
				Analyze
			</a>
			</div>
			
		    <table>
		        <caption><h2>Users</h2></caption>
		        <tr>
		            <th>Email</th>
		            <th>First name</th>
		            <th>Last name</th>
		            <th>Address</th>
		            <th>Password</th>
		            <th>Age</th>
		            <th>Balance ($ETH)</th>
		            <th>NFT_owned</th>
		        </tr>		        
		        <c:forEach var="users" items="${listUser}">
		            <tr style="text-align:center">
		                <td><c:out value="${users.email}" /></td>
		                <td><c:out value="${users.firstName}" /></td>
		                <td><c:out value="${users.lastName}" /></td>
		                <td><c:out value="${users.address_street_num} 
																			${users.address_street} 
																			${users.address_city} 
																			${users.address_state} 
																			${users.address_zip_code}" /></td>
		                <td><c:out value="${users.password}" /></td>
		                <td><c:out value="${users.age}" /></td>
		                <td><c:out value="${users.balance}"/></td>
		                <td><c:out value="${users.NFT_owned}" /></td>
		            </tr>
		        </c:forEach>
		    </table>
				
				<table class="tables">
					<caption><h2>NFTs</h2></caption>
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
						String sql1 ="SELECT * FROM nfts";
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
				<table class="tables">
					<caption><h2>Transactions details</h2></caption>
					<tr>
							<th>Transaction ID</th>
							<th>NFT ID</th>
							<th>From</th>
							<th>To</th>
							<th>Type</th>
							<th>Time</th>
							<th>Price</th>
					</tr>
					<%					 
						//connection = DriverManager.getConnection("jdbc:mysql://jariok.com:3306/testdb?allowPublicKeyRetrieval=true&useSSL=false&user=john&password=pass1234");
						statement=connection.createStatement();
						String sql2 ="SELECT * FROM transactions";
						resultSet = statement.executeQuery(sql2);
						while(resultSet.next()){
					%>
							<tr style="text-align:center">
									<td><%=resultSet.getInt("trans_id") %></td>
									<td><%=resultSet.getInt("nft_id") %></td>
									<td><%=resultSet.getString("from_user") %></td>
									<td><%=resultSet.getString("to_user") %></td>
									<td><%=resultSet.getString("trans_type") %></td>
									<td><%=resultSet.getString("trans_time") %></td>
									<td><%=resultSet.getDouble("price") %></td>
							</tr>
					<% 	}
					%>
				</table>
				<table class="tables">
					<caption><h2>Active Listings</h2></caption>
					<tr>
							<th>Listing ID</th>
							<th>Current Owner</th>
							<th>NFT ID</th>
							<th>Start Time</th>
							<th>End Time</th>
							<th>Price</th>
					</tr>
					<%					 
						//connection = DriverManager.getConnection("jdbc:mysql://jariok.com:3306/testdb?allowPublicKeyRetrieval=true&useSSL=false&user=john&password=pass1234");
						statement=connection.createStatement();
						String sql3 ="SELECT * FROM listings";
						resultSet = statement.executeQuery(sql3);
						while(resultSet.next()){
					%>
							<tr style="text-align:center">
									<td><%=resultSet.getInt("list_id") %></td>
									<td><%=resultSet.getString("nft_owner") %></td>
									<td><%=resultSet.getInt("nft_id") %></td>
									<td><%=resultSet.getString("start_time") %></td>
									<td><%=resultSet.getString("end_time") %></td>
									<td><%=resultSet.getDouble("price") %></td>
							</tr>
					<% 	}
					%>
				</table>
		</div>

</body>
</html>