package dao;

import model.Review;
import java.sql.*;
import java.util.*;

public class ReviewDAO {
    private Connection conn;

    public ReviewDAO() {
        try {
            this.conn = DBConnection.getConnection();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    public ReviewDAO(Connection conn) {
        this.conn = conn;
    }

    public boolean addReview(Review review) throws SQLException {
        String sql = "INSERT INTO reviews (movie_id, user_id, rating, review_text) VALUES (?, ?, ?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, review.getMovieId());
            stmt.setInt(2, review.getUserId());
            stmt.setInt(3, review.getRating());
            stmt.setString(4, review.getReviewText());
            return stmt.executeUpdate() > 0;
        }
    }

    // ✅ Updated to include username
    public List<Review> getReviewsByMovieId(int movieId) throws SQLException {
        List<Review> list = new ArrayList<>();
        String sql = "SELECT r.*, u.username FROM reviews r JOIN users u ON r.user_id = u.user_id WHERE r.movie_id = ? ORDER BY r.review_date DESC";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, movieId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    Review review = new Review();
                    review.setReviewId(rs.getInt("review_id"));
                    review.setMovieId(rs.getInt("movie_id"));
                    review.setUserId(rs.getInt("user_id"));
                    review.setRating(rs.getInt("rating"));
                    review.setReviewText(rs.getString("review_text"));
                    review.setReviewDate(rs.getTimestamp("review_date"));
                    review.setUsername(rs.getString("username")); // ✅ Set reviewer username
                    list.add(review);
                }
            }
        }
        return list;
    }

    public Review getReviewById(int reviewId) throws SQLException {
        String sql = "SELECT * FROM reviews WHERE review_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, reviewId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    return new Review(
                        rs.getInt("review_id"),
                        rs.getInt("movie_id"),
                        rs.getInt("user_id"),
                        rs.getInt("rating"),
                        rs.getString("review_text"),
                        rs.getTimestamp("review_date")
                    );
                }
            }
        }
        return null;
    }

    public boolean updateReview(Review review) throws SQLException {
        String sql = "UPDATE reviews SET rating = ?, review_text = ? WHERE review_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, review.getRating());
            stmt.setString(2, review.getReviewText());
            stmt.setInt(3, review.getReviewId());
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean deleteReview(int reviewId) throws SQLException {
        String sql = "DELETE FROM reviews WHERE review_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, reviewId);
            return stmt.executeUpdate() > 0;
        }
    }

    public boolean hasUserReviewedMovie(int userId, int movieId) throws SQLException {
        String sql = "SELECT review_id FROM reviews WHERE user_id = ? AND movie_id = ?";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setInt(1, userId);
            stmt.setInt(2, movieId);
            try (ResultSet rs = stmt.executeQuery()) {
                return rs.next();
            }
        }
    }
}
