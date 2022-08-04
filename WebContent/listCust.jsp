<html>
<head>
<title>Customer List</title>
<%@ include file="jdbc.jsp" %>
<link rel="stylesheet" href="styles.css">
<%@ include file="header.jsp" %>

</head>
<body>
  <div class="content">
      <%
      try {
          getConnection();
          String sql = "SELECT customerId, firstName, lastName, email, phonenum, address, city, state, postalCode, country, userId FROM customer";
          PreparedStatement pstmt = con.prepareStatement(sql);
          ResultSet rst = pstmt.executeQuery();

          out.println("<table><tr><td class='tableheader'>Customer Id</td><td class='tableheader'>First Name</td><td class='tableheader'>Last Name</td><td class='tableheader'>Email</td><td class='tableheader'>Phone Number</td><td class='tableheader'>Address</td><td class='tableheader'>City</td><td class='tableheader'>State</td><td class='tableheader'>Postal Code</td><td class='tableheader'>Country</td><td class='tableheader'>Username</td></tr>");

          while(rst.next()){
            out.println("<tr>");
            for(int i = 1; i<12; i++) {
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
