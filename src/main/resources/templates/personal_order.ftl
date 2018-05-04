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
    <h2 align="center">个人账单</h2>
    <div id="page-content">
        <div class="panel">
            <div class="panel-body">
                <div class="row">
                    <div class="col-sm-4 col-sm-offset-4">
                        <div class="form-group">
                            <label for="bill_type" class="col-sm-2 control-label">账单类型</label>
                            <div class="col-sm-8">
                                <input id="bill_type" data-bind="value:model.billType" style="width: 100%">
                                <script>
                                    $('#bill_type').kendoDropDownList({
                                        valuePrimitive: true,
                                        dataSource:[{value:null,meaning:'全部'},{value:'ROOM',meaning:'住房'},{value:'FOOD',meaning:'菜肴'}],
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
    </div>
</body>
<script>
    var basePath = '${rca.contextPath}';

    var viewModel = kendo.observable({
        model: {
            billType:null
        },
        queryFn:function () {
            gridDataSource.page(1)
        },
        resetFn:function () {
            this.model.set('billType',null);
        }
    });
    kendo.bind($('#page-content'), viewModel);

    var gridDataSource = new kendo.data.DataSource({
        transport:{
            read:{
                url:basePath+'/bill/queryPersonalBill',
                type:'POST',
                dataType:'json'
            },
            parameterMap:function (data,type) {
                if(type==='read'){
                    viewModel.model.set('userId','${_operator.userId}');
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
                id:'billId',
                fields:{
                    billType:{type:'string'},
                    totalPrice:{type:'number'}
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
                field:'billType',
                title:'账单类型',
                values:[{text:'住房',value:'ROOM'},{text:'菜肴',value:'FOOD'}],
                headerAttributes:{
                    style:'text-align:center'
                },
                attributes:{
                    style:'text-align:center'
                }
            },
            {
                field:'totalPrice',
                title:'账单金额',
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
            }/*,
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
            }*/
        ]
    }).data('kendoGrid');
</script>
</html>
