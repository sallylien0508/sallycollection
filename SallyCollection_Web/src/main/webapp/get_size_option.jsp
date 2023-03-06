<%@ page pageEncoding="UTF-8"%>

<%
String productId=request.getParameter("productId");
String colorName=request.getParameter("colorName");
if("1".equals(productId)&& "粉色".equals(colorName)){
	

%>
<option value=''>請選擇尺寸</option>
	<option value='S' data-stock='10' data-listprice='10' data-price='10'>S</option>
	<option value='M' data-stock='20' data-listprice='10'data-price='10'>M</option>	
	<option value='L' data-stock='20' data-listprice='10'data-price='10'>L</option>				

<%}else if("1".equals(productId)&& "黑色".equals(colorName)) {%>
<option value=''>請選擇尺寸</option>
	<option value='M' data-stock='20' data-listprice='10'data-price='10'>M</option>	
	<option value='L' data-stock='20' data-listprice='10'data-price='10'>L</option>
<%} %>
