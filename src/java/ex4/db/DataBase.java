
package ex4.db;

//import ex2.output.Output;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * This class provide read write data base access
 * @author Misha Lebedev & Nina Eidelshtein
 */
public class DataBase {

    // connection to db
    private Connection connection;
    
    //needed to execute insert command
    private Statement stmt;
    /**
     * function load the driver, establish database connection
     * and create java statement.
     * @return true if db open successes, else false
     */
    public boolean open(){
         try {
            //Load the driver
            //Class.forName("org.apache.derby.jdbc.ClientDriver");
            Class.forName("org.apache.derby.jdbc.EmbeddedDriver");
            //Establish database connection
            //connection = DriverManager.getConnection("jdbc:derby://localhost:1527/STATISTICS");
            connection = DriverManager.getConnection("jdbc:derby:ex4;create=true");
            //create java statement
            stmt = connection.createStatement();
            ResultSet rs = stmt.executeQuery("select * from SYS.SYSTABLES where tablename='users'");
            if (!rs.next()) {
                stmt.execute("create table users ("
                        + "first_name varchar(256),"
                        + "last_name varchar(256),"
                        + "login varchar(256),"
                        + "password varchar(256),"
                        + "email varchar(256))");
            }
            rs.close();
            
            return true;
        } catch (java.lang.ClassNotFoundException e) {
            System.out.println("Cannot find driver class");
            return false;

        } catch (java.sql.SQLException e) {
            System.out.println("Cannot get connection");
            return false;
        }   
    }
     /**
     * function check if url exists in db and save data
     * @param  url      url
     * @param  counter  number of images in given url
     * @return true if  url and counter saved  successes, else false
     */
    public boolean save(String url, int counter) {

        try {
            //check if url exists in db 
            ResultSet results = stmt.executeQuery("SELECT * FROM IMAGES WHERE url='"+url+"'");
            if (results.next()) {
                System.out.println("URL:"+url+" already exists in database");
                return false;
            }
            else
            {
                //save data
                //Code to write to database
                stmt.executeUpdate("INSERT INTO images VALUES ('" + url + "'," + counter + " )");
                //save the new chenches in data base
                connection.commit();
            }
            results.close();
        } catch (SQLException ex) {
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, "Cannot save:url="+url, ex);
            return false;
        }

        return true;
    }
    
     /**
     * function read data from table in db and prints to given output 
     * @param  tableName  name of the table in db
     * @param  out        output device handle
     */
    public void printTable(String tableName) {
        try {
            // Code to read from database
            ResultSet results = stmt.executeQuery("SELECT * FROM "+ tableName );
            while (results.next()) {
                String url = results.getString(1);
                int counter = results.getInt(2);
                //out.print(url,counter);
            }
            results.close();
        } catch (SQLException ex) {
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, "Cannot print table="+tableName, ex);
        }
    }
   
     /**
     * function  close connection to db and statement
     */
    public void close() {
        try {
            connection.close();
            stmt.close();
        } catch (SQLException ex) {
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, "Cannot close connection or statement", ex);
        }
        
    }

    public boolean checkIfExist(String firstName, String lastName, String login, String password, String email) {
        boolean result = false;
        try {
            ResultSet results = stmt.executeQuery("SELECT * FROM users where " 
                           + "first_name='"+ firstName
                           + "' and last_name='"+ lastName
                           + "' and login='"+ login
                           + "' and password='"+ password
                           + "' and email='"+ email+"'");
            result = results.next();
        } catch (SQLException ex) {
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
  
    }

    public void save(String firstName, String lastName, String login, String password, String email) {
        
        try {
          ///insert into users va
                //save data
                //Code to write to database
                stmt.executeUpdate("INSERT INTO users VALUES ('" + firstName + 
                        "','" + lastName+ 
                        "','" + login+
                        "','" + password+
                        "','" + email+
                        "' )");
                //save the new chenches in data base
                connection.commit();
           
        } catch (SQLException ex) {
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, "Cannot save:user="+login, ex);
           
        }
    }
    
   public boolean checkUsernameAndPassword(String username, String password) {
        boolean result = false;
        try {
            ResultSet results = stmt.executeQuery("SELECT * FROM users where " 
                           + " login='"+ username
                           + "' and password='"+ password+"'");
            result = results.next();
        } catch (SQLException ex) {
            Logger.getLogger(DataBase.class.getName()).log(Level.SEVERE, null, ex);
        }
        return result;
  
    }

    
}

