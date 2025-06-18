<%-- 
    Document   : review_list
    Created on : Jun 11, 2025, 9:56:16 PM
    Author     : User
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="model.Review" %>
<%@ page import="model.User" %>
<%
    List<Review> reviewList = (List<Review>) request.getAttribute("reviewList");
    Integer movieId = (Integer) request.getAttribute("movieId");
    User user = (User) session.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Movie Reviews</title>
    <style>
        body {
            background-color: #141414;
            color: #fff;
            font-family: 'Helvetica Neue', sans-serif;
            padding: 40px;
        }

        h2 {
            color: #e50914;
            margin-bottom: 20px;
        }

        h3 {
            color: #fff;
            margin-top: 40px;
        }

        ul {
            list-style: none;
            padding: 0;
        }

        li {
            background-color: #1f1f1f;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.4);
        }

        strong {
            color: #e50914;
        }

        small {
            color: #aaa;
        }

        a {
            color: #b3b3b3;
            text-decoration: none;
            margin-left: 10px;
        }

        a:hover {
            text-decoration: underline;
        }

        form {
            background-color: #1f1f1f;
            padding: 20px;
            border-radius: 8px;
            margin-top: 20px;
            max-width: 600px;
        }

        label {
            display: block;
            margin-top: 10px;
            font-weight: bold;
        }

        input[type="number"],
        textarea {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            background-color: #333;
            border: none;
            border-radius: 4px;
            color: #fff;
        }

        input[type="submit"] {
            background-color: #e50914;
            color: white;
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            font-weight: bold;
            margin-top: 15px;
            cursor: pointer;
        }

        input[type="submit"]:hover {
            background-color: #f40612;
        }
    </style>
</head>
<body>

    <h2>📢 Movie Reviews</h2>

    <% if (reviewList == null || reviewList.isEmpty()) { %>
        <p>No reviews yet.</p>
    <% } else { %>
        <ul>
            <% for (Review review : reviewList) { %>
                <li>
                    <strong>Rating:</strong> <%= review.getRating() %>/5<br>
                    <strong>Review:</strong> <%= review.getReviewText() %><br>
                    <small>Posted on: <%= review.getReviewDate() %></small>
                    <% if (user != null && review.getUserId() == user.getUserId()) { %>
                        | <a href="ReviewServlet?action=edit&reviewId=<%= review.getReviewId() %>">Edit</a>
                        | <a href="ReviewServlet?action=delete&reviewId=<%= review.getReviewId() %>">Delete</a>
                    <% } %>
                </li>
            <% } %>
        </ul>
    <% } %>

    <% if (user != null) { %>
        <h3>Add Your Review</h3>
        <form action="ReviewServlet" method="post">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="movieId" value="<%= movieId %>">

            <label for="rating">Rating (1–5):</label>
            <input type="number" name="rating" min="1" max="5" required>

            <label for="reviewText">Review:</label>
            <textarea name="reviewText" rows="4" required></textarea>

            <input type="submit" value="Submit Review">
        </form>
    <% } else { %>
        <p><a href="login.jsp">Log in</a> to post a review.</p>
    <% } %>

    <p><a href="MovieServlet">← Back to Movie List</a></p>

</body>
</html>
