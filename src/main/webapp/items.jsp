<%@ page import="java.util.*, com.pahanaedu.model.Item" %>
<%
    if (session.getAttribute("username") == null) {
        response.sendRedirect("login.html");
        return;
    }
    List<Item> items = (List<Item>) request.getAttribute("items");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8" />
<title>Manage Items</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
<style>
  * { box-sizing: border-box; margin: 0; padding: 0; font-family: 'Poppins', sans-serif; }
  body {
    background: linear-gradient(135deg, #6a11cb, #2575fc);
    min-height: 100vh;
    display: flex;
    justify-content: center;
    align-items: flex-start;
    padding: 40px 20px;
    color: #fff;
  }

  .container {
    width: 100%;
    max-width: 950px;
    background: rgba(255,255,255,0.1);
    backdrop-filter: blur(15px);
    border-radius: 20px;
    padding: 40px;
    box-shadow: 0 15px 40px rgba(0,0,0,0.25);
  }

  nav {
    display: flex;
    justify-content: flex-end;
    gap: 20px;
    margin-bottom: 30px;
  }
  nav a {
    color: #fff;
    text-decoration: none;
    font-weight: 500;
    padding: 10px 18px;
    border-radius: 12px;
    background: rgba(255,255,255,0.15);
    transition: all 0.3s ease;
  }
  nav a:hover {
    background: rgba(255,255,255,0.3);
    transform: translateY(-2px);
  }

  h1 {
    text-align: center;
    font-size: 2.5rem;
    margin-bottom: 30px;
    color: #ffd700;
    text-shadow: 0 2px 6px rgba(0,0,0,0.3);
  }

  table {
    width: 100%;
    border-collapse: separate;
    border-spacing: 0;
    font-size: 1rem;
  }
  th, td {
    text-align: left;
    padding: 14px 18px;
  }
  th {
    background: rgba(255,255,255,0.2);
    color: #ffd700;
    font-weight: 600;
  }
  tbody tr {
    background: rgba(255,255,255,0.05);
    border-radius: 12px;
    margin-bottom: 10px;
    display: table-row;
  }
  tbody tr:hover {
    background: rgba(255,255,255,0.15);
  }
  td a {
    display: inline-block;
    margin-right: 12px;
    padding: 6px 12px;
    border-radius: 8px;
    font-weight: 600;
    color: #fff;
    background: #4a6cf7;
    text-decoration: none;
    transition: all 0.3s;
  }
  td a:hover {
    background: #3a57d6;
    transform: translateY(-2px);
  }

  /* Responsive Table */
  @media (max-width: 700px) {
    table, thead, tbody, th, td, tr { display: block; }
    thead { display: none; }
    tr { margin-bottom: 20px; background: rgba(255,255,255,0.1); border-radius: 12px; padding: 15px; }
    td {
      text-align: right;
      padding-left: 50%;
      position: relative;
    }
    td::before {
      position: absolute;
      left: 18px;
      top: 14px;
      font-weight: 600;
      text-align: left;
      color: #ffd700;
    }
    td:nth-of-type(1)::before { content: "Item Code"; }
    td:nth-of-type(2)::before { content: "Name"; }
    td:nth-of-type(3)::before { content: "Price"; }
    td:nth-of-type(4)::before { content: "Actions"; }
  }
</style>
</head>
<body>
<div class="container">
  <nav>
    <a href="dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
    <a href="add_item.html"><i class="fas fa-plus-circle"></i> Add Item</a>
    <a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
  </nav>

  <h1>Manage Items</h1>

  <table>
    <thead>
      <tr>
        <th>Item Code</th>
        <th>Name</th>
        <th>Price</th>
        <th>Actions</th>
      </tr>
    </thead>
    <tbody>
      <% if (items != null) {
           for (Item item : items) { %>
      <tr>
        <td><%= item.getItemCode() %></td>
        <td><%= item.getName() %></td>
        <td>Rs. <%= String.format("%.2f", item.getPrice()) %></td>
        <td>
          <a href="editItem?item_id=<%= item.getItemId() %>"><i class="fas fa-edit"></i> Edit</a>
          <a href="deleteItem?item_id=<%= item.getItemId() %>" onclick="return confirm('Delete this item?');"><i class="fas fa-trash-alt"></i> Delete</a>
        </td>
      </tr>
      <%   }
         } else { %>
      <tr><td colspan="4" style="text-align:center; color:#ffd700;">No items found</td></tr>
      <% } %>
    </tbody>
  </table>
</div>
</body>
</html>
