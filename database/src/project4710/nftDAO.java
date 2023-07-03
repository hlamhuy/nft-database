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

@WebServlet("/nftDAO")
public class nftDAO 
{
	private static final long serialVersionUID = 1L;
	private Connection connect = null;
	private Statement statement = null;
	private PreparedStatement preparedStatement = null;
	private ResultSet resultSet = null;
	
	public nftDAO(){}
	
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
	        statement.executeUpdate("drop table if exists nfts");
	        statement.executeUpdate("set foreign_key_checks = 1");
	        
	        String[] INITIAL = {("CREATE TABLE if not exists nfts( " 
	        		+ "nft_id INT auto_increment,"
	        		+ "nft_name varchar(100),"
	        		+ "url varchar(200),"
	        		+ "creator varchar(100),"
	        		+ "nft_owner varchar(100),"
	        		+ "mint_time timestamp not null default current_timestamp,"
	        		+ "primary key(nft_id),"
	        		+ "foreign key(creator) references user(email),"
	        		+ "foreign key(nft_owner) references user(email)"
	        		+ ");") 
	        };
	        String[] TUPLES = {("insert into nfts(nft_name, url, creator, nft_owner) values "
	        		+ "('cherry', 'url1', 'susie@gmail.com', 'susie@gmail.com'),"
	        		+ "('apple', 'url2', 'ana@gmail.com', 'ana@gmail.com'),"
	        		+ "('orange', 'url3', 'sophie@gmail.com', 'sophie@gmail.com'),"
	        		+ "('grape', 'url4', 'don@gmail.com', 'don@gmail.com'),"
	        		+ "('pear', 'url5', 'jo@gmail.com', 'jo@gmail.com'),"
	        		+ "('kiwi', 'url6', 'wallace@gmail.com', 'wallace@gmail.com'),"
	        		+ "('banana', 'url7', 'jeannette@gmail.com', 'jeannette@gmail.com'),"
	        		+ "('mango', 'url8', 'rudy@gmail.com', 'rudy@gmail.com'),"
	        		+ "('avocado', 'url9', 'angelo@gmail.com', 'angelo@gmail.com'),"
	        		+ "('coconut', 'url10', 'amelia@gmail.com', 'amelia@gmail.com'),"
	        		+ "('popstar101', 'popstar.com/101', 'susie@gmail.com', 'susie@gmail.com'),"
	        		+ "('popstar102', 'popstar.com/102', 'susie@gmail.com', 'susie@gmail.com'),"
	        		+ "('popstar103', 'popstar.com/103', 'susie@gmail.com', 'susie@gmail.com'),"
	        		+ "('popstar104', 'popstar.com/104', 'susie@gmail.com', 'susie@gmail.com'),"
	        		+ "('popstar105', 'popstar.com/105', 'susie@gmail.com', 'susie@gmail.com'),"
	        		+ "('popstar106', 'popstar.com/106', 'susie@gmail.com', 'susie@gmail.com'),"
	        		+ "('popstar107', 'popstar.com/107', 'susie@gmail.com', 'susie@gmail.com'),"
	        		+ "('popstar108', 'popstar.com/108', 'susie@gmail.com', 'susie@gmail.com'),"
	        		+ "('popstar109', 'popstar.com/109', 'susie@gmail.com', 'susie@gmail.com')"
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