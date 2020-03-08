<%@ page import="com.pym.entity.Student" %>
<%@ page import="com.pym.entity.Course" %><%--
  Created by IntelliJ IDEA.
  User: pym
  Date: 16/7/10
  Time: 13:11
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    //getContextPath()以 / 开始，不以 / 结束。
    pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!-- 上述3个meta标签*必须*放在最前面，任何其他内容都*必须*跟随其后！ -->
    <!-- Bootstrap core CSS -->
    <link href="static/bootstrap-3.3.5-dist/css/bootstrap.min.css" rel="stylesheet">
    <link href="static/css/footer.css" rel="stylesheet">
    <link href="static/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <script src="static/js/jquery-3.0.0.min.js" type="text/javascript"></script>
    <script src="static/SweetAlertSrc/sweetalert.min.js" type="text/javascript"></script>
    <link rel="stylesheet" type="text/css" href="static/SweetAlertSrc/sweetalert.css">
    <script type="text/javascript" src="static/bootstrap-3.3.5-dist/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="static/js/moment-with-locales.js"></script>
    <script type="text/javascript" src="static/js/bootstrap-datetimepicker.min.js"></script>
    <script type="text/javascript" src="static/js/bootstrap-datetimepicker.zh-CN.js"></script>
    <title>新课程信息</title>
    <style>
        body {
            padding-top: 100px;
            padding-bottom: 40px;
            background-color: #eee;
        }

        form {
            max-width: 330px;
            padding: 15px;
            margin: 0 auto;
        }
    </style>
</head>
<body>
<%
    Course c = null;
    if(session!=null){
        c = (Course) session.getAttribute("course");
        session.setAttribute("id",c.getId());
    }
%>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                    aria-expanded="false" aria-controls="navbar">
                <span class="sr-only">Toggle navigation</span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
                <span class="icon-bar"></span>
            </button>
            <a class="navbar-brand" href="#">学生选修课管理网站</a>
        </div>
        <div id="navbar" class="collapse navbar-collapse">
            <ul class="nav navbar-nav">
                <li><a href="/adminIndex">主页</a></li>
                <li ><a href="/studentManage">学生管理</a></li>
                <li class="active"><a href="/courseManage">课程管理</a></li>
                <li><a href="/chooseManage">选课管理</a> </li>
                <li><a href="/index">返回学生版主页</a></li>
            </ul>
        </div><!--/.nav-collapse -->

    </div>
</nav>

<div class="container">
    <form action="/changeCourse" method="post" id="course_change">
        <h3>新课程信息</h3>
        <div class="form-group has-success">
            <label for="name">课程名</label>
            <input type="text" class="form-control" id="name" name="name" placeholder="课程名" value="<%=c.getName()%>" required>
        </div>
        <div class="form-group has-success">
            <label for="time">上课时间</label>
            <input type="text" class="form-control" id="time" name="time" placeholder="上课时间" value="<%=c.getTime()%>" required>
        </div>
        <div class="form-group has-success">
            <label for="credit">课程学分</label>
            <input type="text" class="form-control" id="credit" name="credit" placeholder="课程学分" value="<%=c.getCredit()%>" required>
            <span class="help-block"></span>
        </div>
        <div class="form-group has-success">
            <label for="aca_select">所属学院</label>
            <%--<input type="text" class="form-control" id="belong" name="belong" placeholder="所属学院" value="<%=c.getBelong()%>" required>--%>
            <select class="form-control" id="aca_select" name="belong">
                <option><%=c.getBelong()%></option>
            </select>
        </div>
        <div class="form-group has-success">
            <label for="place">开课地点</label>
            <input type="text" class="form-control" id="place" name="place" placeholder="开课地点" value="<%=c.getPlace()%>" required>
        </div>
        <div class="form-group has-success">
            <label for="amount">课程容量</label>
            <input type="text" class="form-control" id="amount" name="amount" placeholder="课程容量" value="<%=c.getAmount()%>" required>
            <span class="help-block"></span>
        </div>
        <div class="form-group has-success">
            <label for="detail">课程描述</label>
            <textarea rows="5" type="text" class="form-control" id="detail" name="detail" placeholder="课程描述" value="" required><%=c.getDetail()%></textarea>
        </div>
        <button id="submit_btn" type="submit" class="btn btn-info">提交</button>
        <a href="/courseManage" class="btn btn-default">返回</a>
    </form>
</div>
<script type="text/javascript">
    get_aca("#aca_select");
    function get_aca(ele) {
        $.ajax({
            url: "${APP_PATH}/getAca",
            type: "get",
            success: function (result) {
                //alert("正在获取学院信息");
                console.log(result);
                var academies = result.extend.academy;
                $.each(academies, function () {
                    var optionEle = $("<option></option>").append(this.aname).attr("value", this.aname);
                    optionEle.appendTo(ele);
                })
            }
        })
    }

    function btn_disabled(flag) {
        if (flag == 1) {
            $("#submit_btn").attr("disabled","");
        } else if (flag == 0) {
            $("#submit_btn").removeAttr("disabled","");
        }
    }

    function checknull(obj) {
        if (obj.val() == ""){
            show_validate_msg(obj,"error","");
            btn_disabled(1);
        } else {
            show_validate_msg(obj,"success","");
        }
    }


    $("#course_change").bind('input porpertychange',function () {
        $("#submit_btn").removeAttr("disabled","");
        $("#credit").parent().removeClass("has-success has-error");
        $("#amount").parent().removeClass("has-success has-error");
        $("#credit").next("span").text("");
        $("#amount").next("span").text("");
        var credit = $("#credit").val();
        var amount = $("#amount").val();
        var reg_credit = /^([0-9]{1})([.]{1}[5|0]{1})$|^([0-9]{1})$/;
        var reg_amount = /^[1-9]\d*$/;
        checknull($("#name"));
        checknull($("#time"));
        checknull($("#credit"));
        checknull($("#amount"));
        checknull($("#belong"));
        checknull($("#place"));
        checknull($("#detail"));
        //alert(credit);
        if ((!reg_credit.test(credit))||(!reg_amount.test(amount))) {
            if (!reg_credit.test(credit)){
                show_validate_msg("#credit","error","请输入正确的学分！");
                btn_disabled(1);
            }
            if(!reg_amount.test(amount)){
                show_validate_msg("#amount","error","请输入正确的数量！");
                btn_disabled(1);
            }
        } else {
            $("#credit").parent().addClass("has-success");
            $("#amount").parent().addClass("has-success");
        }
    })





    function show_validate_msg(ele, status, msg) {
        //校验前把当前元素的校验状态清除
        $(ele).parent().removeClass("has-success has-error");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);

        }
    }
</script>
</body>
</html>
