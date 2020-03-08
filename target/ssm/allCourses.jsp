<%@ page import="com.pym.entity.Student" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pym.entity.Course" %><%--
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
    <title>所有课程</title>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top">
    <div class="container">
        <div class="navbar-header">
            <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#navbar"
                    aria-expanded="false" aria-controls="navbar" style="margin-right: 30px">
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
                <li class="active"><a href="/courseManage">课程管理</a></li>
                <li><a href="/chooseManage">选课管理</a></li>
                <li><a href="/index">返回学生版主页</a></li>
            </ul>
        </div><!--/.nav-collapse -->

    </div>
</nav>
<%
    List<Course> course = (List<Course>) session.getAttribute("courses");
    String msg = (String) session.getAttribute("msg");
    int num = 1;
%>
<div class="container theme-showcase" role="main">

    <ol class="breadcrumb" style="margin-top: 100px">
        <li><a href="/adminIndex">首页</a></li>
        <li class="active">课程管理</li>
    </ol>
        <a href="addCourse.jsp" class="btn btn-success col-sm-offset-10">添加课程</a>
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
                <th>课程编号</th>
                <th>课程名</th>
                <th>上课时间</th>
                <th>课程学分</th>
                <th>所属学院</th>
                <th>开课地点</th>
                <th>已选人数/课程容量</th>
                <%--<th>课程描述</th>--%>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (Course c : course) {
            %>
            <tr>
                <td><%=c.getId()%>
                </td>
                <td><%=c.getName()%>
                </td>
                <td><%=c.getTime()%>
                </td>
                <td><%=c.getCredit()%>
                </td>
                <td><%=c.getBelong()%>
                </td>
                <td><%=c.getPlace()%>
                </td>
                <td><%=c.getSelected()%> / <%=c.getAmount()%>
                </td>
                <%--<td><%=c.getDetail()%>--%>
                <%--</td>--%>
                <%--<td><a href="/changeStudent?id=<%=s.getId()%>" class="btn btn-primary" id="changeStu">修改</a>--%>
                <td><a href="/changeCourse?id=<%=c.getId()%>" class="btn btn-primary">修改</a>
                    <button type="button" c_name="<%=c.getName()%>" id="del_course" cou_id="<%=c.getId()%>" onclick="del_course(this)" class="btn btn-danger">删除
                    </button>
                </td>
            </tr>
            <%
                }
            %>

            </tbody>
        </table>
    </div>

</div>

<script>
    function del_course(obj) {
        //var sid = obj.attr("stu_id");
        cid = obj.getAttribute("cou_id");
        cname = obj.getAttribute("c_name");
        console.log(cname);
        //console.log(sid);
        //console.log(obj);
        //alert(sid);
        swal({
                    title: "确定删除"+cname+"的课程信息吗？",
                    text: "你将无法恢复该课程信息！",
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
                            title: "删除成功!",
                            text: " ",
                            type: "success",
                            showConfirmButton:false,
                            timer:1500
                        });
                        setTimeout(window.location.href = "/adminDelCourse?id="+cid,1500);
                    } else {
                        swal("取消！", "该课程信息未被删除",
                                "error");
                    }
                });

    }
</script>


</body>
</html>
