<%@ page import="com.pym.entity.Student" %><%--
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
    <script src="static/js/jquery-3.0.0.min.js" type="text/javascript"></script>
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
    <title>修改学生信息</title>
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
                <li class="active"><a href="/studentManage">学生管理</a></li>
                <li><a href="/courseManage">课程管理</a></li>
                <li><a href="/chooseManage">选课管理</a> </li>
                <li><a href="/index">返回学生版主页</a></li>
            </ul>
        </div><!--/.nav-collapse -->

    </div>
</nav>

<%
    Student s = null;
    if(session!=null){
        s = (Student) session.getAttribute("student");
    }
%>
<div class="container">
<form id="change_stu_form" action="/changeStudent" method="post" accept-charset="UTF-8">
    <h3>修改学生信息</h3>
    <div class="form-group has-warning">
        <label for="id">学生学号</label>
        <input type="text" class="form-control" id="id" name="id" placeholder="学号" value="<%=s.getId()%>" readonly>
    </div>
    <div class="form-group has-success">
        <label for="name">姓名</label>
        <input type="text" class="form-control" id="name" name="name" placeholder="姓名" value="<%=s.getName()%>" required>
    </div>
    <div class="form-group has-success">
        <label for="pwd">密码</label>
        <input type="text" class="form-control" id="pwd" name="pwd" placeholder="密码" value="<%=s.getPwd()%>" required>
    </div>
    <div class="form-group">
        <label for="boy">性别</label>&nbsp;&nbsp;&nbsp;&nbsp;
        <%
            if(s.getSex()=='女'){
        %>
        <input type="radio" name="sex" value="男" id="boy">男
        <input type="radio" name="sex" value="女" id="girl" checked="true">女
        <%
            }else{
        %>
        <input type="radio" name="sex" value="男" id="boy" checked="true">男
        <input type="radio" name="sex" value="女" id="girl">女
        <%
            }
        %>
    </div>
    <div class="form-group">
        <label for="maj_add_select">专业</label>
        <select class="form-control" id="maj_add_select" name="major">
            <option><%=s.getMajor()%></option>
        </select>
    </div>

    <div class="form-group">
        <label for="nowdate">入学年份</label>
        <a class="input-group date" id="datetimepicker1">
            <input type="text" class="form-control" name="year" id="nowdate" value="<%=s.getYear()%>"
                   style="width: 250px; height: 30px;"/>
                                    <span class="input-group-addon" style="float: left; width: 50px; height: 30px;">
                                         <span class="glyphicon glyphicon-calendar"></span>
                                     </span>
        </a>
    </div>
    <button type="button" id="stu_submit" onclick="result('更新')" class="btn btn-success">提交</button>
    <a href="/studentManage" class="btn btn-default">返回</a>
</form>
</div>
<script type="text/javascript">
    get_maj("#maj_add_select");
    function get_maj(ele) {
        $.ajax({
            url: "${APP_PATH}/getMaj",
            type: "get",
            success: function (result) {
//                alert("正在获取专业信息");
                console.log(result);
                var majors = result.extend.major;
                $.each(majors, function () {
                    var optionEle = $("<option></option>").append(this.mname).attr("value", this.mname);
                    optionEle.appendTo(ele);
                })
            }
        })
    }

    function result(status) {
        swal({
            title: status+"成功!",
            text: " ",
            type: "success",
            timer:1000,
            showConfirmButton:false
        })
        setTimeout(setTimeout($("#change_stu_form").submit(),2000),2000);

    }


    Datetime();
    function Datetime() {
        $("#datetimepicker1").datetimepicker({
            language: 'zh-CN',//显示中文
            format: 'yyyy-mm-dd',//显示格式
            minView: "month",//设置只显示到月份
            initialDate: new Date(),
            autoclose: true,//选中自动关闭
            todayBtn: true,//显示今日按钮
            locale: moment.locale('zh-cn'),
        });
        //默认获取当前日期
        var today = new Date();
        var nowdate = (today.getFullYear()) + "-" + (today.getMonth() + 1) + "-" + today.getDate();
        //对日期格式进行处理
        var date = new Date(nowdate);
        var mon = date.getMonth() + 1;
        var day = date.getDate();
        mydate = date.getFullYear() + "-" + (mon < 10 ? "0" + mon : mon) + "-" + (day < 10 ? "0" + day : day);
        //document.getElementById("nowdate").value = mydate;
        //  ;
    }
    //把校验结果提示信息抽取
    function show_validate_msg(ele, status, msg) {
        //校验前把当前元素的校验状态清除
        $(ele).parent().removeClass("has-success has-error");
        $(ele).next("span").text("");
        if ("success" == status) {
            $(ele).parent().addClass("has-success");
            $(ele).next("span").text(msg);
        } else if ("error" == status) {
            $(ele).parent().addClass("has-error");
            $(ele).next("span").text(msg);
        }
    }

    check_date1();
    function check_date1() {
        $("#nowdate").change(function () {
            name = $("#name").val();
            pwd = $("#pwd").val();
            select_date = $("#nowdate").val().replace(/-/g,'');
            newday = mydate.replace(/-/g,'');
            if (select_date>newday){
                show_validate_msg("#datetimepicker1","error","")
                $("#stu_submit").attr("disabled","");
            }else {
                show_validate_msg("#datetimepicker1","success","");
                if (name != "" && pwd != ""){
                    $("#stu_submit").removeAttr("disabled","");
                }
            }
        })
    }

    $("#change_stu_form").bind('input porpertychange',function () {
        $("#name").parent().removeClass("has-success has-error");
        $("#pwd").parent().removeClass("has-success has-error");
        var name = $("#name").val();
        var pwd = $("#pwd").val();
        if (name == ""){
            show_validate_msg("#name","error","");
            $("#stu_submit").attr("disabled","");
        } else {
            show_validate_msg("#name","success","");
        }
        if (pwd == ""){
            show_validate_msg("#pwd","error","");
            $("#stu_submit").attr("disabled","");
        }else {
            show_validate_msg("#pwd","success","");
        }

        if (name != "" && pwd != ""){
            $("#stu_submit").removeAttr("disabled","");
        } else {
            $("#stu_submit").attr("disabled","");
        }
    })

</script>
</body>
</html>
