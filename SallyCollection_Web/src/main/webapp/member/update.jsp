<%@page import="java.time.LocalDate"%>
<%@page import="uuu.ksc.entity.Customer"%>
<%@ page pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<!DOCTYPE html>
<html>
	<head>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/index.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>sally's collection</title>
        <script src="https://kit.fontawesome.com/e3d7510046.js"></script>
        <script src="https://code.jquery.com/jquery-3.0.0.js" integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" crossorigin="anonymous"></script>
        <style>
        #captchaImage{cursor:pointer;}
        .tab_content{
        width:70%}
        </style> 
           <% Customer member= (Customer)session.getAttribute("member"); %>
	</head>
<body>

   <jsp:include page="/subviews/header.jsp" />  
   <jsp:include page="/subviews/nav.jsp" />
       
       
    <div class="loginandout">
            <div id="tab2" class="tab_content">
             <div class="loginpostition">
        <% 
       	 List<String> register_errors = (List<String>)request.getAttribute("errors");
        %>
       		 <%= register_errors==null?"":register_errors %>
                    <h1>會員修改</h1>
                    <form method="post" action="update.do" id="register">
                        <div class="loginpostition_parent">
                            <div class="loginpostition_child">
                            <div class="txt_field">
                                <input type="text" readonly name="id" id="id" class="" pattern="[A-Z][12][0-9]{8}" >
                                <span></span>
                              </div>
                            <div class="txt_field">
                                <input type="text" required title="請填寫此欄位並符合email格式" type="email" name="email">
                                <span></span>
                                <label for="account">信箱</label>
                              </div>
                 <fieldset>
					<legend>
						<input type='checkbox' name='changePwd'>修改密碼
					</legend>
					<p>	
						<label>密碼: </label>
						<input autocomplete="on" id='password' name='password' type='password' disabled placeholder="請輸入密碼(注意大小寫)">
						<input type='checkbox' id='showPwdBox'><label>顯示密碼</label>
						<br><label>確認: </label>
						<input autocomplete="on" id='password2' name='password2' type='password' disabled placeholder="請再輸入密碼(注意大小寫)">
					</p>
				</fieldset>
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
                                    <input type="radio" name="gender" value='<%= Customer.MALE %>'><label>男</label>
                                    <input type="radio" name="gender"  value='<%= Customer.FEMALE %>'><label>女</label>
                                </div>
                                <input type="submit" value="修改"  class="registerbtn">
                            </div>
                          </div>
                
                    </form>

                </div>
            </div>
        </div>


</body>
<script>
showPwdBox.onchange=showPassword;
$(document).ready(init);

function init()
{
    $("#memberName").click(function(){
		   /*  $(".sidebar").toggle(); */
		  $(".sidebar").slideToggle();
		   
		  });
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
  //如果有post這個才會有repopulateFormData() 
  //超連結一開始會用get請求所以不會有

  repopulateFormData() 
}

function repopulateFormData(){
	<% if("POST".equalsIgnoreCase(request.getMethod())){   //修改失敗帶入上次輸入的資料%>
		$("input[name='id']").val('<%= request.getParameter("id")%>');
		$("input[name='email']").val('<%= request.getParameter("email")%>');
		<%-- $("input[name='password']").val('<%= request.getParameter("password")%>'); --%>
		$("input[name='password']").val('<%= request.getParameter("password")%>');
		$("input[name='password2']").val('<%= request.getParameter("password2")%>');



		$("input[name='name']").val('<%= request.getParameter("name")%>');				
		$("#birthday").val('<%= request.getParameter("birthday")%>');
						
		$("textarea[name='address']").val('<%= request.getParameter("address")%>');
		$("input[name='phone']").val('<%= request.getParameter("phone")%>');	
		//帶入gender資料(radio)				
		var genderData= '<%= request.getParameter("gender")%>';
		$("#register input[value='"+genderData+"']").prop('checked',true);
	<% }else if(member==null){ %>
		alert("請先登入後才能修改!");
	<% }else{  //修改時先帶入session範圍的member資料 %>
		$("input[name='id']").val('<%= member.getId()%>');
		$("input[name='email']").val('<%= member.getEmail()%>');
		$("input[name='password']").val('<%= member.getPassword()%>');
		$("input[name='name']").val('<%= member.getName()%>');				
		$("#birthday").val('<%= member.getBirthday() %>');
						
		$("textarea[name='address']").val('<%= member.getAddress()%>');
		$("input[name='phone']").val('<%=  member.getPhone() %>');
		//帶入gender資料(radio)				
		var genderData= '<%= member.getGender()%>';
		$("#register input[value='"+genderData+"']").prop('checked',true);
	<% } %>
}
function showPassword(){
	console.log(showPwdBox.checked);
	if(showPwdBox.checked){
		password.type='text';
		password2.type='text';
	}else{
		password.type='password';
		password2.type='password';
	}
}



</script>
</html>


