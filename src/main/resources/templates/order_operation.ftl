<html>
<head>
    <title>Title</title>
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
    <h2 align="center">订单处理</h2>
    <div id="page-content">

        <div class="panel">
            <div class="panel-body">
                <div class="row">
                    <div class="col-sm-4 col-sm-offset-4">
                        <div class="form-group">
                            <label for="order_status" class="col-sm-2 control-label">订单状态</label>
                            <div class="col-sm-8">
                                <input id="order_status" data-bind="value:model.orderStatus" style="width: 100%">
                                <script>
                                    $('#order_status').kendoDropDownList({
                                        valuePrimitive: true,
                                        dataSource:[{value:'NEW',meaning:'未配送'},{value:'HANDLED',meaning:'已配送'},{value:null,meaning:'全部'}],
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
        </div>


        <div id="grid"></div>

        <div class="modal fade" id="detail-editor" tabindex="-1" role="dialog" aria-labelledby="detail">
            <div class="modal-dialog" role="document">
                <div class="modal-content col-sm-6 col-sm-offset-3">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="detail">订单详情</h4>
                    </div>
                    <div class="modal-body">
                        <table id="detail-table">
                        </table>
                    </div>
                    <div class="modal-footer">
                        配送房间：
                        <input id="send_address" class="k-textbox" readonly="readonly"/>
                        <button type="button" class="btn btn-primary" id="send">配送</button>
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
            orderStatus:'NEW'
        },
        queryFn:function () {
            gridDataSource.page(1)
        },
        resetFn:function () {
            this.model.set('orderStatus','NEW');
        }
    });
    kendo.bind($('#page-content'), viewModel);

    var gridDataSource = new kendo.data.DataSource({
        transport:{
            read:{
                url:basePath+'/foodOrder/query',
                type:'POST',
                dataType:'json'
            },
            parameterMap:function (data,type) {
                if(type==='read'){
                    viewModel.model.set('page',data.page);
                    viewModel.model.set('pageSize',data.pageSize);
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
                id:'orderId',
                fields:{
                    account:{},
                    createTime:{}
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
                field:'account',
                title:'用户账号',
                headerAttributes:{
                    style:'text-align:center'
                },
                attributes:{
                    style:'text-align:center'
                }
            },
            {
                field:'totalPrice',
                title:'订单金额',
                headerAttributes:{
                    style:'text-align:center'
                },
                attributes:{
                    style:'text-align:center'
                },
                template:function (item) {
                    return '￥'+item.totalPrice
                }
            },
            {
                field:'createTime',
                title:'创建时间',
                headerAttributes:{
                    style:'text-align:center'
                },
                attributes:{
                    style:'text-align:center'
                },
                template:function (item) {
                    var d = new Date(item.createTime)
                    return d.getFullYear()+'-'+d.getMonth()+'-'+d.getDate()+' '+d.getHours()+':'+d.getMinutes()+':'+d.getSeconds()
                }
            },
             {
             title:'订单详情',
             headerAttributes:{
             style:'text-align:center'
             },
             attributes:{
             style:'text-align:center'
             },
             template:function (item) {
                 return '<span class="btn btn-success" onclick="openDetail('+JSON.stringify(item.orderDetails).replace(/"/g,'&quot;')+',\''+item.orderStatus+'\',\''+item.sendAddress+'\');">查看</span>'
                }
             }
        ]
    }).data('kendoGrid');

    var orderId = 0;

    $('#send').on('click',function () {
        $.ajax({
            url:basePath+'/foodOrder/send',
            type:'post',
            data:{
                orderId:orderId
            },
            dataType:'json',
            success:function (resp) {
                if(resp){
                    $('#detail-editor').modal('hide');
                    gridDataSource.page(1)
                }
            }
        })
    });

    function openDetail(detail,sent,sendAddress) {
        orderId = detail[0].orderId || 0;
        if(sent==='HANDLED'){
            $('#send').hide();
        }else {
            $('#send').show();
        }
        var content = '<thead><td>菜肴名称</td><td>数量</td></thead>';
        for(var k in detail) {
            content += '<tr><td>'+detail[k].food.foodName+'</td><td>'+detail[k].amount+'</td></tr>';
        }
        $('#detail-table').html(content).addClass('table').addClass('table-striped').find('td').css('text-align','center');
        $('#send_address').val(sendAddress);
        $('#detail-editor').modal({backdrop:'static'}).modal('show');
    }

</script>
</html>
