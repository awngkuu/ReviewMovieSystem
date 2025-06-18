<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Movie, model.Review, model.User, java.util.List" %>
<%
    // 🔐 Prevent browser caching (Back-button logout protection)
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // ✅ Session validation
    User currentUser = (User) session.getAttribute("user");
    String role = (String) session.getAttribute("role");
    if (currentUser == null || role == null) {
        response.sendRedirect(request.getContextPath() + "/user/login.jsp");
        return;
    }

    Movie movie = (Movie) request.getAttribute("movie");
    List<Review> reviewList = (List<Review>) request.getAttribute("reviewList");

    String rawUrl = (movie != null) ? movie.getTrailerUrl() : "";
    String embedUrl = "";

    if (rawUrl != null && !rawUrl.isEmpty()) {
        if (rawUrl.contains("watch?v=")) {
            String videoId = rawUrl.substring(rawUrl.indexOf("watch?v=") + 8);
            int ampIndex = videoId.indexOf("&");
            if (ampIndex != -1) {
                videoId = videoId.substring(0, ampIndex);
            }
            embedUrl = "https://www.youtube.com/embed/" + videoId;
        } else if (rawUrl.contains("youtu.be/")) {
            String videoId = rawUrl.substring(rawUrl.lastIndexOf("/") + 1);
            int qIndex = videoId.indexOf("?");
            if (qIndex != -1) {
                videoId = videoId.substring(0, qIndex);
            }
            embedUrl = "https://www.youtube.com/embed/" + videoId;
        } else {
            embedUrl = rawUrl;
        }
    }
%>

<% if (movie != null) { %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title><%= movie.getTitle() %> - Details</title>
    <style>
        body {
            background-color: #141414;
            color: #fff;
            font-family: 'Helvetica Neue', sans-serif;
            margin: 40px;
        }
        h1, h2 {
            color: #e50914;
        }
        img {
            border-radius: 8px;
            box-shadow: 0 0 10px rgba(0,0,0,0.5);
        }
        p {
            line-height: 1.6;
        }
        .review-box {
            background-color: #1f1f1f;
            border-radius: 8px;
            padding: 15px;
            margin-bottom: 15px;
            box-shadow: 0 4px 12px rgba(0,0,0,0.4);
        }
        iframe {
            border-radius: 8px;
            margin-top: 10px;
        }
        form textarea, form input[type="number"] {
            width: 100%;
            padding: 10px;
            background: #333;
            color: #fff;
            border: none;
            border-radius: 4px;
        }
        form input[type="submit"] {
            background-color: #e50914;
            color: white;
            padding: 10px 20px;
            border: none;
            margin-top: 10px;
            border-radius: 4px;
            cursor: pointer;
        }
        form input[type="submit"]:hover {
            background-color: #f40612;
        }
        a {
            color: #b3b3b3;
            text-decoration: none;
        }
        a:hover {
            text-decoration: underline;
        }
        .trailer {
            margin-top: 20px;
        }
    </style>
</head>
<body>

    <h1><%= movie.getTitle() %></h1>
    <img src="<%= movie.getPosterUrl() != null ? movie.getPosterUrl() : "#" %>" alt="Poster" width="200"/>

    <p><strong>🎬 Genre:</strong> <%= movie.getGenre() != null ? movie.getGenre() : "N/A" %></p>
    <p><strong>📅 Release Date:</strong> <%= movie.getReleaseDate() != null ? movie.getReleaseDate() : "N/A" %></p>
    <p><strong>🎥 Director:</strong> <%= movie.getDirector() != null ? movie.getDirector() : "N/A" %></p>
    <p><strong>👥 Cast:</strong> <%= movie.getCast() != null ? movie.getCast() : "N/A" %></p>
    <p><strong>📝 Synopsis:</strong> <%= movie.getSynopsis() != null ? movie.getSynopsis() : "N/A" %></p>

    <div class="trailer">
        <h2>▶️ Trailer</h2>
        <% if (!embedUrl.isEmpty()) { %>
            <iframe width="560" height="315" src="<%= embedUrl %>" frameborder="0" allowfullscreen></iframe>
        <% } else { %>
            <p>No trailer available.</p>
        <% } %>
    </div>

    <hr>

    <h2>🗣️ Reviews</h2>
    <%
        if (reviewList != null && !reviewList.isEmpty()) {
            for (Review review : reviewList) {
    %>
        <div class="review-box">
            <p><strong>👤 User:</strong> <%= review.getUsername() %></p>
            <p><strong>⭐ Rating:</strong> <%= review.getRating() %>/5</p>
            <p><strong>💬 Review:</strong> <%= review.getReviewText() %></p>
            <p><small>📅 Date: <%= review.getReviewDate() %></small></p>

            <% if ("user".equals(role) && currentUser.getUserId() == review.getUserId()) { %>
                <form action="<%= request.getContextPath() %>/ReviewServlet" method="get">
                    <input type="hidden" name="action" value="edit">
                    <input type="hidden" name="reviewId" value="<%= review.getReviewId() %>">
                    <input type="submit" value="Edit">
                </form>
                <form action="<%= request.getContextPath() %>/ReviewServlet" method="get" onsubmit="return confirm('Are you sure you want to delete this review?');">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="reviewId" value="<%= review.getReviewId() %>">
                    <input type="submit" value="Delete">
                </form>
            <% } %>
        </div>
    <%
            }
        } else {
    %>
        <p>No reviews yet.</p>
    <%
        }
    %>

    <hr>
    <% if ("user".equals(role)) { %>
        <h2>✍️ Leave a Review</h2>
        <form action="<%= request.getContextPath() %>/ReviewServlet" method="post">
            <input type="hidden" name="action" value="add">
            <input type="hidden" name="movieId" value="<%= movie.getMovieId() %>">

            <label for="rating">Rating (1-5):</label>
            <input type="number" name="rating" min="1" max="5" required>

            <label for="reviewText">Review:</label><br>
            <textarea name="reviewText" rows="4" required></textarea><br>

            <input type="submit" value="Submit Review">
        </form>
    <% } %>

    <p><a href="<%= request.getContextPath() %>/MovieServlet">← Back to Movie List</a></p>
</body>
</html>
<% } else { %>
<!DOCTYPE html>
<html>
<head><title>Movie Not Found</title></head>
<body>
    <h2>Error: Movie details not available.</h2>
    <p>Please <a href="<%= request.getContextPath() %>/index.jsp">go back</a> and try again.</p>
</body>
</html>
<% } %>
