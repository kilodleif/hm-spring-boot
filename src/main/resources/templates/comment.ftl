<html>
<head>
    <title>用户留言</title>
    <link rel="stylesheet" type="text/css" href="${rca.contextPath}/resource/styles/bootstrap.min.css">
    <link rel="stylesheet" type="text/css" href="${rca.contextPath}/resource/styles/sweetalert.css">
    <script type="text/javascript" src="${rca.contextPath}/resource/js/jquery.min.js"></script>
    <script type="text/javascript" src="${rca.contextPath}/resource/js/sweetalert.js"></script>

</head>
<body>
    <h2 align="center">留言板</h2>
    <div class="container">
    <#list returnData.data as comment>
        <div class="panel panel-default">
            <div class="panel-heading">
                用户 ${comment.account} 发布于 ${comment.createTime?string('yyyy-MM-dd HH:mm:ss')}
                <#if _operator.userType == 'ADMIN'>
                    <a href="#" onclick="deleteComment('${comment.commentId}')">删除</a>
                </#if>
            </div>
            <div class="panel-body">
                ${comment.content}
            </div>
        </div>
    </#list>

        <nav>
            <ul class="pager">
                <#if returnData.page == 1>
                    <li class="disabled"><a href="#">上一页</a></li>
                <#else>
                    <li><a href="${rca.contextPath}/page/comment?page=${returnData.page-1}">上一页</a></li>
                </#if>

                <#if returnData.page == returnData.totalPage>
                    <li class="disabled"><a href="#">下一页</a></li>
                <#else>
                    <li><a href="${rca.contextPath}/page/comment?page=${returnData.page+1}">下一页</a></li>
                </#if>
            </ul>
        </nav>


        <form role="form">
            输入您的留言：
            <div class="form-group">
                <textarea title="" id="comment-content" class="form-control" rows="3"></textarea>
            </div>
            <div class="text-center">
                <input id="btn-reset" class="btn btn-default" type="button" value="重置">
                <input id="btn-submit" class="btn btn-info" type="button" value="提交">
            </div>
        </form>

    </div>
    <script>
        var basePath = '${rca.contextPath}';

        $('#btn-reset').on('click',function () {
            $('#comment-content').val('').focus();
        });

        $('#btn-submit').on('click',function () {
            if($('#comment-content').val()){
                $.ajax({
                    url:basePath+'/comment/submit',
                    type:'post',
                    data:{
                        content:$('#comment-content').val()
                    },
                    dataType:'json',
                    success:function (resp) {
                        if(resp){
                            swal({title:"提示",
                                text:"留言成功",
                                type:"success",
                                confirmButtonText:"确定"
                            },function () {
                                location.href=basePath+'/page/comment'
                            });
                        }
                    }
                });
            }
        });

        function deleteComment(commentId) {
            $.ajax({
                url:basePath+'/comment/delete',
                type:'post',
                data:{
                    commentId:commentId
                },
                dataType:'json',
                success:function (resp) {
                    swal({
                        title:"提示",
                        text:"成功删除评论",
                        type: "success"
                    },function () {
                        location.href=basePath+'/page/comment'
                    })
                }
            })
        }
    </script>
</body>
</html>
