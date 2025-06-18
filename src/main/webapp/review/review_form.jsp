<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Review, model.User" %>
<%@ page session="true" %>
<%
    User user = (User) session.getAttribute("user");
    String role = (String) session.getAttribute("role");

    if (user == null || role == null) {
        response.sendRedirect("../user/login.jsp");
        return;
    }

    if (!"user".equals(role)) {
        response.sendRedirect("../user/dashboard.jsp");
        return;
    }

    Review review = (Review) request.getAttribute("review");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Edit Review</title>
    <style>
        body {
            background-color: #141414;
            color: #fff;
            font-family: 'Helvetica Neue', sans-serif;
            padding: 40px;
        }

        h2 {
            color: #e50914;
            margin-bottom: 30px;
        }

        form {
            background-color: #1f1f1f;
            padding: 30px;
            border-radius: 8px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.5);
            max-width: 500px;
        }

        label {
            display: block;
            margin-bottom: 10px;
            font-weight: bold;
        }

        input[type="number"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-bottom: 20px;
            background-color: #333;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 16px;
        }

        input[type="submit"] {
            background-color: #e50914;
            border: none;
            color: white;
            padding: 10px 20px;
            font-size: 16px;
            font-weight: bold;
            border-radius: 4px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #f40612;
        }

        a {
            color: #b3b3b3;
            text-decoration: none;
            margin-top: 20px;
            display: inline-block;
        }

        a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

    <h2>✍️ Edit Your Review</h2>

    <form action="ReviewServlet" method="post">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="reviewId" value="<%= review.getReviewId() %>">

        <label for="rating">Rating (1–5):</label>
        <input type="number" name="rating" min="1" max="5" value="<%= review.getRating() %>" required>

        <label for="reviewText">Review:</label>
        <textarea name="reviewText" rows="5" required><%= review.getReviewText() %></textarea>

        <input type="submit" value="Update Review">
    </form>

    <a href="MovieServlet?action=detail&movieId=<%= review.getMovieId() %>">← Back to Movie</a>

</body>
</html>