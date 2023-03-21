<%@page import="java.util.List"%>
<%@page import="uuu.ksc.entity.Order"%>
<%@page import="uuu.ksc.entity.OrderItem"%>
<%@page import="uuu.ksc.service.OrderService"%>
<%@page import="uuu.ksc.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
        <link rel="stylesheet" href="<%= request.getContextPath() %>/index.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>sally's collection</title>
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
td{width: 20%;}
.shipping-progress {
  display: flex;
  justify-content: space-evenly;
  padding-top: 2%;
}

.step {
  display: flex;
  flex-direction: column;
  align-items: center;
  margin-right: 20px;
}

.circle {
  width: 30px;
  height: 30px;
  border-radius: 50%;
  background-color: #ccc;
  color: white;
  display: flex;
  justify-content: center;
  align-items: center;
  font-size: 18px;
  font-weight: bold;
  margin-bottom: 10px;
}

.active .circle {
  background-color: blue;
}

.label {
  text-align: center;
  font-size: 14px;
}

</style>
	</head>

    
<body>

   <jsp:include page="/subviews/header.jsp" />  
   <jsp:include page="/subviews/nav.jsp" />
<div style="background-color:white;width: 80%; margin: 150px auto;">
<%-- 	<div>${requestScope.theOrder}</div>		 --%>
<%
    		Customer member = (Customer)session.getAttribute("member");		
			Order order = (Order)request.getAttribute("theOrder");
			String orderId;
			if(order!=null){
				orderId = String.valueOf(order.getId());
			}else{
				orderId = request.getParameter("orderId");
			}
		%>
		<% if(order==null) {%>
		<%}else{ %>	
	 <div class="shipping-progress">
	  		<div class="step active">
	    	<div class="circle">1</div>
	    	<div class="label">下單</div>
			</div>
		  <div class="step">
		    <div class="circle">2</div>
		    <div class="label">出貨</div>
		  </div>
		  <div class="step">
		    <div class="circle">3</div>
		    <div class="label">運送</div>
		  </div>
		  <div class="step">
		    <div class="circle">4</div>
		    <div class="label">抵達</div>
		  </div>
		</div>
	<hr>
    <p style="text-align: center;font-size: 30px;color: #0b0b53;">
    訂單資料
    </p>
    <div style="display: flex;justify-content: space-evenly;">
    	<div>
    		<p>訂單日期</p>    	
    		<p>訂單編號</p>		
    		<p>寄送方式</p>   	
    		<p>付款方式</p>
    		<p>出貨狀態</p>
    		
    	</div>
    	<div>
    		<p><%= order.getOrderDate() %> <%= order.getOrderTime() %></p>
	    	<p><%= order.getIdString() %></p>
	    	<p><%= order.getShippingType() %></p>
	    	<p><%= order.getPaymentType() %></p>
	    	<p><%= (order.getStatus() == 0) ? "待出貨" : "出貨中" %></p>
    	</div>
		<div>
			<p>產品價格</p>
	    	<p>付款手續費</p>
	    	<p>運費</p>
	    	<p>總計</p>
		</div>
	    <div>
	       	<p><span id='totalAmount'><%= order.getTotalAmount() %></span>元</p>
	    	<p><%= order.getPaymentFee() %> 元</p>
	    	<p><%= order.getShippingFee() %>元</p>
	    	<p><%= order.getTotalAmountWithFee() %></p>
	 
		</div>
    </div>
    <hr>
     <p style="text-align: center;font-size: 30px;color: #0b0b53;">
    收件人資料
    </p>
	    <div style="display:flex;justify-content: space-evenly;">
	    <div>
			<p>姓名: <%= order.getRecipientName() %></p>
			<p>Email: <%= order.getRecipientEmail() %></p>
		</div>
		<div>
			<p>電話: <%= order.getRecipientPhone() %></p>	
			<p>地址: <%= order.getShippingAddress() %></p> 
		</div>
	</div>
	<hr>
    <p style="text-align: center;font-size: 30px;color: #0b0b53;">
    訂單明細
    </p>
<table style="width: 80%;text-align: center;margin: 0 auto;">
<thead>
    <tr>
	    <th>產品</th>
	    <th>顏色</th>
	    <th>尺寸</th>
	    <th>價格/1件</th>
	    <th>數量</th>
	    <th>小計</th>
    </tr>
<thead>
<tbody>
<% for(OrderItem orderItem:order.getOrderItemSet()) {%>
	<tr> 
		<td>
		 	 <span><%= orderItem.getProductName() %>	</span><br>
	   		 <img alt="" src='<%= request.getContextPath() %>/<%= orderItem.getPhotoURL()%>' style="width:50%">
	    </td>
	    	<td><%= orderItem.getColorName()%></td>
	    	<td><%= orderItem.getSize()%></td>
			<td><%= orderItem.getPrice()%>元</td>
			<td><%= orderItem.getQuantity()%></td>
			<td><%= orderItem.getAmount()%>元</td>
	</tr>
	<% } %>		
</tbody>
</table>

</div>
	<% } %>	
<%@ include file="/subviews/footer.jsp" %>
</body>
</html> 