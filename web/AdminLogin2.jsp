<%--
  Created by IntelliJ IDEA.
  User: 彭奕铭
  Date: 2018/2/24
  Time: 11:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //getContextPath()以 / 开始，不以 / 结束。
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>管理员</title>
    <script src="static/js/jquery-3.0.0.min.js" type="text/javascript"></script>
    <script src="static/SweetAlertSrc/sweetalert.min.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="static/SweetAlertSrc/sweetalert.css">
    <link rel="stylesheet" type="text/css" href="static/css/default2.css">
    <link rel="stylesheet" type="text/css" href="static/css/styles.css">
</head>
<body>
<article class="htmleaf-container">
    <header class="htmleaf-header">
        <h1>学生选修课管理系统 <span>students' elective courses manage system</span></h1>
        <div class="htmleaf-links">

        </div>
    </header>
    <div class="panel-lite">
        <div class="thumbur">
            <div class="icon-lock"></div>
        </div>
        <h4>管理员登录</h4>
        <form>
            <div class="form-group">
                <input name="username" required="required" class="form-control"/>
                <label class="form-label">身份证号 </label>
            </div>
            <div class="form-group">
                <input name="pwd" type="password" required="required" class="form-control"/>
                <label class="form-label">密　码</label>
            </div>
            <a href="#">没有账号？请联系教务处 </a>
            <button id="admin_add" type="button" class="floating-btn"><i class="icon-arrow"></i></button>
        </form>
    </div>

</article>
<script type="text/javascript">

    function goai(){
        window.location.href = "/adminIndex";
    }

    $("#admin_add").click(function () {
        $.ajax({
            url: "${APP_PATH}/adminLogin",
            data: $("form").serialize(),
            //同上data:{"username":username,"pwd":pwd},
            type: "POST",
            success: function (result) {
                //console.log(result);
                if (result.code == 100) {
                    swal({
                        title: "登录成功!",
                        text: " ",
                        type: "success",
                        showConfirmButton:false
                    });
                    setTimeout(goai,1000)

                } else {
                    swal({
                        title: "登录失败!",
                        text: " ",
                        type: "error",
                        showConfirmButton:false,
                        timer:1000
                    });
                }
            }
        })
    })
</script>

</body>
</html>