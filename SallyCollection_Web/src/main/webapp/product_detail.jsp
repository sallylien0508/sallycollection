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
			.productData{margin:0 5%;width: 60%;display: flex;border: 1px solid #22202059;box-shadow: 0 0 20px 0 rgb(51 51 102 / 20%);background:#f7f5f3;padding: 1.5%;}
			#productImg{width:300px}
			.productDescription{padding-top: 1ex}
			.productIcon{width:32px;vertical-align: middle;margin: 1ex}
			.productInfo{margin-left:10%;font-size: 20px;width: 100%;}
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
	        
	        .zoom-icon {
			    position: relative;
			    top: -40px;
			    left: 310px;
			    cursor: pointer;
			    width: 10%;
			}
			
			.zoom-icon i {
			    font-size: 30px;
			    color: #b6745d;
			}
	        #overlay {
			    position: fixed;
			    top: 0;
			    left: 0;
			    width: 100%;
			    height: 100%;
			    background-color: rgba(0,0,0,0.8);
			    display: none;
			    justify-content: center;
			    align-items: center;
			}
			
			#overlayImg {
			    max-width: 70%;
			    max-height: 70%;
			    display: block;
			  	margin: 10% auto;
			}
			#snackbar {
        visibility: hidden;
        min-width: 250px;
        margin-left: -125px;
        background-color: rgb(139 42 49);
        color: #fff;
        text-align: center;
        border-radius: 2px;
        padding: 16px;
        position: fixed;
        z-index: 100000;
        left: 50%;
        top: 50%; 
        font-size: 17px;
    }

    #snackbar.show {
        visibility: visible;
        -webkit-animation: fadein 0.5s, fadeout 0.5s  0.8s;
        animation: fadein 0.5s, fadeout 0.5s  1.8s;
    }

    @-webkit-keyframes fadein {
        from {top: 0; opacity: 0;} 
        to {top: 50%; opacity: 1;}
    }

    @keyframes fadein {
        from {top: 0; opacity: 0;}
        to {top: 50%; opacity: 1;}
    }

    @-webkit-keyframes fadeout {
        from {top: 50%; opacity: 1;} 
        to {top: 0; opacity: 0;}
    }

    @keyframes fadeout {
        from {top: 50%; opacity: 1;}
        to {top: 0; opacity: 0;}
    }
		</style>
		<%
		String productId=request.getParameter("productId");
		String Pimg = request.getParameter("detail_img");
		List<Product> list;
		ProductService service = new ProductService();
		Product p =null;
		if(productId!=null && productId.length()>0){
			p =service.getProductById(productId);
		}
		%>
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
			document.getElementById('slider').scrollLeft -= 100
		})

		buttonRight.addEventListener('click', function(){
			document.getElementById('slider').scrollLeft += 100
		})
		
	    $(".zoom-icon").click(function() {
	        var imgSrc = $("#productImg").attr("src");
	        $("#overlayImg").attr("src", imgSrc);
	        $("#overlay").fadeIn();
	    });

	    $("#overlay").click(function() {
	        $("#overlay").fadeOut();
	    });
	    
	    
	    <% if(p!=null && p.getcolorCount()==0 && p.hasSize()){%>
	    getSizeOption($("input[name='productId']").val(),'');
	    <%}%>
	
});
		
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
		function addCart(e){						
			//e.preventDefault(); //無效
			
			//送出同步的submit
			//return true;				
			
			//用ajax送出非同步的POST請求
			$.ajax({
				url: $("#addCartForm").attr("action")+"?ajax=",
				method: "POST",
				data: $("#addCartForm").serialize()
			}).done(addCartDoneHandler);
			
			return false;
		}
		
		function addCartDoneHandler(result, txtStatus, xhr){
			//console.log(result); //for test
			//alert("加入購物車成功: 目前有" + result.totalQty + "個");
			toastMessage("加入購物車成功! 目前有" + result.totalQty + "個");
			$(".cartTotalQty").text(result.totalQty);
		}

	    function toastMessage(msg) {
	        var x = document.getElementById("snackbar");
	        x.innerHTML = msg;
	        x.className = "show";
	        setTimeout(function () {
	            x.className = x.className.replace("show", "");
	        }, 2300); //此根據css show方法fadeout所需時間相加
	    } 
</script>
	</head>
	<body>
		<header>
		<jsp:include page="/subviews/header.jsp" />  
	    <jsp:include page="/subviews/nav.jsp" />
		</header>	

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
				<div class="zoom-icon">
				    <i class="fa fa-search-plus"></i>
				</div>
				<div id="overlay">
				    <img id="overlayImg" src="">
				</div>
<% 
	
    list = service.getPimg(productId);
if (list != null && list.size()>0) {
%>

<div id="slide-wrapper">
    <img id="slideLeft" class="arrow" src="images/arrow-left.png"> 	
    <div id="slider">
        <% for (Product product : list) { %>
            <img src='<%= product.getPimg() %>' class="smallPic"/>
        <% } %>
    </div>
    <img id="slideRight" class="arrow" src="images/arrow-right.png">
</div>
<% }else{ %>
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
			<%} %>
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
					<form method='POST' action='./add_cart.do' onsubmit="return addCart()" id='addCartForm'>
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
					<input type='submit' class="addcart" value="加入購物車" >
					</form>
					<a href="<%= request.getContextPath() %>/member/cart.jsp" style ="color: #153262;float: right;">view cart >></a>
				</div>
</div>					
			</div>
				<%}%>
				<div id="snackbar"></div>
		</article> 

        <%@ include file="/subviews/footer.jsp" %>
	</body>
</html>
