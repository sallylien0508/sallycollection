<%@page import="uuu.ksc.entity.Customer"%>
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
td{width: 20%;}
</style>
	</head>

    
<body>

   <jsp:include page="/subviews/header.jsp" />  
   <jsp:include page="/subviews/nav.jsp" />
<div style="background-color:white;width: 80%; margin: 0 auto;border-radius: 4%;">
    <p style="margin-top: 150px;text-align: center;font-size: 30px;color: #0b0b53;">
    訂單資料
    </p>
    <div style="display: flex;justify-content: space-evenly;">
    	<div>
    		<p>訂單日期</p>    	
    		<p>訂單編號</p>		
    		<p>寄送方式</p>   	
    		<p>付款方式</p>
    		<p>出貨狀態</p>
    		
    	</div>
    	<div>
    		<p>2023-02-03</p>
	    	<p>AP12345678</p>
	    	<p>新竹物流</p>
	    	<p>線上刷卡</p>
	    	<p>已出貨</p>
    	</div>
		<div>
		    <p>原價</p>
	    	<p>活動折扣</p>
	    	<p>手續費</p>
	    	<p>運費</p>
	    	<p>應繳總金額</p>
		</div>
	    <div>
		    <p>1780元</p>
	    	<p>9折 178元</p>
	    	<p>10元</p>
	    	<p>20</p>
	    	<p>1622元</p>
		</div>
    </div>
    <hr>
    <p style="text-align: center;font-size: 30px;color: #0b0b53;">
    訂單明細
    </p>
<table style="width: 80%;text-align: center;margin: 0 auto;">
<thead>
    <tr>
	    <th>產品</th>
	    <th>價格</th>
	    <th>數量</th>
	    <th>小計</th>
    </tr>
<thead>
<tbody>
	<tr> 
		<td>
		 	 <span>Snoopy Dress</span><br>
	   		 <img alt="" src="<%= request.getContextPath() %>/images/snoopy_black.jpg" style="width:50%">
	    </td>
	    <td>499</td>
	    <td>2件</td>
	    <td>989元</td>
	</tr>
</tbody>
</table>
</div>
<%@ include file="/subviews/footer.jsp" %>
</body>
</html> 