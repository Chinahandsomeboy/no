<%--
  Created by IntelliJ IDEA.
  User: 彭奕铭
  Date: 2018/8/5
  Time: 12:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en" class="no-js">

<head>

    <meta charset="utf-8">
    <title>Fullscreen Login</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">

    <!-- CSS -->
    <link rel="stylesheet" href="static/css/reset.css">
    <link rel="stylesheet" href="static/css/supersized.css">
    <link rel="stylesheet" href="static/css/style.css">

    <!-- HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

</head>

<body oncontextmenu="return false">

<div class="page-container">
    <h1>Login</h1>
    <form action="" method="post">
        <div>
            <input type="text" name="username" class="username" placeholder="Username" autocomplete="off"/>
        </div>
        <div>
            <input type="password" name="password" class="password" placeholder="Password" oncontextmenu="return false" onpaste="return false" />
        </div>
        <button id="submit" type="button">Sign in</button>
    </form>
    <div class="connect">
        <p>If we can only encounter each other rather than stay with each other,then I wish we had never encountered.</p>
        <p style="margin-top:20px;">如果只是遇见，不能停留，不如不遇见。</p>
    </div>
</div>
<div class="alert" style="display:none">
    <h2>消息</h2>
    <div class="alert_con">
        <p id="ts"></p>
        <p style="line-height:70px"><a class="btn">确定</a></p>
    </div>
</div>

<!-- Javascript -->
<script src="http://apps.bdimg.com/libs/jquery/1.6.4/jquery.min.js" type="text/javascript"></script>
<script src="static/js/supersized.3.2.7.min.js"></script>
<script src="static/js/supersized-init.js"></script>
<script>
    $(".btn").click(function(){
        is_hide();
    })
    var u = $("input[name=username]");
    var p = $("input[name=password]");
    $("#submit").live('click',function(){
        if(u.val() == '' || p.val() =='')
        {
            $("#ts").html("用户名或密码不能为空~");
            is_show();
            return false;
        }
        else{
            var reg = /^[0-9A-Za-z]+$/;
            if(!reg.exec(u.val()))
            {
                $("#ts").html("用户名错误");
                is_show();
                return false;
            }
        }
    });
    window.onload = function()
    {
        $(".connect p").eq(0).animate({"left":"0%"}, 600);
        $(".connect p").eq(1).animate({"left":"0%"}, 400);
    }
    function is_hide(){ $(".alert").animate({"top":"-40%"}, 300) }
    function is_show(){ $(".alert").show().animate({"top":"45%"}, 300) }
</script>
<ul id="supersized" class="quality" style="visibility: visible;"><li class="slide-0 prevslide" style="visibility: visible; opacity: 1;"><a target="_blank"><img src="static/images/1.jpg" style="width: 1020px; left: -304.5px; top: 0px; height: 714px;"></a></li><li class="slide-1 activeslide" style="visibility: visible; opacity: 1;"><a target="_blank"><img src="./img/2.jpg" style="width: 1020px; left: -304.5px; top: 0px; height: 714px;"></a></li><li class="slide-2" style="visibility: visible; opacity: 1;"><a target="_blank"><img src="./img/3.jpg" style="width: 1065.67px; height: 714px; left: -327.5px; top: 0px;"></a></li></ul>
</body>

</html>


