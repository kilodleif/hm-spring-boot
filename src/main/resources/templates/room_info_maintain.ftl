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
    <h2 align="center">客房信息维护</h2>
    <div id="page-content">
        <div id="grid"></div>
    </div>
</body>
<script>
    var basePath = '${rca.contextPath}';

    var viewModel = kendo.observable({
        model: {}
    });
    kendo.bind($('#page-content'), viewModel);

    var gridDataSource = new kendo.data.DataSource({
        transport:{
            read:{
                url:basePath+'/room/query',
                type:'POST',
                dataType:'json'
            },
            create:{
                url:basePath+'/room/add',
                type:'post',
                contentType:'application/json'
            },
            update:{
                url:basePath+'/room/update',
                type:'post',
                contentType:'application/json'
            },
            parameterMap:function (data,type) {
                if(type==='read'){
                    viewModel.model.set('page',data.page);
                    viewModel.model.set('pageSize',data.pageSize);
                    return viewModel.model.toJSON()
                }else {
                    return JSON.stringify(data)
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
                    roomNumber:{type:'string',validation:{required:true}},
                    roomType:{validation:{required:true}},
                    roomPrice:{type:'number',validation:{required:true,min:0}}
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
        editable:true,
        pageable: {
            pageSizes: [10],
            refresh:true,
            buttonCount:5
        },
        toolbar:[{
            template : '<button onclick="grid.addRow()" class="btn btn-primary"><i class="fa fa-plus-square"></i> 新建</button>'
        },{
            template : '<button onclick="grid.saveChanges();gridDataSource.query();grid.refresh();" class="btn btn-success"><i class="fa fa-save"></i> 保存</button>'
        },{
            template : '<button onclick="grid.cancelChanges()" class="btn btn-default"><i class="fa fa-reply"></i> 取消</button>'
        }],
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
                title:'房间价格',
                headerAttributes:{
                    style:'text-align:center'
                },
                attributes:{
                    style:'text-align:center'
                }
            }
        ]
    }).data('kendoGrid');
</script>
</html>
