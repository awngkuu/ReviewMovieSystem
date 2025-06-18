<%@ page import="java.sql.*" %>
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
                <h3>All Data from 'users' Table:</h3>
                <%
                    try {
                        stmt = conn.createStatement();
                        rs = stmt.executeQuery("SELECT * FROM users");

                        ResultSetMetaData metaData = rs.getMetaData();
                        int columnCount = metaData.getColumnCount();

                        if (!rs.isBeforeFirst()) {
                %>
                            <p>No data found in the 'users' table.</p>
                <%
                        } else {
                %>
                            <table border="1" cellpadding="5" cellspacing="0">
                                <tr>
                                    <% for (int i = 1; i <= columnCount; i++) { %>
                                        <th><%= metaData.getColumnLabel(i) %></th>
                                    <% } %>
                                </tr>
                                <% while (rs.next()) { %>
                                    <tr>
                                        <% for (int i = 1; i <= columnCount; i++) { %>
                                            <td><%= rs.getString(i) %></td>
                                        <% } %>
                                    </tr>
                                <% } %>
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
