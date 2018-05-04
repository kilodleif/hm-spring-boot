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
    <h2 align="center">用户管理</h2>
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
                url:basePath+'/user/query',
                type:'POST',
                dataType:'json'
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
                id:'userId',
                fields:{

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
                title:'账号',
                headerAttributes:{
                    style:'text-align:center'
                },
                attributes:{
                    style:'text-align:center'
                }
            },
            {
                field:'name',
                title:'姓名',
                headerAttributes:{
                    style:'text-align:center'
                },
                attributes:{
                    style:'text-align:center'
                }
            },
            {
                field:'gender',
                title:'性别',
                values:[{text:'男',value:'M'},{text:'女',value:'F'},{text:'',value:null}],
                headerAttributes:{
                    style:'text-align:center'
                },
                attributes:{
                    style:'text-align:center'
                }
            },
            {
                field:'telephone',
                title:'电话',
                headerAttributes:{
                    style:'text-align:center'
                },
                attributes:{
                    style:'text-align:center'
                }
            },
            {
                field:'address',
                title:'地址',
                headerAttributes:{
                    style:'text-align:center'
                },
                attributes:{
                    style:'text-align:center'
                }
            },
            {
                field:'email',
                title:'邮箱',
                headerAttributes:{
                    style:'text-align:center'
                },
                attributes:{
                    style:'text-align:center'
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
                    return '<span class="btn btn-success" onclick="deleteUser('+item.userId+')">删除</span>'
                }
            }
        ]
    }).data('kendoGrid');

    function deleteUser(userId) {
        $.ajax({
            url:basePath+'/user/delete',
            type:'post',
            contentType:'application/json',
            data:JSON.stringify({
                userId:userId
            }),
            dataType:'json',
            success:function (resp) {
                swal({
                    title:"提示",
                    text:"成功删除用户",
                    type: "success"
                },function () {
                    gridDataSource.page(1)
                })
            }
        })
    }

</script>
</html>
