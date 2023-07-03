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

@WebServlet("/listingsDAO")
public class listingsDAO 
{
	private static final long serialVersionUID = 1L;
	private Connection connect = null;
	private Statement statement = null;
	private PreparedStatement preparedStatement = null;
	private ResultSet resultSet = null;
	
	public listingsDAO(){}
	
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
	        statement.executeUpdate("drop table if exists listings");
	        statement.executeUpdate("set foreign_key_checks = 1");
	        
	        String[] INITIAL = {("CREATE TABLE if not exists listings( "	        		
	        		+ "list_id INT auto_increment,"
	        		+ "nft_owner varchar(50),"
	        		+ "nft_id INT,"
	        		+ "start_time timestamp not null default current_timestamp,"
	        		+ "end_time timestamp,"
	        		+ "price double,"
	        		+ "primary key(list_id),"
	        		+ "foreign key(nft_owner) references user(email),"
	        		+ "foreign key(nft_id) references nfts(nft_id)"	
	        		+ ");") 
	        };
	        String[] TUPLES = {("insert into listings(nft_owner, nft_id, end_time, price) values "
	        		+ "('susie@gmail.com', 11, (select date_add(current_timestamp, interval 90 day)), 10),"
	        		+ "('susie@gmail.com', 12, (select date_add(current_timestamp, interval 90 day)), 10),"
	        		+ "('susie@gmail.com', 13, (select date_add(current_timestamp, interval 90 day)), 10),"
	        		+ "('susie@gmail.com', 14, (select date_add(current_timestamp, interval 90 day)), 10),"
	        		+ "('susie@gmail.com', 15, (select date_add(current_timestamp, interval 90 day)), 10),"
	        		+ "('susie@gmail.com', 16, (select date_add(current_timestamp, interval 90 day)), 10),"
	        		+ "('susie@gmail.com', 17, (select date_add(current_timestamp, interval 90 day)), 10),"
	        		+ "('susie@gmail.com', 18, (select date_add(current_timestamp, interval 90 day)), 10),"
	        		+ "('susie@gmail.com', 19, (select date_add(current_timestamp, interval 90 day)), 10)"
	        		+ ";") 
	        };
	      //for loop to put these in database
	        for (int i = 0; i < INITIAL.length; i++)
	        	statement.execute(INITIAL[i]);
	        for (int i = 0; i < TUPLES.length; i++)	
	        	statement.execute(TUPLES[i]);
	        disconnect();
	}
	
}