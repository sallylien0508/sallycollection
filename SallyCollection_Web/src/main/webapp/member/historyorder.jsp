<%@page import="uuu.ksc.service.OrderService"%>
<%@page import="uuu.ksc.entity.Order"%>
<%@page import="java.util.List"%>
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
        	Customer member = (Customer)session.getAttribute("member");
			List<Order> list = null;
			if(member!=null){
				OrderService oService = new OrderService();
				list = oService.getOrdersHistory(member);
			}
		%>
			<table id='cart'>
		<% if(list==null || list.isEmpty()){%>查無歷史訂單<%}else{ %>	
				<caption>歷史清單</caption>
				<thead>
					<tr>
					<th>訂單編號</th>
					<th>訂購日期</th>
					<th>付款方式</th>
					<th>訂單狀態</th>
					<th>訂單金額</th>
					</tr>
				</thead>
				<% for(Order order:list) {%>
				<tbody>	
					<tr>
			 	<td><a href='order.jsp?orderId=<%= order.getId() %>'><%= order.getIdString() %></a></td>
						<td><%= order.getOrderDate() %> <%= order.getOrderTime() %></td>
						<td><%= order.getPaymentType() %>/<%= order.getShippingType() %></td>
						<td>未付款</td>
				 		<td><%= order.getTotalAmountWithFee() %></td> 
					</tr>										
				</tbody>
				<% } %>
			</table>
				<% } %>
		</article>
       <%@ include file="/subviews/footer.jsp" %>
   
    </body>
</html>





