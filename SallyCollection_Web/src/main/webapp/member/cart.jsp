<%@ page pageEncoding="UTF-8"%>
<html>
    <head>
        <link rel="stylesheet" href="<%= request.getContextPath() %>/index.css">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>sally's collection_cart</title>
        <script src="https://kit.fontawesome.com/e3d7510046.js"></script>
        <script src="https://code.jquery.com/jquery-3.0.0.js" integrity="sha256-jrPLZ+8vDxt2FnE1zvZXCkCcebI/C8Dt5xyaQBjxQIo=" crossorigin="anonymous"></script>
		<style>
        article{
        margin:200px auto;
        }
        #cart {
                  font-family: Arial, Helvetica, sans-serif;
                  border-collapse: collapse;
                  width: 80%;
                  margin: auto;
                }
               
                #cart td, #cart th {
                  border: 1px solid #ddd;
                  padding: 8px; text-align: center;
                }
               
                #cart tr:nth-child(even){background-color: #f2f2f2;}
               
                #cart tr:hover {background-color: #ddd;}
                
               	#cart tbody img{width:56px;vertical-align: middle;}
               	
                #cart caption{
                  padding-top: 12px;
                  padding-bottom: 12px;              
                  background-color: #04AA6D;
                  color: white;
                }
               
                #cart th{
                  padding-top: 12px;
                  padding-bottom: 12px;              
                  background-color: darkgray;
                  color: white;
                }
               
                #cart tfoot td{text-align: right}
        </style>    
    </head>
    <body>     
    <header>
		<jsp:include page="/subviews/header.jsp" />  
	    <jsp:include page="/subviews/nav.jsp" />
	</header>	  
        <article>
            <table id='cart'>
                <caption>購物明細</caption>
                <thead>
                    <tr>
                    <th>名稱</th>
                    <th>顏色/Size</th>
                    <th>價格</th>
                    <th>數量</th>
                    <th>小計</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>     
                    	     
                        <td><img src ='<%= request.getContextPath() %>/images/red.jpg'>  
                        Java 7 教學手冊 第五版(附光碟)</td>
                        <td></td>
                        <td>
                            定價：650.0元<br>
                            優惠價：9折<br>
                            585.0元
                        </td>
                        <td>2</td>
                        <td>1170.0</td>
                    </tr>  
                    <tr>                
                        <td>【德國LYRA】Groove三角洞洞色鉛筆</td>
                        <td>紅</td>
                        <td>
                            定價：70.0元<br>
                            優惠價：9折<br>
                            63.0元
                        </td>
                        <td>1</td>
                        <td>63</td>
                    </tr>
                    <tr>                
                        <td>【德國LYRA】Groove三角洞洞色鉛筆</td>
                        <td>藍</td>
                        <td>
                            定價：70.0元<br>
                            優惠價：9折<br>
                            63.0元
                        </td>
                        <td>1</td>
                        <td>63</td>
                    </tr>
                    <tr>                
					    <td>Pentel百點橡皮擦</td>
					    <td>白/S</td>
					    <td>
					        定價：10元<br>
					        優惠價：8折<br>
					        8元
					    </td>
					    <td>1</td>
					    <td>8</td>
					</tr>  
                </tbody>
                <tfoot>
                    <tr>
                        <td colspan="5">
                            總計: 1304元
                        </td>
                    </tr>
                </tfoot>
            </table>
        </article>
       <%@ include file="/subviews/footer.jsp" %>
   
    </body>
</html>





