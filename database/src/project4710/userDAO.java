package project4710;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.DriverManager;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.Statement;
import java.sql.PreparedStatement;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
import java.sql.ResultSet;
//import java.sql.Statement;
import java.util.ArrayList;
import java.util.List;
/**
 * Servlet implementation class Connect
 */
@WebServlet("/userDAO")
public class userDAO 
{
	private static final long serialVersionUID = 1L;
	private Connection connect = null;
	private Statement statement = null;
	private PreparedStatement preparedStatement = null;
	private ResultSet resultSet = null;
	
	public userDAO(){}
	
	/** 
	 * @see HttpServlet#HttpServlet()
     */
    protected void connect_func() throws SQLException {
    	//uses default connection to the database
        if (connect == null || connect.isClosed()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                throw new SQLException(e);
            }
            connect = (Connection) DriverManager.getConnection("jdbc:mysql://jariok.com:3306/testdb?allowPublicKeyRetrieval=true&useSSL=false&user=john&password=pass1234");
            System.out.println(connect);
        }
    }
    
    public boolean database_login(String email, String password) throws SQLException{
    	try {
    		connect_func("root","pass1234");
    		String sql = "select * from user where email = ?";
    		preparedStatement = connect.prepareStatement(sql);
    		preparedStatement.setString(1, email);
    		ResultSet rs = preparedStatement.executeQuery();
    		return rs.next();
    	}
    	catch(SQLException e) {
    		System.out.println("failed login");
    		return false;
    	}
    }
	//connect to the database 
    public void connect_func(String username, String password) throws SQLException {
        if (connect == null || connect.isClosed()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                throw new SQLException(e);
            }
            connect = (Connection) DriverManager
  			      .getConnection("jdbc:mysql://127.0.0.1:3306/userdb?"
  			          + "useSSL=false&user=" + username + "&password=" + password);
            System.out.println(connect);
        }
    }
    
    public List<user> listAllUsers() throws SQLException {
        List<user> listUser = new ArrayList<user>();        
        String sql = "SELECT * FROM User";      
        connect_func();      
        statement = (Statement) connect.createStatement();
        ResultSet resultSet = statement.executeQuery(sql);
         
        while (resultSet.next()) {
            String email = resultSet.getString("email");
            String firstName = resultSet.getString("firstName");
            String lastName = resultSet.getString("lastName");
            String password = resultSet.getString("password");
            String age = resultSet.getString("age");
            String address_street_num = resultSet.getString("address_street_num"); 
            String address_street = resultSet.getString("address_street"); 
            String address_city = resultSet.getString("address_city"); 
            String address_state = resultSet.getString("address_state"); 
            String address_zip_code = resultSet.getString("address_zip_code"); 
            int balance = resultSet.getInt("balance");
            int NFT_owned = resultSet.getInt("NFT_owned");

             
            user users = new user(email,firstName, lastName, password, age, address_street_num,  address_street,  address_city,  address_state,  address_zip_code, balance,NFT_owned);
            listUser.add(users);
        }        
        resultSet.close();
        disconnect();        
        return listUser;
    }
    
    protected void disconnect() throws SQLException {
        if (connect != null && !connect.isClosed()) {
        	connect.close();
        }
    }
    
    public void insert(user users) throws SQLException {
    	connect_func("root","pass1234");         
		String sql = "insert into User(email, firstName, lastName, password, age,address_street_num, address_street,address_city,address_state,address_zip_code,balance,NFT_owned) values (?, ?, ?, ?, ?, ?, ?, ?, ?, ? ,? ,?)";
		preparedStatement = (PreparedStatement) connect.prepareStatement(sql);
			preparedStatement.setString(1, users.getEmail());
			preparedStatement.setString(2, users.getFirstName());
			preparedStatement.setString(3, users.getLastName());
			preparedStatement.setString(4, users.getPassword());
			preparedStatement.setString(5, users.getAge());
			preparedStatement.setString(6, users.getAddress_street_num());		
			preparedStatement.setString(7, users.getAddress_street());		
			preparedStatement.setString(8, users.getAddress_city());		
			preparedStatement.setString(9, users.getAddress_state());		
			preparedStatement.setString(10, users.getAddress_zip_code());		
			preparedStatement.setInt(11, users.getBalance());		
			preparedStatement.setInt(12, users.getNFT_owned());		

		preparedStatement.executeUpdate();
        preparedStatement.close();
    }
    
    public boolean delete(String email) throws SQLException {
        String sql = "DELETE FROM User WHERE email = ?";        
        connect_func();
         
        preparedStatement = (PreparedStatement) connect.prepareStatement(sql);
        preparedStatement.setString(1, email);
         
        boolean rowDeleted = preparedStatement.executeUpdate() > 0;
        preparedStatement.close();
        return rowDeleted;     
    }
     
    public boolean update(user users) throws SQLException {
        String sql = "update User set firstName=?, lastName =?,password = ?,age=?,address_street_num =?, address_street=?,address_city=?,address_state=?,address_zip_code=?, balance=?, NFT_owned =? where email = ?";
        connect_func();
        
        preparedStatement = (PreparedStatement) connect.prepareStatement(sql);
        preparedStatement.setString(1, users.getEmail());
		preparedStatement.setString(2, users.getFirstName());
		preparedStatement.setString(3, users.getLastName());
		preparedStatement.setString(4, users.getPassword());
		preparedStatement.setString(5, users.getAge());
		preparedStatement.setString(6, users.getAddress_street_num());		
		preparedStatement.setString(7, users.getAddress_street());		
		preparedStatement.setString(8, users.getAddress_city());		
		preparedStatement.setString(9, users.getAddress_state());		
		preparedStatement.setString(10, users.getAddress_zip_code());		
		preparedStatement.setInt(11, users.getBalance());		
		preparedStatement.setInt(12, users.getNFT_owned());
         
        boolean rowUpdated = preparedStatement.executeUpdate() > 0;
        preparedStatement.close();
        return rowUpdated;     
    }
    
    public user getUser(String email) throws SQLException {
    	user user = null;
        String sql = "SELECT * FROM User WHERE email = ?";
         
        connect_func();
         
        preparedStatement = (PreparedStatement) connect.prepareStatement(sql);
        preparedStatement.setString(1, email);
         
        ResultSet resultSet = preparedStatement.executeQuery();
         
        if (resultSet.next()) {
            String firstName = resultSet.getString("firstName");
            String lastName = resultSet.getString("lastName");
            String password = resultSet.getString("password");
            String age = resultSet.getString("age");
            String address_street_num = resultSet.getString("address_street_num"); 
            String address_street = resultSet.getString("address_street"); 
            String address_city = resultSet.getString("address_city"); 
            String address_state = resultSet.getString("address_state"); 
            String address_zip_code = resultSet.getString("address_zip_code"); 
            int balance = resultSet.getInt("balance");
            int NFT_owned = resultSet.getInt("NFT_owned");
            user = new user(email, firstName, lastName, password, age, address_street_num,  address_street,  address_city,  address_state,  address_zip_code,balance,NFT_owned);
        }
         
        resultSet.close();
        statement.close();
         
        return user;
    }
    
    public boolean checkEmail(String email) throws SQLException {
    	boolean checks = false;
    	String sql = "SELECT * FROM User WHERE email = ?";
    	connect_func();
    	preparedStatement = (PreparedStatement) connect.prepareStatement(sql);
        preparedStatement.setString(1, email);
        ResultSet resultSet = preparedStatement.executeQuery();
        
        System.out.println(checks);	
        
        if (resultSet.next()) {
        	checks = true;
        }
        
        System.out.println(checks);
    	return checks;
    }
    
    public boolean checkPassword(String password) throws SQLException {
    	boolean checks = false;
    	String sql = "SELECT * FROM User WHERE password = ?";
    	connect_func();
    	preparedStatement = (PreparedStatement) connect.prepareStatement(sql);
        preparedStatement.setString(1, password);
        ResultSet resultSet = preparedStatement.executeQuery();
        
        System.out.println(checks);	
        
        if (resultSet.next()) {
        	checks = true;
        }
        
        System.out.println(checks);
       	return checks;
    }
    
    
    
    public boolean isValid(String email, String password) throws SQLException
    {
    	String sql = "SELECT * FROM User";
    	connect_func();
    	statement = (Statement) connect.createStatement();
    	ResultSet resultSet = statement.executeQuery(sql);
    	
    	resultSet.last();
    	
    	int setSize = resultSet.getRow();
    	resultSet.beforeFirst();
    	
    	for(int i = 0; i < setSize; i++)
    	{
    		resultSet.next();
    		if(resultSet.getString("email").equals(email) && resultSet.getString("password").equals(password)) {
    			return true;
    		}		
    	}
    	return false;
    }
    
    
    public void init() throws SQLException, FileNotFoundException, IOException{
    	connect_func();
        statement =  (Statement) connect.createStatement();
        
        String[] INITIAL = {"drop database if exists testdb; ",
					        "create database testdb; ",
					        "use testdb; ",
					        "drop table if exists User; ",
					        ("CREATE TABLE if not exists User( " +
					            "email VARCHAR(50) NOT NULL, " + 
					            "firstName VARCHAR(10) NOT NULL, " +
					            "lastName VARCHAR(10) NOT NULL, " +
					            "password VARCHAR(20) NOT NULL, " +
					            "age VARCHAR(2) NOT NULL, " +
					            "address_street_num VARCHAR(4) , "+ 
					            "address_street VARCHAR(30) , "+ 
					            "address_city VARCHAR(20)," + 
					            "address_state VARCHAR(2),"+ 
					            "address_zip_code VARCHAR(5),"+ 
					            "balance DECIMAL(13,2) DEFAULT 1000,"+ 
					            "NFT_owned INT DEFAULT 0,"+
					            "PRIMARY KEY (email) "+"); ")
        					};
        String[] TUPLES = {("insert into User(email, firstName, lastName, password, age, address_street_num, address_street, address_city, address_state, address_zip_code, balance, NFT_owned)"+
        			"values ('root', 'default', 'default','pass1234', '00', '0000', 'Default', 'Default', '0', '00000','100','1000000000'),"+
			    		 	"('don@gmail.com', 'Don', 'Cummings','don123', '40', '1000', 'hi street', 'mama', 'MO', '12345','100', '1'),"+
			    	 	 	"('margarita@gmail.com', 'Margarita', 'Lawson','margarita1234', '30', '1234', 'ivan street', 'tata','CO','12561','100', '1'),"+
			    		 	"('jo@gmail.com', 'Jo', 'Brady','jo1234', '18', '3214','marko street', 'brat', 'DU', '54321','100', '1'),"+
			    		 	"('wallace@gmail.com', 'Wallace', 'Moore','wallace1234', '39', '4500', 'frey street', 'sestra', 'MI', '48202','100', '1'),"+
			    		 	"('amelia@gmail.com', 'Amelia', 'Phillips','amelia1234', '31', '1245', 'm8s street', 'baka', 'IL', '48000','100', '1'),"+
			    			"('sophie@gmail.com', 'Sophie', 'Pierce','sophie1234', '23', '2468', 'yolos street', 'ides', 'CM', '24680','100', '1'),"+
			    			"('angelo@gmail.com', 'Angelo', 'Francis','angelo1234', '25', '4680', 'egypt street', 'lolas', 'DT', '13579','100', '1'),"+
			    			"('rudy@gmail.com', 'Rudy', 'Smith','rudy1234', '25', '1234', 'sign street', 'samo ne tu','MH', '09876','100', '1'),"+
			    			"('jeannette@gmail.com', 'Jeannette ', 'Stone','jeannette1234', '29', '0981', 'snoop street', 'kojik', 'HW', '87654','100', '1'),"+
			    			"('susie@gmail.com', 'Susie ', 'Guzman', 'susie1234', '22', '1234', 'whatever street', 'detroit', 'MI', '48202','100', '1'),"+
			    			"('ana@gmail.com', 'Ana', 'Spencer','ana1234', '41', '123', 'Maple St', 'New York', 'MI', '12345','100','1');")
			    			};
        
        //for loop to put these in database
        for (int i = 0; i < INITIAL.length; i++)
        	statement.execute(INITIAL[i]);
        for (int i = 0; i < TUPLES.length; i++)	
        	statement.execute(TUPLES[i]);
        disconnect();
    }
    
    
   
    
    
    
    
    
	
	

}
