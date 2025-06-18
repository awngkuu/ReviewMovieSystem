<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="dao.DBConnection" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Database Connection Test</title>
</head>
<body>
    <h2>Database Connection Test</h2>
    <%
        Connection conn = null;
        Statement stmt = null;
        ResultSet rs = null;
        try {
            conn = DBConnection.getConnection();
            if (conn != null && !conn.isClosed()) {
    %>
                <p style="color: green;">✅ Connection successful!</p>
                <h3>Users Table Data:</h3>
                <%
                    try {
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery("SELECT * FROM users");

                        if (!rs.isBeforeFirst()) {
                %>
                            <p>No users found in the table.</p>
                <%
                        } else {
                %>
                            <table border="1" cellpadding="5" cellspacing="0">
                                <tr>
                                    <th>User ID</th>
                                    <th>Username</th>
                                    <th>Email</th>
                                </tr>
                <%
                            while (rs.next()) {
                                int id = rs.getInt("user_id");
                                String username = rs.getString("username");
                                String email = rs.getString("email");
                %>
                                <tr>
                                    <td><%= id %></td>
                                    <td><%= username %></td>
                                    <td><%= email %></td>
                                </tr>
                <%
                            }
                %>
                            </table>
                <%
                        }
                    } catch (Exception queryEx) {
                %>
                        <p style="color: red;">❌ Error executing query:</p>
                        <pre><%= queryEx.toString() %></pre>
                <%
                    }
                %>
    <%
            } else {
    %>
                <p style="color: red;">❌ Connection failed (connection is null or closed).</p>
    <%
            }
        } catch (Exception e) {
    %>
            <p style="color: red;">❌ An error occurred while connecting to the database:</p>
            <pre><%= e.toString() %></pre>
            <p><strong>Stack Trace:</strong></p>
            <pre>
<%
                e.printStackTrace(new java.io.PrintWriter(out));
%>
            </pre>
    <%
        } finally {
            if (rs != null) try { rs.close(); } catch (Exception e) {}
            if (stmt != null) try { stmt.close(); } catch (Exception e) {}
            if (conn != null) try { conn.close(); } catch (Exception ex) {
    %>
                <p style="color: orange;">⚠️ Warning: Failed to close connection: <%= ex.toString() %></p>
    <%
            }
        }
    %>
</body>
</html>
