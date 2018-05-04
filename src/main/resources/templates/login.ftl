<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>酒店管理系统登录</title>
</head>

<link rel="stylesheet" type="text/css" href="${rca.contextPath}/resource/styles/bootstrap.min.css">
<link rel="stylesheet" type="text/css" href="${rca.contextPath}/resource/styles/sweetalert.css">
<link rel="stylesheet" type="text/css" href="${rca.contextPath}/resource/styles/nprogress.css">
<script type="text/javascript" src="${rca.contextPath}/resource/js/jquery.min.js"></script>
<script type="text/javascript" src="${rca.contextPath}/resource/js/sweetalert.js"></script>
<script type="text/javascript" src="${rca.contextPath}/resource/js/bootstrap.min.js"></script>
<script type="text/javascript" src="${rca.contextPath}/resource/js/kendo.all.min.js"></script>
<script type="text/javascript" src="${rca.contextPath}/resource/js/nprogress.js"></script>
<style>
    #wrapper {
        background:#333;
        background:rgba(0,0,0,0.5);
        background:url('${rca.contextPath}/resource/images/login-background.jpg') no-repeat center;
        width:100%;
        height:100%;
        position:fixed;
        top:0;
        left:0;
    }
    .vertical-center{
        position: absolute;
        top: 50%;
        left: 50%;
        transform: translate(-50%, -50%);
    }
</style>

<body>
<div id="wrapper">
    <div id="content">
        <div class="row">
            <div class="col-md-4 vertical-center">
                <div class="panel panel-default">
                    <div class="panel-heading">
                        <h3 class="panel-title">酒店管理系统</h3>
                    </div>
                    <div class="panel-body">
                        <form class="form-horizontal" method="post">
                            <div class="form-group">
                                <label for="account" class="col-sm-3 control-label">账号</label>
                                <div class="col-sm-7 input-group">
                                    <input type="text" class="form-control" id="account" placeholder="请输入账号">
                                    <span class="input-group-addon glyphicon glyphicon-user"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <label for="password" class="col-sm-3 control-label">密码</label>
                                <div class="col-sm-7 input-group">
                                    <input type="password" class="form-control" id="password" placeholder="请输入密码">
                                    <span class="input-group-addon glyphicon glyphicon-lock"></span>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="col-sm-offset-4 col-sm-6">
                                    <button type="button" class="btn btn-primary">登&nbsp;&nbsp;录</button>
                                    <button type="button" style="margin-left: 30px" class="btn btn-success" data-toggle='modal' data-target='#editor' data-backdrop="static">注&nbsp;&nbsp;册</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="editor" tabindex="-1" role="dialog" aria-labelledby="regEditor">
    <div class="modal-dialog" role="document">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                <h4 class="modal-title" id="regEditor">用户注册</h4>
            </div>
            <div class="modal-body">
                <form>
                    <div class="form-group">
                        <label for="reg-account" class="control-label">*账号:</label>
                        <input type="text" data-bind="value:model.account" placeholder="6-20位字母数字组合,区分大小写" class="form-control" id="reg-account">
                    </div>

                    <div class="form-group">
                        <label for="reg-password" class="control-label">*密码:</label>
                        <input type="password" data-bind="value:model.password" placeholder="6-20位字母数字组合,区分大小写" class="form-control" id="reg-password">
                    </div>

                    <div class="form-group">
                        <label for="confirm-password" class="control-label">*确认密码:</label>
                        <input type="password" data-bind="value:model.confirmPassword" class="form-control" id="confirm-password">
                    </div>

                    <div class="form-group">
                        <label for="name" class="control-label">姓名:</label>
                        <input type="text" data-bind="value:model.name" class="form-control" id="name">
                    </div>

                    <div class="form-group">
                        <label for="gender" class="control-label">性别:</label>
                        <select data-bind="value:model.gender" class="form-control" id="gender">
                            <option value="M">男</option>
                            <option value="F">女</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <label for="telephone" class="control-label">电话:</label>
                        <input type="tel" data-bind="value:model.telephone" class="form-control" id="telephone">
                    </div>

                    <div class="form-group">
                        <label for="email" class="control-label">Email:</label>
                        <input type="text" data-bind="value:model.email" class="form-control" id="email">
                    </div>

                    <div class="form-group">
                        <label for="address" class="control-label">地址:</label>
                        <input type="text" data-bind="value:model.address" class="form-control" id="address">
                    </div>

                </form>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-success" data-bind="click:registerCheck" >注册</button>
            </div>
        </div>
    </div>
</div>


<script>
    var basePath = '${rca.contextPath}';
    $(function () {

        var viewModel = kendo.observable({
            model:{},
            registerCheck:function () {
                if(!(this.model.get('account')&&this.model.get('password')&&this.model.get('confirmPassword'))){
                    swal({title:"提示",
                        text:"请将必填项填写完整",
                        type:"warning",
                        confirmButtonText:"确定"
                    });
                }else if(!/^[a-zA-Z][a-zA-Z0-9]{5,19}$/.test(this.model.get('account'))){
                    swal({title:"账号格式错误",
                        text:"请输入以字母开头且只包含字母和数字的6-20位账号",
                        type:"error",
                        confirmButtonText:"确定"
                    });
                }else if(this.model.get('password').length<6){
                    swal({title:"密码长度过短",
                        text:"请设置符合格式的密码",
                        type:"error",
                        confirmButtonText:"确定"
                    });
                }else if(this.model.get('password')!=this.model.get('confirmPassword')){
                    swal({title:"提示",
                        text:"两次输入的密码必须一致",
                        type:"warning",
                        confirmButtonText:"确定"
                    });
                }else {
                    $.ajax({
                        url:basePath+'/user/register',
                        type:'post',
                        data:this.model.toJSON(),
                        dataType:'json',
                        success:function () {
                            location.href = basePath+"/page/index";
                        }
                    });
                }
            }
        });

        kendo.bind($('#editor'), viewModel);

        $('button.btn.btn-primary').on('click',function () {
            NProgress.start();
            var account = $('#account').val()||'',
                    password = $('#password').val()||'';
            if(!(account && password)){
                NProgress.done();
                swal({title:"提示",
                    text:"账号密码不能为空！",
                    type:"warning",
                    confirmButtonText:"确定"
                });
            }else {
                $.ajax({
                    url:basePath+'/user/auth',
                    type:'post',
                    data:{account:account,password:password},
                    dataType:'json',
                    success:function (resp) {
                        if(!resp){
                            NProgress.done();
                            swal({
                                title:"登录失败",
                                text:"账号不存在或密码错误",
                                type:"error",
                                confirmButtonText:"确定"
                            });
                        }else {
                            NProgress.done();
                            location.href = basePath+"/page/index";
                        }
                    }
                });
            }
        });

        $('#reg-account').on('blur',function () {
            if(viewModel.model.get('account')){
                $.ajax({
                    url:basePath+'/user/checkUsed',
                    type:'post',
                    dataType:'json',
                    data:{account:viewModel.model.get('account')},
                    success:function (resp) {
                        if(!resp){
                            swal({
                                title:"提示",
                                text:"这个账号已被使用,请使用其他账号",
                                type:"warning",
                                confirmButtonText:"确定"
                            },function () {
                                viewModel.model.set('account','')
                            });
                        }
                    }
                })
            }
        })

    });
</script>
</body>
</html>