<%@page import="java.time.LocalDate"%>
<%@page import="uuu.ksc.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
	<head>
        <link rel="stylesheet" href="index.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>sally's collection</title>
        <script src="https://kit.fontawesome.com/e3d7510046.js"></script>
        <script src="https://code.jquery.com/jquery-3.0.0.js" integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" crossorigin="anonymous"></script>
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
/*       birthday.setAttribute=("max",maxDate); */
  	  birthday.setAttribute=("max",'<%= LocalDate.now().minusYears(Customer.MIN_AGE) %>'); 
<%--   
	  $("input[name ='id']").attr('pattern',<%=Customer.ID_PATTERN%>);
	  $("input[name ='id']").attr('maxlength',<%=Customer.MAX_ID_LENGTH %>);
	  $("input[type ='password']").attr('minlength',<%=Customer.MIN_PWD_LENGTH %>);
  	  $("input[type ='password']").attr('maxlength',<%=Customer.MAX_PWD_LENGTH %>); 
   	  $("input[name ='name']").attr('minlength',<%=Customer.MIN_PWD_LENGTH %>);
  	  $("input[name ='name']").attr('maxlength',<%=Customer.MAX_PWD_LENGTH %>);   --%>
	  $("#myShow").mousedown(showpassHandler)
				  .mouseup(hidepassHandler)
				  .mouseleave(hidepassHandler);
			
      //如果有post這個才會有repopulateFormData() 
      //超連結一開始會用get請求所以不會有

      repopulateFormData() 
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
		function repopulateFormData(){
		   <% if("POST".equals(request.getMethod()) ){%>
		   <% if (request.getParameter("submit") != null){%>
			$("#register input[name='id']").val('<%= request.getParameter("id")%>');
			$("#register input[name='email']").val('<%= request.getParameter("email")%>');
			$("#register input[name='password']").val('<%= request.getParameter("password")%>');
			$("#register input[name='name']").val('<%= request.getParameter("name")%>');
			$("#register input[name='phone']").val('<%= request.getParameter("phone")%>');
			$("#register #birthday").val('<%= request.getParameter("birthday")%>');
			var genderData= '<%= request.getParameter("gender")%>';
			$("#register input[value='"+genderData+"']").prop('checked',true);
			<%}else{%>
			$("#login input[name='id']").val('<%= request.getParameter("id")%>');
			$("#login input[name='email']").val('<%= request.getParameter("email")%>');
		   <%}%>	
		   <%}%>
		}
		</script>  
	</head>
<body>

   <jsp:include page="/subviews/header.jsp" />  
   <jsp:include page="/subviews/nav.jsp" />
       
       
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
                    
                    <form method="post" action="login.do#tab1" id ="login">
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
                    <form method="post" action="register.do" id="register">
                        <div class="loginpostition_parent">
                            <div class="loginpostition_child">
                            <div class="txt_field">
                                <input type="text" name="id" id="id" class="" pattern="[A-Z][12][0-9]{8}" required>
                                <span></span>
                                <label>身分證</label>
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
                                    <label for="birthday" class="">生日:&nbsp;&nbsp;</label>
                                    <input type="date" name="birthday" id="birthday" class="" max="2023-02-02">
                                </div>
                                <div class="loginpostition_txt">
                                    <label for="gender" class="">性別:&nbsp;&nbsp;</label>
                                    <input type="radio" name="gender"   value='<%= Customer.MALE %>'><label>男</label>
                                    <input type="radio" name="gender"  value='<%= Customer.FEMALE %>'><label>女</label>
                                </div>
                                <input type="submit" value="註冊" name='submit'  class="registerbtn">
                            </div>
                          </div>
                    </form>

                </div>
            </div>
        </div>
    </div>

</body>
</html> 