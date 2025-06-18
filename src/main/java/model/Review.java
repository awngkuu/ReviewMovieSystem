package model;

import java.sql.Timestamp;

public class Review {
    private int reviewId;
    private int movieId;
    private int userId;
    private int rating;
    private String reviewText;
    private Timestamp reviewDate;

    private String username; // ✅ NEW FIELD

    // Constructors
    public Review() {}

    public Review(int reviewId, int movieId, int userId, int rating, String reviewText, Timestamp reviewDate) {
        this.reviewId = reviewId;
        this.movieId = movieId;
        this.userId = userId;
        this.rating = rating;
        this.reviewText = reviewText;
        this.reviewDate = reviewDate;
    }

    public Review(int movieId, int userId, int rating, String reviewText) {
        this.movieId = movieId;
        this.userId = userId;
        this.rating = rating;
        this.reviewText = reviewText;
    }

    // Getters and Setters
    public int getReviewId() {
        return reviewId;
    }

    public void setReviewId(int reviewId) {
        this.reviewId = reviewId;
    }

    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    public String getReviewText() {
        return reviewText;
    }

    public void setReviewText(String reviewText) {
        this.reviewText = reviewText;
    }

    public Timestamp getReviewDate() {
        return reviewDate;
    }

    public void setReviewDate(Timestamp reviewDate) {
        this.reviewDate = reviewDate;
    }

    public String getUsername() {  // ✅ NEW GETTER
        return username;
    }

    public void setUsername(String username) {  // ✅ NEW SETTER
        this.username = username;
    }
}
