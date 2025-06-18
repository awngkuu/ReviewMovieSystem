<%-- 
    Document   : db
    Created on : 17 Jun 2025, 11:51:15 AM
    Author     : tuf
--%>

<%@ page import="java.sql.*" %>
<%
    String url = "jdbc:mysql://localhost:3306/movie_review_system";
    String user = "root";
    String password = "";

    Connection conn = null;
    try {
        Class.forName("com.mysql.cj.jdbc.Driver"); // Load MySQL JDBC Driver
        conn = DriverManager.getConnection(url, user, password);
        out.println("<p>? Successfully connected to the database.</p>");
    } catch (Exception e) {
        out.println("<p>? Connection failed: " + e.getMessage() + "</p>");
        e.printStackTrace(new java.io.PrintWriter(out));
    } finally {
        if (conn != null) {
            try {
                conn.close();
                out.println("<p>? Connection closed.</p>");
            } catch (SQLException e) {
                out.println("<p>?? Error closing connection: " + e.getMessage() + "</p>");
            }
        }
    }
%>

