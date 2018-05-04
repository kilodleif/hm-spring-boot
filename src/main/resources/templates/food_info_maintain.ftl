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
    <h2 align="center">菜肴信息维护</h2>
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
                url:basePath+'/food/query',
                type:'POST',
                dataType:'json'
            },
            create:{
                url:basePath+'/food/add',
                type:'post',
                contentType:'application/json'
            },
            update:{
                url:basePath+'/food/update',
                type:'post',
                contentType:'application/json'
            },
            parameterMap:function (data,type) {
                if(type === 'read'){
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
                id:'foodId',
                fields:{
                    foodName:{type:'string',validation:{required:true}},
                    foodPrice:{type:'number',validation:{required:true,min:0}},
                    leftAmount:{type:'number',validation:{required:true,min:0}}
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
                field:'foodName',
                title:'菜肴名称',
                headerAttributes:{
                    style:'text-align:center'
                },
                attributes:{
                    style:'text-align:center'
                }
            },
            {
                field:'foodPrice',
                title:'菜肴价格',
                headerAttributes:{
                    style:'text-align:center'
                },
                attributes:{
                    style:'text-align:center'
                }
            },
            {
                field:'leftAmount',
                title:'剩余库存',
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
