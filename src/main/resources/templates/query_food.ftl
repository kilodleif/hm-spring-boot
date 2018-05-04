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
    <h2 align="center">菜肴名称</h2>
    <div id="page-content">
        <div class="panel">
            <div class="panel-body">
                <div class="row">
                    <div class="col-sm-4 col-sm-offset-4">
                        <div class="form-group">
                            <label for="food_name" class="col-sm-2 control-label">菜肴名称</label>
                            <div class="col-sm-8">
                                <input id="food_name" class="k-textbox" data-bind="value:model.foodName" style="width: 100%">
                            </div>
                        </div>
                    </div>

                </div>
            </div>

            <div class="panel-footer">
                <div class="text-left">
                    <span class="btn btn-success" onclick="openCart()" style="float: left;">
                        <i class="fa fa-shopping-cart"></i> 购物车 <span class="badge"></span>
                    </span>
                </div>

                <div class="text-right">
                    <span class="btn btn-primary" data-bind="click:queryFn"><i class="fa fa-search"></i> 查询</span>
                    <span class="btn btn-default" data-bind="click:resetFn"><i class="fa fa-refresh"></i> 重置</span>
                </div>
            </div>
        </div>

        <div class="modal fade" id="cart-editor" tabindex="-1" role="dialog" aria-labelledby="cart">
            <div class="modal-dialog" role="document">
                <div class="modal-content col-sm-6 col-sm-offset-3">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="cart">购物车</h4>
                    </div>
                    <div class="modal-body">
                        <table id="cart-table">
                        </table>
                    </div>
                    <div class="modal-footer">
                        配送房间：
                        <input id="send_address">
                        <input type="password" class="k-textbox" placeholder="请输入密码">
                        <button type="button" class="btn btn-primary" id="pay">付款</button>
                    </div>
                </div>
            </div>
        </div>

        <div id="grid"></div>

    </div>
</body>
<script>
    var basePath = '${rca.contextPath}';

    parent['shoppingCart'] = new Map();

    var toPay = 0;

    function openCart() {
        toPay = 0;
        var content = '<thead><td>菜肴名称</td><td>数量</td></thead>';
        parent['shoppingCart'].forEach(function (item,key) {
            toPay += item.totalPrice;
            content += '<tr><td>'+key+'</td><td>'+item.amount+'</td></tr>';
        });
        $('#cart-table').html(content).addClass('table').addClass('table-striped').find('td').css('text-align','center');
        $('#cart-editor').modal({backdrop:'static'}).modal('show')
    }

    $('#pay').on('click',function () {
        //$('input[type="password"]').focus();
        if(toPay){
            var details = [];
            parent['shoppingCart'].forEach(function (item) {
                details.push({foodId:item.foodId,amount:item.amount})
            });
            var data = {
                userId:'${_operator.userId}',
                orderDetails:details,
                totalPrice:toPay,
                sendAddress:$('#send_address').val()||''
            };
            if($('input[type=password]').val()=="${_operator.password}"){
                swal({
                        title: "订单确认",
                        text: "共需付款：￥"+toPay+'\n配送房间：'+$('#send_address').val(),
                        type: "info",
                        showCancelButton: true,
                        closeOnConfirm: false,
                        showLoaderOnConfirm: true
                    },
                    function(){
                        $.ajax({
                            url:basePath+'/foodOrder/submit.do',
                            type:'post',
                            contentType:'application/json',
                            data:JSON.stringify(data),
                            dataType:'json',
                            success:function (resp) {
                                swal("付款完成");
                                $('#cart-editor').modal('hide');
                                //清空购物车，密码输入，徽章数字
                                parent['shoppingCart'] = new Map();
                                $('input[type=password]').val(null);
                                $('.badge').text('');
                                gridDataSource.page(1);
                            }
                        });

                    });
            }else {
                swal({
                    title:"密码错误",
                    type:"error"
                })
            }
        }
    });

    var viewModel = kendo.observable({
        model: {
            foodName:null
        },
        queryFn:function () {
            gridDataSource.page(1)
        },
        resetFn:function () {
            this.model.set('foodName',null);
        }
    });
    kendo.bind($('#page-content'), viewModel);

    var gridDataSource = new kendo.data.DataSource({
        transport:{
            read:{
                url:basePath+'/food/queryAvailable',
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
                id:'foodId',
                fields:{
                    reservedAmount:{type:'number',defaultValue:0}
                },
                editable:function (col) {
                    if(col==='reservedAmount'){
                        return true
                    }
                    return false
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
                },
                template:function (item) {
                    return '￥'+item.foodPrice
                }
            },
            {
                field:'leftAmount',
                title:'剩余数量',
                headerAttributes:{
                    style:'text-align:center'
                },
                attributes:{
                    style:'text-align:center'
                }
            },
            {
                title: '加入购物车',
                field:'reservedAmount',
                headerAttributes: {
                    style: 'text-align:center'
                },
                attributes: {
                    style: 'text-align:center'
                },
                editor: function (container, options) {
                    $('<input name="' + options.field + '"/>')
                        .appendTo(container)
                        .kendoNumericTextBox({
                            decimals:1,
                            format:'n0',
                            min:0,
                            max:options.model.get('leftAmount'),
                            spin:function (e) {
                                $(e.sender.element).parents('td').prev('td').text(options.model.get('leftAmount')-this.value());
                            },
                            change:function () {
                                var val = this.value();
                                if(val>0){
                                    parent['shoppingCart'].set(options.model.foodName,{
                                            foodId:options.model.foodId,
                                            amount:val,
                                            totalPrice:options.model.foodPrice*val}
                                        );
                                }else {
                                    parent['shoppingCart'].delete(options.model.foodName);
                                }
                                var s = parent['shoppingCart'].size;
                                $('.badge').text(s);
                                if(s===0){
                                    $('.badge').text('')
                                }
                            }
                        });
                },
                template:function (item) {
                    return item.reservedAmount||0
                }
            }

        ]
    }).data('kendoGrid');

    $('#send_address').kendoDropDownList({
        valuePrimitive: true,
        dataSource:new kendo.data.DataSource({
            transport:{
                read:{
                    url:basePath+'/room/queryAll',
                    type:'POST',
                    dataType:'json'
                }
            },
            schema:{
                data:'data',
                total:'total',
                model:{
                    id:'roomId',
                    fields:{
                    }
                }
            }
        }),
        dataTextField:'roomNumber',
        dataValueField:'roomNumber'
    });

</script>
</html>
