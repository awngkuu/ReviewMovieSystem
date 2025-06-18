/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package controller;

/**
 *
 * @author User
 */
import dao.MovieDAO;
import dao.ReviewDAO;
import model.Movie;
import model.Review;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/MovieServlet")
public class MovieServlet extends HttpServlet {

    private MovieDAO movieDAO;
    private ReviewDAO reviewDAO;

    @Override
    public void init() throws ServletException {
        movieDAO = new MovieDAO();
        reviewDAO = new ReviewDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if (action == null) action = "list";

            switch (action) {
                case "add":
                    showAddForm(request, response);
                    break;
                case "edit":
                    showEditForm(request, response);
                    break;
                case "delete":
                    deleteMovie(request, response);
                    break;
                case "view":
                    viewMovieDetails(request, response);
                    break;
                default:
                    listMovies(request, response);
                    break;
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                insertMovie(request, response);
            } else if ("update".equals(action)) {
                updateMovie(request, response);
            }
        } catch (SQLException ex) {
            throw new ServletException(ex);
        }
    }

    private void listMovies(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        List<Movie> movieList = movieDAO.getAllMovies();
        request.setAttribute("movieList", movieList);
        request.getRequestDispatcher("movie/movie_list.jsp").forward(request, response);
    }

    private void showAddForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("movie/add_movie.jsp").forward(request, response);
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, ServletException, IOException {
        int movieId = Integer.parseInt(request.getParameter("id"));
        Movie existingMovie = movieDAO.getMovieById(movieId);
        request.setAttribute("movie", existingMovie);
        request.getRequestDispatcher("movie/edit_movie.jsp").forward(request, response);
    }

    private void insertMovie(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        Movie movie = new Movie();
        movie.setTitle(request.getParameter("title"));
        movie.setGenre(request.getParameter("genre"));
        movie.setReleaseDate(request.getParameter("releaseDate"));
        movie.setDirector(request.getParameter("director"));
        movie.setCast(request.getParameter("cast"));
        movie.setSynopsis(request.getParameter("synopsis"));
        movie.setPosterUrl(request.getParameter("posterUrl"));
        movie.setTrailerUrl(request.getParameter("trailerUrl"));

        movieDAO.addMovie(movie);
        response.sendRedirect("MovieServlet");
    }

    private void updateMovie(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));

        Movie movie = new Movie();
        movie.setMovieId(id);
        movie.setTitle(request.getParameter("title"));
        movie.setGenre(request.getParameter("genre"));
        movie.setReleaseDate(request.getParameter("releaseDate"));
        movie.setDirector(request.getParameter("director"));
        movie.setCast(request.getParameter("cast"));
        movie.setSynopsis(request.getParameter("synopsis"));
        movie.setPosterUrl(request.getParameter("posterUrl"));
        movie.setTrailerUrl(request.getParameter("trailerUrl"));

        movieDAO.updateMovie(movie);
        response.sendRedirect("MovieServlet");
    }

    private void deleteMovie(HttpServletRequest request, HttpServletResponse response)
            throws SQLException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        movieDAO.deleteMovie(id);
        response.sendRedirect("MovieServlet");
    }

    private void viewMovieDetails(HttpServletRequest request, HttpServletResponse response)
        throws SQLException, ServletException, IOException {
    int movieId = Integer.parseInt(request.getParameter("id"));
    Movie movie = movieDAO.getMovieById(movieId);
    List<Review> reviews = reviewDAO.getReviewsByMovieId(movieId);

    request.setAttribute("movie", movie);
    request.setAttribute("reviewList", reviews); 
    request.getRequestDispatcher("movie/movie_detail.jsp").forward(request, response);
}

}
