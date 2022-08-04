<html>
<head>
<title>Product Creation</title>
<%@ include file="jdbc.jsp" %>
<link rel="stylesheet" href="styles.css">

</head>
<body>
    <%
    if (request.getMethod().equals("GET")) {
        %>
    <form action="createreview.jsp" method="POST">
        <label for="rrating">Rating:</label>
        <input type="text" id="rrating" name="rrating" size=1 maxlength="1"><br><br>
    
        <label for="pdesc">Product description:</label>
        <input type="text" id="pdesc" name="pdesc"><br><br>
    
        <input type="submit" value="Submit">
        <input type="hidden" id="prodId" name="prodId" value='<%=request.getParameter("prodId") %>'>
      </form>
    <% 
    } else {
	    String userName = (String) session.getAttribute("authenticatedUser");
      try {
          getConnection();
          String sql = "INSERT INTO review(reviewRating, reviewDate, customerId, productId, reviewComment) VALUES (?, (SELECT GETDATE()), ?, ?, ?)";
          PreparedStatement pstmt = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);

          String sql2 = "SELECT customerId FROM Customer C  WHERE userId = ?";
          PreparedStatement pstmt2 = con.prepareStatement(sql2);
		    pstmt2.setString(1, userName);
            ResultSet rst = pstmt2.executeQuery();
            rst.next();
            int custId = rst.getInt("customerId");
          
          pstmt.setInt(1, Integer.parseInt(request.getParameter("rrating")));
          // pstmt.setDate(2, java.sql.Date.getCurrentDatetime());
          pstmt.setInt(2, custId);
          pstmt.setInt(3, Integer.parseInt(request.getParameter("prodId")));
          pstmt.setString(4, request.getParameter("pdesc"));
          pstmt.executeUpdate();

          out.print("Review has been created!");
      } finally {
          closeConnection();
          System.out.println("Connection has closed");
      }
      response.sendRedirect("product.jsp?id="+Integer.parseInt(request.getParameter("prodId")));
    }
      %>

      <form action="listprod.jsp">
        <input type="submit" value="Continue Shopping">
      </form>
      
</body>
</html>
