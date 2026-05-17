<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Forgot Password - HRMS</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6366f1;
            --bg: #0f172a;
            --card-bg: rgba(30, 41, 59, 0.7);
            --text: #f8fafc;
            --text-muted: #94a3b8;
            --input-bg: #1e293b;
            --input-border: #334155;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Outfit', sans-serif; }
        body { background: var(--bg); height: 100vh; display: flex; align-items: center; justify-content: center; color: var(--text); }

        .forgot-card {
            background: var(--card-bg);
            backdrop-filter: blur(12px);
            border-radius: 24px;
            padding: 48px;
            width: 100%;
            max-width: 440px;
            text-align: center;
        }

        h1 { margin-bottom: 16px; font-size: 24px; }
        p { color: var(--text-muted); margin-bottom: 32px; font-size: 14px; }

        .form-group { margin-bottom: 24px; text-align: left; position: relative; }
        input {
            width: 100%;
            padding: 14px 16px 14px 48px;
            background: var(--input-bg);
            border: 1px solid var(--input-border);
            border-radius: 12px;
            color: var(--text);
            outline: none;
        }
        .form-group i { position: absolute; left: 16px; top: 50%; transform: translateY(-50%); color: var(--text-muted); }

        button {
            width: 100%;
            padding: 14px;
            background: var(--primary);
            border: none;
            border-radius: 12px;
            color: white;
            font-weight: 700;
            cursor: pointer;
            margin-bottom: 24px;
        }

        .back-link { color: var(--text-muted); text-decoration: none; font-size: 14px; }
        .back-link:hover { color: var(--primary); }

        .success-message { color: #10b981; background: rgba(16, 185, 129, 0.1); padding: 12px; border-radius: 8px; margin-bottom: 24px; }
    </style>
</head>
<body>
    <div class="forgot-card">
        <h1>Forgot Password?</h1>
        <p>No worries, we'll send you reset instructions.</p>

        <% if (request.getAttribute("message") != null) { %>
            <div class="success-message"><%= request.getAttribute("message") %></div>
        <% } %>

        <form action="forgot-password" method="POST">
            <div class="form-group">
                <input type="email" name="email" placeholder="Enter your email" required>
                <i class="fas fa-envelope"></i>
            </div>
            <button type="submit">Reset Password</button>
        </form>

        <a href="login" class="back-link"><i class="fas fa-arrow-left"></i> Back to login</a>
    </div>
</body>
</html>
