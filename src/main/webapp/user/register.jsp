<%-- 
    Document   : register
    Created on : Jun 10, 2025, 3:27:40 AM
    Author     : User
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Register - Movie Review System</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.2.19/dist/tailwind.min.css" rel="stylesheet">
  <style>
    body {
      background-color: #0f0f0f;
      color: #ffffff;
    }
  </style>
</head>
<body class="flex items-center justify-center min-h-screen px-4">
  <div class="bg-gray-900 p-8 rounded-xl shadow-2xl w-full max-w-md">
    <h2 class="text-3xl font-extrabold text-center text-red-600 mb-6">Create Your Account</h2>

    <% String error = (String) request.getAttribute("error");
       String message = (String) request.getAttribute("message");
       if (error != null) { %>
        <p class="text-red-400 text-sm mb-4 text-center"><%= error %></p>
    <% } else if (message != null) { %>
        <p class="text-green-400 text-sm mb-4 text-center"><%= message %></p>
    <% } %>

    <form action="<%= request.getContextPath() %>/UserServlet" method="post" class="space-y-5">
      <input type="hidden" name="action" value="register">

      <div>
        <label class="block mb-1 font-semibold text-gray-300">Username</label>
        <input type="text" name="username" required
               class="w-full px-4 py-2 rounded-lg bg-gray-800 text-white focus:outline-none focus:ring-2 focus:ring-red-500">
      </div>

      <div>
        <label class="block mb-1 font-semibold text-gray-300">Email</label>
        <input type="email" name="email" required
               class="w-full px-4 py-2 rounded-lg bg-gray-800 text-white focus:outline-none focus:ring-2 focus:ring-red-500">
      </div>

      <div>
        <label class="block mb-1 font-semibold text-gray-300">Full Name</label>
        <input type="text" name="fullName" required
               class="w-full px-4 py-2 rounded-lg bg-gray-800 text-white focus:outline-none focus:ring-2 focus:ring-red-500">
      </div>

      <div>
        <label class="block mb-1 font-semibold text-gray-300">Password</label>
        <input type="password" name="password" required
               class="w-full px-4 py-2 rounded-lg bg-gray-800 text-white focus:outline-none focus:ring-2 focus:ring-red-500">
      </div>

      <button type="submit"
              class="w-full bg-red-600 hover:bg-red-700 text-white py-2 rounded-lg font-semibold transition duration-200">
        Register
      </button>
    </form>

    <p class="text-center text-sm mt-6 text-gray-400">
      Already have an account?
      <a href="login.jsp" class="text-red-500 hover:underline font-medium">Login here</a>
    </p>
  </div>
</body>
</html>

