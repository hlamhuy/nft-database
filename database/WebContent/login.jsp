<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="project4710.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login to Database</title>
	<style>
		body {
    	background-color: #444444;
    	padding-bottom: 8em;
    }
	</style>
</head>
<body style="font-family: 'Roboto',sans-serif;">
	<h1 style="text-align: center; color:#00FF00;"> REAL NFT TRADING </h1> 
	<div style="max-width: 400px; margin: auto">
		<p> ${loginFailedStr} </p>
		<div>
			<h2 style="text-align: center; font-size: 2em; margin-bottom: 0.25em;">
				Sign in
			</h2>
		</div>
		<form style="font-size: 100%;" action="login" method="post">	
			<div>		
				<label style="text-align: left; font-size: .85em; color: #C1C1C1;">
					EMAIL
				</label>				
				<input name="email" type="text" 
									style="border: 1px solid #f1f1f1;
													height: auto;
													width: 95%;
													margin: 0.5em 0;
													padding: 10px 10px;" autofocus>
			</div>
			<div>
				<label style="text-align: left; font-size: .85em; color: #C2C2C2;">
					PASSWORD
				</label>
				<input name="password" type="password" size="45"
									style="border: 1px solid #f1f1f1;
													height: auto;
													width: 95%;
													margin: 0.5em 0;
													padding: 10px 10px;" >
			</div>
			<button style="height: 3em; width: 100%; font-size: 1em; 
												background: #000000; color: #ffffff;
												cursor: pointer;" 								
								color="dark" type="submit" value="Login">
					SIGN IN
			</button>		
		</form>
		<div style="text-align: center; margin: 1em;">
				New user?
				<a style="color:#f1f1f1;" href="register.jsp" target="_self">
					Register Here
				</a>		
		</div>	
	</div>
</body>
</html>