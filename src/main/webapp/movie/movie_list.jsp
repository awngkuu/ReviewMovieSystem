<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, model.Movie, model.User" %>
<%@ page session="true" %>
<%
    // 🔐 Prevent caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // 🔒 Session validation
    User user = (User) session.getAttribute("user");
    String role = (String) session.getAttribute("role");
    if (user == null || role == null) {
        response.sendRedirect("../user/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Movie List</title>
    <style>
        body {
            font-family: 'Helvetica Neue', sans-serif;
            background-color: #141414;
            color: #fff;
            margin: 0;
            padding: 20px;
        }
        h1 {
            font-size: 28px;
            margin-bottom: 20px;
        }
        .add-button {
            background-color: #e50914;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            font-weight: bold;
            border-radius: 4px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
            background-color: #1f1f1f;
            box-shadow: 0 2px 8px rgba(0,0,0,0.3);
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
        .actions a {
            margin-right: 10px;
            color: #00bfff;
            text-decoration: none;
            font-size: 14px;
        }
        .actions a:hover {
            text-decoration: underline;
        }
        .no-movie {
            padding: 20px;
            text-align: center;
        }
        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #ccc;
            text-decoration: none;
        }
        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <h1>🎬 Movie List</h1>

    <% if ("admin".equals(role)) { %>
        <a class="add-button" href="movie/add_movie.jsp">+ Add New Movie</a>
    <% } %>

    <table>
        <tr>
            <th>Poster</th>
            <th>Title</th>
            <th>Genre</th>
            <th>Release Date</th>
            <th>Actions</th>
        </tr>
        <%
            List<Movie> movieList = (List<Movie>) request.getAttribute("movieList");
            if (movieList != null && !movieList.isEmpty()) {
                for (Movie movie : movieList) {
        %>
        <tr>
            <td><%= movie.getPosterUrl() %></td>
            <td><%= movie.getTitle() %></td>
            <td><%= movie.getGenre() %></td>
            <td><%= movie.getReleaseDate() %></td>
            <td class="actions">
                <a href="MovieServlet?action=view&id=<%= movie.getMovieId() %>">Details</a>
                <% if ("admin".equals(role)) { %>
                    <a href="MovieServlet?action=edit&id=<%= movie.getMovieId() %>">Edit</a>
                    <a href="MovieServlet?action=delete&id=<%= movie.getMovieId() %>" onclick="return confirm('Are you sure you want to delete this movie?')">Delete</a>
                <% } %>
            </td>
        </tr>
        <%
                }
            } else {
        %>
        <tr>
            <td colspan="4" class="no-movie">No movies found.</td>
        </tr>
        <% } %>
    </table>

    <a class="back-link" href="<%= request.getContextPath() %>/user/dashboard.jsp">← Back to Dashboard</a>

</body>
</html>
