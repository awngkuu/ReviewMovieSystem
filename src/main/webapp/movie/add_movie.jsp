<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%
    // 🔐 Prevent back button after logout
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // ✅ Session & role validation
    User user = (User) session.getAttribute("user");
    String role = (String) session.getAttribute("role");
    if (user == null || role == null || !"admin".equals(role)) {
        response.sendRedirect(request.getContextPath() + "/user/login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Add Movie</title>
    <style>
        body {
            background-color: #141414;
            font-family: 'Helvetica Neue', Helvetica, Arial, sans-serif;
            color: #fff;
            margin: 0;
            padding: 0;
        }

        .container {
            max-width: 700px;
            margin: 60px auto;
            background-color: #1f1f1f;
            padding: 40px;
            border-radius: 10px;
            box-shadow: 0 0 30px rgba(0, 0, 0, 0.6);
        }

        h2 {
            text-align: center;
            color: #e50914;
            margin-bottom: 30px;
        }

        label {
            display: block;
            margin-top: 20px;
            color: #b3b3b3;
            font-weight: bold;
        }

        input[type="text"],
        input[type="date"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-top: 6px;
            background-color: #333;
            color: white;
            border: none;
            border-radius: 5px;
            font-size: 14px;
        }

        textarea {
            resize: vertical;
            height: 80px;
        }

        input[type="submit"] {
            width: 100%;
            padding: 12px;
            background-color: #e50914;
            color: white;
            font-size: 16px;
            border: none;
            border-radius: 6px;
            margin-top: 30px;
            cursor: pointer;
            font-weight: bold;
        }

        input[type="submit"]:hover {
            background-color: #f40612;
        }

        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            text-decoration: none;
            color: #999;
        }

        .back-link:hover {
            color: white;
        }
    </style>
</head>
<body>

<div class="container">
    <h2>Add New Movie</h2>
    <form action="<%=request.getContextPath()%>/MovieServlet?action=add" method="post">

        <label for="title">Title</label>
        <input type="text" name="title" required>

        <label for="genre">Genre</label>
        <input type="text" name="genre">

        <label for="releaseDate">Release Date</label>
        <input type="date" name="releaseDate">

        <label for="director">Director</label>
        <input type="text" name="director">

        <label for="cast">Cast</label>
        <textarea name="cast"></textarea>

        <label for="synopsis">Synopsis</label>
        <textarea name="synopsis"></textarea>

        <label for="posterUrl">Poster URL</label>
        <input type="text" name="posterUrl">

        <label for="trailerUrl">Trailer URL</label>
        <input type="text" name="trailerUrl">

        <input type="submit" value="Add Movie">
    </form><br>
    <a href="<%= request.getContextPath() %>/MovieServlet" class="back-link">← Back to list</a>
</div>

</body>
</html>
