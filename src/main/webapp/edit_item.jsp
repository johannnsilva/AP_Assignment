<%@ page import="com.pahanaedu.model.Item" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.html");
        return;
    }
    Item item = (Item) request.getAttribute("item");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Edit Item</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
  /* Reset & base */
  * { margin: 0; padding: 0; box-sizing: border-box; font-family: 'Poppins', sans-serif; }
  body { background: #e0e5ec; color: #333; min-height: 100vh; display: flex; flex-direction: column; }

  /* Navbar */
  nav {
      display: flex;
      justify-content: center;
      gap: 20px;
      padding: 15px 30px;
      background: #1e1e2f;
      box-shadow: 0 5px 15px rgba(0,0,0,0.2);
      border-radius: 10px;
      margin-bottom: 40px;
  }
  nav a {
      color: #fff;
      text-decoration: none;
      font-weight: 500;
      display: inline-flex;
      align-items: center;
      gap: 6px;
      padding: 8px 14px;
      border-radius: 8px;
      transition: 0.3s;
  }
  nav a:hover { background: #ffd700; color: #1e1e2f; }

  /* new Container & card */
  .container { flex: 1; display: flex; justify-content: center; align-items: center; padding: 40px 20px; }
  .card {
      background: #e0e5ec;
      padding: 40px 30px;
      border-radius: 25px;
      box-shadow: 20px 20px 60px #bebebe, -20px -20px 60px #ffffff;
      width: 100%;
      max-width: 500px;
      transition: transform 0.3s ease;
  }
  .card:hover { transform: translateY(-5px); }

  h1 {
      text-align: center;
      margin-bottom: 30px;
      font-size: 2rem;
      color: #1e1e2f;
  }

  /* new Form */
  form { display: flex; flex-direction: column; gap: 20px; }
  .form-row { display: flex; flex-direction: column; }
  label { margin-bottom: 8px; font-weight: 600; color: #555; }
  input[type="text"], input[type="number"] {
      padding: 14px 16px;
      border-radius: 15px;
      border: none;
      background: #e0e5ec;
      box-shadow: inset 5px 5px 10px #bebebe, inset -5px -5px 10px #ffffff;
      font-size: 15px;
      transition: all 0.3s ease;
  }
  input:focus { outline: none; box-shadow: inset 3px 3px 6px #bebebe, inset -3px -3px 6px #ffffff, 0 0 8px #2575fc; }

  /*new  Submit button */
  .btn {
      padding: 14px 0;
      border: none;
      border-radius: 25px;
      background: linear-gradient(135deg, #6a11cb, #2575fc);
      color: #fff;
      font-size: 1.1rem;
      font-weight: 600;
      cursor: pointer;
      transition: 0.3s;
      box-shadow: 5px 5px 15px rgba(0,0,0,0.2);
  }
  .btn:hover { transform: translateY(-3px); box-shadow: 8px 8px 20px rgba(0,0,0,0.25); }

  @media (max-width: 600px) {
      .card { padding: 30px 20px; }
      h1 { font-size: 1.6rem; }
      nav { flex-direction: column; gap: 15px; padding: 15px; }
  }
   /*new itemcard */
</style>
</head>
<body>

<div class="container">
    <div class="card">
        <nav>
            <a href="dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
            <a href="items"><i class="fas fa-box"></i> Manage Items</a>
            <a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
        </nav>

        <h1>Edit Item</h1>
        <form method="post" action="editItem">
            <input type="hidden" name="item_id" value="<%= item.getItemId() %>">

            <div class="form-row">
                <label>Item Code</label>
                <input type="text" name="item_code" value="<%= item.getItemCode() %>" required>
            </div>
            <div class="form-row">
                <label>Name</label>
                <input type="text" name="name" value="<%= item.getName() %>" required>
            </div>
            <div class="form-row">
                <label>Price</label>
                <input type="number" step="0.01" name="price" value="<%= item.getPrice() %>" required>
            </div>
            <button class="btn" type="submit">Save Changes</button>
        </form>
    </div>
</div>

</body>
</html>
