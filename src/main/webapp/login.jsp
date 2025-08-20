<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Login - Pahana Edu</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
  @import url('https://fonts.googleapis.com/css2?family=Montserrat:wght@400;600;700&display=swap');
  * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Montserrat', sans-serif; }

  body {
    height: 100vh;
    display: flex;
    justify-content: center;
    align-items: center;
    background: radial-gradient(circle at top left, #6a11cb, #2575fc);
    overflow: hidden;
  }

  /*new Animated background circles */
  body::before, body::after {
    content: '';
    position: absolute;
    border-radius: 50%;
    opacity: 0.4;
    filter: blur(120px);
    animation: float 12s ease-in-out infinite;
  }
  body::before { width: 400px; height: 400px; background: #ff6b6b; top: -100px; left: -100px; }
  body::after { width: 500px; height: 500px; background: #ffd700; bottom: -150px; right: -150px; animation-duration: 15s; }

  @keyframes float {
    0%,100% { transform: translateY(0) translateX(0); }
    50% { transform: translateY(-30px) translateX(30px); }
  }

  .login-card {
    position: relative;
    background: rgba(255, 255, 255, 0.1);
    backdrop-filter: blur(20px);
    border-radius: 20px;
    width: 100%;
    max-width: 420px;
    padding: 40px 35px;
    box-shadow: 0 25px 50px rgba(0,0,0,0.3);
    z-index: 1;
    border: 1px solid rgba(255,255,255,0.2);
    animation: fadeInScale 0.8s ease forwards;
  }

  @keyframes fadeInScale {
    0% { opacity: 0; transform: scale(0.9); }
    100% { opacity: 1; transform: scale(1); }
  }

  .login-card h1 {
    text-align: center;
    font-size: 2rem;
    font-weight: 700;
    color: #fff;
    margin-bottom: 10px;
  }
  .login-card p {
    text-align: center;
    font-size: 1rem;
    color: rgba(255,255,255,0.8);
    margin-bottom: 30px;
  }

  .input-group {
    position: relative;
    margin-bottom: 22px;
  }
  .input-group input {
    width: 100%;
    padding: 14px 16px 14px 45px;
    border-radius: 12px;
    border: none;
    background: rgba(255,255,255,0.15);
    color: #fff;
    font-size: 1rem;
    outline: none;
    transition: 0.3s;
  }
  .input-group input::placeholder { color: rgba(255,255,255,0.6); }
  .input-group input:focus { background: rgba(255,255,255,0.25); box-shadow: 0 0 10px rgba(255,255,255,0.2); }
  .input-group i {
    position: absolute;
    top: 50%; left: 14px;
    transform: translateY(-50%);
    color: rgba(255,255,255,0.7);
    font-size: 1.1rem;
  }

  .login-button {
    width: 100%;
    padding: 15px;
    border-radius: 12px;
    border: none;
    background: linear-gradient(135deg, #ff6b6b, #ffd700);
    font-weight: 600;
    font-size: 1.05rem;
    color: #fff;
    cursor: pointer;
    transition: all 0.3s ease;
  }
  .login-button:hover {
    transform: translateY(-2px);
    box-shadow: 0 8px 20px rgba(255,215,0,0.5);
  }
  .login-button:active { transform: translateY(0); }

  .error-message {
    display: flex;
    align-items: center;
    gap: 10px;
    margin-top: 15px;
    padding: 12px;
    border-radius: 10px;
    font-size: 0.95rem;
    font-weight: 500;
    color: #ff6b6b;
    background: rgba(255,0,0,0.15);
    border-left: 4px solid #ff6b6b;
  }
</style>
</head>
<body>

<div class="login-card">
  <h1>Welcome Back</h1>
  <p>Sign in to access your account</p>

  <form method="post" action="login">
    <div class="input-group">
      <i class="fas fa-user"></i>
      <input type="text" name="username" required placeholder="Username">
    </div>

    <div class="input-group">
      <i class="fas fa-lock"></i>
      <input type="password" name="password" required placeholder="Password">
    </div>

    <button type="submit" class="login-button"><i class="fas fa-sign-in-alt"></i> Login</button>
  </form>

  <% if(request.getAttribute("error") != null) { %>
  <div class="error-message">
    <i class="fas fa-exclamation-circle"></i>
    <div><%= request.getAttribute("error") %></div>
  </div>
  <% } %>
</div>

<script>
  const btn = document.querySelector('.login-button');
  btn.addEventListener('click', () => {
    btn.innerHTML = '<i class="fas fa-spinner fa-spin"></i> Authenticating...';
    setTimeout(() => { btn.innerHTML = '<i class="fas fa-sign-in-alt"></i> Login'; }, 20000);
  });
</script>

</body>
</html>
