<%--
  Created by IntelliJ IDEA.
  User: HP
  Date: 2017-12-06
  Time: 11:13
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=1280, initial-scale=1.0, maximum-scale=1.0, user-scalable=no">
    <meta name="renderer" content="webkit|ie-stand|ie-comp">
    <link rel="stylesheet" href="${pageContext.request.contextPath }/css/bootstrap.min.css" type="text/css">
    <script src="${pageContext.request.contextPath }/js/jquery.min.js"></script>
    <script src="${pageContext.request.contextPath }/js/bootstrap.min.js"></script>
    <title>精斗云云进销存</title>
    <link rel="icon" href="http://vip2-gd.youshang.com/css/blue/img/favicon.png" type="image/x-icon">
    <link href="${pageContext.request.contextPath }/css/common.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath }/css/print.css" rel="stylesheet" type="text/css">
    <link href="${pageContext.request.contextPath }/css/ui.min.css" rel="stylesheet">
    <script src="${pageContext.request.contextPath }/js/jquery-1.10.2.min.js"></script>
    <script src="${pageContext.request.contextPath }/js/json3.min.js"></script>
    <script src="${pageContext.request.contextPath }/js/vue.js"></script>
    <script src="${pageContext.request.contextPath }/js/common.js"></script>
    <script src="${pageContext.request.contextPath }/js/grid.js"></script>
    <script src="${pageContext.request.contextPath }/js/plugins.js"></script>
    <script src="${pageContext.request.contextPath }/js/jquery.dialog.js"></script>
    <script src="${pageContext.request.contextPath }/js/material/vendor-list-2.js"></script>
    <style>
        .chk-list {
            line-height: 28px;
        }
        .up{
            position: relative;
            top: -5px;
        }
        .reminder{
            color: red;
        }
        li{
            list-style-type:none;
        }
    </style>
    <script>
        $(function () {
            var i=$("#control").val();
            if(i==0){
                document.getElementById("btn-enable").setAttribute("disabled",true);
                //控制按钮恢复可点击
                $("#addClient").attr("disabled",false);
                $("#btn-disable").attr("disabled",false);
            }
            if(i==1){
                document.getElementById("btn-disable").setAttribute("disabled",true);
                document.getElementById("addClient").setAttribute("disabled",true);
                //控制按钮恢复可点击
                $("#btn-enable").attr("disabled",false);
            }
        })
    </script>

    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath }/common/pagination.css" media="screen">

</head>
<div style="">
    <input style="display: none" id="control" value="${i}" />
    <div class="bill-ser-top">
        <ul class="ul-inline cf">
            <li class="chk-list" id="chk-ischecked" style="display: list-item;position: relative;left: 60px;">
                <div >

                    <button type="button" id="cooperation" name="0" class="btn btn-info" data-toggle="modal" >
                        <span class="">合作中</span></button>
                    <button type="button" id="termination" name="1" class="btn btn-info" data-toggle="modal">
                        <span class="">已终止</span>
                    </button>
                </div>
            </li>
        </ul>
    </div>
    <div class="wrapper btc" style="z-index:0;height: 600px" >
        <div class="bill-ser-botm cf">
            <div class="fr ml10">
                <button type="button" id="addClient" class="btn btn-info" data-toggle="modal" data-target="#myModal" ><span class="">新增</span></button>
                <a class="btn btn-info"name="jin" id="btn-disable"><span class="">终止合作</span></a>
                <a class="btn btn-info" id="btn-enable"><span class="">启用合作</span></a>
            </div>
        </div>
        <div class="grid-wrap">
            <div class="ui-jqgrid ui-widget ui-widget-content ui-corner-all" id="gbox_grid" dir="ltr"
                 style="width: 1371px;">
                <div class="ui-widget-overlay jqgrid-overlay" id="lui_grid"></div>
                <div class="ui-jqgrid-view" id="gview_grid" style="width: 1371px;">
                    <div class="ui-jqgrid-titlebar ui-jqgrid-caption ui-widget-header ui-corner-top ui-helper-clearfix"
                         style="display: none;"><a role="link" class="ui-jqgrid-titlebar-close ui-corner-all HeaderButton"
                                                   style="right: 0px;"><span
                            class="ui-icon ui-icon-circle-triangle-n"></span></a></div>

                </div>
                <div class="ui-jqgrid-resize-mark" id="rs_mgrid">&nbsp;</div>

            </div>

        </div>
        <%-- method="post"--%>

        <%--展示信息--%>
        <div style="position: relative;left: 20px">
            <c:if test="${i==0}">
                <form id="form" action="/supplier/cooperative.do" method="post" >
                    <input style="display: none" name="currentPage"  value="1" />
                    <li style="position: relative;left: 200px;top:-94px">
                        <button type="submit" class="btn btn-info">查找</button>
                        <input class="coosupplierName" value="${cooname}" name="supplierName" placeholder ="名称/ 联系人/ 电话查询" class="input-medium search-query" type="text" />
                    </li>
                    <table class="table table-striped" style="width: 1200px">
                        <thead>
                        <tr>
                            <th></th>
                            <th>供应商名称</th>
                            <th>负责人</th>
                            <th>职位</th>
                            <th>电话</th>
                            <th>移动电话</th>
                            <th>传真</th>
                            <th>供应商地址</th>
                            <th>工厂地址</th>
                            <th>合作关系</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody >
                        <c:forEach items="${supplies}" var="s">
                            <tr id="${s.supplierId}"  class="clients">
                                <td><input class="supplierId"  runat="server" type="checkbox" value="${s.supplierId}" /></td>
                                <td id="supplierId" style="display: none">${s.supplierId}</td>
                                <td id="supplierName">${s.supplierName}</td>
                                <td id="supplierPersonInCharge">${s.supplierPersonInCharge}</td>
                                <td id="supplierPost">${s.supplierPost}</td>
                                <td id="supplierPhone">${s.supplierPhone}</td>
                                <td id="supplierMobilePhone">${s.supplierMobilePhone}</td>
                                <td id="supplierFax">${s.supplierFax}</td>
                                <td id="supplierAddress">${s.supplierAddress}</td>
                                <td id="supplierFactoryAddress">${s.supplierFactoryAddress}</td>
                                <c:if test="${s.supplierState==0}">
                                    <td  id="supplierState">合作中</td>
                                </c:if>
                                <c:if test="${s.supplierState==1}">
                                    <td  id="clientState">已终止</td>
                                </c:if>
                                <td  >
                                    <button type="button" onclick="gainclient(${s.supplierId})"id="${s.supplierId}" data-target="#update" name="updateClient"   class="btn btn-info btn-sm" data-toggle="modal"  ><span class="up">修改</span></button>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                    <div class="ads" id="dsa" style="position: absolute;left: 800px;top: 340px">
                        <ul class="pagination" >
                            <div class="M-box2"></div>
                            <script>
                                $(function(){
                                    $('.M-box2').pagination({
                                        coping:true,
                                        homePage:'首页',
                                        endPage:'末页',
                                        prevContent:'上页',
                                        nextContent:'下页',
                                    });
                                });
                            </script>
                                <%--分页--%>
                            <script>
                                (function (factory) {
                                    if (typeof define === "function" && (define.amd || define.cmd) && !jQuery) {
                                        // AMD或CMD
                                        define(["jquery"], factory);
                                    } else if (typeof module === 'object' && module.exports) {
                                        // Node/CommonJS
                                        module.exports = function (root, jQuery) {
                                            if (jQuery === undefined) {
                                                if (typeof window !== 'undefined') {
                                                    jQuery = require('jquery');
                                                } else {
                                                    jQuery = require('jquery')(root);
                                                }
                                            }
                                            factory(jQuery);
                                            return jQuery;
                                        };
                                    } else {
                                        //Browser globals
                                        factory(jQuery);
                                    }
                                }(function ($) {
                                    //配置参数
                                    var defaults = {
                                        totalData: ${pages.totalRecord}, //数据总条数
                                        showData: ${pages.pageSize}, //每页显示的条数
                                        pageCount: ${pages.totalPage}, //总页数,默认为9
                                        current: ${pages.currentPage}, //当前第几页
                                        prevCls: 'prev', //上一页class
                                        nextCls: 'next', //下一页class
                                        prevContent: '<', //上一页内容
                                        nextContent: '>', //下一页内容
                                        activeCls: 'active', //当前页选中状态
                                        coping: false, //首页和尾页
                                        isHide: false, //当前页数为0页或者1页时不显示分页
                                        homePage: '', //首页节点内容
                                        endPage: '', //尾页节点内容
                                        keepShowPN: false, //是否一直显示上一页下一页
                                        count: 1, //当前页前后分页个数
                                        jump: false, //跳转到指定页数
                                        jumpIptCls: 'jump-ipt', //文本框内容
                                        jumpBtnCls: 'jump-btn', //跳转按钮
                                        jumpBtn: '跳转', //跳转按钮文本
                                        callback: function () {} //回调
                                    };

                                    var Pagination = function (element, options) {
                                        //全局变量
                                        var opts = options, //配置
                                            current, //当前页
                                            $document = $(document),
                                            $obj = $(element); //容器

                                        /**
                                         * 设置总页数
                                         * @param {int} page 页码
                                         * @return opts.pageCount 总页数配置
                                         */
                                        this.setPageCount = function (page) {
                                            return opts.pageCount = page;
                                        };

                                        /**
                                         * 获取总页数
                                         * 如果配置了总条数和每页显示条数，将会自动计算总页数并略过总页数配置，反之
                                         * @return {int} 总页数
                                         */
                                        this.getPageCount = function () {
                                            return opts.totalData && opts.showData ? Math.ceil(parseInt(opts.totalData) / opts.showData) : opts.pageCount;
                                        };

                                        /**
                                         * 获取当前页
                                         * @return {int} 当前页码
                                         */
                                        this.getCurrent = function () {
                                            return current;
                                        };

                                        /**
                                         * 填充数据
                                         * @param {int} 页码
                                         */
                                        this.filling = function (index) {
                                            var html = '';
                                            current = parseInt(index) || parseInt(opts.current); //当前页码
                                            var pageCount = this.getPageCount(); //获取的总页数
                                            if (opts.keepShowPN || current > 1) { //上一页
                                                html += '<a href="javascript:;" class="' + opts.prevCls + '">' + opts.prevContent + '</a>';
                                            } else {
                                                if (opts.keepShowPN == false) {
                                                    $obj.find('.' + opts.prevCls) && $obj.find('.' + opts.prevCls).remove();
                                                }
                                            }
                                            if (current >= opts.count + 2 && current != 1 && pageCount != opts.count) {
                                                var home = opts.coping && opts.homePage ? opts.homePage : '1';
                                                html += opts.coping ? '<a href="javascript:;" data-page="1">' + home + '</a>' : '';
                                            }
                                            var start = (current - opts.count) <= 1 ? 1 : (current - opts.count);
                                            var end = (current + opts.count) >= pageCount ? pageCount : (current + opts.count);
                                            for (; start <= end; start++) {
                                                if (start <= pageCount && start >= 1) {
                                                    if (start != current) {
                                                        html += '<a href="javascript:;" data-page="' + start + '">' + start + '</a>';
                                                    } else {
                                                        html += '<span class="' + opts.activeCls + '">' + start + '</span>';
                                                    }
                                                }
                                            }
                                            if (current + opts.count < pageCount && current >= 1 && pageCount > opts.count) {
                                                var end = opts.coping && opts.endPage ? opts.endPage : pageCount;
                                                html += opts.coping ? '<a href="javascript:;" data-page="' + pageCount + '">' + end + '</a>' : '';
                                            }
                                            if (opts.keepShowPN || current < pageCount) { //下一页
                                                html += '<a href="javascript:;" class="' + opts.nextCls + '">' + opts.nextContent + '</a>'
                                            } else {
                                                if (opts.keepShowPN == false) {
                                                    $obj.find('.' + opts.nextCls) && $obj.find('.' + opts.nextCls).remove();
                                                }
                                            }
                                            html += opts.jump ? '<input type="text" class="' + opts.jumpIptCls + '"><a href="javascript:;" class="' + opts.jumpBtnCls + '">' + opts.jumpBtn + '</a>' : '';
                                            $obj.empty().html(html);
                                        };

                                        //绑定事件
                                        this.eventBind = function () {
                                            var that = this;
                                            var pageCount = that.getPageCount(); //总页数
                                            var index = 1;
                                            $obj.off().on('click', 'a', function () {
                                                if ($(this).hasClass(opts.nextCls)) {
                                                    if ($obj.find('.' + opts.activeCls).text() >= pageCount) {
                                                        $(this).addClass('disabled');
                                                        return false;
                                                    } else {
                                                        index = parseInt($obj.find('.' + opts.activeCls).text()) + 1;
                                                    }
                                                } else if ($(this).hasClass(opts.prevCls)) {
                                                    if ($obj.find('.' + opts.activeCls).text() <= 1) {
                                                        $(this).addClass('disabled');
                                                        return false;
                                                    } else {
                                                        index = parseInt($obj.find('.' + opts.activeCls).text()) - 1;
                                                    }
                                                } else if ($(this).hasClass(opts.jumpBtnCls)) {
                                                    if ($obj.find('.' + opts.jumpIptCls).val() !== '') {
                                                        index = parseInt($obj.find('.' + opts.jumpIptCls).val());
                                                    } else {
                                                        return;
                                                    }
                                                } else {
                                                    index = parseInt($(this).data('page'));
                                                }
                                                that.filling(index);
                                                typeof opts.callback === 'function' && opts.callback(that);
                                                //页码数
                                                var name=$(".coosupplierName").val();
                                                window.location.href="/supplier/cooperative.do?currentPage="+index+"&supplierName="+name;
                                            });
                                            //输入跳转的页码
                                            $obj.on('input propertychange', '.' + opts.jumpIptCls, function () {
                                                var $this = $(this);
                                                var val = $this.val();
                                                var reg = /[^\d]/g;
                                                if (reg.test(val)) $this.val(val.replace(reg, ''));
                                                (parseInt(val) > pageCount) && $this.val(pageCount);
                                                if (parseInt(val) === 0) $this.val(1); //最小值为1
                                            });
                                            //回车跳转指定页码
                                            $document.keydown(function (e) {
                                                if (e.keyCode == 13 && $obj.find('.' + opts.jumpIptCls).val()) {
                                                    var index = parseInt($obj.find('.' + opts.jumpIptCls).val());
                                                    that.filling(index);
                                                    typeof opts.callback === 'function' && opts.callback(that);
                                                }
                                            });
                                        };
                                        //初始化
                                        this.init = function () {
                                            this.filling(opts.current);
                                            this.eventBind();
                                            if (opts.isHide && this.getPageCount() == '1' || this.getPageCount() == '0') $obj.hide();
                                        };
                                        this.init();
                                    };

                                    $.fn.pagination = function (parameter, callback) {
                                        if (typeof parameter == 'function') { //重载
                                            callback = parameter;
                                            parameter = {};
                                        } else {
                                            parameter = parameter || {};
                                            callback = callback || function () {};
                                        }
                                        var options = $.extend({}, defaults, parameter);
                                        return this.each(function () {
                                            var pagination = new Pagination(this, options);
                                            callback(pagination);
                                        });

                                    };
                                }));
                            </script>
                        </ul>
                    </div>

                </form>
            </c:if>
            <c:if test="${i==1}">
                <form id="form" action="/supplier/noncooperation.do" method="post" >
                    <input style="display: none" name="currentPage"  value="1" />
                    <li style="position: relative;left: 200px;top:-94px">
                        <button type="submit" class="btn btn-info">查找</button>
                        <input class="nonsupplierName" value="${noncname}"  name="supplierName" placeholder ="名称/ 联系人/ 电话查询" class="input-medium search-query" type="text" />
                    </li>
                    <table class="table table-striped" style="width: 1200px">
                        <thead>
                        <tr>
                            <th></th>
                            <th>供应商名称</th>
                            <th>负责人</th>
                            <th>职位</th>
                            <th>电话</th>
                            <th>移动电话</th>
                            <th>传真</th>
                            <th>供应商地址</th>
                            <th>工厂地址</th>
                            <th>合作关系</th>
                        </tr>
                        </thead>
                        <tbody id="tbod">
                        <c:forEach items="${ss}" var="ss">
                            <tr id="${ss.supplierId}"  class="clients">
                                <td><input  class="supplierId" runat="server" type="checkbox" value="${ss.supplierId}" /></td>
                                <td  style="display: none">${ss.supplierId}</td>
                                <td id="supplierId" style="display: none">${ss.supplierId}</td>
                                <td id="supplierName">${ss.supplierName}</td>
                                <td id="supplierPersonInCharge">${ss.supplierPersonInCharge}</td>
                                <td id="supplierPost">${ss.supplierPost}</td>
                                <td id="supplierPhone">${ss.supplierPhone}</td>
                                <td id="supplierMobilePhone">${ss.supplierMobilePhone}</td>
                                <td id="supplierFax">${ss.supplierFax}</td>
                                <td id="supplierAddress">${ss.supplierAddress}</td>
                                <td id="supplierFactoryAddress">${ss.supplierFactoryAddress}</td>
                                <c:if test="${ss.supplierState==0}">
                                    <td  id="supplierState">合作中</td>
                                </c:if>
                                <c:if test="${ss.supplierState==1}">
                                    <td  id="clientState">已终止</td>
                                </c:if>
                            </tr>
                        </c:forEach>
                         </tbody>
                    </table>
                    <div  style="position: absolute;left: 800px;top: 340px">
                        <ul class="pagination" >
                            <div class="M-box2"></div>
                            <script>
                                $(function(){
                                    $('.M-box2').pagination({
                                        coping:true,
                                        homePage:'首页',
                                        endPage:'末页',
                                        prevContent:'上页',
                                        nextContent:'下页',
                                    });
                                });
                            </script>
                                <%--分页--%>
                            <script>
                                (function (factory) {
                                    if (typeof define === "function" && (define.amd || define.cmd) && !jQuery) {
                                        // AMD或CMD
                                        define(["jquery"], factory);
                                    } else if (typeof module === 'object' && module.exports) {
                                        // Node/CommonJS
                                        module.exports = function (root, jQuery) {
                                            if (jQuery === undefined) {
                                                if (typeof window !== 'undefined') {
                                                    jQuery = require('jquery');
                                                } else {
                                                    jQuery = require('jquery')(root);
                                                }
                                            }
                                            factory(jQuery);
                                            return jQuery;
                                        };
                                    } else {
                                        //Browser globals
                                        factory(jQuery);
                                    }
                                }(function ($) {
                                    //配置参数
                                    var defaults = {
                                        totalData: ${pages.totalRecord}, //数据总条数
                                        showData: ${pages.pageSize}, //每页显示的条数
                                        pageCount: ${pages.totalPage}, //总页数,默认为9
                                        current: ${pages.currentPage}, //当前第几页
                                        prevCls: 'prev', //上一页class
                                        nextCls: 'next', //下一页class
                                        prevContent: '<', //上一页内容
                                        nextContent: '>', //下一页内容
                                        activeCls: 'active', //当前页选中状态
                                        coping: false, //首页和尾页
                                        isHide: false, //当前页数为0页或者1页时不显示分页
                                        homePage: '', //首页节点内容
                                        endPage: '', //尾页节点内容
                                        keepShowPN: false, //是否一直显示上一页下一页
                                        count: 1, //当前页前后分页个数
                                        jump: false, //跳转到指定页数
                                        jumpIptCls: 'jump-ipt', //文本框内容
                                        jumpBtnCls: 'jump-btn', //跳转按钮
                                        jumpBtn: '跳转', //跳转按钮文本
                                        callback: function () {} //回调
                                    };

                                    var Pagination = function (element, options) {
                                        //全局变量
                                        var opts = options, //配置
                                            current, //当前页
                                            $document = $(document),
                                            $obj = $(element); //容器

                                        /**
                                         * 设置总页数
                                         * @param {int} page 页码
                                         * @return opts.pageCount 总页数配置
                                         */
                                        this.setPageCount = function (page) {
                                            return opts.pageCount = page;
                                        };

                                        /**
                                         * 获取总页数
                                         * 如果配置了总条数和每页显示条数，将会自动计算总页数并略过总页数配置，反之
                                         * @return {int} 总页数
                                         */
                                        this.getPageCount = function () {
                                            return opts.totalData && opts.showData ? Math.ceil(parseInt(opts.totalData) / opts.showData) : opts.pageCount;
                                        };

                                        /**
                                         * 获取当前页
                                         * @return {int} 当前页码
                                         */
                                        this.getCurrent = function () {
                                            return current;
                                        };

                                        /**
                                         * 填充数据
                                         * @param {int} 页码
                                         */
                                        this.filling = function (index) {
                                            var html = '';
                                            current = parseInt(index) || parseInt(opts.current); //当前页码
                                            var pageCount = this.getPageCount(); //获取的总页数
                                            if (opts.keepShowPN || current > 1) { //上一页
                                                html += '<a href="javascript:;" class="' + opts.prevCls + '">' + opts.prevContent + '</a>';
                                            } else {
                                                if (opts.keepShowPN == false) {
                                                    $obj.find('.' + opts.prevCls) && $obj.find('.' + opts.prevCls).remove();
                                                }
                                            }
                                            if (current >= opts.count + 2 && current != 1 && pageCount != opts.count) {
                                                var home = opts.coping && opts.homePage ? opts.homePage : '1';
                                                html += opts.coping ? '<a href="javascript:;" data-page="1">' + home + '</a>' : '';
                                            }
                                            var start = (current - opts.count) <= 1 ? 1 : (current - opts.count);
                                            var end = (current + opts.count) >= pageCount ? pageCount : (current + opts.count);
                                            for (; start <= end; start++) {
                                                if (start <= pageCount && start >= 1) {
                                                    if (start != current) {
                                                        html += '<a href="javascript:;" data-page="' + start + '">' + start + '</a>';
                                                    } else {
                                                        html += '<span class="' + opts.activeCls + '">' + start + '</span>';
                                                    }
                                                }
                                            }
                                            if (current + opts.count < pageCount && current >= 1 && pageCount > opts.count) {
                                                var end = opts.coping && opts.endPage ? opts.endPage : pageCount;
                                                html += opts.coping ? '<a href="javascript:;" data-page="' + pageCount + '">' + end + '</a>' : '';
                                            }
                                            if (opts.keepShowPN || current < pageCount) { //下一页
                                                html += '<a href="javascript:;" class="' + opts.nextCls + '">' + opts.nextContent + '</a>'
                                            } else {
                                                if (opts.keepShowPN == false) {
                                                    $obj.find('.' + opts.nextCls) && $obj.find('.' + opts.nextCls).remove();
                                                }
                                            }
                                            html += opts.jump ? '<input type="text" class="' + opts.jumpIptCls + '"><a href="javascript:;" class="' + opts.jumpBtnCls + '">' + opts.jumpBtn + '</a>' : '';
                                            $obj.empty().html(html);
                                        };

                                        //绑定事件
                                        this.eventBind = function () {
                                            var that = this;
                                            var pageCount = that.getPageCount(); //总页数
                                            var index = 1;
                                            $obj.off().on('click', 'a', function () {
                                                if ($(this).hasClass(opts.nextCls)) {
                                                    if ($obj.find('.' + opts.activeCls).text() >= pageCount) {
                                                        $(this).addClass('disabled');
                                                        return false;
                                                    } else {
                                                        index = parseInt($obj.find('.' + opts.activeCls).text()) + 1;
                                                    }
                                                } else if ($(this).hasClass(opts.prevCls)) {
                                                    if ($obj.find('.' + opts.activeCls).text() <= 1) {
                                                        $(this).addClass('disabled');
                                                        return false;
                                                    } else {
                                                        index = parseInt($obj.find('.' + opts.activeCls).text()) - 1;
                                                    }
                                                } else if ($(this).hasClass(opts.jumpBtnCls)) {
                                                    if ($obj.find('.' + opts.jumpIptCls).val() !== '') {
                                                        index = parseInt($obj.find('.' + opts.jumpIptCls).val());
                                                    } else {
                                                        return;
                                                    }
                                                } else {
                                                    index = parseInt($(this).data('page'));
                                                }
                                                that.filling(index);
                                                typeof opts.callback === 'function' && opts.callback(that);
                                                //页码数
                                                var name=$(".nonsupplierName").val();
                                                window.location.href="/supplier/noncooperation.do?currentPage="+index+"&supplierName="+name;
                                            });
                                            //输入跳转的页码
                                            $obj.on('input propertychange', '.' + opts.jumpIptCls, function () {
                                                var $this = $(this);
                                                var val = $this.val();
                                                var reg = /[^\d]/g;
                                                if (reg.test(val)) $this.val(val.replace(reg, ''));
                                                (parseInt(val) > pageCount) && $this.val(pageCount);
                                                if (parseInt(val) === 0) $this.val(1); //最小值为1
                                            });
                                            //回车跳转指定页码
                                            $document.keydown(function (e) {
                                                if (e.keyCode == 13 && $obj.find('.' + opts.jumpIptCls).val()) {
                                                    var index = parseInt($obj.find('.' + opts.jumpIptCls).val());
                                                    that.filling(index);
                                                    typeof opts.callback === 'function' && opts.callback(that);
                                                }
                                            });
                                        };
                                        //初始化
                                        this.init = function () {
                                            this.filling(opts.current);
                                            this.eventBind();
                                            if (opts.isHide && this.getPageCount() == '1' || this.getPageCount() == '0') $obj.hide();
                                        };
                                        this.init();
                                    };

                                    $.fn.pagination = function (parameter, callback) {
                                        if (typeof parameter == 'function') { //重载
                                            callback = parameter;
                                            parameter = {};
                                        } else {
                                            parameter = parameter || {};
                                            callback = callback || function () {};
                                        }
                                        var options = $.extend({}, defaults, parameter);
                                        return this.each(function () {
                                            var pagination = new Pagination(this, options);
                                            callback(pagination);
                                        });

                                    };
                                }));
                            </script>
                        </ul>
                    </div>

                </form>
            </c:if>
        </div>

    </div>
</div>
<!-- 新增 -->
<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form class="modal-content" id="addsupplier">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="myModabel">
                    新增供应商信息
                </h4>
            </div>
            <div class="modal-body" style="width: 300px;height: 500px" >
                <div class="input-group">
                    <span class="input-group-addon" style="width: 81px;">供应商名称</span>
                    <input  id="addname" name="supplierName" type="text" placeholder="请输入50字以内信息" class="form-control" style="width:477px;">
                </div>
                <span  class="reminder" id="Divname">&nbsp;</span>
                <br>
                <div class="input-group">
                    <span class="input-group-addon" style="width: 81px;">负责人名称</span>
                    <input name="supplierPersonInCharge" id="addpersonInCharge"placeholder="请输入50字以内信息" type="text" class="form-control"  style="width:477px;">
                </div>
                <span  class="reminder" id="DivpersonInCharge">&nbsp;</span>
                <br>
                <div class="input-group">
                    <span class="input-group-addon" style="width: 81px;">负责人职称</span>
                    <input name="supplierPost"  id="addpost" type="text"placeholder="请输入50字以内信息" class="form-control" style="width:477px;">
                </div>
                <span  class="reminder" id="Divpost">&nbsp;</span>
                <br>
                <div class="input-group">
                    <span class="input-group-addon" style="width: 81px;">供应商地址</span>
                    <input name="supplierAddress"  id="addaddress" type="text" placeholder="请输入100字以内信息"class="form-control"  style="width:487px;">
                </div>
                <span   class="reminder" id="Divaddress">&nbsp;</span>
                <br>
                <div class="input-group">
                    <span class="input-group-addon" style="width: 81px;">工厂地址</span>
                    <input name="supplierFactoryAddress"  id="addfactoryAddress" type="text"placeholder="请输入100字以内信息" class="form-control"  style="width:487px;">
                </div>
                <span  class="reminder" id="DivfactoryAddress">&nbsp;</span> <br>
                <div class="input-group">
                    <span class="input-group-addon" style="width: 81px;">移动电话</span>
                    <input name="supplierMobilePhone"  id="addmobilePhone"  type="text" class="form-control" placeholder="请输入正确号码" style="width:487px;">
                </div>
                <span  class="reminder" id="DivmobilePhone">&nbsp;</span> <br>
                <div class="input-group">
                    <span class="input-group-addon" style="width: 81px;">电话</span>
                    <input name="supplierPhone" id="addphone"  type="text" class="form-control" placeholder="请输入正确号码" style="width:515px;">
                </div>
                <span  class="reminder" id="Divphone">&nbsp;</span> <br>
                <div class="input-group">
                    <span class="input-group-addon" style="width: 81px;">传真</span>
                    <input name="supplierFax" id="addfax"  type="text" class="form-control" placeholder="请输入正确号码"  style="width:515px;">
                </div>
                <span class="reminder" id="Divfax">&nbsp;</span> <br>
                <div class="input-group" style="display: none">
                    <span class="input-group-addon" style="width: 81px;">是否已删除</span>
                    <input name="supplierState" id="addstate" type="text" value="0" class="form-control"  style="width:487px;">
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" id="closeAdd" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" id="insert" class="btn btn-primary">
                    提交新增
                </button>
            </div>
        </form>
    </div><!-- /.modal-content -->
</div><!-- /.modal -->
<!-- 修改 -->
<div class="modal fade" id="update" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
    <div class="modal-dialog">
        <form id="updatesupplier">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal" aria-hidden="true">
                    &times;
                </button>
                <h4 class="modal-title" id="updateTime">
                    修改供应商信息
                </h4>
            </div>
            <div class="modal-body" style="width: 300px;height: 500px" >
                <input id="updateid" name="supplierId" style="display: none"/>
                <div class="input-group">
                    <span class="input-group-addon" style="width: 81px;">供应商名称</span>
                    <input  name="supplierName" id="updatename" type="text" placeholder="请输入50字以内信息" class="form-control" style="width:477px;">
                </div>
                <span class="reminder" id="remindername">&nbsp;</span><br>
                <div class="input-group">
                    <span class="input-group-addon" style="width: 81px;">负责人名称</span>
                    <input  name="supplierPersonInCharge" id="updatepersonInCharge"placeholder="请输入50字以内信息" type="text" class="form-control"  style="width:477px;">
                </div>
                <span class="reminder" id="reminderpersonInCharge">&nbsp;</span><br>
                <div class="input-group">
                    <span class="input-group-addon" style="width: 81px;">负责人职称</span>
                    <input name="supplierPost"  id="updatepost" type="text"placeholder="请输入50字以内信息" class="form-control" style="width:477px;">
                </div>
                <span class="reminder" id="reminderpost">&nbsp;</span><br>
                <div class="input-group">
                    <span class="input-group-addon" style="width: 81px;">供应商地址</span>
                    <input name="supplierAddress"   id="updateaddress" type="text" placeholder="请输入100字以内信息"class="form-control"  style="width:477px;">
                </div>
                <span class="reminder" id="reminderaddress">&nbsp;</span><br>
                <div class="input-group">
                    <span class="input-group-addon" style="width: 81px;">工厂地址</span>
                    <input name="supplierFactoryAddress"  id="updatefactoryAddress" type="text"placeholder="请输入100字以内信息" class="form-control"  style="width:487px;">
                </div>
                <span class="reminder" id="reminderfactoryAddress">&nbsp;</span><br>
                <div class="input-group">
                    <span class="input-group-addon" style="width: 81px;">移动电话</span>
                    <input name="supplierMobilePhone"  id="updatemobilePhone"  type="text" class="form-control" placeholder="请输入正确号码" style="width:487px;">
                </div>
                <span class="reminder" id="remindermobilePhone">&nbsp;</span><br>
                <div class="input-group">
                    <span class="input-group-addon" style="width: 81px;">电话</span>
                    <input  name="supplierPhone"  id="updatephone"  type="text" class="form-control" placeholder="请输入正确号码" style="width:515px;">
                </div>
                <span class="reminder" id="reminderphone">&nbsp;</span><br>
                <div class="input-group">
                    <span class="input-group-addon" style="width: 81px;">传真</span>
                    <input name="supplierFax"  id="updatefax"  type="text" class="form-control" placeholder="请输入正确号码"  style="width:515px;">
                </div>
                <span class="reminder" id="reminderfax">&nbsp;</span><br>
            </div>
            <div class="modal-footer">
                <button type="button" id="closeUpdate" class="btn btn-default" data-dismiss="modal">关闭
                </button>
                <button type="button" id="updates" class="btn btn-primary">
                    提交修改
                </button>
            </div>
        </div><!-- /.modal-content -->
        </form>
    </div><!-- /.modal -->
</div>
</body>

</html>