<html>
<head>
<title>Order List</title>
<%@ include file="jdbc.jsp" %>
<link rel="stylesheet" href="styles.css">
<%@ include file="header.jsp" %>

</head>
<body>
  <div class="content">
      <%
      try {
          getConnection();
          String sql = "SELECT orderId, customerId, totalAmount FROM ordersummary";
          PreparedStatement pstmt = con.prepareStatement(sql);
          ResultSet rst = pstmt.executeQuery();

          out.println("<table><tr><td class='tableheader'>Order Id</td><td class='tableheader'>Customer ID</td><td class='tableheader'>Total Amount</td></tr>");

          while(rst.next()){
            out.println("<tr>");
            for(int i = 1; i<4; i++) {
                out.println("<td>"+rst.getString(i)+"</td>");
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