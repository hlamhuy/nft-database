package project4710; 

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;



import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.PreparedStatement;


public class ControlServlet extends HttpServlet {
	    private static final long serialVersionUID = 1L;
	    private userDAO userDAO = new userDAO();
	    private nftDAO nftDAO = new nftDAO();
	    private transactionsDAO transactionsDAO = new transactionsDAO();
	    private listingsDAO listingsDAO = new listingsDAO();
	    private String currentUser;
	    private HttpSession session=null;

	    public ControlServlet()
	    {
	    	
	    }
	    
	    public void init()
	    {
	    	userDAO = new userDAO();
	    	nftDAO = new nftDAO();
	    	transactionsDAO = new transactionsDAO();
	    	currentUser= "";
	    }
	    
	    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        doGet(request, response);
	    }
	    
	    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	        String action = request.getServletPath();
	        System.out.println(action);
	    
	    try {
        	switch(action) {  
        	case "/login":
        		login(request,response);
        		break;
        	case "/register":
        		register(request, response);
        		break;
        	case "/initialize":
        		userDAO.init();
        		nftDAO.init();
        		transactionsDAO.init();
        		listingsDAO.init();
        		System.out.println("Database successfully initialized!");
        		
        		rootPage(request,response,"");
        		break;
        	case "/root":
        		rootPage(request,response, "");
        		break;
        	case "/logout":
        		logout(request,response);
        		break;           	
        	case "/list": 
                System.out.println("The action is: list");
                listUser(request, response);           	
                break;
        	
	    	}
	    }
	    catch(Exception ex) {
        	System.out.println(ex.getMessage());
	    	}
	    }
        	
	    private void listUser(HttpServletRequest request, HttpServletResponse response)
	            throws SQLException, IOException, ServletException {
	        System.out.println("listUser started: 00000000000000000000000000000000000");

	     
	        List<user> listUser = userDAO.listAllUsers();
	        request.setAttribute("listUser", listUser);       
	        RequestDispatcher dispatcher = request.getRequestDispatcher("UserList.jsp");       
	        dispatcher.forward(request, response);
	     
	        System.out.println("listPeople finished: 111111111111111111111111111111111111");
	    }
	    
	    
	    
	    	        
	    private void rootPage(HttpServletRequest request, HttpServletResponse response, String view) throws ServletException, IOException, SQLException{
	    	System.out.println("root view");
			request.setAttribute("listUser", userDAO.listAllUsers());
	    	request.getRequestDispatcher("rootView.jsp").forward(request, response);
	    }
	    
	    
	    protected void login(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
	    	 String email = request.getParameter("email");
	    	 String password = request.getParameter("password");
	    	 
	    	 if (email.equals("root") && password.equals("pass1234")) {
				 System.out.println("Login Successful! Redirecting to root");
				 session = request.getSession();
				 session.setAttribute("username", email);
				 rootPage(request, response, "");
	    	 }
	    	 else if(userDAO.isValid(email, password)) 
	    	 {
			 	 currentUser = email;
			 	 user user = userDAO.getUser(currentUser);
			 	 session=request.getSession();
			 	 session.setAttribute("fName", user.getFirstName());
			 	 session.setAttribute("lName", user.getLastName());
			 	 session.setAttribute("email", user.getEmail());
			 	 session.setAttribute("nft_owned", user.getNFT_owned());			 	 
				 System.out.println("Login Successful! Redirecting");
				 request.getRequestDispatcher("activitypage.jsp").forward(request, response);
				 //request.getRequestDispatcher("create-nft.jsp").forward(request, response);
				 //request.getRequestDispatcher("sell-nft.jsp").forward(request, response);
				 return;
			 			 			 			 
	    	 }
	    	 else {
	    		 request.setAttribute("loginStr","Login Failed: Please check your credentials.");
	    		 request.getRequestDispatcher("login.jsp").forward(request, response);
	    	 }
	    }
	    
	    private void register(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException, SQLException {
	    	String email = request.getParameter("email");
	   	 	String firstName = request.getParameter("firstName");
	   	 	String lastName = request.getParameter("lastName");
	   	 	String password = request.getParameter("password");
	   	 	String age = request.getParameter("age");
	   	 	String address_street_num = request.getParameter("address_street_num"); 
	   	 	String address_street = request.getParameter("address_street"); 
	   	 	String address_city = request.getParameter("address_city"); 
	   	 	String address_state = request.getParameter("address_state"); 
	   	 	String address_zip_code = request.getParameter("address_zip_code"); 	   	 	
	   	 	String confirm = request.getParameter("confirmation");
	   	 	int n = Integer.parseInt(age) ;
	   	 	if (password.equals(confirm)) {
	   	 		if (!userDAO.checkEmail(email) && n > 18) {
		   	 		System.out.println("Registration Successful! Added to database");
		            user users = new user(email,firstName, lastName, password, age, address_street_num,  address_street,  address_city,  address_state,  address_zip_code, 1000,0);
		   	 		userDAO.insert(users);
		   	 		response.sendRedirect("login.jsp");
	   	 		}
	   	 		else if (n < 18){
	   	 			System.out.println("Age cannot be below 18!");
	   	 			request.setAttribute("errorOne","Registration failed!");
	   	 			request.setAttribute("errorTwo","You must be 18 and older!");	   	 		
	   	 			request.getRequestDispatcher("register.jsp").forward(request, response);
	   	 		}
		   	 	else {
		   	 		System.out.println("Username taken, please enter new username");
		    		request.setAttribute("errorOne","Registration failed!");
		    		request.setAttribute("errorTwo","Username taken, please enter a new username!");
		    		request.getRequestDispatcher("register.jsp").forward(request, response);
		   	 	}
	   	 	}
	   	 	else {
	   	 		System.out.println("Password and Password Confirmation do not match");
	   	 		request.setAttribute("errorOne","Registration failed!");
	   	 		request.setAttribute("errorTwo","Password did not match!");
	   	 		request.getRequestDispatcher("register.jsp").forward(request, response);
	   	 	}
	    }    
	    private void logout(HttpServletRequest request, HttpServletResponse response) throws IOException {
	    	currentUser = "";
        		response.sendRedirect("login.jsp");
        	}
	
	    

	     
        
	    
	    
	    
	    
	    
}
	        
	        
	    
	        
	        
	        
	    


