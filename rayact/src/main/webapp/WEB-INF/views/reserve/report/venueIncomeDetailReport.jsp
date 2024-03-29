<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>场地收入统计</title>
    <meta name="decorator" content="main"/>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/sidebar.jsp">
    <jsp:param name="action" value="venueIncomeReport"></jsp:param>
</jsp:include>
<div class="container-fluid" id="pcont">
    <div class="row">
        <div class="col-md-12">
            <div class="block-flat">
                <div class="header">
                    <h3>场地收入统计</h3>
                </div>
                <form:form id="searchForm" modelAttribute="reserveVenue" action="${ctx}/reserve/reserveVenue/report"
                           method="post" class="breadcrumb form-search">
                    <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}"/>
                    <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}"/>

                    <div class="row">
                        <div class="col-sm-12 col-md-12 col-lg-12">
                            <table class="no-border">
                                <tbody class="no-border-y">
                                <tr>
                                    <td>场馆:</td>
                                    <td>

                                        <sys:select cssClass="input-large" name="reserveVenue.id"
                                                    value="reserveVenue"
                                                    items="${reserveVenueList}" itemLabel="name" itemValue="id"
                                                    defaultLabel="----请选择-----"
                                                    defaultValue=""></sys:select>
                                    </td>
                                    <td>项目:</td>
                                    <td>

                                        <sys:select cssClass="input-large" name="reserveProject.id"
                                                    value="reserveProject"
                                                    items="${reserveProjectList}" itemLabel="name" itemValue="id"
                                                    defaultLabel="----请选择-----"
                                                    defaultValue=""></sys:select>
                                    </td>
                                    <td>类型：</td>
                                    <td>
                                        <div class="btn-group" id="payType">
                                            <label class="radio-inline">
                                                <input type="radio" class="icheck" value="1"
                                                       name="queryType"/>汇总
                                            </label>

                                            <label class="radio-inline">
                                                <input type="radio" class="icheck" value="2" checked="checked" name="queryType"/>明细
                                            </label>
                                        </div>
                                    </td>
                                    <td>
                                        <input name="startDate" id="startDate" type="text"
                                               maxlength="20"
                                               class="input-medium form-control Wdate "
                                               value="<fmt:formatDate value="${incomeReport.startDate}" type="date"></fmt:formatDate>"
                                               onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                                        </td>
                                    <td>
                                        <input name="endDate" id="endDate" type="text"
                                               maxlength="20"
                                               class="input-medium form-control Wdate "
                                               value="<fmt:formatDate value="${incomeReport.endDate}" type="date"></fmt:formatDate>"
                                               onclick="WdatePicker({dateFmt:'yyyy-MM-dd',isShowClear:false});"/>
                                    </td>
                                    <td><input id="btnSubmit" class="btn btn-primary" type="submit" value="查询"/></td>
                                </tr>
                                </tbody>
                            </table>
                        </div>
                    </div>
                </form:form>
                时间:<fmt:formatDate value="${incomeReport.startDate}" type="date"></fmt:formatDate>至<fmt:formatDate value="${incomeReport.endDate}" type="date"></fmt:formatDate>
                <div class="content">
                    <div class="table-responsive">
                        <table>
                            <thead>
                            <tr>
                                <th>场馆</th>
                                <th>项目</th>
                                <th>场地</th>
                                <th>储值卡</th>
                                <th>现金</th>
                                <th>银行卡</th>
                                <th>微信</th>
                                <th>支付宝</th>
                                <th>其它</th>
                                <th>欠账</th>
                                <th>合计</th>
                            </tr>
                            </thead>
                            <tbody>
                            <%-- 总统计 开始 --%>



                            <c:forEach items="${incomeReport.projectIntervalReports}" var="projectReport">

                                <c:forEach items="${projectReport.fieldIntervalReports}" var="report">
                                <%-- 项目区间统计 开始 --%>
                                <tr>
                                    <td>
                                            ${report.reserveVenue.name}
                                    </td>
                                    <td>
                                            ${report.reserveProject.name}
                                    </td>
                                    <td>
                                            ${report.reserveField.name}
                                    </td>
                                    <td>
                                            ${report.fieldBillStoredCard}
                                    </td>
                                    <td>
                                            ${report.fieldBillCash}
                                    </td>
                                    <td>
                                            ${report.fieldBillBankCard}
                                    </td>

                                    <td>
                                            ${report.fieldBillWeiXin}
                                    </td>
                                    <td>
                                            ${report.fieldBillAliPay}
                                    </td>
                                    <td>
                                            ${report.fieldBillOther}
                                    </td>
                                    <td>
                                            ${report.fieldBillDue}
                                    </td>
                                    <td>
                                            ${report.bill}
                                    </td>

                                </tr>
                                </c:forEach>
                            </c:forEach>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>