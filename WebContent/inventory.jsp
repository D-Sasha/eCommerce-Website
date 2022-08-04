<html>
<head>
<title>Inventory</title>
<%@ include file="jdbc.jsp" %>
<link rel="stylesheet" href="styles.css">
<%@ include file="header.jsp" %>

</head>
<body>
  <div class="content">
    <% 
    try {
      getConnection();
      String sql = "SELECT productId, quantity FROM productinventory WHERE warehouseId = ?";
      PreparedStatement stmt = con.prepareStatement(sql);
      stmt.setInt(1, Integer.parseInt(request.getParameter("wid")));          
      ResultSet rst = stmt.executeQuery();
      out.println("<table><tr><td class='tableheader'>Product ID</td><td class='tableheader'>Inventory</td></tr>");

      while(rst.next()){
        out.println("<tr>");
        for(int i = 1; i<3; i++) {
            out.println("<td>" +rst.getString(i)+ "</td>");
        }
        out.println("</tr>");
    }
    out.println("</table><br>");

  } finally {
      closeConnection();
      System.out.println("Connection has closed");
  }

    %>
    
      <form action="admin.jsp">
        <input type="submit" value="Return to Admin">
      </form>
    </div>
</body>
</html>
