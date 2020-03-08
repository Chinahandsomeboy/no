<%@ page import="com.pym.entity.Student" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pym.entity.StudyInfo" %><%--
  Created by IntelliJ IDEA.
  User: pym
  Date: 16/7/8
  Time: 20:53
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
    <title>选课记录</title>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                    aria-expanded="false" aria-controls="navbar" >
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
                <li><a href="/studentManage">学生管理</a></li>
                <li><a href="/courseManage">课程管理</a></li>
                <li class="active"><a href="/chooseManage">选课管理</a></li>
                <li><a href="/index">返回学生版主页</a></li>
            </ul>
        </div><!--/.nav-collapse -->

    </div>
</nav>
<%
    List<StudyInfo> records = (List<StudyInfo>) session.getAttribute("records");
    String msg = (String) session.getAttribute("msg");
    int num = 1;
%>
<div class="container theme-showcase" role="main">

    <ol class="breadcrumb" style="margin-top: 100px">
        <li><a href="/adminIndex">首页</a></li>
        <li class="active">选课管理</li>
    </ol>
    <button class="btn btn-success col-lg-offset-10" id="addsel" data-toggle="modal" data-target="#myModal">添加选课记录
    </button>
    <%
        if (msg != null) {
            if (msg.equals("添加成功") || msg.equals("更新成功") || msg.equals("删除成功")) {
    %>
    <div class="alert alert-success" style="margin-top: 50px" role="alert">
        <%
        } else {
        %>
        <div class="alert alert-danger" style="margin-top: 50px" role="alert">
            <%
                }
            %>
            <strong><%=msg%>
            </strong>
        </div>

        <%
                session.setAttribute("msg", null);
            }
        %>


        <table class="table table-striped">
            <thead>

            <tr>
                <th>序号</th>
                <th>学生姓名</th>
                <th>学号</th>
                <th>学院专业</th>
                <th>课程编号</th>
                <th>课程名</th>
                <th>所属学院</th>
                <th>学分</th>
                <th>上课时间</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (StudyInfo s : records) {
            %>
            <tr>
                <td><%=num++%>
                </td>
                <td><%=s.getS_name()%>
                </td>
                <td><%=s.getS_id()%>
                </td>
                <td><%=s.getS_major()%>
                </td>
                <td><%=s.getC_id()%>
                </td>
                <td><%=s.getC_name()%>
                </td>
                <td><%=s.getC_belong()%>
                </td>
                <td><%=s.getC_credit()%>
                </td>
                <td><%=s.getC_time()%>
                </td>
                <td>
                    <%--<a href="/delStudyInfo?id=<%=s.getId()%>" class="btn btn-danger">删除</a>--%>
                    <button type="button" sel_name="<%=s.getS_name()%>" id="del_sel" sel_id="<%=s.getId()%>" onclick="del_selcourse(this)" class="btn btn-danger">删除
                    </button>
                </td>
            </tr>
            <%
                }
            %>


            </tbody>
        </table>
    </div>

    <div class="modal fade" id="myModal" tabindex="-1" role="dialog"
         aria-labelledby="myModalLabel" aria-hidden="true">
        <div class="modal-dialog">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close"
                            data-dismiss="modal" aria-hidden="true">
                        &times;
                    </button>
                    <h4 class="modal-title" id="myModalLabel">
                        添加选课记录
                    </h4>
                </div>
                <div class="modal-body">
                    <form action="/addChoose" method="post">
                        <div class="form-group">
                            <label for="stuId">学生学号</label>
                            <input type="text" class="form-control" id="stuId" name="stuId" placeholder="学号" required>
                            <span class="help-block"></span>
                        </div>
                        <div class="form-group">
                            <label for="clzId">课程编号</label>
                            <input type="text" class="form-control" id="clzId" name="clzId" placeholder="课程编号" required>
                            <span class="help-block"></span>
                        </div>
                        <div class="modal-footer">
                            <input type="submit" id="qqqq" class="btn btn-success" value="提交">
                            <button type="button" class="btn btn-default"
                                    data-dismiss="modal">关闭
                            </button>
                        </div>
                    </form>
                </div>
            </div><!-- /.modal-content -->
        </div><!-- /.modal -->
    </div>
</div>
<script>
    function del_selcourse(obj) {
        //var sid = obj.attr("stu_id");
        selid = obj.getAttribute("sel_id");
        selname = obj.getAttribute("sel_name");
        console.log(selname);
        //console.log(sid);
        //console.log(obj);
        //alert(sid);
        swal({
                    title: "确定删除"+selname+"的选课记录吗？",
                    text: "",
                    type: "warning",
                    showCancelButton: true,
                    confirmButtonColor: "#DD6B55",
                    confirmButtonText: "确定删除！",
                    cancelButtonText: "取消删除！",
                    closeOnConfirm: false,
                    closeOnCancel: false
                },
                function(isConfirm){
                    if (isConfirm) {
                        swal({
                            title: "删除选课记录成功!",
                            text: " ",
                            type: "success",
                            showConfirmButton:false,
                            timer:1500
                        });
                        setTimeout(window.location.href = "/delStudyInfo?id="+selid,1500);
                    } else {
                        swal("取消！", "该选课记录未被删除",
                                "error");
                    }
                });

    }


    function btn_disabled(flag) {
        if (flag == 1) {
            $("#qqqq").attr("disabled","");
        } else if (flag == 0) {
            $("#qqqq").removeAttr("disabled","");
        }
    }
    function reset_form(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-success has-error");
        //清空表单内容
        $(ele).find(".help-block").text("");
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
    function reset_form(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-success has-error");
        //清空表单内容
        $(ele).find(".help-block").text("");
    }

    $("#addsel").click(function () {
        reset_form("#myModal form");
        btn_disabled(1);
    })
    $("#myModal form").bind('input porpertychange',function () {
        var s_id = $("#stuId").val();
        var c_id = $("#clzId").val();
        var reg = /^[0-9]$/;
        btn_disabled(1);
        if (isNaN(s_id) || s_id == ""){
            show_validate_msg("#stuId","error","请输入正确的学号");
            btn_disabled(1);
        }else {
            show_validate_msg("#stuId","success","");
        }
        if (isNaN(c_id) || c_id == ""){
            show_validate_msg("#clzId","error","请输入正确的课程号");
            btn_disabled(1);
        }else {
            show_validate_msg("#clzId","success","");
        }
        if (s_id != "" && c_id != ""){
            btn_disabled(0);
        }
    })
</script>
</body>
</html>
