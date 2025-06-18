<%@ page import="java.sql.Connection" %>
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
        try {
            conn = DBConnection.getConnection();
            if (conn != null && !conn.isClosed()) {
    %>
                <p style="color: green;">✅ Connection successful!</p>
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
            if (conn != null) {
                try {
                    conn.close();
                } catch (Exception ex) {
%>
                    <p style="color: orange;">⚠️ Warning: Failed to close connection: <%= ex.toString() %></p>
<%
                }
            }
        }
    %>
</body>
</html>
