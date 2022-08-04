<html>
<head>
<title>User Account Creation</title>
<link rel="stylesheet" href="styles.css">
<%@ include file="jdbc.jsp" %>
<%@ include file="usercreate.html" %>

</head>
<body>
      <%
      try {
          getConnection();
          String sql = "INSERT INTO customer(firstName, lastName, email, phonenum, address, city, state, postalCode, country, userid, password)" + 
          " VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
          PreparedStatement stmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
          
          stmt.setString(1, request.getParameter("fname"));
          stmt.setString(2, request.getParameter("lname"));
          stmt.setString(3, request.getParameter("email"));
          stmt.setString(4, request.getParameter("pnum"));
          stmt.setString(5, request.getParameter("addy"));
          stmt.setString(6, request.getParameter("city"));
          stmt.setString(7, request.getParameter("st"));
          stmt.setString(8, request.getParameter("pcode"));
          stmt.setString(9, request.getParameter("ctry"));
          stmt.setString(10, request.getParameter("id"));
          stmt.setString(11, request.getParameter("pss"));
          int test = stmt.executeUpdate();
          System.out.println(test);

          out.print("User Account has been created!");
      } finally {
          closeConnection();
          System.out.println("Connection has closed");
      }
      %>

      <form action="admin.jsp">
        <input type="submit" value="Return to Admin">
      </form>
      
</body>
</html>

