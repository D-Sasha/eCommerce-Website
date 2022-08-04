<%@ page import="java.sql.*" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Iterator" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.Map" %>
<%@ page import="java.util.Date" %>
<%@ include file="jdbc.jsp" %>

<html>
<head>
<title>YOUR NAME Grocery Shipment Processing</title>
<link rel="stylesheet" href="styles.css">
</head>
<body>
        
<%@ include file="header.jsp" %>

<%
try{
    getConnection();
    Statement stmt = con.createStatement(); 
    // TODO: Get order id
    String orderId = request.getParameter("orderId");

    // TODO: Check if valid order id
    int ordId = -1;
        try{
            ordId = Integer.parseInt(orderId);
        }
        catch(Exception e){
            out.println("Order id: " + orderId + " is invalid.");
        }
    
    // TODO: Start a transaction (turn-off auto-commit)
    con.setAutoCommit(false);

    // TODO: Retrieve all items in order with given id
    String SQL = "SELECT * FROM orderproduct WHERE orderId = ?";
    PreparedStatement retrieve_items = con.prepareStatement(SQL);
    retrieve_items.setInt(1, ordId);
    ResultSet rst = retrieve_items.executeQuery();
    String SQL1 = "INSERT INTO shipment (shipmentDate, warehouseId) VALUES (?, 1)";
    PreparedStatement new_shipment = con.prepareStatement(SQL1);
    boolean success = true;
    int productId = -1;
    int productQuantity = -1;

    while(rst.next()){
        productId = rst.getInt("productId");
        productQuantity = rst.getInt("quantity");

        // TODO: Create a new shipment record.
        java.util.Date Date = new java.util.Date();
        java.sql.Date sqlDate = new java.sql.Date(Date.getTime());
        new_shipment.setDate(1,sqlDate);
        new_shipment.executeUpdate();

        // TODO: For each item verify sufficient quantity available in warehouse 1.
    	String SQL2 = "SELECT quantity FROM productinventory WHERE warehouseId = 1 AND productId = ?";
    	PreparedStatement verify_quantity = con.prepareStatement(SQL2);
    	verify_quantity.setInt(1, productId);
    	ResultSet verify_rst = verify_quantity.executeQuery();
    	int inventory_quantity = 0;
    	if(verify_rst.next())
        	inventory_quantity = verify_rst.getInt("quantity");
    
    	if(inventory_quantity>=productQuantity){
			int new_inventory_quantity = inventory_quantity-productQuantity;
			String SQL3 = "UPDATE productinventory SET quantity = ? WHERE productId = ? AND warehouseId = 1";
			PreparedStatement update_inventory = con.prepareStatement(SQL3);
			update_inventory.setInt(1,new_inventory_quantity);
			update_inventory.setInt(2,productId);
			update_inventory.executeUpdate();

			out.println("<h3>Ordered product id: "+ productId + "<br>Product quantity: " + productQuantity);
			ResultSet rst_quantity = stmt.executeQuery("SELECT quantity FROM productinventory WHERE productId = "+productId+" AND warehouseId = 1");
			rst_quantity.next();
			int new_quantity = rst_quantity.getInt("quantity");
        	out.print("<br>Previous inventory: "+ inventory_quantity);
        	out.println("<span class='tab'> New inventory: " + new_inventory_quantity + "</span></h3>");
    	}else{
        	// TODO: If any item does not have sufficient inventory, cancel transaction and rollback. Otherwise, update inventory for each item.
        	success = false;
        	break;
    	}
	}

    if(success){
        con.commit();
        out.println("<h2>Shipment successfully processed.</h2>");
    }
    else{
        con.rollback();
        out.println("<h2>Shipment not done. <br> <h3>Insufficient inventory for product id: "+productId+"</h3></h2>");
    }

    
    // TODO: Auto-commit should be turned back on
    con.setAutoCommit(true);
}catch(SQLException e){
	out.println(e); 
	con.rollback();
}finally{
    closeConnection();
}
%>                                      

<h2><a href="shop.html">Back to Main Page</a></h2>

</body>
</html>