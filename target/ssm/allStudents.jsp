<%@ page import="com.pym.entity.Student" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: pym
  Date: 16/7/8
  Time: 20:53
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
    <title>所有学生</title>
    <style type="text/css">
        * {
            margin: 0;
            padding: 0;
            list-style-type: none;
        }

        a,
        img {
            border: 0;
        }

        body {

        }

        /* actGotop */

        .actGotop {
            position: fixed;
            _position: absolute;
            bottom: 100px;
            right: 50px;
            width: 150px;
            height: 195px;
            display: none;
        }

        .actGotop a,
        .actGotop a:link {
            width: 150px;
            height: 195px;
            display: inline-block;
            background: url(static/images/blog7year_gotop.png) no-repeat;
            _background: url(static/images/blog7year_gotop.gif) no-repeat;
            outline: none;
        }

        .actGotop a:hover {
            background: url(static/images/blog7year_gotopd.gif) no-repeat;
            outline: none;
        }
    </style>
</head>
<body style="height:2000px;">
<div class="actGotop">
    <a href="javascript:;" title="返回顶部"></a>
</div>
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
                <li class="active"><a href="/studentManage">学生管理</a></li>
                <li><a href="/courseManage">课程管理</a></li>
                <li><a href="/chooseManage">选课管理</a></li>
                <li><a href="/index">返回学生版主页</a></li>
            </ul>
        </div><!--/.nav-collapse -->

    </div>
</nav>
<%
    List<Student> students = (List<Student>) session.getAttribute("students");
    String msg = (String) session.getAttribute("msg");
    int num = 1;
%>
<%--学生添加模态框
    以下所有name属性，应该和bean中的属性一致，方便springmvc.
--%>
<div class="modal fade" id="stuAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModalLabel">
                    学生用户添加
                </h4>
            </div>
            <div class="modal-body">
                <form class="form-horizontal" role="form">
                    <div class="form-group">
                        <label class="col-sm-2 control-label">学号</label>
                        <div class="col-sm-8">
                            <input type="text" name="id" class="form-control" id="stuId_input"
                                   placeholder="请输入学号,不可重复" autocomplete="off">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">姓 名</label>
                        <div class="col-sm-8">
                            <input type="text" name="name" class="form-control" id="name_input" placeholder="请输入姓名">
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">性 别</label>
                        <div class="col-sm-8">
                            <label class="radio-inline ">
                                <input type="radio" name="sex" value="男" autocomplete="off" checked="checked"/>男
                            </label>
                            <label class="radio-inline ">
                                <input type="radio" name="sex" value="女" autocomplete="off"/>女
                            </label>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">入学年份</label>
                        <div class="col-sm-8">
                            <a class="input-group date" id="datetimepicker1" style="float: left;">
                                <input type="text" class="form-control" name="year" id="nowdate"
                                       style="width: 150px; height: 30px;"/>
                                    <span class="input-group-addon" style="float: left; width: 50px; height: 30px;">
                                         <span class="glyphicon glyphicon-calendar"></span>
                                     </span>
                            </a>
                            <span class="help-block"></span>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">专 业</label>
                        <div class="col-sm-8">
                            <select class="form-control" id="maj_add_select" name="major">
                            </select>
                        </div>
                    </div>
                    <div class="form-group">
                        <label class="col-sm-2 control-label">密 码</label>
                        <div class="col-sm-8">
                            <input type="password" name="pwd" class="form-control" id="pwd_input1" placeholder="请输入密码">
                            <span class="help-block"></span>
                            <%--<input type="password" name="pwd" class="form-control" id="pwd_input2" placeholder="请再次输入密码">--%>
                            <%--<span class="help-block"></span>--%>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">
                    <span class="glyphicon glyphicon-remove" aria-hidden="true"></span>关闭
                </button>
                <button type="button" class="btn btn-primary" id="stu_save_btn">
                    <span class="glyphicon glyphicon-floppy-disk" aria-hidden="true"></span>提交更改
                </button>
            </div>
        </div>
        <!-- /.modal-content -->
    </div>
    <!-- /.modal -->
</div>


<div class="container theme-showcase" role="main">

    <ol class="breadcrumb" style="margin-top: 100px">
        <li><a href="/adminIndex">首页</a></li>
        <li class="active">学生管理</li>
    </ol>
    <a class="col-sm-offset-10">
        <button type="button" class="btn btn-info" data-toggle="modal" data-target="#stuAddModal"
                id="stu_modal_add_btn">添加新学生
        </button>
    </a>
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
                <th>密码</th>
                <th>专业</th>
                <th>性别</th>
                <th>入学年份</th>
                <th>操作</th>
            </tr>
            </thead>
            <tbody>
            <%
                for (Student s : students) {
            %>
            <tr>
                <td><%=num++%>
                </td>
                <td><%=s.getName()%>
                </td>
                <td><%=s.getId()%>
                </td>
                <td><%=s.getPwd()%>
                </td>
                <td><%=s.getMajor()%>
                </td>
                <td><%=s.getSex()%>
                </td>
                <td><%=s.getYear()%>
                </td>
                <%--<td><a href="/changeStudent?id=<%=s.getId()%>" class="btn btn-primary" id="changeStu">修改</a>--%>
                <td><a href="/changeStudent?id=<%=s.getId()%>" class="btn btn-primary" id="changeStu">修改</a>
                    <%--<a href="/delStudent?id=<%=s.getId()%>" class="studel btn btn-danger">删除</a>--%>
                    <button type="button" s_name="<%=s.getName()%>" id="del_stu" stu_id="<%=s.getId()%>" onclick="del_stu(this)" class="btn btn-danger">删除
                    </button>
                    <%--/delStudent?id=<%=s.getId()%>--%>
                </td>
            </tr>
            <%
                }
            %>
            <tr>
                <td colspan="7">&nbsp</td>
                <td>

                </td>
            </tr>

            </tbody>
        </table>
    </div>

</div>
<script type="text/javascript">

    //设置日期时间控件
    //设置日期时间控件
    Datetime();
    addStu();
    checkId();
    clickAddStu();
    function del_stu(obj) {
        //var sid = obj.attr("stu_id");
        sid = obj.getAttribute("stu_id");
        sname = obj.getAttribute("s_name");
        //console.log(sid);
        //console.log(obj);
        //alert(sid);
        swal({
                    title: "确定删除"+sname+"的学生信息吗？",
                    text: "你将无法恢复该学生信息！",
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
                        setTimeout(window.location.href = "/delStudent?id="+sid,1500);
                    } else {
                        swal("取消！", " ",
                                "error");
                    }
                });

    }

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
    //每次点击注册按钮，将原来的样式清空
    //清除表单数据（表单重置）jQ没有reset方法，要转换成dom对象http://www.jb51.net/article/49747.htm、http://www.jquerycn.cn/a_4561
    //百度jq对象转换为dom对象
    //表单重置了表单中填写的数据，还需要重置的样式（has-success...之类的）
    //$("#empAddModal form")[0].reset();
    function reset_form(ele) {
        $(ele)[0].reset();
        //清空表单样式
        $(ele).find("*").removeClass("has-success has-error");
        //清空表单内容
        $(ele).find(".help-block").text("");
    }


    function clickAddStu() {
        $("#stu_modal_add_btn").click(function () {
            reset_form("#stuAddModal form");
            get_maj("#maj_add_select");
            btn_disabled(1);
            $("#nowdate").val(mydate);
            $("#stuAddModal").modal({
                backdrop: static
            })
        })
    }

    function btn_disabled(flag) {
        if (flag == 1) {
            $("#stu_save_btn").attr("disabled", "");
        } else if (flag == 0) {
            $("#stu_save_btn").removeAttr("disabled", "");
        }
    }

    check_date2();
    function check_date() {
        $("#nowdate").bind('input porpertychange', function () {
            var select_date = $("#nowdate").val().replace(/-/g, '');
            var newday = mydate.replace(/-/g, '');
            if (select_date > newday) {
                alert("sb");
                show_validate_msg("#datetimepicker1", "error", "")
                btn_disabled(1);
            }
        })
    }
    check_date2();
    function check_date2() {
        $("#nowdate").change(function () {
            sid = $("#stuId_input").val();
            select_date = $("#nowdate").val().replace(/-/g,'');
            newday = mydate.replace(/-/g,'');
            if (select_date>newday){
                show_validate_msg("#datetimepicker1","error","");
                btn_disabled(1);
            }else {
                show_validate_msg("#datetimepicker1","success","");
                if ($("#name_input").val() != "" && $("#pwd_input1").val() != "" && sid != ""){
                    $("#nowdate").attr("test","success");
                    btn_disabled(0);
                }

            }
        })
    }


    function checkId() {
        //正则和查重校验学号是否可用
        $("#stuAddModal form").bind('input porpertychange', function () {
            var sid = $("#stuId_input").val();
            //^1\d{9}$
            var regsid = /^1\d{8}$/;
            if (!regsid.test(sid)) {
                show_validate_msg("#stuId_input", "error", "学号是1开头的9位数字，如140401020");

                btn_disabled(1);
            } else {
                var id = $("#stuId_input").val();
//            alert("运行查重" + id);
                $.ajax({
                    url: "${APP_PATH}/checkId/" + id,
                    type: "GET",
                    success: function (result) {
//                    alert(result.msg);
                        if (result.code == 100) {
                            show_validate_msg("#stuId_input", "success", "学号可用！");
                            if ($("#name_input").val() == (undefined || "")) {
                                show_validate_msg("#name_input", "error", "")
                                btn_disabled(1);
                            } else {
                                show_validate_msg("#name_input", "success", "")
                            }
                            if ($("#pwd_input1").val() == (undefined || "")) {
                                show_validate_msg("#pwd_input1", "error", "")
                                btn_disabled(1);
                            } else {
                                show_validate_msg("#pwd_input1", "success", "")
                                btn_disabled(1);
                            }

                            if (($("#name_input").val() != "" && $("#pwd_input1").val() != "" && sid != "")) {
                                btn_disabled(0);
                            }
                        }
                        else if (result.code == 200) {
                            show_validate_msg("#stuId_input", "error", "已有相同的学号!");
                            if ($("#name_input").val() == (undefined || "")) {
                                show_validate_msg("#name_input","error","")
                                btn_disabled(1);
                            }else {
                                show_validate_msg("#name_input","success","")
                            }
                            if ($("#pwd_input1").val() == (undefined || "")){
                                show_validate_msg("#pwd_input1","error","")
                                btn_disabled(1);
                            }else {
                                show_validate_msg("#pwd_input1","success","")
                                btn_disabled(1);
                            }
                            btn_disabled(1);
                        }
                    }
                })
            }
        });
    }


    function addStu() {
        //点击“提交更改”，保存学生信息
        $("#stu_save_btn").click(function () {
            //验证学号是否合法
            var sid = $("#stuId_input").val();
            var regsid = /^1\d{8}$/;
            if (!regsid.test(sid)) {
                show_validate_msg("#stuId_input", "error", "请输入正确的学号格式");
                btn_disabled(1);
            } else {
                show_validate_msg("#stuId_input", "success", "");
            }

            btn_disabled(0);
            //将模态框中填写的数据提交给服务器进行保存
            //alert($("#empAddModal form").serialize());
            //结果是这样：empName=123&email=123&gender=M&dId=1
            var formval = $("#stuAddModal form").serialize();
            formval = decodeURIComponent(formval, true); //将数据解码 不然会乱码
//        alert(formval);
            $.ajax({
                url: "${APP_PATH}/regStu",
                type: "POST",//这里要和controller中的method = RequestMethod.POST一样。
                //下面data，可以通过js拿到每个值，在拼装成我们想要的数据，但是太麻烦，JQ有一个简单的方法。serialize!!!
                data: formval,
                success: function (result) {
//                alert(result.msg);
                    if (result.code == 100) {
                        // * 员工保存成功后，需要做两个步骤：
                        // * 1.关闭当前模态框
                        $("#stuAddModal").modal("hide");
                        $(".alert").remove();
                        swal("添加成功！", " ", "success");
                        window.location.href = "/studentManage";
                        //* 2.返回到最后一页显示新添加的数据
                        //发送ajax请求显示最后一页数据即可，因为pageHelper认为超过总页码的数，就是最后一页！所以可以传9999，更好方法是传total
                    }

                },
            });

        })
    }

    //查询专业信息并构建option
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

    $(function () {

        $(window).scroll(function () {

            if ($(window).scrollTop() >= 100) {

                $('.actGotop').fadeIn(300);

            } else {

                $('.actGotop').fadeOut(300);

            }

        });

        $('.actGotop').click(function () {

            $('html,body').animate({
                scrollTop: '0px'
            }, 800);
        });

    });
</script>
</body>
</html>
