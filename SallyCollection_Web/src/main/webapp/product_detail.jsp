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
			.productImg{float:left;width:300px}
			.productDescription{clear:both;padding-top: 1ex}
		</style>
			<script>
		$(document).ready(function(){
		  $("#memberName").click(function(){
		   /*  $(".sidebar").toggle(); */
		  $(".sidebar").slideToggle();
		   
		  });
		});
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
				<img class='productImg' src='<%= p.getPhotoUrl() %>'>
				<div class='productInfo' style='float: left'>
					<h2><%= p.getName() %></h2>
					<% if(p instanceof Outlet) {%>
					<div>定價：<%= ((Outlet)p).getListPrice()%>元</div>
					<%} %>
					<div>優惠價：
					<%= p instanceof Outlet?((Outlet)p).getDiscountString():"" %>
					<%= p.getUnitPrice() %>元</div>
					<div>庫存：<%= p.getStock()%></div>
					<form>
					<input type='hidden' name='productId' value='<%= productId %>' max='3' min='0' required>
					<label>數量: </label>
					<input type='number' name='quantity' max='<%= p.getStock() %>' min='0' required>
					
					<input type='submit' value="加入購物車">
					</form>
				</div>
				<div class='productDescription'>
					<hr>					
					<%= p.getDescription() %>
				</div>
			</div>
				<%}%>
		</article>
		
        <%@ include file="/subviews/footer.jsp" %>
	</body>
</html>
