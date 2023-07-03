<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@page import="project4710.*" %>
<!DOCTYPE html>
<html>
<head><title>Registration</title></head>
<body style="font-family: 'Roboto',sans-serif;">
	<h1 style="text-align: center; color:#0020FF;"> REAL NFT TRADING </h1> 
	<div style="max-width: 400px; margin:auto;">		
		<h2 style="text-align: center; font-size: 2em; 
								margin-top: 0.25em; margin-bottom: 0.25em;">
			Register
		</h2>
		<form action="register">
			<div>
				<label style="text-align: left; font-size: .85em; color: #C1C1C1;">
					EMAIL
				</label>
				<input name="email" type="text" 
									style="border: 1px solid #f1f1f1;
													height: auto;
													width: 100%;
													margin: 0.5em 0;
													padding: 10px 10px;" 
									onfocus="this.value=''">
			</div>
			<div>
				<label style="text-align: left; font-size: .85em; color: #C1C1C1;">
					FIRST NAME
				</label>
				<input name="firstName" type="text" 
									style="border: 1px solid #f1f1f1;
													height: auto;
													width: 100%;
													margin: 0.5em 0;
													padding: 10px 10px;" 
									onfocus="this.value=''">
			</div>			
			<div>
				<label style="text-align: left; font-size: .85em; color: #C1C1C1;">
					LAST NAME
				</label>
				<input name="lastName" type="text" 
									style="border: 1px solid #f1f1f1;
													height: auto;
													width: 100%;
													margin: 0.5em 0;
													padding: 10px 10px;" 
									onfocus="this.value=''">
			</div>
			<div>
				<label style="text-align: left; font-size: .85em; color: #C1C1C1;">
					AGE
				</label>
				<input name="age" type="text" 
									style="border: 1px solid #f1f1f1;
													height: auto;
													width: 100%;
													margin: 0.5em 0;
													padding: 10px 10px;" 
									onfocus="this.value=''">
			</div>
			<div>
				<label style="text-align: left; font-size: .85em; color: #C1C1C1;">
					PASSWORD
				</label>
				<input name="password" type="password" 
									style="border: 1px solid #f1f1f1;
													height: auto;
													width: 100%;
													margin: 0.5em 0;
													padding: 10px 10px;" 
									onfocus="this.value=''">
			</div>
			<div>
				<label style="text-align: left; font-size: .85em; color: #C1C1C1;">
					CONFIRM PASSWORD
				</label>
				<input name="confirmation" type="password" 
									style="border: 1px solid #f1f1f1;
													height: auto;
													width: 100%;
													margin: 0.5em 0;
													padding: 10px 10px;" 
									onfocus="this.value=''">
			</div>
			<button style="height: 3em; width: 100%; font-size: 1em; 
												background: #000000; color: #ffffff;
												cursor: pointer;" 								
								color="dark" type="submit" value="Register">
					REGISTER
			</button>
			<div style="text-align: center; margin: 1em;">
			Already have an account?
			<a style="color:#525252;" href="login.jsp" target="_self">
				Sign in
			</a>		
		</div>
		</form>		
	</div>
	<p style="text-align: center; color: #FF0000"> ${errorOne } </p>
	<p style="text-align: center; color: #FF0000"> ${errorTwo } </p>
</body>