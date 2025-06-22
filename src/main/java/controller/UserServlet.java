package controller;

/**
 *
 * @author User
 */
import dao.UserDAO;
import model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String action = request.getParameter("action");

        switch (action) {
            case "register":
                handleRegister(request, response);
                break;
            case "login":
                handleLogin(request, response);
                break;
            case "update":
                handleUpdateProfile(request, response);
                break;
            case "delete":
                handleDeleteProfile(request, response);
                break;
            default:
                response.sendRedirect(request.getContextPath() + "/user/login.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");

        } else if ("delete".equals(action)) {
            handleDeleteProfile(request, response);

        } else if ("adminDeleteUser".equals(action)) {
            String userIdStr = request.getParameter("userId");
            if (userIdStr != null) {
                int userId = Integer.parseInt(userIdStr);
                try {
                    User targetUser = userDAO.getUserById(userId);
                    if (!"admin".equals(targetUser.getRole())) {
                        boolean deleted = userDAO.deleteUser(userId);
                        if (deleted) {
                            request.getSession().setAttribute("msg", "User deleted successfully.");
                        } else {
                            request.getSession().setAttribute("msg", "Failed to delete user.");
                        }
                    } else {
                        request.getSession().setAttribute("msg", "Cannot delete admin user.");
                    }
                } catch (Exception e) {
                    request.getSession().setAttribute("msg", "Error: " + e.getMessage());
                    e.printStackTrace();
                }
            }
            response.sendRedirect("user/manage_users.jsp");

        } else {
            response.sendRedirect(request.getContextPath() + "/user/login.jsp");
        } 
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            User user = new User();
            user.setUsername(request.getParameter("username"));
            user.setEmail(request.getParameter("email"));
            user.setPassword(request.getParameter("password"));
            user.setFullName(request.getParameter("fullName"));
            user.setRole("user"); // default role on registration

            boolean success = userDAO.registerUser(user);
            if (success) {
                request.setAttribute("message", "Registration successful. Please login.");
                response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            } else {
                request.setAttribute("error", "Registration failed. Try again.");
                request.getRequestDispatcher("/user/register.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Server error: " + e.getMessage());
            request.getRequestDispatcher(request.getContextPath() + "/user/register.jsp").forward(request, response);
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            String username = request.getParameter("username");
            String password = request.getParameter("password");

            User user = userDAO.loginUser(username, password);

            if (user != null) {
                HttpSession session = request.getSession();
                session.setAttribute("user", user);
                session.setAttribute("role", user.getRole()); // store role in session
                response.sendRedirect("user/dashboard.jsp");
            } else {
                HttpSession session = request.getSession();
                session.setAttribute("error", "Invalid credentials.");
                response.sendRedirect(request.getContextPath() + "/user/login.jsp");
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Server error: " + e.getMessage());
            request.getRequestDispatcher("/user/login.jsp").forward(request, response);
        }
    }

    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
    try {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("/user/login.jsp");
            return;
        }

        User sessionUser = (User) session.getAttribute("user");

        User updatedUser = new User();
        updatedUser.setUserId(sessionUser.getUserId());
        updatedUser.setUsername(request.getParameter("username"));
        updatedUser.setEmail(request.getParameter("email"));
        updatedUser.setFullName(request.getParameter("fullName"));
        updatedUser.setRole(sessionUser.getRole()); // preserve role

        boolean success = userDAO.updateProfile(updatedUser);

        if (success) {
            User freshUser = userDAO.getUserById(updatedUser.getUserId());
            session.setAttribute("user", freshUser);
            session.setAttribute("role", freshUser.getRole());
            session.setAttribute("message", "Profile updated successfully.");
            response.sendRedirect(request.getContextPath() + "/user/profile.jsp");
        } else {
            request.setAttribute("error", "Profile update failed.");
            request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
        }

    } catch (Exception e) {
        e.printStackTrace();
        request.setAttribute("error", "Server error: " + e.getMessage());
        request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
    }
}

    private void handleDeleteProfile(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {
        try {
            HttpSession session = request.getSession(false);
            if (session != null && session.getAttribute("user") != null) {
                User user = (User) session.getAttribute("user");

                if ("admin".equals(user.getRole())) {
                    request.setAttribute("error", "Admin account cannot be deleted.");
                    request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
                    return;
                }

                boolean deleted = userDAO.deleteUser(user.getUserId());
                if (deleted) {
                    session.invalidate();
                    response.sendRedirect("/user/login.jsp");
                } else {
                    request.setAttribute("error", "Failed to delete profile.");
                    request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
                }
            } else {
                response.sendRedirect("/user/login.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Server error: " + e.getMessage());
            request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
        }
    }
}
