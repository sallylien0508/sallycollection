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
				.p_s_Type{float:left;width:45%;text-align: left}
				
				#cart tfoot fieldset input:not([type='button']){width:70%;min-width:10em}
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
			<table id='cart'>
				<caption>購物明細</caption>
				<thead>
					<tr>
					<th>名稱</th>
					<th>顏色/Size</th>
					<th>價格</th>
					<th>數量</th>
					<th>小計</th>
					</tr>
				</thead>
				<tbody>	
					<% for(CartItem cartItem:cart.getCartItemSet()){%>
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
						
					</tr>
					<% }%>												
				</tbody>
				<tfoot>
					<tr>
						<td colspan="3">
							共<%=cart.size() %>項, <%=cart.getTotalQuantity() %>件
						</td>
						<td colspan="2">
							總計: <%=cart.getTotalAmount() %>元
						</td>
					</tr>
					<tr>
						
					</tr>
					<tr>
						<td  colspan="3">
						<span class='p_s_Type' >
							<label>付款方式:</label>
							<select name='paymentType' required onchange='paymentChanged()'>
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
						</span>
						<span style='float:left'>
						<label>貨運方式:</label>
							<select name='shippingType' required onchange='shippingChanged()'>
							<option value=''>請選擇...</option>
								<% for(ShippingType sType: ShippingType.values()) {%>
								<option value='<%= sType.name() %>' data-fee='<%= sType.getFee() %>'><%= sType %></option>
								<%} %> 
							</select>
						</span>
						</td>
						<td  colspan="2">
							+手續費 總計: <span id='totalAmountWithFee'>585.0</span>元
						</td>
					</tr>
					<tr>
						<td colspan="5">
							<fieldset style='width:95%'>
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
						</td>
					</tr>
					<tr>
						<td  colspan="5">							
							<input type='submit' value='送出訂單'>
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