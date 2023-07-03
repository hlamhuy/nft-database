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

@WebServlet("/transactionsDAO")
public class transactionsDAO 
{
	private static final long serialVersionUID = 1L;
	private Connection connect = null;
	private Statement statement = null;
	private PreparedStatement preparedStatement = null;
	private ResultSet resultSet = null;
	
	public transactionsDAO(){}
	
	protected void connect_func() throws SQLException {
    	//uses default connection to the database
        if (connect == null || connect.isClosed()) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
            } catch (ClassNotFoundException e) {
                throw new SQLException(e);
            }
            connect = (Connection) DriverManager.getConnection("jdbc:mysql://jariok.com:3306/testdb?allowPublicKeyRetrieval=true&useSSL=false&user=john&password=pass1234");
            System.out.println("connected: " + connect);
        }
	}
	
	protected void disconnect() throws SQLException {
        if (connect != null && !connect.isClosed()) {
        	connect.close();
        }
	}
	
	public void init() throws SQLException, FileNotFoundException, IOException{
	    	connect_func();
	        statement =  (Statement) connect.createStatement();
	        statement.executeUpdate("set foreign_key_checks = 0");
	        statement.executeUpdate("drop table if exists transactions");
	        statement.executeUpdate("set foreign_key_checks = 1");
	        
	        String[] INITIAL = {("CREATE TABLE if not exists transactions( "
	        		+ "trans_id INT auto_increment,"
	        		+ "nft_id INT not null,"
	        		+ "from_user varchar(100) not null,"
	        		+ "to_user varchar(100) not null,"
	        		+ "trans_type char(1) not null,"
	        		+ "trans_time timestamp not null default current_timestamp,"
	        		+ "price double not null,"
	        		+ "primary key(trans_id),"
	        		+ "foreign key(from_user) references user(email),"
	        		+ "foreign key(to_user) references user(email),"
	        		+ "foreign key(nft_id) references nfts(nft_id)"		        		
	        		+ ");") 
	        };
	        /*String[] TUPLES = {("insert into transactions(from_user, to_user, trans_type, price) values "
	        		+ "('jo@gmail.com', 'susie@gmail.com', 't', 0)"
	        		+ ";") 
	        };*/
	      //for loop to put these in database
	        for (int i = 0; i < INITIAL.length; i++)
	        	statement.execute(INITIAL[i]);
	        /*for (int i = 0; i < TUPLES.length; i++)	
	        	statement.execute(TUPLES[i]);*/
	        disconnect();
	}
	
}