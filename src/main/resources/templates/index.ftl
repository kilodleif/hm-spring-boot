<html>
<head>
    <title>酒店管理系统</title>
    <link rel="stylesheet" type="text/css" href="${rca.contextPath}/resource/styles/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${rca.contextPath}/resource/font-awesome-4.6.3/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${rca.contextPath}/resource/styles/sweetalert.css">
    <script type="text/javascript" src="${rca.contextPath}/resource/js/jquery.min.js"></script>
    <script type="text/javascript" src="${rca.contextPath}/resource/js/bootstrap.min.js"></script>
    <script type="text/javascript" src="${rca.contextPath}/resource/js/sweetalert.js"></script>
    <style>
        .nav a {
            color: black;
        }
        ul.nav.nav-list span{
            margin-left: 20px;
        }
        #page-content div.navbar,div.col-md-2,iframe.col-md-10{
            margin: 0;padding: 0;
        }
    </style>
</head>
<body>
<div id="page-content">
    <div class="navbar navbar-default">
        <div class="container-fluid" style="margin-right: 20px">
            <div class="navbar-brand"><h4>酒店管理系统</h4></div>
            <div class="navbar-text navbar-right btn-group" style="">
                <button type="button" class="btn btn-default dropdown-toggle" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">
                    <span class="fa fa-user"></span>
                    ${_operator.account}
                    <span class="caret"></span>
                </button>
                <ul class="dropdown-menu">
                    <li><a id="view-info" data-toggle='modal' data-target='#info-editor' data-backdrop="static">个人信息</a></li>
                    <li><a data-toggle='modal' data-target='#password-editor' data-backdrop="static">修改密码</a></li>
                    <li role="separator" class="divider"></li>
                    <li><a id="logout">退出</a></li>
                </ul>
            </div>
        </div>
    </div>

    <div id="nav-menu" style="height: 90%">
        <div class="col-md-2">
            <ul class="nav nav-list" style="background: #f8f8f8">
                <#if _operator.userType == 'USER'>
                    <li>
                        <a href="#">
                            <i class="fa fa-home"></i>
                            <span>客房查询</span>
                            <i class="fa fa-chevron-right" style="float:right;"></i>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fa fa-cutlery"></i>
                            <span>菜肴查询</span>
                            <i class="fa fa-chevron-right" style="float:right;"></i>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fa fa-shopping-cart"></i>
                            <span>个人账单</span>
                            <i class="fa fa-chevron-right" style="float:right;"></i>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fa fa-comments-o"></i>
                            <span>留言</span>
                            <i class="fa fa-chevron-right" style="float:right;"></i>
                        </a>
                    </li>
                </#if>

                <#if _operator.userType == 'ADMIN'>
                    <li>
                        <a href="#">
                            <i class="fa fa-list"></i>
                            <span>订单处理</span>
                            <i class="fa fa-chevron-right" style="float:right;"></i>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fa fa-home"></i>
                            <span>客房信息维护</span>
                            <i class="fa fa-chevron-right" style="float:right;"></i>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fa fa-cutlery"></i>
                            <span>菜肴信息维护</span>
                            <i class="fa fa-chevron-right" style="float:right;"></i>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fa fa-user"></i>
                            <span>用户管理</span>
                            <i class="fa fa-chevron-right" style="float:right;"></i>
                        </a>
                    </li>
                    <li>
                        <a href="#">
                            <i class="fa fa-comments-o"></i>
                            <span>留言</span>
                            <i class="fa fa-chevron-right" style="float:right;"></i>
                        </a>
                    </li>
                </#if>
            </ul>
        </div>

        <#if _operator.userType == 'USER'>
            <iframe id="main-content" style="height: 90%" src="${rca.contextPath}/page/queryRoom" frameborder="0" class="col-md-10" >无法加载此页面</iframe>
        </#if>

        <#if _operator.userType == 'ADMIN'>
            <iframe id="main-content" style="height: 90%" src="${rca.contextPath}/page/orderOperation" frameborder="0" class="col-md-10" >无法加载此页面</iframe>
        </#if>
    </div>

    <div class="modal fade" id="info-editor" tabindex="-1" role="dialog" aria-labelledby="userInfo">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="userInfo">修改用户信息</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="account" class="control-label">账号:</label>
                            <input type="text" readonly class="form-control" id="account">
                        </div>
                        <div class="form-group">
                            <label for="name" class="control-label">姓名:</label>
                            <input type="text" class="form-control" id="name">
                        </div>
                        <div class="form-group">
                            <label for="gender" class="control-label">性别:</label>
                            <select class="form-control" id="gender">
                                <option value="M">男</option>
                                <option value="F">女</option>
                            </select>
                        </div>
                        <div class="form-group">
                            <label for="telephone" class="control-label">电话:</label>
                            <input type="tel" class="form-control" id="telephone">
                        </div>
                        <div class="form-group">
                            <label for="email" class="control-label">Email:</label>
                            <input type="text" class="form-control" id="email">
                        </div>
                        <div class="form-group">
                            <label for="address" class="control-label">地址:</label>
                            <input type="text" class="form-control" id="address">
                        </div>

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="save-info">保存信息</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="password-editor" tabindex="-1" role="dialog" aria-labelledby="alterPassword">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="alterPassword">修改密码</h4>
                </div>
                <div class="modal-body">
                    <form>
                        <div class="form-group">
                            <label for="old-password" class="control-label">旧密码:</label>
                            <input type="password" class="form-control" id="old-password">
                        </div>
                        <div class="form-group">
                            <label for="password" class="control-label">新密码:</label>
                            <input type="password" placeholder="6-20位字母数字组合,区分大小写" class="form-control" id="password">
                        </div>
                        <div class="form-group">
                            <label for="confirm-password" class="control-label">确认密码:</label>
                            <input type="password" class="form-control" id="confirm-password">
                        </div>

                    </form>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="save-password">保存</button>
                </div>
            </div>
        </div>
    </div>

    <div class="navbar navbar-default navbar-fixed-bottom">
        <div class="container-fluid" style="text-align: center;line-height: 45px;">
            Copyright © 2018 kilodleif. All Rights Reserved.
        </div>
    </div>

</div>

<script>
    var basePath = '${rca.contextPath}';
    $(function () {
        $('#nav-menu a').on('click',function () {
            var fn = $(this).find('span').text(),page=basePath;
            if(fn==='客房查询'){
                page += '/page/queryRoom'
            }else if(fn==='菜肴查询'){
                page += '/page/queryFood'
            }else if(fn==='个人账单'){
                page += '/page/personalOrder'
            }else if(fn==='留言'){
                page += '/page/comment'
            }else if(fn==='订单处理'){
                page += '/page/orderOperation'
            }else if(fn==='客房信息维护'){
                page += '/page/roomInfoMaintain'
            }else if(fn==='菜肴信息维护'){
                page += '/page/foodInfoMaintain'
            }else if(fn==='用户管理'){
                page += '/page/userManage'
            }else if(fn==='留言管理'){
                page += '/page/commentManage'
            } else {
                page += '/page/error';
            }
            $('#main-content').attr('src',page);
        });

        $('#logout').on('click',function () {
            location.href = basePath+'/user/logout';
        });

        $('#view-info').on('click',function () {
            $.ajax({
                url:basePath+'/userInfo/fetch',
                type:'post',
                data:{
                    userId:'${_operator.userId}'
                },
                dataType:'json',
                success:function (resp) {
                    $('#account').val('${_operator.account}');
                    $('#name').val(resp.name);
                    $('#gender').val(resp.gender);
                    $('#telephone').val(resp.telephone);
                    $('#email').val(resp.email);
                    $('#address').val(resp.address);
                }
            });
        });

        $('#save-info').on('click',function () {
            $.ajax({
                url:basePath+'/userInfo/update',
                type:'post',
                data:{
                    userId:'${_operator.userId}',
                    name:$('#name').val(),
                    gender:$('#gender').val(),
                    telephone:$('#telephone').val(),
                    email:$('#email').val(),
                    address:$('#address').val()
                },
                dataType:'json',
                success:function (resp) {
                    if(resp){
                        swal({title:"提示",
                            text:"修改个人信息成功",
                            type:"success",
                            confirmButtonText:"确定"
                        },function () {
                            $('#info-editor').modal('hide');
                        });
                    }
                }
            });
        });

        $('#password-editor').on('show.bs.modal',function () {
            $('#password').val('');
            $('#confirm-password').val('');

        });

        $('#save-password').on('click',function () {
            var password = $('#password').val(),
                confirmPassword = $('#confirm-password').val(),
                oldPassword=$('#old-password').val();
            if(!(password&&confirmPassword&&oldPassword)){
                swal({title:"提示",
                    text:"请将必填项填写完整",
                    type:"warning",
                    confirmButtonText:"确定"
                });
            }else if(oldPassword!=='${_operator.password}'){
                swal({title:"旧密码错误",
                    text:"请输入正确的旧密码",
                    type:"error",
                    confirmButtonText:"确定"
                });
            }else if(password.length<6){
                swal({title:"密码长度过短",
                    text:"请设置符合格式的密码",
                    type:"error",
                    confirmButtonText:"确定"
                });
            }else if(password!==confirmPassword){
                swal({title:"提示",
                    text:"两次输入的密码必须一致",
                    type:"warning",
                    confirmButtonText:"确定"
                });
            }else {
                $.ajax({
                    url:basePath+'/user/alterPassword',
                    type:'post',
                    data:{password:password},
                    dataType:'json',
                    success:function (resp) {
                        if(resp){
                            swal({
                                title:"提示",
                                text:"修改密码成功",
                                type:"success",
                                confirmButtonText:"确定"
                            },function () {
                                $('#password-editor').modal('hide');
                            });
                        }
                    }
                });
            }
        })
    })
</script>
</body>
</html>
