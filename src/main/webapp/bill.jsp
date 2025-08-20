<%@ page import="com.pahanaedu.model.Customer" %>
<%
  if (session.getAttribute("username") == null) { 
      response.sendRedirect("login.html"); 
      return; 
  }
  Customer c = (Customer) request.getAttribute("customer");
  String billAccount = request.getAttribute("billAccount") != null ? request.getAttribute("billAccount").toString() : null;
  String customerName = request.getAttribute("customerName") != null ? request.getAttribute("customerName").toString() : "N/A";
%>
<!doctype html>
<html>
<head>
<meta charset="utf-8">
<title>Bill</title>
<style>
  * { margin:0; padding:0; box-sizing:border-box; font-family: "Inter", sans-serif; }
  body {
    background: linear-gradient(135deg,#1f4037 0%,#99f2c8 100%);
    min-height:100vh;
    color:#fff;
    display:flex;
    flex-direction:column;
  }

  /* new bill Navbar */
  nav {
    backdrop-filter: blur(12px);
    background: rgba(255,255,255,0.1);
    padding:18px 30px;
    display:flex;
    gap:25px;
    align-items:center;
    border-bottom:1px solid rgba(255,255,255,0.25);
    box-shadow:0 4px 20px rgba(0,0,0,0.25);
  }
  nav a {
    color:#fff;
    text-decoration:none;
    font-weight:500;
    transition:opacity .3s;
  }
  nav a:hover { opacity:.7; }
  nav a:last-child { margin-left:auto; color:#ff6b6b; font-weight:600; }

  /* new billContainer */
  .container {
    flex-grow:1;
    display:flex;
    justify-content:center;
    align-items:flex-start;
    padding:50px 20px;
  }
  .card {
    background: rgba(255,255,255,0.15);
    backdrop-filter: blur(18px);
    border:1px solid rgba(255,255,255,0.3);
    padding:40px 35px;
    border-radius:20px;
    max-width:700px;
    width:100%;
    box-shadow:0 15px 40px rgba(0,0,0,0.25);
    color:#fff;
  }

  h1,h2,h3 {
    text-align:center;
    margin-bottom:25px;
    background:linear-gradient(45deg,#fff,#c8fff4);
    -webkit-background-clip:text;
    -webkit-text-fill-color:transparent;
  }

  /* Form */
  form { display:flex; flex-direction:column; gap:20px; }
  .form-row { display:flex; flex-direction:column; }
  label { margin-bottom:6px; font-weight:500; opacity:.9; }
  input,select {
    padding:12px 14px;
    border-radius:10px;
    border:none;
    outline:none;
    background:rgba(255,255,255,0.25);
    color:#fff;
    font-size:1rem;
    transition:all .3s;
  }
  input[readonly] { opacity:.7; cursor:not-allowed; }
  input:focus,select:focus { background:rgba(255,255,255,0.35); box-shadow:0 0 0 2px #fff; }
  option { color:#222; }

  .btn {
    background:linear-gradient(135deg,#ff512f,#dd2476);
    border:none;
    border-radius:12px;
    padding:14px 0;
    font-size:1.1rem;
    font-weight:600;
    color:#fff;
    cursor:pointer;
    transition:transform .2s,box-shadow .2s;
  }
  .btn:hover { transform:translateY(-2px); box-shadow:0 6px 18px rgba(0,0,0,0.25); }

  /* Printable bill */
  #printable {
    background:#fff;
    color:#000;
    padding:35px 40px;
    border-radius:18px;
    box-shadow:0 10px 30px rgba(0,0,0,0.2);
    margin-top:20px;
  }
  #printable .company-header { text-align:center; margin-bottom:30px; }
  #printable h2 { color:#185a9d; margin-bottom:8px; }
  #printable p { color:#555; margin:4px 0; }

  table { width:100%; border-collapse:collapse; margin-top:20px; }
  th,td { border:1px solid #ccc; padding:12px 16px; font-size:16px; }
  th { background:#f3f7ff; color:#185a9d; }
  .total-row td { font-weight:700; background:#eef4ff; }
  .thankyou { text-align:center; margin-top:30px; font-weight:600; color:#333; }

  /* Print mode */
  @media print {
    body * { visibility:hidden; }
    #printable,#printable * { visibility:visible; }
    #printable { position:absolute; top:0; left:0; width:100%; box-shadow:none; border-radius:0; }
  }
</style>
</head>
<body>
  <nav>
    <a href="dashboard.jsp">Dashboard</a>
    <a href="customers">Customers</a>
    <a href="logout">Logout</a>
  </nav>

  <div class="container">
    <div class="card">
      <h1>Generate Bill</h1>

      <% if (c != null) { %>
        <h3>Customer: <%= c.getName() %> (Acc: <%= c.getAccountNo() %>)</h3>

        <form method="post" action="calculateBill">
          <input type="hidden" name="account_no" value="<%= c.getAccountNo() %>">

          <div class="form-row">
            <label for="units">Units</label>
            <input type="number" id="units" name="units" value="<%= c.getUnitsConsumed() %>" min="0" required>
          </div>

          <div class="form-row">
            <label for="itemSelect">Select Item</label>
            <select id="itemSelect" name="item_id" required>
              <option value="">-- Select Item --</option>
              <%
                com.pahanaedu.dao.ItemDAO itemDAO = new com.pahanaedu.dao.ItemDAO();
                java.util.List<com.pahanaedu.model.Item> items = itemDAO.findAll();
                for (com.pahanaedu.model.Item item : items) {
              %>
                <option value="<%= item.getItemId() %>" data-price="<%= item.getPrice() %>">
                  <%= item.getName() %> - Rs.<%= String.format("%.2f", item.getPrice()) %>
                </option>
              <% } %>
            </select>
          </div>

          <div class="form-row">
            <label for="unit_price">Unit Price (Rs.)</label>
            <input type="number" step="0.01" id="unit_price" name="unit_price" value="0.00" readonly required>
          </div>

          <div class="form-row">
            <label for="total">Total Amount (Rs.)</label>
            <input type="number" step="0.01" id="total" name="total" value="0.00" readonly>
          </div>

          <button class="btn" type="submit">Calculate & Print</button>
        </form>

      <% } else if (billAccount != null) { %>

        <div id="printable">
          <div class="company-header">
            <h2>Pahana Edu Power Ltd.</h2>
            <p>No. 123, Main Street, Colombo</p>
            <p>Tel: +94 11 1234567 | Email: info@pahanaedu.lk</p>
            <hr>
          </div>

          <h2>Bill</h2>

          <table>
            <thead>
              <tr>
                <th>Description</th>
                <th>Units</th>
                <th>Unit Price (Rs.)</th>
                <th>Amount (Rs.)</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <td>Electricity Consumption</td>
                <td><%= request.getAttribute("units") %></td>
                <td><%= request.getAttribute("unitPrice") %></td>
                <td><%= request.getAttribute("total") %></td>
              </tr>
              <tr class="total-row">
                <td colspan="3" style="text-align:right">Total</td>
                <td><%= request.getAttribute("total") %></td>
              </tr>
            </tbody>
          </table>

          <p class="thankyou">Thank you for your payment!</p>
        </div>

        <button class="btn" onclick="window.print()">Print</button>

      <% } else { %>
        <p style="text-align:center; font-size:18px; color:#ddd;">No customer selected.</p>
      <% } %>
    </div>
  </div>

  <script>
    const itemSelect = document.getElementById('itemSelect');
    const unitPriceInput = document.getElementById('unit_price');
    const unitsInput = document.getElementById('units');
    const totalInput = document.getElementById('total');

    function calculateTotal() {
      const units = parseFloat(unitsInput.value) || 0;
      const price = parseFloat(unitPriceInput.value) || 0;
      totalInput.value = (units * price).toFixed(2);
    }

    if(itemSelect){
      itemSelect.addEventListener('change', function() {
        const price = this.options[this.selectedIndex].getAttribute('data-price');
        unitPriceInput.value = price || "0.00";
        calculateTotal();
      });
    }
    if(unitsInput){ unitsInput.addEventListener('input', calculateTotal); }
  </script>
</body>
</html>
