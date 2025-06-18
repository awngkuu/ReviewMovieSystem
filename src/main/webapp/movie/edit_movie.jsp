<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="model.Movie, model.User" %>
<%
    // 🔐 Prevent back button after logout
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // ✅ Session check (admin only)
    User user = (User) session.getAttribute("user");
    String role = (String) session.getAttribute("role");
    if (user == null || role == null || !"admin".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/user/login.jsp");
        return;
    }

    Movie movie = (Movie) request.getAttribute("movie");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Movie</title>
    <style>
        body {
            background-color: #141414;
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            color: #fff;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 600px;
            margin: 80px auto;
            background-color: #1f1f1f;
            padding: 30px 40px;
            border-radius: 10px;
            box-shadow: 0 0 30px rgba(0,0,0,0.5);
        }

        h2 {
            text-align: center;
            margin-bottom: 30px;
            color: #e50914;
        }

        label {
            font-weight: bold;
            margin-top: 15px;
            display: block;
            color: #b3b3b3;
        }

        input[type="text"],
        input[type="date"],
        textarea {
            width: 100%;
            background-color: #333;
            color: white;
            border: none;
            padding: 10px;
            border-radius: 5px;
            margin-top: 5px;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
            height: 100px;
        }

        button {
            width: 100%;
            padding: 12px;
            background-color: #e50914;
            color: white;
            border: none;
            font-size: 16px;
            font-weight: bold;
            margin-top: 25px;
            border-radius: 5px;
            cursor: pointer;
        }

        button:hover {
            background-color: #f40612;
        }

        .back-link {
            display: block;
            margin-top: 15px;
            text-align: center;
            color: #999;
            text-decoration: none;
        }

        .back-link:hover {
            color: #fff;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Edit Movie</h2>
    <form action="MovieServlet?action=update" method="post">
        <input type="hidden" name="id" value="<%= movie.getMovieId() %>" />

        <label for="title">Title</label>
        <input type="text" name="title" value="<%= movie.getTitle() %>" required />

        <label for="genre">Genre</label>
        <input type="text" name="genre" value="<%= movie.getGenre() %>" required />

        <label for="releaseDate">Release Date</label>
        <input type="date" name="releaseDate" value="<%= movie.getReleaseDate() %>" required />

        <label for="director">Director</label>
        <input type="text" name="director" value="<%= movie.getDirector() %>" />

        <label for="cast">Cast</label>
        <textarea name="cast"><%= movie.getCast() %></textarea>

        <label for="synopsis">Synopsis</label>
        <textarea name="synopsis" required><%= movie.getSynopsis() %></textarea>

        <label for="posterUrl">Poster URL</label>
        <input type="text" name="posterUrl" value="<%= movie.getPosterUrl() %>" />

        <label for="trailerUrl">Trailer URL (YouTube)</label>
        <input type="text" name="trailerUrl" value="<%= movie.getTrailerUrl() %>" />

        <button type="submit">Save Changes</button>
    </form>

    <a href="MovieServlet?action=list" class="back-link">← Back to Movie List</a>
</div>

</body>
</html>
