<%@ page import="java.util.*, com.pahanaedu.model.Customer" %>
<%
    if (session.getAttribute("username") == null) { 
        response.sendRedirect("login.html"); 
        return; 
    }
    List<Customer> customers = (List<Customer>) request.getAttribute("customers");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<title>Customer Management</title>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

<style>
    * { margin: 0; padding: 0; box-sizing: border-box; font-family: "Poppins", sans-serif; }
    body {
        background: #f4f6f9;
        color: #333;
        min-height: 100vh;
        display: flex;
        flex-direction: column;
    }

    /* Modern Navbar */
    nav {
        background: #1e1e2f;
        padding: 15px 30px;
        display: flex;
        justify-content: space-between;
        align-items: center;
        color: #fff;
        box-shadow: 0 3px 10px rgba(0,0,0,0.2);
    }
    nav .brand {
        font-size: 1.4rem;
        font-weight: 600;
        letter-spacing: 1px;
        color: #ffd700;
    }
    nav .links a {
        margin-left: 25px;
        color: #fff;
        text-decoration: none;
        font-size: 1rem;
        transition: 0.3s;
    }
    nav .links a:hover {
        color: #ffd700;
    }

    /* Page container */
    .container {
        flex: 1;
        padding: 30px;
    }

    h1 {
        font-size: 2rem;
        margin-bottom: 20px;
        color: #1e1e2f;
    }

    /* Customer Card Grid */
    .grid {
        display: grid;
        grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
        gap: 20px;
    }

    .card {
        background: #fff;
        border-radius: 15px;
        padding: 20px;
        box-shadow: 0 6px 18px rgba(0,0,0,0.1);
        transition: transform 0.2s ease, box-shadow 0.2s ease;
        position: relative;
        overflow: hidden;
    }
    .card:hover {
        transform: translateY(-5px);
        box-shadow: 0 10px 25px rgba(0,0,0,0.2);
    }
    .card h2 {
        font-size: 1.2rem;
        margin-bottom: 8px;
        color: #333;
    }
    .card p {
        font-size: 0.95rem;
        margin: 4px 0;
        color: #555;
    }

    /* Highlight Account No */
    .account-no {
        font-weight: bold;
        font-size: 0.95rem;
        color: #2575fc;
        margin-bottom: 8px;
        display: inline-block;
    }

    /* Buttons */
    .actions {
        margin-top: 15px;
    }
    .btn {
        display: inline-flex;
        align-items: center;
        gap: 6px;
        padding: 8px 14px;
        border-radius: 8px;
        font-size: 0.85rem;
        font-weight: 500;
        text-decoration: none;
        color: #fff;
        margin-right: 8px;
        transition: background 0.3s;
    }
    .btn-edit { background: #28a745; }
    .btn-edit:hover { background: #218838; }
    .btn-bill { background: #17a2b8; }
    .btn-bill:hover { background: #138496; }

    /* Responsive tweak */
    @media (max-width: 600px) {
        nav .brand { font-size: 1.1rem; }
        .btn { font-size: 0.8rem; padding: 6px 10px; }
    }
</style>
</head>
<body>

<!--update customer Navbar -->
<nav>
    <div class="brand"><i class="fas fa-bolt"></i> PowerBilling</div>
    <div class="links">
        <a href="dashboard.jsp"><i class="fas fa-home"></i> Dashboard</a>
        <a href="add_customer.html"><i class="fas fa-user-plus"></i> Add Customer</a>
        <a href="logout"><i class="fas fa-sign-out-alt"></i> Logout</a>
    </div>
</nav>

<!-- CustomerContent -->
<div class="container">
    <h1>Customer List</h1>
    <div class="grid">
        <% if (customers != null) {
             for (Customer c : customers) { %>
            <div class="card">
                <span class="account-no">Account No: <%= c.getAccountNo() %></span>
                <h2><i class="fas fa-user"></i> <%= c.getName() %></h2>
                <p><i class="fas fa-map-marker-alt"></i> <%= c.getAddress() %></p>
                <p><i class="fas fa-phone"></i> <%= c.getTelephone() %></p>
                <p><i class="fas fa-bolt"></i> Units: <%= c.getUnitsConsumed() %></p>
                <div class="actions">
                    <a class="btn btn-edit" href="editCustomer?account_no=<%= c.getAccountNo() %>">
                        <i class="fas fa-edit"></i> Edit
                    </a>
                    <a class="btn btn-bill" href="calculateBill?account_no=<%= c.getAccountNo() %>">
                        <i class="fas fa-file-invoice-dollar"></i> Bill
                    </a>
                </div>
            </div>
        <%   }
           } %>
    </div>
</div>

</body>
</html>
