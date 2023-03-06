<%@page import="uuu.ksc.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<!-- nav.jsp start -->
                <% Customer member= (Customer)session.getAttribute("member"); 
        String gender = "";
        if(member!=null){
        	if(member.getGender() ==Customer.FEMALE){
        		gender ="小姐";
        	}else{
        		gender="先生";
        	}
        }
		%>
            <nav>
            <!-- 尚未登入  -->
            <% if(member==null){%>
              <div class="navitem">
                <div class="navitem__icon"></div>
                <i class="fa fa-pencil-square" style="font-size:30px; color: wheat;"></i>
                <a class=navitem__text href="<%= request.getContextPath() %>/AboutUs.jsp">關於我們</a>
              </div>
                <div class="navitem">
                  <div class="navitem__icon"></div>
                  <i class="fa-solid fa-cart-shopping" style="font-size:30px; color: wheat;"></i>
                  <a class=navitem__text href="<%= request.getContextPath() %>/member/cart.jsp">我的訂單</a>
                </div>
                <div class="navitem">
                  <div class="navitem__icon"></div>
                  <i class="fa fa-user-circle-o" style="font-size:30px; color: wheat;"></i>
                  <a class=navitem__text href="<%= request.getContextPath() %>/login.jsp#tab1">登入/註冊</a>
                  </div>
                 <% }else{ %>
                  <!-- 已經登入 -->
               <div class="navitem">
                <div class="navitem__icon"></div>
                <i class="fa fa-pencil-square" style="font-size:30px; color: wheat;"></i>
                <a class=navitem__text href="<%= request.getContextPath() %>/AboutUs.jsp">關於我們</a>
              </div>
                <div class="navitem">
                  <div class="navitem__icon"></div>
                  <i class="fa-solid fa-cart-shopping" style="font-size:30px; color: wheat;"></i>
                  <a class=navitem__text href="<%= request.getContextPath() %>/member/cart.jsp">我的訂單</a>
                </div>
              <div class="navitem" id ='memberName'>
                  <div class="navitem__icon"></div>
                  <i class="fa fa-user-circle-o" style="font-size:30px; color: wheat;"></i>
                  <a class=navitem__text><%= member!=null?member.getName():"" %></a>
              </div>
                   <ul class="sidebar">
                      <li><a href="<%= request.getContextPath() %>/member/update.jsp" >修改會員</a></li>
                      <hr>
                      <li><a href="<%= request.getContextPath() %>/logout.do" >登出</a></li>
                    </ul>
              <!-- http://localhost:8080/vgb/  -->
               
                <%} %>
            </nav>
    </div>
    
    <!-- nav.jsp end -->