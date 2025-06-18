/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

/**
 *
 * @author User
 */
import dao.DBConnection;
import dao.ReviewDAO;
import model.Review;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;

@WebServlet("/ReviewServlet")
public class ReviewServlet extends HttpServlet {
    private ReviewDAO reviewDAO;

    @Override
    public void init() {
        try {
            Connection conn = DBConnection.getConnection();
            reviewDAO = new ReviewDAO(conn);
        } catch (SQLException e) {
            throw new RuntimeException("Database connection failed", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            switch (action) {
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteReview(request, response);
                    break;
                default:
                    response.sendRedirect("index.jsp");
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        String action = request.getParameter("action");

        try {
            switch (action) {
                case "add":
                    insertReview(request, response);
                    break;
                case "update":
                    updateReview(request, response);
                    break;
                default:
                    response.sendRedirect("index.jsp");
                    break;
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    private void insertReview(HttpServletRequest request, HttpServletResponse response)
        throws Exception {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");
        if (user == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        int movieId = Integer.parseInt(request.getParameter("movieId"));
        int rating = Integer.parseInt(request.getParameter("rating"));
        String reviewText = request.getParameter("reviewText");

        Review review = new Review(movieId, user.getUserId(), rating, reviewText);
        reviewDAO.addReview(review);

        response.sendRedirect("MovieServlet?action=detail&movieId=" + movieId);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
        throws Exception {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        int reviewId = Integer.parseInt(request.getParameter("reviewId"));
        Review review = reviewDAO.getReviewById(reviewId);

        // Only the user who wrote the review can edit
        if (user != null && user.getUserId() == review.getUserId()) {
            request.setAttribute("review", review);
            request.getRequestDispatcher("/review/review_form.jsp").forward(request, response);
        } else {
            response.sendRedirect("MovieServlet?action=detail&movieId=" + review.getMovieId());
        }
    }

    private void updateReview(HttpServletRequest request, HttpServletResponse response)
        throws Exception {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        int reviewId = Integer.parseInt(request.getParameter("reviewId"));
        Review review = reviewDAO.getReviewById(reviewId);

        if (user != null && user.getUserId() == review.getUserId()) {
            int rating = Integer.parseInt(request.getParameter("rating"));
            String reviewText = request.getParameter("reviewText");

            review.setRating(rating);
            review.setReviewText(reviewText);
            reviewDAO.updateReview(review);
        }

        response.sendRedirect("MovieServlet?action=detail&movieId=" + review.getMovieId());
    }

    private void deleteReview(HttpServletRequest request, HttpServletResponse response)
        throws Exception {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        int reviewId = Integer.parseInt(request.getParameter("reviewId"));
        Review review = reviewDAO.getReviewById(reviewId);

        // Only the user who wrote the review can delete
        if (user != null && user.getUserId() == review.getUserId()) {
            reviewDAO.deleteReview(reviewId);
        }

        response.sendRedirect("MovieServlet?action=detail&movieId=" + review.getMovieId());
    }
}