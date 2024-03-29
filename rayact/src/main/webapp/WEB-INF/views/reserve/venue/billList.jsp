<%@ page contentType="text/html;charset=UTF-8" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>场馆损益管理</title>
    <meta name="decorator" content="main"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/sidebar.jsp">
    <jsp:param name="action" value="reserveVenueBill"></jsp:param>
</jsp:include>
<div class="container-fluid" id="pcont">
    <div class="row">
        <div class="col-md-12">
            <div class="block-flat">
                <div class="header">
                    <h3>场馆损益列表</h3>

                    <form:form id="searchForm" modelAttribute="reserveVenueBill"
                               action="${ctx}/reserve/reserveVenueBill/" method="post" class="breadcrumb form-search">
                        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>
                        <div class="row">
                            <div class="col-sm-6 col-md-6 col-lg-6">
                                <table class="no-border">
                                    <tbody class="no-border-y">
                                    <tr>
                                        <td>场馆名称:</td>
                                        <td>
                                            <sys:select cssClass="input-xlarge" cssStyle="width:200px"
                                                        name="reserveVenue.id"
                                                        items="${venueList}"
                                                        value="${venue}" itemLabel="name"
                                                        itemValue="id"></sys:select>
                                        </td>
                                        <td><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/>
                                        </td>
                                    </tr>
                                    </tbody>
                                </table>
                            </div>
                            <div class="pull-right">
                                <a class="btn btn-success" href="${ctx}/reserve/reserveVenueBill/form">
                                    <i class="fa fa-plus"></i>添加
                                </a>
                            </div>
                        </div>
                    </form:form>
                    <sys:msg content="${message}"/>
                    <div class="content">
                        <div class="table-responsive">
                            <table>
                                <thead>
                                <tr>
                                    <th>场馆</th>
                                    <th>水费</th>
                                    <th>电费</th>
                                    <th>油费</th>
                                    <th>体育用品维修</th>
                                    <th>办公设施维修</th>
                                    <th>场馆设备维修</th>
                                    <th>其他</th>
                                    <th>开始时间</th>
                                    <th>结束时间</th>
                                    <th>操作</th>
                                </tr>
                                </thead>
                                <tbody>
                                <c:forEach items="${page.list}" var="reserveVenueBill">
                                    <tr>
                                        <td>
                                                ${reserveVenueBill.reserveVenue.name}
                                        </td>
                                        <td>
                                                ${reserveVenueBill.waterBill}
                                        </td>
                                        <td>
                                                ${reserveVenueBill.elecBill}
                                        </td>
                                        <td>
                                                ${reserveVenueBill.oilBill}
                                        </td>
                                        <td>
                                                ${reserveVenueBill.sportDeviceRepairBill}
                                        </td>
                                        <td>
                                                ${reserveVenueBill.officeDeviceRepairBill}
                                        </td>
                                        <td>
                                                ${reserveVenueBill.venueDeviceRepairBill}
                                        </td>
                                        <td>
                                                ${reserveVenueBill.otherBill}
                                        </td>
                                        <td><fmt:formatDate value="${reserveVenueBill.startDate}"
                                                            type="date"/></td>
                                        <td>
                                            <fmt:formatDate value="${reserveVenueBill.endDate}"
                                                            type="date"/>
                                        </td>
                                        <td>
                                            <a class="btn btn-primary btn-xs"
                                               href="${ctx}/reserve/reserveVenueBill/form?id=${reserveVenueBill.id}"><i
                                                    class="fa fa-pencil"></i>修改</a>
                                            <a class="btn btn-danger btn-xs"
                                               href="${ctx}/reserve/reserveVenueBill/delete?id=${reserveVenueBill.id}"
                                               onclick="return confirmb('确认要删除该场馆损益吗？', this.href)"><i
                                                    class="fa fa-times"></i>删除</a>
                                        </td>
                                    </tr>
                                </c:forEach>
                                </tbody>
                            </table>

                            <div class="row">
                                <div class="col-sm-12">

                                    <div class="pull-right">
                                        <div class="dataTables_paginate paging_bs_normal">
                                            <sys:javascript_page p="${page}"></sys:javascript_page>
                                        </div>
                                    </div>
                                    <div class="clearfix"></div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
