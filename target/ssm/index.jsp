<%@ page import="com.pym.entity.Course" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: pym
  Date: 16/7/5
  Time: 11:19
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
    <title>用户登陆</title>
</head>
<%
    String id = null;
    String msg = null;
    if (session != null) {
        id = (String) session.getAttribute("user");
        msg = (String) session.getAttribute("msg");
    }
%>
<body role="document">
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
                <li class="active"><a href="/index">主页</a></li>
                <li><a href="/showAllClasses">所有选修课</a></li>
                <li><a href="/showMyClasses">我的选修课</a></li>
                <li><a href="/AdminLogin2.jsp">管理员登录</a></li>
            </ul>
            <%
                if (id != null) {
            %>

            <ul class="nav navbar-nav navbar-right">
                <li><a style="color: white"><strong><%=id%> 欢迎您!</strong>
                </a></li>
                <li><a id="change" href="#" data-toggle="modal"
                       data-target="#myModal">修改密码</a></li>
                <li><a href="/logout">退出登录</a></li>
            </ul>
            <%
            } else {
            %>
            <form class="navbar-form navbar-right" action="/login" method="post">
                <!-- 下面的required：如果未输入会提示”请输入该字段“，想要自定义，则需要：https://www.jianshu.com/p/76b451a3ff80 -->
                <div class="form-group">
                    <input type="text" placeholder="学号" id="id_input" class="form-control" name="id" required
                           oninvalid="setCustomValidity('请输入学号！');" oninput="setCustomValidity('');">
                </div>
                <div class="form-group">
                    <input type="password" placeholder="密码" class="form-control" name="pwd" required
                           oninvalid="setCustomValidity('请输入密码！');" oninput="setCustomValidity('');">
                </div>
                <button type="submit" class="btn btn-success">登录</button>
                <button type="button" class="btn btn-info" data-toggle="modal" data-target="#stuAddModal"
                        id="stu_modal_add_btn">注册
                </button>
            </form>
            <%
                }
            %>
        </div><!--/.nav-collapse -->

    </div>
</nav>

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
                    <strong>学生注册</strong>
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
                        <div class="col-sm-8 has-success">
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
                    <div class="form-group has-success">
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
    <%
        if (msg != null) {
            if (msg == "修改成功!") {
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
        <div class="jumbotron" style="color: #f9f9f9;background-image: url(static/pic/bjdx.jpg)">
            <br>
            <h2>欢迎登陆学生选修课管理网站!</h2>
            <p>welcome to students' elective courses manage system!</p>
        </div>

        <div class="container">
            <ol class="breadcrumb" style="margin-top: 10px">
                <li class="active"><strong style="color: #2D93CA">热门选修课</strong>&nbsp;&nbsp;<span class="badge">6</span></li>
            </ol>
            <!-- Example row of columns -->
            <div class="row">

                <%
                    int i = 0;
                    List<Course> clzs = (List<Course>) session.getAttribute("clzs");
                    if (!(clzs == null || clzs.isEmpty())) {
                        for (Course clz : clzs) {
                            if (i == 6) break;
                            i++;
                    int left = clz.getAmount().intValue() - clz.getSelected().intValue();
                %>

                <div class="col-md-4" style="border-top: 2px solid #c4cac7">
                    <h2 style="background-color:#F5F5F5;"><%=clz.getName()%></h2>&nbsp;&nbsp;
                    <p>剩余可选人数:&nbsp;&nbsp;<span class="badge"><%=left%></span></p>
                    <p>所属学院:&nbsp;&nbsp;<%=clz.getBelong()%>
                    </p>
                    <p><%=clz.getDetail()%>
                    </p>
                    <p><a class="btn btn-info" href="/showDetail?id=<%=clz.getId()%>" role="button">查看详情 &raquo;</a></p>
                </div>
                <%
                        }
                    }
                %>
            </div>
        </div>
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
                        修改密码
                    </h4>
                </div>
                <div class="modal-body">
                    <form action="/changePwd" method="post">
                        <div class="form-group">
                            <label for="old">旧密码</label>
                            <input type="password" class="form-control" id="old" name="old" placeholder="旧密码" required>
                            <span class="help-block"></span>
                        </div>
                        <div class="form-group">
                            <label for="newpwd">新密码</label>
                            <input type="password" class="form-control" id="newpwd" name="newpwd" placeholder="新密码"
                                   required>
                            <span class="help-block"></span>
                        </div>
                        <div class="form-group">
                            <label for="newagain">确认新密码</label>
                            <input type="password" class="form-control" id="newagain" name="newagain"
                                   placeholder="再次输入新密码" required>
                            <span class="help-block"></span>
                        </div>
                        <div class="modal-footer">
                            <input type="submit" class="btn btn-success" id="changepwd" value="提交">
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
<footer style="text-align: center">©2018 YiMingPeng. All rights reserved.</footer>
<script type="text/javascript">

    $("#change").click(function () {
        reset_form("#myModal form");
        $("#changepwd").attr("disabled","");
    })

    $("#myModal form").bind('input porpertychange',function () {
        if ($("#oid").val()==""){
            show_validate_msg("#oid","error","");
            $("#changepwd").attr("disabled","");
        }else {
            show_validate_msg("#oid","success","");
        }
        if ($("#newpwd").val()==""){
            show_validate_msg("#newpwd","error","");
        }else {
            show_validate_msg("#newpwd","success","");
        }
        if ($("#newagain").val()==""){
            show_validate_msg("#newagain","error","");
        }
        if ($("#newpwd").val() != $("#newagain").val()){
            show_validate_msg("#newagain","error","两次密码输入不一致");
        }else {
            if ($("#newpwd").val()==""){
                show_validate_msg("#newagain","error","");
            }else {
                show_validate_msg("#newagain","success","")
            }
        }
        if ($("#oid").val()!="" && $("#newpwd").val()!="" && $("#newagain").val()!="" && $("#newpwd").val() == $("#newagain").val()){
            $("#changepwd").removeAttr("disabled","");
        }

    })

    $(function(){
        function footerPosition(){
            $("footer").removeClass("fixed-bottom");
            var contentHeight = document.body.scrollHeight,//网页正文全文高度
                    winHeight = window.innerHeight;//可视窗口高度，不包括浏览器顶部工具栏
            if(!(contentHeight > winHeight)){
                //当网页正文高度小于可视窗口高度时，为footer添加类fixed-bottom
                $("footer").addClass("fixed-bottom");
            } else {
                $("footer").removeClass("fixed-bottom");
            }
        }
        footerPosition();
        $(window).resize(footerPosition);
    });


    //设置日期时间控件
    Datetime();
    addStu();
    checkId();
    clickAddStu();

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
            $("#stu_save_btn").attr("disabled","");
        } else if (flag == 0) {
            $("#stu_save_btn").removeAttr("disabled","");
        }
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
                            if (($("#name_input").val() != "" && $("#pwd_input1").val() != "" && sid != "" ))
                            {
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
            formval = decodeURIComponent(formval, true); //将数据解码
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
                        swal("注册成功！", "输入密码即可登录","success");
                        $("#id_input").val(sid);
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

</script>
</body>
</html>
