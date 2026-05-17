<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login - HRMS</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Outfit:wght@300;400;600;700&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary: #6366f1;
            --primary-hover: #4f46e5;
            --bg: #0f172a;
            --card-bg: rgba(30, 41, 59, 0.7);
            --text: #f8fafc;
            --text-muted: #94a3b8;
            --input-bg: #1e293b;
            --input-border: #334155;
            --error: #ef4444;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: 'Outfit', sans-serif;
        }

        body {
            background-color: var(--bg);
            background-image: radial-gradient(circle at 50% 50%, #1e1b4b 0%, #0f172a 100%);
            height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--text);
            overflow: hidden;
        }

        .login-card {
            background: var(--card-bg);
            backdrop-filter: blur(12px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 24px;
            padding: 48px;
            width: 100%;
            max-width: 440px;
            box-shadow: 0 25px 50px -12px rgba(0, 0, 0, 0.5);
            animation: fadeIn 0.6s ease-out;
        }

        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(20px); }
            to { opacity: 1; transform: translateY(0); }
        }

        .header {
            text-align: center;
            margin-bottom: 32px;
        }

        .logo-icon {
            width: 64px;
            height: 64px;
            background: var(--primary);
            border-radius: 16px;
            display: flex;
            align-items: center;
            justify-content: center;
            margin: 0 auto 16px;
            font-size: 32px;
            box-shadow: 0 0 20px rgba(99, 102, 241, 0.4);
        }

        h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 8px;
            letter-spacing: -0.5px;
        }

        p.subtitle {
            color: var(--text-muted);
            font-size: 15px;
        }

        .form-group {
            margin-bottom: 24px;
            position: relative;
        }

        .form-group i {
            position: absolute;
            left: 16px;
            top: 50%;
            transform: translateY(-50%);
            color: var(--text-muted);
            transition: color 0.3s;
        }

        input {
            width: 100%;
            padding: 14px 16px 14px 48px;
            background: var(--input-bg);
            border: 1px solid var(--input-border);
            border-radius: 12px;
            color: var(--text);
            font-size: 16px;
            transition: all 0.3s;
            outline: none;
        }

        input:focus {
            border-color: var(--primary);
            box-shadow: 0 0 0 4px rgba(99, 102, 241, 0.15);
        }

        input:focus + i {
            color: var(--primary);
        }

        .options {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 32px;
            font-size: 14px;
        }

        .remember-me {
            display: flex;
            align-items: center;
            gap: 8px;
            cursor: pointer;
            color: var(--text-muted);
        }

        .forgot-link {
            color: var(--primary);
            text-decoration: none;
            font-weight: 600;
            transition: opacity 0.3s;
        }

        .forgot-link:hover {
            opacity: 0.8;
        }

        button {
            width: 100%;
            padding: 14px;
            background: var(--primary);
            border: none;
            border-radius: 12px;
            color: white;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            transition: all 0.3s;
            box-shadow: 0 4px 6px -1px rgba(0, 0, 0, 0.1);
        }

        button:hover {
            background: var(--primary-hover);
            transform: translateY(-1px);
            box-shadow: 0 10px 15px -3px rgba(99, 102, 241, 0.4);
        }

        .error-message {
            background: rgba(239, 68, 68, 0.1);
            border-left: 4px solid var(--error);
            color: #fca5a5;
            padding: 12px 16px;
            border-radius: 8px;
            margin-bottom: 24px;
            font-size: 14px;
            display: ${error != null ? 'block' : 'none'};
        }
    </style>
</head>
<body>
    <div class="login-card">
        <div class="header">
            <div class="logo-icon"><i class="fas fa-users-gear"></i></div>
            <h1>Welcome Back</h1>
            <p class="subtitle">Enter your credentials to access HRMS</p>
        </div>

        <% if (request.getAttribute("error") != null) { %>
            <div class="error-message">
                <i class="fas fa-circle-exclamation"></i> <%= request.getAttribute("error") %>
            </div>
        <% } %>

        <form action="login" method="POST">
            <div class="form-group">
                <input type="text" name="username" placeholder="Username or Email" required>
                <i class="fas fa-user"></i>
            </div>
            <div class="form-group">
                <input type="password" name="password" placeholder="Password" required>
                <i class="fas fa-lock"></i>
            </div>
            <div class="options">
                <label class="remember-me">
                    <input type="checkbox" style="width: auto; height: auto; margin: 0;"> Remember me
                </label>
                <a href="forgot-password" class="forgot-link">Forgot password?</a>
            </div>
            <button type="submit">Sign In</button>
        </form>
    </div>
</body>
</html>
