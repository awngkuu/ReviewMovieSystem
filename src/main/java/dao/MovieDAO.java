/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dao;

/**
 *
 * @author User
 */
import java.sql.*;
import java.util.*;
import model.Movie;

public class MovieDAO {

    public void addMovie(Movie movie) throws SQLException {
        String sql = "INSERT INTO movies (title, genre, release_date, director, cast, synopsis, poster_url, trailer_url) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, movie.getTitle());
            stmt.setString(2, movie.getGenre());
            stmt.setString(3, movie.getReleaseDate());
            stmt.setString(4, movie.getDirector());
            stmt.setString(5, movie.getCast());
            stmt.setString(6, movie.getSynopsis());
            stmt.setString(7, movie.getPosterUrl());
            stmt.setString(8, movie.getTrailerUrl());

            stmt.executeUpdate();
        }
    }

    public List<Movie> getAllMovies() throws SQLException {
        List<Movie> list = new ArrayList<>();
        String sql = "SELECT * FROM movies";

        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                Movie movie = new Movie(
                    rs.getInt("movie_id"),
                    rs.getString("title"),
                    rs.getString("genre"),
                    rs.getString("release_date"),
                    rs.getString("director"),
                    rs.getString("cast"),
                    rs.getString("synopsis"),
                    rs.getString("poster_url"),
                    rs.getString("trailer_url")
                );
                list.add(movie);
            }
        }
        return list;
    }

    public Movie getMovieById(int movieId) throws SQLException {
        String sql = "SELECT * FROM movies WHERE movie_id = ?";
        Movie movie = null;

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, movieId);
            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next()) {
                    movie = new Movie(
                        rs.getInt("movie_id"),
                        rs.getString("title"),
                        rs.getString("genre"),
                        rs.getString("release_date"),
                        rs.getString("director"),
                        rs.getString("cast"),
                        rs.getString("synopsis"),
                        rs.getString("poster_url"),
                        rs.getString("trailer_url")
                    );
                }
            }
        }
        return movie;
    }

    public void updateMovie(Movie movie) throws SQLException {
        String sql = "UPDATE movies SET title = ?, genre = ?, release_date = ?, director = ?, cast = ?, "
                   + "synopsis = ?, poster_url = ?, trailer_url = ? WHERE movie_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, movie.getTitle());
            stmt.setString(2, movie.getGenre());
            stmt.setString(3, movie.getReleaseDate());
            stmt.setString(4, movie.getDirector());
            stmt.setString(5, movie.getCast());
            stmt.setString(6, movie.getSynopsis());
            stmt.setString(7, movie.getPosterUrl());
            stmt.setString(8, movie.getTrailerUrl());
            stmt.setInt(9, movie.getMovieId());

            stmt.executeUpdate();
        }
    }

    public void deleteMovie(int movieId) throws SQLException {
        String sql = "DELETE FROM movies WHERE movie_id = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setInt(1, movieId);
            stmt.executeUpdate();
        }
    }
}
