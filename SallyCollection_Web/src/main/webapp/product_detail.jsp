<%@page import="uuu.ksc.entity.Color"%>
<%@page import="uuu.ksc.entity.Outlet"%>
<%@page import="uuu.ksc.entity.Product"%>
<%@page import="uuu.ksc.service.ProductService"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<link rel="stylesheet" href="index.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>sally's collection</title>
        <script src="https://kit.fontawesome.com/e3d7510046.js"></script>
        <script src="https://code.jquery.com/jquery-3.0.0.js" integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" crossorigin="anonymous"></script>
		<style>
			.productData{width:85%;margin:0 auto;}
			#productImg{float:left;width:300px}
			.productDescription{clear:both;padding-top: 1ex}
			.productIcon{width:32px;vertical-align: middle;margin: 1ex}
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
			<script>
		$(document).ready(function(){
		  $("#memberName").click(function(){
		   /*  $(".sidebar").toggle(); */
		  $(".sidebar").slideToggle();
		   
		  });
		});
		
		function changeColorData(theColorIcon){
			//alert(theColorIcon.dataset.photo);				
			productImg.src = theColorIcon.dataset.photo;
			stockSpan.innerHTML = "(" + theColorIcon.title + " " + theColorIcon.dataset.stock + "個)";
			quantity.max=theColorIcon.dataset.stock;
		}
</script>
	</head>
	<body>
		<header>
		<jsp:include page="/subviews/header.jsp" />  
	    <jsp:include page="/subviews/nav.jsp" />
		</header>	
		<%
		String productId=request.getParameter("productId");
		ProductService service = new ProductService();
		Product p =null;
		if(productId!=null && productId.length()>0){
			p =service.getProductById(productId);
		}
		%>
		<article>
			<form id='searchForm' action='products_list.jsp' method='GET'  style="text-align:right;margin-top:10%;">
			    <input type='search' name='keyword' placeholder='請輸入查詢關鍵字...' size="50">
                <button type="submit"><i class="fa fa-search"></i></button>        		
			</form>
			
			<%if(p==null){%>
			<p>查無此產品(<%= productId %>)</p>
			<%
			}else{
			%>
			<div class='productData'>
				<img id='productImg' src='<%= p.getPhotoUrl() %>'>
				<div class='productInfo' style='float: left'>
					<h2><%= p.getName() %></h2>
					<% if(p instanceof Outlet) {%>
					<div>定價：<%= ((Outlet)p).getListPrice()%>元</div>
					<%} %>
					<div>優惠價：
					<%= p instanceof Outlet?((Outlet)p).getDiscountString():"" %>
					<%= p.getUnitPrice() %>元</div>
					<div>庫存：<%= p.getStock()%><span id='stockSpan'>，紅色：2個</span></div>
					<form method='POST' action='<%= request.getContextPath() %>/member/cart.jsp'>
					<input type='hidden' name='productId' value='<%= productId %>' max='3' min='0' required><!-- 加入購物車要指定產品代號 -->
					<%if(p.getcolorCount()>0){ %>
					<!-- 顏色 -->
					<div>
						<label>顏色: </label>
						<% for(int i=0;i<p.getColorsList().size();i++){ 
							Color color = p.getColorsList().get(i);
						%>
						<label>
						<input type='radio' name='color' required value='<%= color.getName() %>'>
						<img class="productIcon" title='<%= color.getName() %>' src='<%= color.getIconUrl()==null?color.getPhotoUrl():color.getIconUrl() %>' data-photo='<%= color.getPhotoUrl() %>' data-stock='<%= color.getStock() %>' onclick='changeColorData(this)'>
						</label>
							<%} %>
					</div>
					<%} %>
					<!-- size -->
					<div>
							<label>Size</label>
							<select id='size' name='size' onchange="changeColorDataSelect(this)">
								<option value=''>請選擇...</option>	
								<option value='S' data-stock='10' data-price='10'>S</option>
								<option value='M' data-stock='20' data-price='10'>M</option>	
								<option value='L' data-stock='20' data-price='10'>L</option>							
							</select>
						</div> 
					<div>
						<label>數量: </label>
						<input type='number' id='quantity' max='<%= p.getStock() %>' min='0' required>
					</div>
					<input type='submit' value="加入購物車">
					</form>
				</div>
				<div class='productDescription'>					
					<%= p.getDescription() %>
				</div>
			</div>
				<%}%>
		</article> 
        <%@ include file="/subviews/footer.jsp" %>
	</body>
</html>
