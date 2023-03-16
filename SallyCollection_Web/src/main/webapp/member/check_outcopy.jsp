<%@page import="uuu.ksc.entity.ShippingType"%>
<%@page import="uuu.ksc.entity.PaymentType"%>
<%@page import="uuu.ksc.entity.Customer"%>
<%@page import="uuu.ksc.entity.CartItem"%>
<%@page import="uuu.ksc.entity.shoppingCart"%>
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
		article{ margin:200px auto;}
		</style>	

		<script>
			function paymentChanged(){
				calculateAmountWithFee();
			}
			
			function paymentChanged(){
				calculateAmountWithFee();				
			}
			
			function shippingChanged(){
				calculateAmountWithFee();
				changeShippingAddr();
			}
			
			function calculateAmountWithFee(){
				console.log($("select[name='paymentType'] option:selected").val(), 
							$("select[name='shippingType'] option:selected").val(),
							Number($("#totalAmount").text()));
				
				var selectedPaymentOption = $("select[name='paymentType'] option:selected");
				var selectedShippingOption = $("select[name='shippingType'] option:selected");
				var total = Number($("#totalAmount").text()); 
				if(selectedPaymentOption.val().length>0){
					if(selectedPaymentOption.attr("data-fee"))
						total+=Number(selectedPaymentOption.attr("data-fee"));
				}
				
				if(selectedShippingOption.val().length>0){
					if(selectedShippingOption.attr("data-fee"))
						total+=Number(selectedShippingOption.attr("data-fee"));
				}
				
				//alert(total);
				$("#totalAmountWithFee").text(total);
			}
			
			function changeShippingAddr(){
				
				var selectedShippingOption = $("select[name='shippingType'] option:selected");
				var theShippingAddr = $("input[name='shippingAddr']");
				
				theShippingAddr.prop("readonly", false);
				theShippingAddr.attr("autocomplete", "on");				
				theShippingAddr.removeAttr("list");
				$("#chooseStoreButton").hide();
				switch(selectedShippingOption.val()){				
				case 'STORE':
					theShippingAddr.prop("readonly", true);
					theShippingAddr.attr("placeholder", "請選擇超商");
					$("#chooseStoreButton").show();
					break;
				case 'SHOP':
					theShippingAddr.attr("list", "shopList");
					theShippingAddr.attr("placeholder", "請選擇門市");
					break;
				default:
					theShippingAddr.attr("placeholder", "請輸入宅配地址");					
				}
			}
			
			function copyMember(){
				$("input[name='name']").val("${sessionScope.member.name}");
				$("input[name='email']").val("${sessionScope.member.email}");
				$("input[name='phone']").val("${sessionScope.member.phone}");				
				
				var selectedShippingOption = $("select[name='shippingType'] option:selected");
				if(selectedShippingOption.val()=='HOME'){
					$("input[name='shippingAddr']").val("${sessionScope.member.address}");
				}
			}
		</script>
	</head>
	  <body>    
	  <div style="background: linear-gradient(to right, #dbd5d2ba 60%, #d9d9d9 60%,  #d9d9d9 60.1%,  #f5f5f5 60.1%);
		height: 100vh;
	    width: 100vw;
	    position: absolute;">
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
<form action='check_out_ok.jsp' method ='POST'><!-- http://localhost:8080/ksc/member/check_out.do -->
<div style="display:flex;justify-content: space-around;">	

		<div style="width: 50%;">
			<div>
				<fieldset style='width:95%; font-size: 30px;'>
					<legend>收件人資料(<a href='javascript:copyMember()'>複製訂購人</a>):</legend>
					<label>姓名:</label><input name='name' placeholder="請輸入收件人姓名" required><br>
					<label>email:</label><input name='email' placeholder="請輸入收件人Email" required><br>
					<label>電話:</label><input name='phone' placeholder="請輸入收件人電話" required><br>
					<label>取件地址:</label><input name='shippingAddr' placeholder="請輸入宅配地址" required><br>
					<input type='button' id='chooseStoreButton' value='選擇超商' style='display:none'>
					<datalist id="shopList">
						  <option value='台北旗艦店 復興北路99號1F'>台北旗艦店 復興北路99號1F</option>
						  <option value="新竹門市">新竹門市 新竹市東區光復路二段295號3樓之2</option>
						  <option value="台中門市">台中門市 台中市西區臺灣大道二段309號2樓</option>
						  <option value="高雄門市">高雄門市 高雄市前鎮區中山二路2號25樓</option>						  
					</datalist>
				</fieldset>
			</div>	
			<br>
			<div>
				<label style="font-size: 30px;">付款方式:</label>
				<select name='paymentType' required onchange='paymentChanged()' style=" width: 20%; padding: 2%;background-color: #c1a9a0; margin-right: 17%;">
					<option value=''>請選擇...</option>
					<% for(PaymentType pType: PaymentType.values()) {%>
					<option value='<%= pType.name() %>'data-fee='<%= pType.getFee() %>'><%= pType %></option>
					<%} %> 
					<!-- <option value='SHOP' >門市付款</option>
					<option value='ATM'>ATM轉帳</option>
					<option value='HOME' data-fee='50'>貨到付款, 50元</option>
					<option value='STORE' data-fee='65'>超商付款,65元</option>
					<option value='CARD'>信用卡</option> -->
				</select>
				<label style="font-size: 30px;">貨運方式:</label>
					<select name='shippingType' required onchange='shippingChanged()'  style=" width: 20%; padding: 2%;background-color: #c1a9a0;">
					<option value=''>請選擇...</option>
						<% for(ShippingType sType: ShippingType.values()) {%>
						<option value='<%= sType.name() %>' data-fee='<%= sType.getFee() %>'><%= sType %></option>
						<%} %> 
					</select>
			</div>
			<button type='submit' value='送出訂單'>送出訂單</button>
		</div>
		
	 	<div style="width: 30%;">
		<% for(CartItem cartItem:cart.getCartItemSet()){%>
				<div style="display: flex;align-items: center;justify-content: space-between;margin-bottom: 3%;">
					<img src='<%= request.getContextPath() %>/<%= cartItem.getPhotourl() %>' style="width:100px">
					<span style="position:relative;top: -40px;left: -50px;display: flex;align-items: center;  width: 30px;height: 30px; border-radius: 50%;background-color: #ccc; justify-content: center;"><%= cart.getQuantity(cartItem)%></span>
								<span style="text-align:left"><%= cartItem.getProductName() %>			
								<br>
					<%= cartItem.getColorName() %><%= cartItem.getSizeName() %></span>		
					<span>$ <%= cart.getAmount(cartItem) %></span>
				</div>
				
		<% }%>	
		<hr>
		<div style="text-align:right;">
		共<%=cart.size() %>項, <%=cart.getTotalQuantity() %>件
		總計: <%=cart.getTotalAmount() %>元
		<br>
		+手續費 100元
		</div>
		<br>
		<hr>
		 <span>總計:</span> <div id='totalAmountWithFee' style="text-align:right;">585.0</div>
		</div>
</div>								
			</form>
				<% } %>
		</article>
</div> 
<%-- <div style="
    position: absolute;
    width: 100%;
    bottom: 0;
    background-color: #6a4d43;
">
<%@ include file="/subviews/footer.jsp" %>	</div> --%>
	</body>
</html>