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
        <script src="https://code.jquery.com/jquery-3.0.0.js" integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" crossorigin="anonymous"></script>
		<style>
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
			.productData{margin:0 5%;width: 60%;display: flex;border: 1px solid #22202059;box-shadow: 0 0 20px 0 rgb(51 51 102 / 20%);background:#f7f5f3;padding: 1.5%;}
			#productImg{width:300px}
			.productDescription{padding-top: 1ex}
			.productIcon{width:32px;vertical-align: middle;margin: 1ex}
			.productInfo{margin-left:10%;font-size: 20px;}
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
			<script>
$(document).ready(function(){
		  $("#memberName").click(function(){
		   /*  $(".sidebar").toggle(); */
		  $(".sidebar").slideToggle();
		   
		  });
			$(".smallPic").click(showHandler);
			$(".smallPic:eq(0)").addClass("selected");
			
		let buttonRight = document.getElementById('slideRight');
		let buttonLeft = document.getElementById('slideLeft');

		buttonLeft.addEventListener('click', function(){
			document.getElementById('slider').scrollLeft -= 180
		})

		buttonRight.addEventListener('click', function(){
			document.getElementById('slider').scrollLeft += 180
		})
	
});
		
		function changeColorData(theColorIcon){
			//alert(theColorIcon.dataset.photo);				
			productImg.src = theColorIcon.dataset.photo;
			stockSpan.innerHTML = "(" + theColorIcon.title + " " + theColorIcon.dataset.stock + "個)";
			quantity.max=theColorIcon.dataset.stock;
		}
		function showHandler(){
			var smallSrc = $(this).attr("src");
			$("#productImg").attr("src",smallSrc);
			$(".smallPic").removeClass("selected");
			$(this).addClass("selected");
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
			<form id='searchForm' action='products_list.jsp' method='GET'  style="text-align:right;margin-top:7%;margin-bottom: 2%;">
			    <input type='search' name='keyword' placeholder='請輸入查詢關鍵字...' size="50">
                <button type="submit"><i class="fa fa-search"></i></button>        		
			</form>
			
			<%if(p==null){%>
			<p>查無此產品(<%= productId %>)</p>
			<%
			}else{
			%>
<div style="display:flex">			
		<div class = "productmenu">
            <ul class="num" style="flex-direction: column;">
                    <!-- <h2>類別</h2> -->
                    <li class="productlist"><a href = 'products_list.jsp?'>所有商品 </a></li>
                    <li class="productlist"><a href = 'products_list.jsp?category=本日精選'>本日精選 </a></li>
                    <li class="productlist"><a href = 'products_list.jsp?category=人氣推薦'>人氣推薦 </a></li>
                    <li class="productlist"><a href = 'products_list.jsp?category=新品上市'>新品上市 </a></li>
            </ul>
        </div>
			
			<div class='productData'>
			<div id="album">
				<img id='productImg' src='<%= p.getPhotoUrl() %>'>
				<div id="slide-wrapper">
				 	<img id="slideLeft" class="arrow" src="images/arrow-left.png">
				    <div id="slider">
				    	<img src='<%= p.getPhotoUrl() %>' class="smallPic"/>
				        <img src="images/cc.jpg" class="smallPic"/>
				        <img src="images/aa.jpg" class="smallPic"/> 
				        <img src="images/a.jpg" class="smallPic"/>
				        <img src="images/ab.jpg" class="smallPic"/> 
				        <img src="images/abcd.jpg" class="smallPic"/>
				        <img src="images/abcde.jpg" class="smallPic"/> 
				    </div>
				  	<img id="slideRight" class="arrow" src="images/arrow-right.png">
			</div>
				 </div>  
				<div class='productInfo'>
					<span style="font-size: 45px;"><%= p.getName() %></span>
					<% if(p instanceof Outlet) {%>
					<span>定價：<%= ((Outlet)p).getListPrice()%>元</span>
					<%} %>
					<br>
					<span>優惠價：
					<%= p instanceof Outlet?((Outlet)p).getDiscountString():"" %>
					<%= p.getUnitPrice() %>元</span>
					<br>
					<span>庫存：<%= p.getStock()%><span id='stockSpan'>，紅色：2個</span></span>
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
</div>					
			</div>
				<div class='productDescription'>					
					<%= p.getDescription() %>
				</div>
				<%}%>
			
		</article> 
        <%@ include file="/subviews/footer.jsp" %>
	</body>
</html>
