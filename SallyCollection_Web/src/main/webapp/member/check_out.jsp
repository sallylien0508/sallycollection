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
		  
			var select = document.querySelector('.select-wrapper select');
			var arrow = document.querySelector('.select-wrapper .select-arrow');

			arrow.addEventListener('click', function() {
			  select.classList.toggle('expanded');
			});
		});


</script>
		<style>
/* 		article{ margin:200px auto;} */
		.form-container {
		  margin-top: 10px;
		  padding: 30px;
		  background: linear-gradient(to bottom right, #c5a291, #f2eeec);
		  border-radius: 20px;
		  box-shadow: 10px 3px 10px rgba(0, 0, 0, 0.2);
		}

		
		input {
		  font-size: 18px;
		  padding: 15px;
		  width: 37%;
		  border-radius: 5px;
		  border: none;
		  margin: 10px 0;
		  box-shadow: 0px 3px 5px rgba(0, 0, 0, 0.1);
		}
		
		input:focus {
		  outline: none;
		  box-shadow: 0px 3px 5px rgba(0, 0, 0, 0.3);
		}
		
		button {
		  background: #ffffff;
		  color: #6a4d43;
		  font-size: 24px;
		  padding: 10px 20px;
		  border: none;
		  box-shadow: 0px 3px 5px rgba(0, 0, 0, 0.1);
		  margin-top: 20px;
		  transition: all 0.2s ease-in-out;
		  float: right;
    	  margin-right: 8%;
		}
		
		button:hover {
		  transform: translateY(-3px);
		  box-shadow: 0px 3px 5px rgba(0, 0, 0, 0.2);
		}
		.select-wrapper {
		  position: relative;
		  display: inline-block;
		  margin: 20px;
		}
		
		select {
		  appearance: none;
		  background-color: transparent;
		  font-size: 16px;
		  color: #555;
		  padding: 10px 30px;
		  cursor: pointer;
		  border-radius: 5px;
		  border: 2px solid #ffffff;
		}
		
		.select-arrow {
		  position: absolute;
		  top: calc(50% - 6px);
		  right: 10px;
		  border-top: 10px solid #ffffff;
		  border-right: 8px solid transparent;
		  border-left: 8px solid transparent;
		  cursor: pointer;
		}
	
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
${requestScope.errorList}
<div style="margin: 150px 0px 50px 90px;">
<a href="<%= request.getContextPath() %>/member/cart.jsp" style="color:black">cart</a> > <a href="<%= request.getContextPath() %>/member/check_out.jsp" style="color:black">Information</a> > <span style="color:grey">payment</span><br>
</div>
<form action='check_out.do' method ='POST'><!-- http://localhost:8080/ksc/member/check_out.do -->
<div style="display:flex;justify-content: space-around;">	
		<div style="width: 50%;">
			<div>
			<div  style="display: flex;align-items: center;">
		<span style="display: flex;  border-top: 2px solid; width: 31%;"></span>&nbsp;&nbsp;&nbsp;請填寫收件人資料(<a href='javascript:copyMember()'>複製訂購人</a>)&nbsp;&nbsp;&nbsp;<span style="display: flex;  border-top: 2px solid; width: 31%;"></span>
			</div>	
				<div class='form-container'style='width:85%; font-size: 30px;'>
					<input name='name' placeholder="請輸入收件人姓名" required>
					<input name='phone' placeholder="請輸入收件人電話" required><br>
					<input name='email' placeholder="請輸入收件人Email" required style=" width: 80%;"><br>
					<input name='shippingAddr' placeholder="請輸入宅配地址" required style=" width: 80%;"><br>
					<input type='button' id='chooseStoreButton' value='選擇超商' style='display:none'>
					<datalist id="shopList">
						  <option value='台北旗艦店 復興北路99號1F'>台北旗艦店 復興北路99號1F</option>
						  <option value="新竹門市">新竹門市 新竹市東區光復路二段295號3樓之2</option>
						  <option value="台中門市">台中門市 台中市西區臺灣大道二段309號2樓</option>
						  <option value="高雄門市">高雄門市 高雄市前鎮區中山二路2號25樓</option>						  
					</datalist>
				</div>
			</div>	
			<br>
			<div  style="display: flex;align-items: center;">
		<span style="display: flex;  border-top: 2px solid; width: 33%;"></span>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;請選擇付款與運送方式&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<span style="display: flex;  border-top: 2px solid; width: 33%;"></span>
			</div>	
			<div style="margin-top: 20px;width: 95%;display: flex;align-items: center;justify-content: space-between;">
				<label style="font-size: 20px;">付款方式:</label>
				  <div class="select-wrapper">
					<select name='paymentType' required onchange='paymentChanged()'>
						<option value=''>請選擇...</option>
						<% for(PaymentType pType: PaymentType.values()) {%>
						<option value='<%= pType.name() %>'data-fee='<%= pType.getFee() %>'><%= pType %></option>
						<%} %> 
					</select>
					<div class="select-arrow"></div>
				  </div>
				<label style="font-size: 20px;">貨運方式:</label>
				  <div class="select-wrapper">
					<select name='shippingType' required onchange='shippingChanged()'>
					<option value=''>請選擇...</option>
						<% for(ShippingType sType: ShippingType.values()) {%>
						<option value='<%= sType.name() %>' data-fee='<%= sType.getFee() %>'><%= sType %></option>
						<%} %> 
					</select>
					<div class="select-arrow"></div>
				  </div>
			</div>
			<button type='submit' value='送出訂單'>送出訂單</button>
		</div>
		
	 	<div style="width: 30%;">
		<% for(CartItem cartItem:cart.getCartItemSet()){%>
				<div style="display: flex;text-align: left;align-items: center;justify-content: space-between;margin-bottom: 3%;">
				 <img src='<%= request.getContextPath() %>/<%= cartItem.getPhotourl() %>' style="width:100px">
				    <span style="position:relative;top: -40px;left: -10px;display: flex;align-items: center; width: 30px;height: 30px; border-radius: 50%;background-color: #ccc; justify-content: center;"><%= cart.getQuantity(cartItem)%></span>
				    <span style=" flex: 1;"> <%= cartItem.getProductName() %>
			        <br>
			        <%= cartItem.getColorName() %><%= cartItem.getSizeName() %>
			    </span>	
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
		 <span>總計:</span> <div id='totalAmountWithFee' style="font-weight: 1000; text-align: right;font-size: 30px;"> NT:585.0</div>
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