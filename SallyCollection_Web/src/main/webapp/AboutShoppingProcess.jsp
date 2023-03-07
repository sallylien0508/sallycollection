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
<style>
.index_h1{
    margin: 0 10%;
    width: 80%;
    text-align: left;
}
</style>
	</head>

    
<body>

   <jsp:include page="/subviews/header.jsp" />  
   <jsp:include page="/subviews/nav.jsp" />
      <p style="margin: 120px auto 2px;width: 50%;border-bottom: #111010f0 dotted;">About Us</p>
<div style="display:flex">     
		<div style="height: 580px;background-color: #d3d1ce; width: 30%;">
		<div style="width: 60%; margin: 30px auto;">
			<a href="<%= request.getContextPath() %>/Aboutmembership.jsp"><span  style="color:#6a4d43;;font-size: 20px;margin-right: 20px;">如何加入會員</span>
			<img id="slideRight" style="width:20%;position: relative;top: 8px;" src="images/arrow-right.png"></a>
		</div>	
		<div style="width: 60%; margin: 30px auto;">
			<a href="<%= request.getContextPath() %>/AboutShoppingProcess.jsp"><span style="color:#6a4d43;;font-size: 20px;margin-right: 20px;">購物流程問題</span>
			<img id="slideRight" style="width:20%;position: relative;top: 8px;" src="images/arrow-right.png"></a>
		</div>	
		<div style="width: 60%; margin: 30px auto;">
			<a href="<%= request.getContextPath() %>/AboutReturnExchange.jsp"><span  style="color:#6a4d43;;font-size: 20px;margin-right: 20px;">退換貨及退款</span>
			<img id="slideRight" style="width:20%;position: relative;top: 8px;" src="images/arrow-right.png"></a>
		</div>	
		</div>
       <!-- 內容 -->
       <div style="display:flex;flex-direction: column;width: 100%;">
       <div class="index_h1">
          <h1>Q1. 購物流程說明</h1>
          <ul>
		       <li>Sally's Collection 提供您簡單又安全的購物流程，親切易懂的指引式流程畫面，讓您充分享受便利的購物樂趣。</li>
		       <li>購物方式：註冊帳號＞＞登入帳號（第一次購物請註冊會員)＞＞選擇商品＞＞加入購物車＞＞前往結帳＞＞填寫收件資訊＞＞完成購物</li>
          </ul>
       </div>
       <div class="index_h1">
          <h1>Q7. 如何計算「七天鑑賞期」？</h1>
          <p>
			根據消保法規定，lativ 提供七日鑑賞期權益。
			於完成簽收取件的隔日起算至第7天止 (如您的收件地址有管理員代收，則以代收的隔日起算)。
			 </p>
			 <ul>
				 <li>提醒您！以下情況將無法為您辦理退貨，煩請留意以免影響您的退貨權益。</li>
				 <li>1.試穿時如您有化妝請特別小心，若衣物上沾有粉妝時，請恕無法接受退貨喔。</li>
				 <li>2.非正常試穿，已長時間穿著、已有使用摺痕或髒污或味道。</li>
				 <li>3.基於衛生原則，貼身衣物例如內衣褲、襪子，一但拆封即無法退貨。</li>
				 <li>4.退回時，商品配件不全或吊牌已剪（襯衫等商品請務必退回所有包裝配件）。</li>
				 <li>5.已在商品上加工，例如：繡花、裁剪、打印……等非lativ商品原樣（請確實驗收商品後再進行加工）。</li>
				 <li>6.活動贈品未退回。</li>
				 <li>7.超過七天鑑賞期。</li>
			 </ul>
       </div>
       </div>
       		<div style="height: 580px;background-color:#d3d1ce; width: 30%;"></div>
</div> 
 
 
 
<%@ include file="/subviews/footer.jsp" %>
</body>
</html> 