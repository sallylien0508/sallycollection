<%@page import="uuu.ksc.entity.shoppingCart"%>
<%@ page pageEncoding="UTF-8" contentType="application/json"%>
<%
	shoppingCart cart = (shoppingCart)session.getAttribute("cart");
%>
{
	"cartItems":[	
					{"name" : "三角洞洞色鉛筆",
					 "color" : "紅",
					 "size" : "S",
					 "qty" : 2}
	            ] 
    ,"totalQty" : ${sessionScope.cart.getTotalQuantity()}
}
