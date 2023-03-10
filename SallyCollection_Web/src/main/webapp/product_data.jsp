<%@page import="java.util.List"%>
<%@page import="uuu.ksc.entity.Color"%>
<%@page import="uuu.ksc.entity.Outlet"%>
<%@page import="uuu.ksc.entity.Product"%>
<%@page import="uuu.ksc.service.ProductService"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="<%= request.getContextPath() %>/index.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>sally's collection</title>
        <script src="https://kit.fontawesome.com/e3d7510046.js"></script>
		<style>
		.addcart{
			height: 50px;
		    font: normal normal 600 24px/20px "PingFang TC";
		    color:white;
		    background-color: rgb(106, 77, 67);
		    border: none;
	    	width: 100%;
	    	margin-top: 10%;
		}
		#album{
			border:1px solid gray;
			padding:10px;
			color:white;
		}
		.smallPic{
			width:100px;
			padding:5px;
			background:white;
			margin:10px 2px;
		}
		.selected{
			background: orange;
		}
		.arrow{
			width: 30px;
			height: 30px;
			cursor: pointer;
			transition: .3s;
		
		}
		#slider{
			width: 440px;
			display: flex;
			flex-wrap: nowrap;
			overflow-x: auto;

		}
		#slide-wrapper{
			display: flex;
			align-items: center;
		}

		    ::placeholder {color: white;}
			.productData{margin:0 auto;display: flex;border: 1px solid #22202059;box-shadow: 0 0 20px 0 rgb(51 51 102 / 20%);background:#f7f5f3;width: 100%;}
			#productImg{width:250px}
			.productDescription{padding-top: 1ex}
			.productIcon{width:32px;vertical-align: middle;margin: 1ex}
			.productInfo{margin: 0 10% 2px;font-size: 20px;}
			#slider{overflow-x: auto;}
			/* HIDE RADIO */
	        [type=radio] { 
	        position: absolute;
	        opacity: 0;
	        width: 1px;
	        height: 1px;
	        }
	
	        /* IMAGE STYLES */
	        [type=radio] + img {
	        cursor: pointer;
	        }
	
	        /* CHECKED STYLES */
	        [type=radio]:checked + img {
	        outline: 2px solid #f00;
	        }
	        
		</style>
		<%
		String productId=request.getParameter("productId");
		ProductService service = new ProductService();
		Product p =null;
		if(productId!=null && productId.length()>0){
			p =service.getProductById(productId);
		}
		%>
		<script>
		
		function changeColorData(theColorIcon,hasSize){
			//alert(theColorIcon.dataset.photo);	
			console.log($("input[name='productId']").val(),theColorIcon.title)
			productImg.src = theColorIcon.dataset.photo;
			stockSpan.innerHTML = "(" + theColorIcon.title + " " + theColorIcon.dataset.stock + "個)";
			quantity.max=theColorIcon.dataset.stock;
			if(hasSize){
				getSizeOption($("input[name='productId']").val(),theColorIcon.title);
			}
		}
		
		function getSizeOption(productId,colorName){
		/* 	alert("用ajax 查詢size" +productId +","+colorName); */
			$.ajax({
				url:'get_size_option.jsp?productId='+productId+ "&colorName=" +colorName,
				method:'GET'
			}).done(getSizeOptionDoneHandler);
		}
		function getSizeOptionDoneHandler(result,textStatus,jqXhr){
			console.log(result);
			$("#size").empty();
			$("#size").append(result);
		}
		
		function showHandler(){
			var smallSrc = $(this).attr("src");
			$("#productImg").attr("src",smallSrc);
			$(".smallPic").removeClass("selected");
			$(this).addClass("selected");
		}
		function changeSizeSelect(theColorIcon){
			var selectedSize = theColorIcon.selectedOptions[0];
			console.log(selectedSize.value, selectedSize.dataset.listprice, selectedSize.dataset.price, selectedSize.dataset.stock);
			var listPrice = document.getElementById("listPrice");
			if(listPrice) listPrice.innerHTML=selectedSize.dataset.listprice;
			unitPrice.innerHTML=selectedSize.dataset.price;
			sizeStockSpan.innerHTML = selectedSize.value + ":" + selectedSize.dataset.stock+"個";
			quantity.max=selectedSize.dataset.stock;
		}	
		function addCart(){
			alert("即將加入購物車");
			 /* e.preventDefault(); */ //無效
			//送出同步的submit
			//return true;

			//用ajax送出非同步的post請求
			$.ajax({
				url:$("#addCartForm").attr("action")+"?ajax=",
				method:"POST",
				data:$("#addCartForm").serialize()
			}).done(addCartDoneHandler);
				return false;
		}
		function addCartDoneHandler(result,txtStatus,xhr){
			console.log(result);
			alert(result.totalQty);
			$(".cartTotalQty").text(result.totalQty);
		}
</script>	
	</head>
	<body>

		<article>
		<div style="color: black; display: flex; align-items: center;float: right;">
                  <i class="fa-solid fa-cart-shopping" style="font-size:30px; "></i>
                  <a href="<%= request.getContextPath() %>/member/cart.jsp" style="color:black" class="cartTotalQty">我的訂單
                   ${sessionScope.cart.getTotalQuantity()}
             <%--      <%= cart!=null?cart.getTotalQuantity():"" %> --%>
                  </a>       
         </div> 
			<%if(p==null){%>
			<p>查無此產品(<%= productId %>)</p>
			<%
			}else{
			%>
<div style="clear: both;display:flex;">			
		
			
			<div class='productData'>
			<div id="album">
				<img id='productImg' src='<%= p.getPhotoUrl() %>'>
				 </div>  
				<div class='productInfo'>
					<span style="font-size: 35px;"><%= p.getName() %></span>
					<br>
					<% if(p instanceof Outlet) {%>
					<span style="text-decoration:line-through;" id='listPrice'><%= ((Outlet)p).getListPrice()%>元</span>
					<%} %>
					<br>
					<span style="color:red;">NT$：
					<%= p instanceof Outlet?((Outlet)p).getDiscountString():"" %></span>
					<span style="color:red;"id='unitPrice'><%= p.getUnitPrice() %></span>
					<span style="color:red;">元</span>
					<br>
					<hr>
					<span id='sizeStockSpan'style="font-size: 15px;float: right;"></span>
					<span style="font-size: 15px;float: right;">庫存：<%= p.getStock()%><span id='stockSpan'></span></span>
					<form id ='addCartForm' method='POST' action='./add_cart.do' onsubmit='return addCart();'>
					<input type='hidden' name='productId' value='<%= productId %>' max='3' min='0' required><!-- 加入購物車要指定產品代號 -->
					<%if(p.getcolorCount()>0){ %>
					<!-- 顏色 -->
					<div>
					<!-- 	<label>顏色: </label> -->
						<% for(int i=0;i<p.getColorsList().size();i++){ 
							Color color = p.getColorsList().get(i);
						%>
						<label>
						<input type='radio' name='color' required value='<%= color.getName() %>'>
						<img class="productIcon" title='<%= color.getName() %>' src='<%= color.getIconUrl()==null?color.getPhotoUrl():color.getIconUrl() %>' data-photo='<%= color.getPhotoUrl() %>' data-stock='<%= color.getStock() %>' onclick='changeColorData(this,<%=p.hasSize()%>)'>
						</label>
							<%} %>
					</div>
					<%} %>
					<!-- size -->
					<% if (p.hasSize()) %>
					<div>
							<label>Size</label>
							<select id='size' name='size' onchange="changeSizeSelect(this)">
								<option value=''>請先選擇顏色...</option>	
<!-- 								<option value='S' data-stock='10' data-list-price='10' data-price='10'>S</option>
								<option value='M' data-stock='20' data-list-price='10'data-price='10'>M</option>	
								<option value='L' data-stock='20' data-list-price='10'data-price='10'>L</option>		 -->					
							</select>
						</div> 
					<div>
						<label>數量: </label>
						<input type='number' id='quantity'name='quantity' max='<%= p.getStock() %>' min='0' required>
					</div>
					<div class='productDescription'>					
					<%= p.getDescription() %>
				</div>
					<input type='submit' class="addcart" value="加入購物車">
					</form>
				</div>
</div>					
			</div>
				<%}%>
		</article> 
	</body>
</html>
