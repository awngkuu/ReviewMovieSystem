<%-- 
    Document   : login
    Created on : Jun 10, 2025, 3:28:42 AM
    Author     : User
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" session="true" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Login - Movie Review System</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #0f0f0f;
      color: #ffffff;
    }
  </style>
</head>
<body class="flex items-center justify-center min-h-screen">
  <div class="bg-gray-900 p-8 rounded-lg shadow-lg w-full max-w-md">
    <h2 class="text-3xl font-bold text-center text-red-500 mb-6">User Login</h2>

    <%-- Session-based error and success messages --%>
    <%
        String sessionError = (String) session.getAttribute("error");
        if (sessionError != null) {
    %>
        <p class="text-red-500 text-sm mb-4"><%= sessionError %></p>
    <%
            session.removeAttribute("error");
        }

        String sessionMessage = (String) session.getAttribute("message");
        if (sessionMessage != null) {
    %>
        <p class="text-green-500 text-sm mb-4"><%= sessionMessage %></p>
    <%
            session.removeAttribute("message");
        }
    %>

    <form action="<%= request.getContextPath() %>/UserServlet" method="post" class="space-y-4">
      <input type="hidden" name="action" value="login">

      <div>
        <label class="block mb-1 font-semibold">Username</label>
        <input type="text" name="username" required class="w-full px-4 py-2 rounded bg-gray-800 text-white focus:outline-none focus:ring-2 focus:ring-red-500">
      </div>

      <div>
        <label class="block mb-1 font-semibold">Password</label>
        <input type="password" name="password" required class="w-full px-4 py-2 rounded bg-gray-800 text-white focus:outline-none focus:ring-2 focus:ring-red-500">
      </div>

      <button type="submit" class="w-full bg-red-600 hover:bg-red-700 text-white py-2 rounded font-semibold transition">Login</button>
    </form>

    <p class="text-center text-sm mt-4 text-gray-400">
      Don't have an account? <a href="register.jsp" class="text-red-500 hover:underline">Register here</a>
    </p>
  </div>
</body>
</html>