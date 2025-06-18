<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List, model.User, dao.UserDAO" %>
<%@ page session="true" %>
<%
    // 🔐 Prevent caching after logout
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // 🔒 Admin session validation
    User currentUser = (User) session.getAttribute("user");
    String role = (String) session.getAttribute("role");

    if (currentUser == null || role == null || !"admin".equals(role)) {
        response.sendRedirect("login.jsp");
        return;
    }

    UserDAO userDAO = new UserDAO();
    List<User> userList = userDAO.getAllUsers();
    String msg = (String) session.getAttribute("msg");
    if (msg != null) {
        session.removeAttribute("msg");
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Manage Users</title>
    <style>
        body {
            background-color: #121212;
            color: white;
            font-family: Arial, sans-serif;
            padding: 40px;
        }
        h2 {
            color: #e50914;
            margin-bottom: 20px;
        }
        .message {
            margin-bottom: 20px;
            color: lightgreen;
            font-weight: bold;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            background-color: #1f1f1f;
        }
        th, td {
            padding: 12px;
            text-align: left;
            border-bottom: 1px solid #333;
        }
        th {
            background-color: #222;
        }
        tr:hover {
            background-color: #2a2a2a;
        }
        .action-link {
            color: #ff4c4c;
            text-decoration: none;
            font-weight: bold;
        }
        .action-link:hover {
            text-decoration: underline;
        }
        .back {
            margin-top: 20px;
            display: inline-block;
            color: #ccc;
            text-decoration: none;
        }
        .back:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    <h2>👥 Manage Users</h2>

    <% if (msg != null) { %>
        <div class="message"><%= msg %></div>
    <% } %>

    <table>
        <tr>
            <th>ID</th>
            <th>Username</th>
            <th>Email</th>
            <th>Full Name</th>
            <th>Role</th>
            <th>Action</th>
        </tr>
        <%
            for (User user : userList) {
        %>
        <tr>
            <td><%= user.getUserId() %></td>
            <td><%= user.getUsername() %></td>
            <td><%= user.getEmail() %></td>
            <td><%= user.getFullName() %></td>
            <td><%= user.getRole() %></td>
            <td>
                <% if (!"admin".equals(user.getRole())) { %>
                    <a class="action-link" href="<%= request.getContextPath() %>/UserServlet?action=adminDeleteUser&userId=<%= user.getUserId() %>"
                       onclick="return confirm('Are you sure you want to delete this user?');">Delete</a>
                <% } else { %>
                    <em>Protected</em>
                <% } %>
            </td>
        </tr>
        <% } %>
    </table>

    <a class="back" href="<%= request.getContextPath() %>/user/dashboard.jsp">← Back to Dashboard</a>
</body>
</html>
