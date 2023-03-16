<%@page import="uuu.ksc.entity.Customer"%>
<%@page import="uuu.ksc.entity.CartItem"%>
<%@page import="uuu.ksc.entity.shoppingCart"%>
<%@ page pageEncoding="UTF-8"%>
<html>
    <head>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/index.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>sally's collection_cart</title>
        <script src="https://kit.fontawesome.com/e3d7510046.js"></script>
        <script src="https://code.jquery.com/jquery-3.0.0.js" integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" crossorigin="anonymous"></script>
		<script>
		$(document).ready(function(){
		  $("#memberName").click(function(){
		   /*  $(".sidebar").toggle(); */
		  $(".sidebar").slideToggle();
		   
		  });
		});
</script>
		<style>
		.sidebar{top: 80px;}
        article{
        margin:200px auto;
        }
        #cart {
				  font-family: Arial, Helvetica, sans-serif;
				  border-collapse: collapse;
				  width: 80%;
				  margin: auto;
				  background-color: white;
				}
				
				#cart td, #cart th {
				  border: 1px solid #ddd;
				  padding: 8px;
				}
				
				#cart tr:nth-child(even){background-color: #f2f2f2;}
				
				#cart tr:hover {background-color: #ddd;}
				
				#cart tbody img{width:56px;vertical-align: middle;}
				#cart tbody input.quantity{width:2.5em}
				
				#cart caption{
				  padding-top: 12px;
				  padding-bottom: 12px;				  
				  background-color: #462e25;
				  color: white;
				}
				
				#cart th{
				  padding-top: 12px;
				  padding-bottom: 12px;				  
				  background-color: #af3c15;
				  color: white;
				}
				
				#cart tfoot td{text-align: right}
        </style>    
    </head>
    <body>     
    <header>
		<jsp:include page="/subviews/header.jsp" />  
	    <jsp:include page="/subviews/nav.jsp" />
	</header>	  
        <article>
        <% 
        shoppingCart cart = (shoppingCart)session.getAttribute("cart");
        
        Customer member = (Customer)session.getAttribute("member");
        if(cart!=null && member!=null){
        	cart.setMember(member);
        }
        %>
<%--         <%= cart %> --%>
<% if(cart ==null || cart.isEmpty()){ %>
<p>購物車是空的!</p>
<%}else{  %>
<form action='update_cart.do' method ='POST'><!-- http://localhost:8080/ksc/member/update_cart.do -->
			<table id='cart'>
				<caption>購物明細</caption>
				<thead>
					<tr>
					<th>名稱</th>
					<th>顏色/Size</th>
					<th>價格</th>
					<th>數量</th>
					<th>小計</th>
					<th>刪除</th>
					</tr>
				</thead>
				<tbody>	
					<% /* ProductService pservice = new ProductService(); */
					for(CartItem cartItem:cart.getCartItemSet()){
					/* int stock=pService.getStock(cartItem); */
					%>
					<tr>				
						<td>
							<img src='<%= request.getContextPath() %>/<%= cartItem.getPhotourl() %>'>
							<%= cartItem.getProductName() %>
						</td>
						<td><%= cartItem.getColorName() %><%= cartItem.getSizeName() %></td>
						<td>
							定價:<%= cart.getListPrice(cartItem) %>元<br>
							<%= cart.getDiscountString(cartItem) %>
							優惠價:<%= cart.getUnitPrice(cartItem) %>元
						</td>
						<td><input type ='number'class='quantity' name = 'quantity<%= cartItem.hashCode() %>' required max='<%= cartItem.getStock()%>' value='<%= cart.getQuantity(cartItem)%>'>
						<span style='font-size=:smaller'>庫存剩下：<%=cartItem.getStock() %> </span>
						</td>
						<td><%= cart.getAmount(cartItem) %></td>
						<td ><input type ='checkbox' name='delete<%= cartItem.hashCode() %>'></td>
					</tr>
					<% }%>												
				</tbody>
				<tfoot>
					<tr>
						<td colspan="4">
							共<%=cart.size() %>項, <%=cart.getTotalQuantity() %>件
						</td>
						<td colspan="2">
							總計: <%=cart.getTotalAmount() %>元
						</td>
					</tr>
					<tr>
					<td  colspan="6">
						<input type='submit' value='修改購物車'>
						<button type='submit' name='submit' value='checkOut'>我要結帳</button>
					</td>
					</tr>
				</tfoot>
			</table>
</form>
			<% } %>
		</article>
       <%@ include file="/subviews/footer.jsp" %>
   
    </body>
</html>





