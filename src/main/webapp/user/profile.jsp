<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.User" %>
<%@ page session="true" %>
<%
    // 🔐 Prevent caching after logout
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);

    // 🔒 Session check
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>User Profile - Movie Review System</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #0f0f0f;
      color: white;
    }
  </style>
</head>
<body class="font-sans min-h-screen">

  <!-- Header -->
  <header class="bg-black bg-opacity-90 p-6 flex justify-between items-center">
    <h1 class="text-2xl font-bold text-red-600">MovieReviewHub</h1>
    <nav class="space-x-4">
      <a href="dashboard.jsp" class="text-gray-300 hover:text-red-400">Dashboard</a>
      <a href="login.jsp" class="text-gray-300 hover:text-red-400">Logout</a>
    </nav>
  </header>

  <!-- Banner -->
  <section class="bg-cover bg-center h-64 flex items-center justify-center" style="background-image: url('https://images.unsplash.com/photo-1604382352975-e5c2e14c4b98');">
    <div class="bg-black bg-opacity-70 px-6 py-8 rounded text-center">
      <h2 class="text-4xl font-bold text-white mb-2">Edit Your Profile</h2>
      <p class="text-gray-300">Keep your account details up to date and manage your identity.</p>
    </div>
  </section>

  <!-- Profile Form -->
  <main class="max-w-xl mx-auto mt-10 bg-gray-900 rounded-lg shadow-lg p-8">
    <div class="flex flex-col items-center mb-6">
      <img src="https://ui-avatars.com/api/?name=<%= user.getFullName().replace(" ", "+") %>&background=ff0000&color=fff&size=128"
           alt="User Avatar" class="rounded-full mb-4 shadow-md">
      <h3 class="text-2xl font-semibold text-red-500"><%= user.getFullName() %></h3>
      <p class="text-sm text-gray-400">Edit your account info below</p>
    </div>

    <%-- 🔔 Show error/success messages (from request) --%>
    <%
       String error = (String) request.getAttribute("error");
       String message = (String) request.getAttribute("message");
       if (error != null) {
    %>
        <p class="text-red-500 text-sm mb-4"><%= error %></p>
    <%
       } else if (message != null) {
    %>
        <p class="text-green-500 text-sm mb-4"><%= message %></p>
    <%
       }
    %>

    <%-- 🔔 Show flash message (from session) --%>
    <%
        String sessionMessage = (String) session.getAttribute("message");
        if (sessionMessage != null) {
    %>
        <div style="color: green; padding: 10px; margin-bottom: 10px;"><%= sessionMessage %></div>
    <%
            session.removeAttribute("message");
        }
    %>

    <form action="<%= request.getContextPath() %>/UserServlet" method="post" class="space-y-5">
      <input type="hidden" name="action" value="update">

      <div>
        <label class="block text-sm font-semibold mb-1">Username</label>
        <input type="text" name="username" value="<%= user.getUsername() %>" required
               class="w-full px-4 py-2 bg-gray-800 text-white rounded focus:outline-none">
      </div>

      <div>
        <label class="block text-sm font-semibold mb-1">Email</label>
        <input type="email" name="email" value="<%= user.getEmail() %>" required
               class="w-full px-4 py-2 bg-gray-800 text-white rounded focus:outline-none focus:ring-2 focus:ring-red-500">
      </div>

      <div>
        <label class="block text-sm font-semibold mb-1">Full Name</label>
        <input type="text" name="fullName" value="<%= user.getFullName() %>" required
               class="w-full px-4 py-2 bg-gray-800 text-white rounded focus:outline-none focus:ring-2 focus:ring-red-500">
      </div>

      <button type="submit"
              class="w-full bg-red-600 hover:bg-red-700 text-white py-2 rounded font-semibold transition">
        Update Profile
      </button>
    </form>

    <div class="text-center mt-6">
      <a href="dashboard.jsp" class="text-sm text-gray-400 hover:underline">← Back to Dashboard</a>
    </div>
  </main>

  <!-- Footer -->
  <footer class="text-center text-sm py-6 text-gray-500 mt-12">
    &copy; 2025 MovieReviewHub. All rights reserved.
  </footer>
</body>
</html>
