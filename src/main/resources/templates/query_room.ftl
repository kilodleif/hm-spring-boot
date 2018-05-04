<html>
<head>
    <title>客房查询</title>

    <link rel="stylesheet" type="text/css" href="${rca.contextPath}/resource/styles/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${rca.contextPath}/resource/font-awesome-4.6.3/css/font-awesome.min.css">
    <link rel="stylesheet" type="text/css" href="${rca.contextPath}/resource/styles/kendo.bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="${rca.contextPath}/resource/styles/kendo.common-bootstrap.min.css"/>
    <link rel="stylesheet" type="text/css" href="${rca.contextPath}/resource/styles/kendo.hap.css">
    <link rel="stylesheet" type="text/css" href="${rca.contextPath}/resource/styles/sweetalert.css">

    <script src="${rca.contextPath}/resource/js/jquery.min.js"></script>
    <script src="${rca.contextPath}/resource/js/bootstrap.min.js"></script>
    <script src="${rca.contextPath}/resource/js/kendo.all.min.js"></script>
    <script src="${rca.contextPath}/resource/js/kendo.messages.zh-CN.js"></script>
    <script src="${rca.contextPath}/resource/js/kendo.culture.zh-CN.js"></script>
    <script src="${rca.contextPath}/resource/js/sweetalert.js"></script>

</head>
<body>
    <h2 align="center">客房查询</h2>
    <div id="page-content">
        <div class="panel">
            <form class="form-horizontal">
                <div class="panel-body">
                    <div class="row">
                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="checkin_time" class="col-sm-4 control-label">入住时间</label>
                                <div class="col-sm-8">
                                    <input id="checkin_time" data-bind="value:model.checkinTime" style="width: 100%">
                                    <script>
                                        $('#checkin_time').kendoDatePicker({
                                            culture:'zh-CN',
                                            format:'yyyy-MM-dd',
                                            min:new Date()
                                        });
                                    </script>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="checkout_time" class="col-sm-4 control-label">退房时间</label>
                                <div class="col-sm-8">
                                    <input id="checkout_time" data-bind="value:model.checkoutTime" style="width: 100%">
                                    <script>
                                        $('#checkout_time').kendoDatePicker({
                                            culture:'zh-CN',
                                            format:'yyyy-MM-dd',
                                            min:new Date()
                                        });
                                    </script>
                                </div>
                            </div>
                        </div>

                        <div class="col-sm-4">
                            <div class="form-group">
                                <label for="room_type" class="col-sm-4 control-label">房间类型</label>
                                <div class="col-sm-8">
                                    <input id="room_type" data-bind="value:model.roomType" style="width: 100%">
                                    <script>
                                        $('#room_type').kendoDropDownList({
                                            valuePrimitive: true,
                                            dataSource:[{value:null,meaning:'全部'},{value:'SINGLE',meaning:'单人间'},{value:'DOUBLE',meaning:'双人间'}],
                                            dataTextField:'meaning',
                                            dataValueField:'value'
                                        });
                                    </script>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>

                <div class="panel-footer text-right">
                    <span class="btn btn-primary" data-bind="click:queryFn"><i class="fa fa-search"></i> 查询</span>
                    <span class="btn btn-default" data-bind="click:resetFn"><i class="fa fa-refresh"></i> 重置</span>
                </div>
            </form>
        </div>

        <div id="grid"></div>

        <div class="row">
            <div class="modal fade col-md-6 col-md-offset-3" id="reserve-editor" tabindex="-1" role="dialog" aria-labelledby="reserveRoom">
                <div class="modal-dialog" role="document">
                    <div class="modal-content">
                        <div class="modal-header">
                            <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                            <h4 class="modal-title" id="reserveRoom">房间预定</h4>
                        </div>
                        <div class="modal-body">
                            <div class="row">
                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="reserve-checkin" class="col-sm-4 control-label">入住日期</label>
                                        <div class="col-sm-8">
                                            <input id="reserve-checkin" style="width: 100%">
                                        </div>
                                    </div>
                                </div>

                                <div class="col-sm-6">
                                    <div class="form-group">
                                        <label for="reserve-checkout" class="col-sm-4 control-label">退房日期</label>
                                        <div class="col-sm-8">
                                            <input id="reserve-checkout" style="width: 100%">
                                        </div>
                                    </div>
                                </div>
                            </div>

                        </div>
                        <div class="modal-footer">
                            <input type="password" class="k-textbox" placeholder="请输入密码">
                            <button type="button" class="btn btn-primary" id="submit-reserve">付款</button>
                        </div>
                    </div>
                </div>
            </div>
        </div>

    </div>
</body>
<script>
        var basePath = '${rca.contextPath}';

        var viewModel = kendo.observable({
            model: {
                roomType:null,
                checkinTime:new Date(),
                checkoutTime:new Date()
            },
            queryFn:function () {
                gridDataSource.page(1)
            },
            resetFn:function () {
                this.model.set('roomType',null);
                this.model.set('checkinTime',new Date());
                this.model.set('checkoutTime',new Date());
            }
        });
        kendo.bind($('#page-content'), viewModel);

        var indp = $('#reserve-checkin').kendoDatePicker({
            culture:'zh-CN',
            format:'yyyy-MM-dd'
        }).data('kendoDatePicker');

        var outdp = $('#reserve-checkout').kendoDatePicker({
            culture:'zh-CN',
            format:'yyyy-MM-dd'
        }).data('kendoDatePicker');

        var roomId;

        function openReserveModal(rid) {
            roomId = rid;
            var minDate = new Date($('#checkin_time').val()), maxDate = new Date($('#checkout_time').val());
            indp.setOptions({min:minDate,max:maxDate});
            outdp.setOptions({min:minDate,max:maxDate});
            $('#reserve-editor').modal({backdrop:'static'}).modal('show')
        }

        var gridDataSource = new kendo.data.DataSource({
            transport:{
                read:{
                    url:basePath+'/room/queryFree',
                    type:'POST',
                    dataType:'json'
                },
                parameterMap:function (data,type) {
                    if(type==='read'){
                        return viewModel.model.toJSON()
                    }
                }
            },
            serverPaging: true,
            pageSize:10,
            schema:{
                data:'data',
                total:'total',
                model:{
                    id:'roomId',
                    fields:{
                        roomNumber:{type:'string'},
                        roomType:{type:'string'},
                        roomPrice:{type:'number'}
                    }
                }
            }
        });

        var grid = $('#grid').kendoGrid({
            dataSource:gridDataSource,
            height:'70%',
            resizable: true,
            scrollable: true,
            navigatable: true,
            rownumber:true,
            pageable: {
                pageSizes: [10],
                refresh:true,
                buttonCount:5
            },
            columns:[
                {
                    field:'roomNumber',
                    title:'房间号',
                    headerAttributes:{
                        style:'text-align:center'
                    },
                    attributes:{
                        style:'text-align:center'
                    }
                },
                {
                    field:'roomType',
                    title:'房间类型',
                    values:[{text:'双人间',value:'DOUBLE'},{text:'单人间',value:'SINGLE'}],
                    headerAttributes:{
                        style:'text-align:center'
                    },
                    attributes:{
                        style:'text-align:center'
                    }
                },
                {
                    field:'roomPrice',
                    title:'单价',
                    headerAttributes:{
                        style:'text-align:center'
                    },
                    attributes:{
                        style:'text-align:center'
                    },
                    template:function (item) {
                        return '￥'+item.roomPrice
                    }
                },
                {
                    title:'操作',
                    headerAttributes:{
                        style:'text-align:center'
                    },
                    attributes:{
                        style:'text-align:center'
                    },
                    template:function (item) {
                        return '<span class="btn btn-success" onclick="openReserveModal(\''+item.roomId+'\')">预定</span>'
                    }
                }
            ]
        }).data('kendoGrid');

        $('#submit-reserve').on('click',function () {
            var reserveCheckin = $('#reserve-checkin').val(), reserveCheckout = $('#reserve-checkout').val();
            if(!(reserveCheckin&&reserveCheckout)){
                swal({title:"提示",
                    text:"请将信息填写完整",
                    type:"warning",
                    confirmButtonText:"确定"
                });
            }else if(new Date(reserveCheckin)>new Date(reserveCheckout)){
                swal({title:"提示",
                    text:"入住时间不能早于退房时间",
                    type:"warning",
                    confirmButtonText:"确定"
                });
            }else {
                if($('input[type=password]').val()==="${_operator.password}"){
                    $.ajax({
                        url:basePath+'/roomOrder/submit',
                        type:'post',
                        data:{
                            userId:'${_operator.userId}',
                            roomId:roomId,
                            checkinTime:new Date(reserveCheckin),
                            checkoutTime:new Date(reserveCheckout)
                        },
                        dataType:'json',
                        success:function (resp) {
                            if(resp){
                                swal({title:"提示",
                                    text:"房间预定成功",
                                    type:"success",
                                    confirmButtonText:"确定"
                                },function () {
                                    $('#reserve-editor').modal('hide');
                                    gridDataSource.page(1);
                                });
                            }
                        }
                    })
                }else {
                    swal({
                        title:"密码错误",
                        type:"error"
                    })
                }

            }

        });
</script>
</html>
