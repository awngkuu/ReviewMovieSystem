/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author User
 */
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/movie_review_system";
    private static final String USER = "root";
    private static final String PASSWORD = "";
    
    
//    private static final String URL = System.getenv("DB_URL");
//    private static final String USER = System.getenv("DB_USER");
//    private static final String PASSWORD = System.getenv("DB_PASS");
    
    
    

    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // For MySQL 8.x
            return DriverManager.getConnection(URL, USER, PASSWORD);
        } catch (ClassNotFoundException e) {
            throw new SQLException(e);
        }
    }
}
