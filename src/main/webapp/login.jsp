<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
  <title>HRM - Login</title>
  <style>
    body { font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif; display: flex; justify-content: center; align-items: center; height: 100vh; margin: 0; background: linear-gradient(135deg, #0056b3 0%, #00a2ff 100%); }
    .login-box { background: white; padding: 40px; border-radius: 10px; box-shadow: 0 10px 25px rgba(0,0,0,0.2); width: 100%; max-width: 350px; text-align: center; }
    .login-box h2 { color: #0056b3; margin-top: 0; }
    input { width: 100%; padding: 12px; margin: 10px 0; border: 1px solid #ccc; border-radius: 5px; box-sizing: border-box; }
    button { width: 100%; padding: 12px; background: #0056b3; color: white; border: none; border-radius: 5px; cursor: pointer; font-size: 16px; font-weight: bold; margin-top: 10px; }
    button:hover { background: #004494; }
    .error { color: #dc3545; font-size: 14px; margin-bottom: 10px; text-align: left; }
  </style>
</head>
<body>
<div class="login-box">
  <h2>HRM Login</h2>
  <p style="color: #666; margin-bottom: 20px;">Manufacturing and Trading System</p>

  <form action="login" method="post">
    <% if (request.getAttribute("error") != null) { %>
    <div class="error">Error: <%= request.getAttribute("error") %></div>
    <% } %>
    <label>
      <input type="text" name="username" placeholder="Username" required>
    </label>
    <label>
      <input type="password" name="password" placeholder="Password" required>
    </label>
    <button type="submit">Login</button>
  </form>
</div>
</body>
</html>