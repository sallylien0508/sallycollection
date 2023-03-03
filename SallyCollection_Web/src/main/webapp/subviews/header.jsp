<%@ page pageEncoding="UTF-8"%>

     <!-- header the start -->
  <div class="header">
        <div class="logo"><a href="<%= request.getContextPath() %>"><img src="<%= request.getContextPath() %>/images/logo.png"></a></div>
        <div class="menu">
            <ul>
            <li><a href="<%= request.getContextPath() %>">首頁</a></li>
            <li><a href="<%= request.getContextPath() %>/products_list.jsp">全部商品</a></li>
            <li><a href="<%= request.getContextPath() %>/woman.html">女性專區</a></li>
            <li><a href="<%= request.getContextPath() %>/woman.html">男性專區</a></li>
            <li class="lastLi"><a href="<%= request.getContextPath() %>/woman.html">孩童專區</a></li>
            </ul>
        </div>
       <!-- header the end -->