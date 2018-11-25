<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/css.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/easyui.css">
    <link type="text/css" rel="stylesheet" href="${pageContext.request.contextPath}/css/icon.css">
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery.easyui.min.js"></script>
    <script type="text/javascript" src="${pageContext.request.contextPath}/js/easyui-lang-zh_CN.js"></script>
    <script type="text/javascript">

        $(function () {
            // 文件上传(文件域)的改变事件
            $(':file').change(function (event) {
                //  HTML5 js 对象的获取
                var files = event.target.files, file;
                if (files && files.length > 0) {
                    // 获取目前上传的文件
                    file = files[0];
                    // 文件的限定类型什么的道理是一样的
                    if (file.size > 1024 * 1024 * 2) {
                        alert('图片大小不能超过 2MB!');
                        return false;
                    }
                    // file对象生成可用的图片
                    var URL = window.URL || window.webkitURL;
                    // 通过 file 生成目标 url
                    var imgURL = URL.createObjectURL(file);

                    $("img").attr('src', imgURL);
                    $("updateimg").attr('src', imgURL);
                }
            });

            $("#prodatagrid").datagrid({
                url: "queryAllProduct",
                pagination: true,
                toolbar: "#myTools",
                fitcolumns: "true",
                style: {position: "relative"},
                columns: [[
                    //一个｛｝表示一列
                    {field: "book_id", checkbox: true},
                    {title: "书名", field: "book_name"},
                    {
                        field: "product_image", title: "图片封面", width: 80,
                        formatter: function (value, row, index) {
                            return '<img width="120px" height="60px" border="0" src="${pageContext.request.contextPath}/productImages/' + row.product_image + '"/>';
                        }
                    },
                    {title: "原价", field: "book_price"},
                    {title: "当当价", field: "dangprice"},
                    {title: "库存", field: "inventory"},
                    {title: "作者", field: "author"},
                    {title: "出版社", field: "press"},
                    {title: "销量", field: "salenum"},
                    {title: "顾客评分", field: "custome_score"},
                    {title: "所属类别", field: "categoryname"},
                ]],
                title: "图书列表",

                onDblClickRow: function (rowIndex, rowDate) {
                    $.ajax({
                        url: "getCategory",
                        success: function (data) {
                            var list = data.categoryList;
                            $.each(list, function (index, obj) {
                                if (rowDate.categoryname == obj.categoryname) {
                                    $("#prosele").append("<option selected='selected' value=" + obj.categoryid + ">" + obj.categoryname + "</option>")
                                }
                                else {
                                    $("#prosele").append("<option value=" + obj.categoryid + ">" + obj.categoryname + "</option>")

                                }


                            });
                        }
                    });

                    $("#proId").val(rowDate.book_id);
                    $("#proName").val(rowDate.book_name);
                    $("#product_image").val(rowDate.product_image);
                    $("#proPrice").val(rowDate.book_price);
                    $("#dangPrice").val(rowDate.dangprice);
                    $("#inventory").val(rowDate.inventory);
                    $("#author").val(rowDate.author);
                    $("#press").val(rowDate.press);
                    $("#salenum").val(rowDate.salenum);
                    $("#custome_score").val(rowDate.custome_score);
                    $("#recommend").val(rowDate.recommend);
                    $("#messages").val(rowDate.messages);
                    $("#updateimg").prop("src", "${pageContext.request.contextPath}/productImages/rowDate.product_image");
                    $("#updateProdia").dialog("open");
                }
            });
            $("#addProdia").dialog({
                title: "添加",
                height: 800,
                width: 400,
                resizable: true,
                closed: true,
                modal: true
            });
            $("#updateProdia").dialog({
                title: "修改",
                height: 800,
                width: 400,
                resizable: true,
                closed: true,
                modal: true
            });
        });

        //删除操作
        function doDelete() {
            //1.获取到所有选中的行：通过datagrid的getSelections方法获取到
            var selectedrows = $("#prodatagrid").datagrid("getSelections");
            if (selectedrows.length == 0) {
                //alert("请选中要删除的数据");
                $.messager.alert("提示框", "请选中要删除的数据", "warning");
            } else {
                //确认是否删除
                $.messager.confirm("确认框", "确认真的要删除选中的内容吗？", function (result) {
                    //执行删除操作
                    //1获取到所有选中的id
                    var ids = new Array(selectedrows.length);
                    for (var i = 0; i < selectedrows.length; i++) {
                        ids[i] = selectedrows[i].book_id;
                    }
                    //2发送ajax请求到后台
                    $.ajax({
                        url: "deleteMany",
                        //用这中格式传递数据，jquery会自动将数据深度序列化
                        data: {"ids": ids},
                        //不让jquery做深度序列化
                        traditional: true,
                        success: function (data) {
                            if (data) {
                                $.messager.alert("提示框", "删除成功", "message");
                                $("#prodatagrid").datagrid("reload");
                            } else {
                                $.messager.alert("提示框", "删除失败", "warning");
                            }
                        }
                    });
                    //ajax-----end
                });
            }
        }

        function openAdd() {
            $("#addProdia").dialog("open");
            $.ajax({
                url: "getCategory",
                success: function (data) {
                    var list = data.categoryList;
                    $.each(list, function (index, obj) {
                        $("#prosele1").append(
                            "<option value='" + obj.categoryid + "'>" + obj.categoryname + "</option>"
                        );
                    });
                }
            });

        }

        function pro1() {
            $("#prof1").form("submit", {
                url: "add",
                success: function (data) {
                    if (data == "true") {
                        $.messager.alert("提示框", "添加成功", "message");
                        $("#addProdia").dialog("close");
                        $("#addProdia").datagrid("reload");
                    } else {
                        $.messager.alert("提示框", "添加失败", "warning");
                    }
                }
            });
        }

        function pro() {
            $("#prof2").form("submit", {
                url: "update",
                success: function (data) {
                    if (data == "true") {
                        $.messager.alert("提示框", "修改成功", "message");
                        $("#updateProdia").dialog("close");
                        $("#updateProdia").datagrid("reload");
                    } else {
                        $.messager.alert("提示框", "修改失败", "warning");
                    }
                }
            });
        }
    </script>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Insert title here</title>
</head>
<body>
<table id="prodatagrid"></table>
<div id="myTools">
    <a href="javaScript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'" onclick="doDelete()">批量删除</a>
    <a href="javaScript:void(0)" class="easyui-linkbutton" data-options="iconCls:'icon-remove'"
       onclick="openAdd()">添加</a>
</div>
<div id="addProdia" class="easyui-dialog" data-options="closed:true">
    <form id="prof1" style="margin:30px" enctype="multipart/form-data" method="post">
        <table>
            <tr>
                <td>
                    图书名字：<input class="easyui-validatebox" name="book_name"
                                data-options="required:true,missingMessage:'请填写商品名字'"/><br/><br/>
                    图书封面：<input class="easyui-filebox" name="myjar"
                                data-options="required:true,missingMessage:'请选择封面'"/>
                    <div class="lf salebd"><a href="#"><img src="images/<>.jpg" width="100" height="100"/></a></div>
                    <br/><br/>

                </td>
                <td>
                    图书原价：<input class="easyui-validatebox" name="book_price" type="number" step="0.1"
                                data-options="required:true,missingMessage:'请输入价格'"/> <br/><br/>
                    当当价格：<input class="easyui-validatebox" name="Dangprice" type="number" step="0.1"
                                data-options="required:true,missingMessage:'请输入价格'"/><br/><br/>
                </td>
            </tr>
            <tr>
                <td>
                    库存：&nbsp;&nbsp;<input class="easyui-validatebox" name="inventory"
                                          data-options="required:true,missingMessage:'请输入库存'"/><br/><br/>
                    作者：&nbsp;&nbsp;<input class="easyui-validatebox" name="author"
                                          data-options="required:true,missingManage:'请输入作者名称'"/>

                    <br/><br/>
                </td>
                <td>
                    出版社：&nbsp;<input class="easyui-validatebox" name="press"
                                     data-options="required:true,missingManage:'请输入出版社名称'"/><br/>
                    &nbsp;销量：&nbsp;&nbsp;<input class="easyui-validatebox" type="number" name="salenum"
                                                data-options="required:true,missManage:'请输入销量记录'"/><br/><br/>
                </td>
            </tr>
            <tr>
                <td>
                    顾客评分：<input class="easyui-validatebox" name="custome_score"
                                data-options="required:true,missingManage:'请输入顾客评分'"/><br/><br/>
                    编辑推荐：<input class="easyui-validatebox" name="recommend"
                                data-options="required:true,missManager:'请输入编辑推荐'"><br/><br/>
                </td>
                <td>
                    类别所属：<select id="prosele1" name="cid">
                    <option value="0">请选择类别</option>

                </select>
                    <br/><br/>
                    简介内容：<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<textarea rows="5" cols="22"
                                                                      name="messages"></textarea><br/><br/>
                </td>
            </tr>
        </table>
        <center>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" onClick="pro1()">确认</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel">取消</a>
        </center>
    </form>
</div>
<div id="updateProdia" class="easyui-dialog" data-options="closed:true">
    <form id="prof2" style="margin:30px" enctype="multipart/form-data" method="post">
        <table>
            <tr>
                <td>
                    <input id="proId" name="book_id" type="hidden"/>
                    图书名字：<input class="easyui-validatebox" id="proName" name="book_name"
                                data-options="required:true,missingMessage:'请填写商品名字'"/><br/><br/>
                    图书封面：<input class="easyui-filebox" id="uploadFile" name="myjar"
                                data-options="required:true,missingMessage:'请选择封面'"/>
                    <div class="lf salebd"><a href="#"><img src="" width="100" height="100" id="updateimg"/></a></div>
                    <input type="hidden" name="product_image" value="" id="product_image"/>
                    <br/><br/>
                </td>
                <td>
                    图书原价：<input class="easyui-validatebox" id="proPrice" name="book_price" type="number" step="0.1"
                                data-options="required:true,missingMessage:'请输入价格'"/> <br/><br/>
                    当当价格：<input class="easyui-validatebox" id="dangPrice" name="dangprice" type="number" step="0.1"
                                data-options="required:true,missingMessage:'请输入价格'"/><br/><br/>
                </td>
            </tr>
            <tr>
                <td colspan="2"><p id="image"></p></td>
            </tr>
            <tr>
                <td>
                    库存：&nbsp;&nbsp;<input class="easyui-validatebox" id="inventory" name="inventory"
                                          data-options="required:true,missingMessage:'请输入库存'"/><br/><br/>
                    作者：&nbsp;&nbsp;<input class="easyui-validatebox" id="author" name="author"
                                          data-options="required:true,missingManage:'请输入作者名称'"/><br/><br/>
                </td>
                <td>
                    出版社：&nbsp;<input class="easyui-validatebox" id="press" name="press"
                                     data-options="required:true,missingManage:'请输入出版社名称'"/><br/>
                    销量：&nbsp;&nbsp;<input class="easyui-validatebox" id="salenum" type="number" name="salenum"
                                          data-options="required:true,missManage:'请输入销量记录'"/><br/><br/>
                </td>
            </tr>
            <tr>
                <td>
                    顾客评分：<input class="easyui-validatebox" id="custome_score" name="custome_score"
                                data-options="required:true,missingManage:'请输入顾客评分'"/><br/><br/>
                    编辑推荐：<input class="easyui-validatebox" id="recommend" name="recommend"
                                data-options="required:true,missManager:'请输入编辑推荐'"><br/><br/>
                </td>
                <td>
                    类别所属：<select id="prosele" name="cid"></select><br/><br/>
                    简介内容：<br/>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<textarea rows="5" cols="22" name="messages"
                                                                      id="messages"></textarea><br/><br/>
                </td>
            </tr>
        </table>
        <center>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-save" onClick="pro()">确认</a>
            <a href="javascript:void(0)" class="easyui-linkbutton" iconCls="icon-cancel" onClick="exit()">取消</a>
        </center>
    </form>
</div>
<script type="text/javascript">

</script>
</body>
</html>