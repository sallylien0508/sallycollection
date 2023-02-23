<%@page import="uuu.ksc.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8" />
        <link rel="stylesheet" href="index.css">
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
	</head>

    
<body>

   <jsp:include page="/subviews/header.jsp" />  
   <jsp:include page="/subviews/nav.jsp" />
       
       

       <div class="bg_img">
          <div class="bg_txt">
            <h1>New arrivals</h1>
            <p>What you waiting for ? &nbsp; Check out what we made for you !</p>
            <br>
            <a href="products_list.jsp">shop now &nbsp;&nbsp;<i class="fa-solid fa-arrow-right"></i></a>
          </div>
       </div>

       <!-- 內容 -->
       <div class="index_h1">
          <h1>Made by Korea just for you.</h1>
          <p>
          歡迎Lorem ipsum dolor sit amet consectetur adipisicing elit. Praesentium accusantium culpa, maiores commodi iste dolorum. Numquam, alias excepturi. Hic, dolores aperiam enim sit architecto dolor animi? Tempore magni dolorum distinctio?
          </p>
       </div>
<%@ include file="/subviews/footer.jsp" %>
</body>
</html> 