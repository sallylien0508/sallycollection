<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
	    <link rel="stylesheet" href="index.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>sally's collection</title>
        <script src="jquery.js"></script>
        <script src="https://kit.fontawesome.com/e3d7510046.js"></script>
        <script>
          var imageAr = ["css3dimg3.jpg","css3dimg6.jpg","css3dimg3.jpg","css3dimg4.jpg","css3dimg5.jpg","css3dimg6.jpg"]
          $(document).ready(init);
          function init(){
            //setTimeout(runHandler,1000);
            setInterval(runHandler,1000);
          }
          var index = 0;
          function runHandler(){
            //console.log("timeout");
            index++;
            index%=imageAr.length;//3
            $("#myImg").attr("src","images/"+ imageAr[index]);
          }
          </script>
	</head>

    
<body>
    <div class="header">
        <div class="logo"><a href="#"><img src="images/logo.png"></a></div>
        <div class="menu">
            <ul>
            <li><a href="./">首頁</a></li>
            <li><a href="products_list.html">全部商品</a></li>
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
        <img id="myImg" src="images/css3dimg3.jpg">
        <div class = "productmenu">
            <ul class="num">
                    <!-- <h2>類別</h2> -->
                    <li class="productlist"><a href = "">所有商品 </a></li>
                    <li class="productlist"><a href = "">本日精選 </a></li>
                    <li class="productlist"><a href = "">人氣推薦 </a></li>
                    <li class="productlist"><a href = "">新品上市 </a></li>
            </ul>
        </div>
            <div class="productItem">
                <h1>
                  本<br>日<br>精<br>選
                </h1>
                <img class="productimgfav" src="https://hexschool.github.io/webLayoutTraining1st/student-week1/favorite_border.png" alt="">
                <img class="productimg" src="images/womanp.jpg" alt="">
                <ul class="prodcontan">
                  <li class="name"> Sleeveless Top</li>
                  <li class="price">NT$450</li>
                </ul>
                <p>
                  <a href="#">加入購物車</a> 
                </p>
              </div>
            <div class="productItem">
                <h1>
                  本<br>日<br>精<br>選
                </h1>
                <img class="productimgfav" src="https://hexschool.github.io/webLayoutTraining1st/student-week1/favorite_border.png" alt="">
                <img class="productimg" src="images/womanp.jpg" alt="">
                <ul class="prodcontan">
                  <li class="name"> Sleeveless Top</li>
                  <li class="price">NT$450</li>
                </ul>
                <p>
                  <a href="#">加入購物車</a> 
                </p>
            </div>
            <div class="productItem">
                <h1>
                  本<br>日<br>精<br>選
                </h1>
                <img class="productimgfav" src="https://hexschool.github.io/webLayoutTraining1st/student-week1/favorite_border.png" alt="">
                <img class="productimg" src="images/womanp.jpg" alt="">
                <ul class="prodcontan">
                  <li class="name"> Sleeveless Top</li>
                  <li class="price">NT$450</li>
                </ul>
                <p>
                  <a href="#">加入購物車</a> 
                </p>
            </div>
            <div class="productItem">
                <h1>
                  本<br>日<br>精<br>選
                </h1>
                <img class="productimgfav" src="https://hexschool.github.io/webLayoutTraining1st/student-week1/favorite_border.png" alt="">
                <img class="productimg" src="images/womanp.jpg" alt="">
                <ul class="prodcontan">
                  <li class="name"> Sleeveless Top</li>
                  <li class="price">NT$450</li>
                </ul>
                <p>
                  <a href="#">加入購物車</a> 
                </p>
            </div>
            <div class="productItem">
                <h1>
                  本<br>日<br>精<br>選
                </h1>
                <img class="productimgfav" src="https://hexschool.github.io/webLayoutTraining1st/student-week1/favorite_border.png" alt="">
                <img class="productimg" src="images/womanp.jpg" alt="">
                <ul class="prodcontan">
                  <li class="name"> Sleeveless Top</li>
                  <li class="price">NT$450</li>
                </ul>
                <p>
                  <a href="#">加入購物車</a> 
                </p>
            </div>
            <div class="productItem">
                <h1>
                  本<br>日<br>精<br>選
                </h1>
                <img class="productimgfav" src="https://hexschool.github.io/webLayoutTraining1st/student-week1/favorite_border.png" alt="">
                <img class="productimg" src="images/womanp.jpg" alt="">
                <ul class="prodcontan">
                  <li class="name"> Sleeveless Top</li>
                  <li class="price">NT$450</li>
                </ul>
                <p>
                  <a href="#">加入購物車</a> 
                </p>
            </div>
            <div class="productItem">
                <h1>
                  本<br>日<br>精<br>選
                </h1>
                <img class="productimgfav" src="https://hexschool.github.io/webLayoutTraining1st/student-week1/favorite_border.png" alt="">
                <img class="productimg" src="images/womanp.jpg" alt="">
                <ul class="prodcontan">
                  <li class="name"> Sleeveless Top</li>
                  <li class="price">NT$450</li>
                </ul>
                <p>
                  <a href="#">加入購物車</a> 
                </p>
            </div>
       
        
</body>
</html> 