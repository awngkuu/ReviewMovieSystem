<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page session="true" %>
<%
    // 🔐 Prevent browser caching
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate"); // HTTP 1.1
    response.setHeader("Pragma", "no-cache"); // HTTP 1.0
    response.setDateHeader("Expires", 0); // Proxies

    // 🔒 Session validation
    User user = (User) session.getAttribute("user");
    String role = (String) session.getAttribute("role");
    if (user == null || role == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Dashboard - Movie Review System</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #0f0f0f;
      color: white;
    }
  </style>
</head>
<body class="min-h-screen font-sans">
  <!-- Header -->
  <header class="bg-black bg-opacity-90 p-6 flex justify-between items-center">
    <h1 class="text-2xl font-bold text-red-600">MovieReviewKito</h1>
    <nav class="space-x-4">
      <a href="profile.jsp" class="text-gray-300 hover:text-red-400">Profile</a>
      <a href="<%= request.getContextPath() %>/UserServlet?action=logout" class="text-gray-300 hover:text-red-400">Logout</a>
    </nav>
  </header>

  <!-- Welcome Section -->
  <section class="px-6 py-10 text-center">
    <h2 class="text-4xl font-bold text-red-500 mb-2">Welcome, <%= user.getFullName() %>!</h2>
    <p class="text-gray-400 text-lg">Your role: <strong><%= role %></strong></p>
  </section>

  <!-- User Info -->
  <section class="max-w-2xl mx-auto bg-gray-900 rounded-lg p-6 shadow-lg mb-10">
    <h3 class="text-2xl font-semibold text-red-400 mb-4">Your Account Details</h3>
    <p><strong>Username:</strong> <span class="text-gray-300"><%= user.getUsername() %></span></p>
    <p><strong>Email:</strong> <span class="text-gray-300"><%= user.getEmail() %></span></p>
  </section>

  <!-- Actions -->
  <section class="max-w-2xl mx-auto px-4 mb-12">
    <h3 class="text-xl font-semibold mb-4 text-gray-300">Quick Actions</h3>
    <div class="grid grid-cols-1 sm:grid-cols-2 gap-4">
      <% if ("admin".equals(role)) { %>
        <a href="<%= request.getContextPath() %>/MovieServlet?action=list"
           class="bg-red-600 hover:bg-red-700 text-white text-center py-3 rounded-lg font-semibold transition">
           🎬 Manage Movies
        </a>
        <a href="manage_users.jsp"
           class="bg-gray-800 hover:bg-gray-700 text-white text-center py-3 rounded-lg font-semibold transition">
           👥 Manage Users
        </a>
      <% } else { %>
        <a href="<%= request.getContextPath() %>/MovieServlet?action=list"
           class="bg-red-600 hover:bg-red-700 text-white text-center py-3 rounded-lg font-semibold transition">
           🎬 Browse Movies
        </a>
        <a href="<%= request.getContextPath() %>/UserServlet?action=delete"
           onclick="return confirm('Are you sure you want to delete your profile? This cannot be undone.');"
           class="bg-gray-700 hover:bg-red-700 text-white text-center py-3 rounded-lg font-semibold transition">
           ❌ Delete Profile
        </a>
      <% } %>
      <a href="<%= request.getContextPath() %>/UserServlet?action=logout"
         class="bg-gray-800 hover:bg-gray-700 text-white text-center py-3 rounded-lg font-semibold transition">
         🚪 Logout
      </a>
       <a href="profile.jsp"
           class="bg-gray-800 hover:bg-gray-700 text-white text-center py-3 rounded-lg font-semibold transition">
           ✏️ Update Profile
        </a>  
    </div>
  </section>

  <!-- Feature Banner -->
  <section class="bg-cover bg-center h-64 rounded-lg mx-4 lg:mx-auto max-w-5xl mb-12" style="background-image: url('https://images.unsplash.com/photo-1524985069026-dd778a71c7b4');">
    <div class="bg-black bg-opacity-60 h-full flex items-center justify-center text-center rounded-lg">
      <div>
        <h3 class="text-2xl font-bold text-white mb-2">Discover the Hottest Movies Now</h3>
        <p class="text-gray-300">Your opinion matters. Rate and review movies in real time.</p>
      </div>
    </div>
  </section>

  <!-- Footer -->
  <footer class="text-center text-sm py-6 text-gray-500">
    &copy; 2025 MovieReviewHub. All rights reserved.
  </footer>
</body>
</html>
