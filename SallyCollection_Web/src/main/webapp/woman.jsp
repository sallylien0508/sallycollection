<%@page import="uuu.ksc.entity.Outlet"%>
<%@page import="uuu.ksc.service.ProductService"%>
<%@page import="uuu.ksc.entity.Product"%>
<%@page import="java.util.List"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		 <link rel='stylesheet' type='text/css' href='./fancybox3/jquery.fancybox.css'>
	    <link rel="stylesheet" href="index.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>sally's collection</title>
        <script src="https://kit.fontawesome.com/e3d7510046.js"></script>
        <script src="https://code.jquery.com/jquery-3.0.0.js" integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" crossorigin="anonymous"></script>
        <script src='./fancybox3/jquery.fancybox.js'></script>
        <script>
        var imageAr = ["css3dimg3.jpg","css3dimg2.jpg","css3dimg4.jpg","css3dimg5.jpg","css3dimg3.jpg","css3dimg2.jpg"]
          $(document).ready(init);
          function init(){
            //setTimeout(runHandler,1000);
            setInterval(runHandler,5000);
            $("#memberName").click(function(){
        		   /*  $(".sidebar").toggle(); */
        		  $(".sidebar").slideToggle();
        		   
        		  });
            
            window.onscroll = function() {
                if (document.body.scrollTop > 1000 || document.documentElement.scrollTop > 1000) {
                  document.getElementById("myBtn").classList.add("show");
                } else {
                  document.getElementById("myBtn").classList.remove("show");
                }
              };
          }
          var index = 0;
          function runHandler(){
            //console.log("timeout");
            index++;
            index%=imageAr.length;//3
            $("#myImg").attr("src","images/"+ imageAr[index]);
          }
          function topFunction() {
        	  document.body.scrollTop = 600; // For Safari
        	  document.documentElement.scrollTop = 600; // For Chrome, Firefox, IE and Opera
        	}
			function getProductData(pid){
				//alert('Hello, pid:' + pid); //for test
				//同步GET請求
				//location.href="product_detail.jsp?productId="+pid;
				
				//ajax送非同步GET請求
				$.ajax({
					url:"product_ajax.jsp?productId="+pid,
					method: 'GET'					
				}).done(getProductDataDoneHandler);
			}
			function getProductDataDoneHandler(result, txtStatus, xhr){
				//console.log(result); //for test
				//用fancybox來顯示
				$("#fancyDialog").html(result);
				$.fancybox.open({
				    src  : '#fancyDialog',
					'width':720,
                    'height':560,
				    type : 'inline',
				    opts : {
				      afterShow : function( instance, current ) {
				        console.info('done!');
			          }
			        }
			    });
			}

          </script>
          <style>
          ::placeholder {
			  color: white;
			}
		  #myBtn {
		  display: none; /* 隱藏按鈕 */
		  position: fixed; /* 固定按鈕位置 */
		  bottom: 40px; /* 將按鈕放在距離底部 20px 的位置 */
		  right: 80px; /* 將按鈕放在距離右側 30px 的位置 */
		  z-index: 1; /* 將按鈕放在其他內容上面 */
		}
		
		#myBtn.show {
		  display: block;
		}
		
		#myBtn:hover {
		  color: white;
		}
          </style>
	</head>

    
<body>

   <jsp:include page="/subviews/header.jsp" />  
   <jsp:include page="/subviews/nav.jsp" />
<%--        <%
			//1.取得request中的form data
			String keyword = request.getParameter("keyword");
			String category = request.getParameter("category");
			List<Product> list;
		
			//2.呼叫商業邏輯
			ProductService service = new ProductService();			
			if(keyword!=null && keyword.length()>0){
				list = service.getProductsByKeyword(keyword);
			}else if(category!=null && category.length()>0){
				list = service.getProductsByCategory(category);
			}else{
				list = service.getALLProducts();
			}
			
			//3.產生回應
		%>		 --%>

<%
			//1.取得request中的form data
			String keyword = request.getParameter("keyword");
			String category = request.getParameter("category");
			String orderBy = request.getParameter("orderBy");
			String gendercategory = request.getParameter("gendercategory");
			List<Product> list;
		
			//2.呼叫商業邏輯
			ProductService service = new ProductService();			
			if(keyword!=null && keyword.length()>0){
				if(category!=null && category.length()>0){
					list = service.getProductsByKeywordAndCategory(keyword, category);
				}else{
				list = service.getProductsByKeyword(keyword);
				}
			}else if (orderBy != null && orderBy.equals("highToLow")) {
			    list = service.getHighToLow(gendercategory);
			}else if (orderBy != null && orderBy.equals("lowTohigh")) {
			    list = service.getLowToHigh(gendercategory);
			}else if(gendercategory!=null&& category ==null){
			    list = service.getgendercategory(gendercategory);
			}else if(gendercategory!=null && category !=null && category.length()>0 ){
			    list = service.categetgendercategory(gendercategory ,category);
			}else{
				list = service.getALLProducts(); 
			}

				//list = service.getALLProducts(); 
				//list = service.getHighToLow();
				//list = service.getLowToHigh(); 
		
			
			//3.產生回應
		%>		
       
       
        <img id="myImg" src="images/css3dimg3.jpg">
        <div class = "productmenu">
            <ul class="num">
                    <!-- <h2>類別</h2> -->
                    <li class="productlist"><a href = 'woman.jsp?gendercategory=女性'>所有商品 </a></li>
                    <li class="productlist"><a href = 'woman.jsp?gendercategory=女性&&category=本日精選'>本日精選</a></li>
                    <li class="productlist"><a href = 'woman.jsp?gendercategory=女性&&category=人氣推薦'>人氣推薦</a></li>
                    <li class="productlist"><a href = 'woman.jsp?gendercategory=女性&&category=新品上市'>新品上市</a></li>
            </ul>
        </div>
        <div style="text-align:right;margin-right:3%;margin-bottom:1%;"> 
          <a href="woman.jsp?gendercategory=女性&&orderBy=highToLow">價格高至低</a><i class="fa-solid fa-up-long" style="color:white"></i>
          <a href="woman.jsp?gendercategory=女性&&orderBy=lowTohigh">價格低至高</a><i class="fa-solid fa-down-long" style="color:white"></i>
        </div>

         <form id='searchForm' action='' method='GET' style="text-align:right;margin-right:3%;">
                <input type='search' name='keyword' placeholder='請輸入查詢關鍵字...' size="50">
                <button type="submit"><i class="fa fa-search"></i></button>         
         </form>
   
        <% if(list==null||list.size()==0){ %>
       		 <p>查無產品</p>
        <% }else{ %>
          
            <% for(int i =0;i<list.size();i++){
            	Product p =list.get(i);
            	%>
            <div class="productItem">
                <h1>
                  現<br>貨<br>供<br>應
                </h1> 
                <img class="productimgfav" src="https://hexschool.github.io/webLayoutTraining1st/student-week1/favorite_border.png" alt=""> 
               <%--  <a href='product_detail.jsp?productId=<%= p.getId()%>'> --%>
               <a href='javascript:getProductData(<%= p.getId()%>)'>
                <img class="productimg" src="<%= p.getPhotoUrl() %>" alt="">
               </a>
               
               <a href='product_detail.jsp?productId=<%= p.getId()%>'> 
                <ul class="prodcontan">
                  <li class="name"> <%= p.getName() %>(<%= p.getStock() %>)</li>
                  <li class="price">NT$ <% if(p instanceof Outlet){ %>
  					 <%= ((Outlet)p).getDiscountString()%>
                     <% } %>
                  <%= p.getUnitPrice() %></li>
                </ul>
                </a>
                <%-- <a href="<%= request.getContextPath() %>/member/cart.jsp"> --%>
	                <p>
	                  <a href="<%= request.getContextPath() %>/product_detail.jsp?productId=<%= p.getId()%>"><input type="submit" value="View More"></input></a>
	                </p>
                <!-- </a> -->
              </div>
       <%} %>
        <%} %>
        <i class="fa-solid fa-circle-up" onclick="topFunction()" id="myBtn" title="Go to top" style="font-size: 50px;"></i>
        <div id='fancyDialog'></div>
        <%@ include file="/subviews/footer.jsp" %>
</body>
</html> 