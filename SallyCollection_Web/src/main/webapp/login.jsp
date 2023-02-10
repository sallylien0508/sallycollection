<!--<%@ page pageEncoding="UTF-8"%>-->
<!DOCTYPE html>
<%@page import="java.util.List"%>
<html>
	<head>
		<meta charset="utf-8" />
        <link rel="stylesheet" href="index.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>sally's collection</title>
        <script src="jquery.js"></script>
        <script src="https://kit.fontawesome.com/e3d7510046.js"></script>
        <style>
        
        #captchaImage{cursor:pointer;}
        
        </style>
		<script>
		$(document).ready(init);
		function init()
		{
      var today =new Date();
      var y =today.getYear()+1900-12;
      // 2023-12(要年滿12歲)
      var m =today.getMonth()+1;
      m = m<10?("0"+m):m;
      var d =today.getDate();
      d = d<10?("0"+d):d;
      var maxDate= y+"-"+m+"-"+d;
      // alert(maxDate);
      birth.setAttribute=("max",maxDate);
			$("#myShow").mousedown(showpassHandler)
						.mouseup(hidepassHandler)
						.mouseleave(hidepassHandler);
		}
		function showpassHandler(){
      $("#myShow").addClass("fas fa-eye");
			$("#myPass").attr("type","text");
		}
		function hidepassHandler(){
      $("#myShow").removeClass("fas fa-eye");
      $("#myShow").addClass("fas fa-eye-slash");
			$("#myPass").attr("type","password");
		}
		function refreshCaptcha(){
			//alert('refresh Captcha');
			captchaImage.src='images/captcha.jpg?refresh=' + new Date(); //ajax
		}
		</script>  
	</head>
<body>
    <div class="header">
        <div class="logo"><a href="./"><img src="images/logo.png"></a></div>
        <div class="menu">
          <ul>
          <li><a href="./">首頁</a></li>
          <li><a href="products_list.jsp">全部商品</a></li>
          <li><a href="woman.html">女性專區</a></li>
          <li><a href=#>男性專區</a></li>
          <li class="lastLi"><a href=#>孩童專區</a></li>
          </ul>
      </div>
        <nav>
          <div class="navitem">
            <div class="navitem__icon"></div>
            <i class="fa fa-pencil-square" style="font-size:30px; color: wheat;"></i>
            <a class=navitem__text href="Untitled-8.html">關於我們</a>
          </div>
            <div class="navitem">
              <div class="navitem__icon"></div>
              <i class="fa-solid fa-cart-shopping" style="font-size:30px; color: wheat;"></i>
              <a class=navitem__text href="Untitled-8.html">我的訂單</a>
            </div>
            <div class="navitem">
              <div class="navitem__icon"></div>
              <i class="fa fa-user-circle-o" style="font-size:30px; color: wheat;"></i>
              <a class=navitem__text href="login.jsp#tab1">登入/註冊</a>
            </div>
        </nav>
    </div>
        <!-- header the end -->
    <div class="loginandout">
        <ul id="tabs" class="tabs">
            <li><a href="#tab1" class="tab">會員登入</a></li>
            <li><a href="#tab2" class="tab">手機號碼註冊</a></li>
        </ul>
        <div id="container">
         <% 
       	 List<String> errors = (List<String>)request.getAttribute("errors");
        %>
        <%= errors==null?"":errors %>
            <div id="tab1" class="tab_content">
                <div class="center">
                    <h1>登入</h1>
                    
                    <form method="post" action="login.do">
                      <div class="txt_field">
                        <input type="text" value="" required name="id">
                        <span></span>
                        <label>身分證或電子信箱</label>
                      </div>
                      <div class="txt_field">
                        <input type="password" id="myPass" required name="password">
                        <span></span>
                        <label>密碼 </label>
                      </div>
           <!--             <input type="checkbox" name="auto" value='ON' />記住我的帳號 -->
                        <!-- <input type="button" value="顯示密碼" id="myShow"><br> -->
                        <i class="fas fa-eye-slash" id="myShow"></i>
                        <div class="captchaImage">
                        <label>&nbsp;驗證碼 : </label>
                       <input name='captcha' required placeholder="     不分大小寫 " size="15" autocomplete="off">
                       <img src='images/captcha.jpg' id='captchaImage' onclick='refreshCaptcha()' title='點選即可更新圖片'>
                    </div>
                      <br>
                      <input type="submit" value="登入" class="submitlogin">
                      <div class="signup_link">
                        不是會員? <a href="#">註冊</a>
                      </div>
<!--                        <div class="Forgot_Password">忘記密碼?</div> -->
                    
                    </form>
                  </div>
            </div>
            <div id="tab2" class="tab_content">
             <div class="loginpostition">
        <% 
       	 List<String> register_errors = (List<String>)request.getAttribute("register_errors");
        %>
       		 <%= register_errors==null?"":register_errors %>
                    <h1>註冊</h1>
                    <form method="post" action="register.do">
                        <div class="loginpostition_parent">
                            <div class="loginpostition_child">
                            <div class="txt_field">
                                <input type="text" name="id" id="id" class="" pattern="[A-Z][12][0-9]{8}" required>
                                <span></span>
                                <label for="address">身分證</label>
                              </div>
                            <div class="txt_field">
                                <input type="text"required title="請填寫此欄位並符合email格式" type="email" name="email">
                                <span></span>
                                <label for="account">信箱</label>
                              </div>
                              <div class="txt_field">
                                <input type="text" required name="password">
                                <span></span>
                                <label for="password">密碼</label>
                              </div>
                              <div class="txt_field">
                                <input type="text" required name="name">
                                <span></span>
                                <label for="name">姓名</label>
                              </div>
                              <div class="txt_field">
                                <input type="tel" name="phone" id="phone" class="" required maxlength="10">
                                <span></span>
                                <label for="p">手機</label>
                              </div>
                              
                            </div>
                            <div class="loginpostition_child2">
                                <div class="loginpostition_txt">
                                    <label for="photo" class="">頭像:&nbsp;&nbsp; </label>
                                    <input type="file" name="photo" id="photo">
                                </div>
                                <div class="loginpostition_txt">
                                    <label for="birth" class="">生日:&nbsp;&nbsp;</label>
                                    <input type="date" name="birthday" id="birthday" class="" max="2023-02-02">
                                </div>
                                <div class="loginpostition_txt">
                                    <label for="gender" class="">性別:&nbsp;&nbsp;</label>
                                    <input type="radio" name="gender" id="gender" value="M" checked><lable>男</lable>
                                    <input type="radio" name="gender" id="gender" value="F"><lable>女</lable>
                                </div>
                                <input type="submit" value="註冊" class="registerbtn" onclick="registerbtn()">
                            </div>
                          </div>
                    </form>

                </div>
            </div>
        </div>
    </div>

</body>
</html> 