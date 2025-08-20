<%@ page session="true" %>
<%
  String username = (String) session.getAttribute("username");
  if (username == null) {
    response.sendRedirect("login.html");
    return;
  }
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Dashboard</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
  * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }

  body {
      background: #f0f3f7;
      min-height: 100vh;
      display: flex;
      flex-direction: column;
  }

  /* Navbar */
  nav {
      display: flex;
      justify-content: space-between;
      align-items: center;
      padding: 15px 40px;
      background: #1e1e2f;
      color: #fff;
      box-shadow: 0 6px 20px rgba(0,0,0,0.2);
      position: sticky;
      top: 0;
      z-index: 100;
      flex-wrap: wrap;
  }

  nav .brand {
      font-size: 1.5rem;
      font-weight: 700;
      letter-spacing: 1px;
      color: #ffd700;
  }

  nav .links a {
      margin-left: 25px;
      color: #fff;
      text-decoration: none;
      font-weight: 500;
      display: inline-flex;
      align-items: center;
      gap: 6px;
      padding: 6px 10px;
      border-radius: 8px;
      transition: 0.3s;
  }

  nav .links a:hover {
      background: #ffd700;
      color: #1e1e2f;
  }

  /* Main container */
  .container {
      flex: 1;
      padding: 50px 30px;
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 40px;
  }

  .welcome-card {
      background: #fff;
      width: 100%;
      max-width: 600px;
      border-radius: 20px;
      padding: 40px 30px;
      text-align: center;
      box-shadow: 0 15px 35px rgba(0,0,0,0.1);
      position: relative;
      overflow: hidden;
      transition: transform 0.3s ease;
  }

  .welcome-card::before {
      content: '';
      position: absolute;
      top: -50%;
      left: -50%;
      width: 200%;
      height: 200%;
      background: linear-gradient(135deg, #6a11cb, #2575fc);
      opacity: 0.15;
      transform: rotate(25deg);
  }

  .welcome-card h1 {
      font-size: 2rem;
      margin-bottom: 15px;
      color: #1e1e2f;
  }

  .welcome-card p {
      font-size: 1rem;
      color: #555;
  }

  /* New Dashboard cards for navigation */
  .dashboard-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
      gap: 25px;
      width: 100%;
      max-width: 900px;
  }

  .dash-card {
      background: #fff;
      border-radius: 20px;
      padding: 30px;
      display: flex;
      flex-direction: column;
      align-items: center;
      gap: 15px;
      box-shadow: 0 10px 30px rgba(0,0,0,0.1);
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      cursor: pointer;
      text-decoration: none;
      color: #1e1e2f;
  }

  .dash-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 15px 35px rgba(0,0,0,0.2);
  }

  .dash-card i {
      font-size: 2.5rem;
      color: #2575fc;
  }

  .dash-card span {
      font-size: 1.1rem;
      font-weight: 600;
  }

  @media (max-width: 600px) {
      nav { padding: 15px 20px; }
      .welcome-card { padding: 30px 20px; }
      .dashboard-grid { gap: 15px; }
  }

</style>
</head>
<body>

<!--  New Navbar -->
<nav>
    <div class="brand"><i class="fas fa-bolt"></i> PowerBilling</div>
    <div class="links">
        <a href="customers"><i class="fas fa-users"></i> Customers</a>
        <a href="items"><i class="fas fa-box"></i> Items</a>
        <a href="help.html"><i class="fas fa-question-circle"></i> Help</a>
        <a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</nav>

<!-- Main Content -->
<div class="container">
    <div class="welcome-card">
        <h1>Welcome, <%= username %>!</h1>
        <p>Manage your customers, items, and billing efficiently using the dashboard below.</p>
    </div>

    <!-- Dashboard Cards -->
    <div class="dashboard-grid">
        <a href="customers" class="dash-card">
            <i class="fas fa-users"></i>
            <span>Manage Customers</span>
        </a>
        <a href="items" class="dash-card">
            <i class="fas fa-box"></i>
            <span>Manage Items</span>
        </a>
        <a href="help.html" class="dash-card">
            <i class="fas fa-question-circle"></i>
            <span>Help & Support</span>
        </a>
        <a href="logout" class="dash-card">
            <i class="fas fa-sign-out-alt"></i>
            <span>Logout</span>
        </a>
    </div>
</div>

</body>
</html>
