<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>场地预定</title>
    <meta name="decorator" content="main"/>
    <link type="text/css" rel="stylesheet" href="${ctxStatic}/modules/reserve/css/field.css?id=7862256"/>
    <link type="text/css" rel="stylesheet" href="${ctxStatic}/jquery/smartMenu.css"/>
    <script type="text/javascript"
            src="${ctxStatic}/jquery/jquery-smartMenu-min.js"></script>
    <script type="text/javascript">var ctx = '${ctx}', consDate = '${consDate.time}', venueId = '${reserveVenue.id}';</script>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/sidebar.jsp">
    <jsp:param name="action" value="reserveField"></jsp:param>
</jsp:include>
<div class="container-fluid" id="pcont">
    <div class="row">
        <div class="col-md-12">
            <div class="block-flat">
                <div class="tab-tit-first">

                    <ul>
                        <div id="venues">
                            <%-- 场馆--%>
                            <c:forEach items="${reserveVenueList}" var="venue" varStatus="status">
                                <li <j:if test="${venue.id eq reserveVenue.id}">class="on"</j:if>><a
                                        href="${ctx}/reserve/field/main?venueId=${venue.id}&t=${consDate.time}">${venue.name}</a>
                                </li>
                            </c:forEach>
                        </div>
                        <%-- 场馆--%>
                    </ul>
                    <ul class="table-ul">
                        <li style="margin-left: 0px;"><span class="green-bg-color"></span>可预订</li>
                        <li><span class="blue-bg-color"></span>已选场次</li>
                        <li><span class="grey-bg-color"></span>已占用</li>
                        <li><span class="red-bg-color"></span>已付款</li>
                    </ul>
                </div>
                <%-- 周几，日期--%>
                <div class="tab-tit">
                    <a name="order"></a>
                    <ul>
                        <div id="timeSlotDiv">
                            <c:forEach items="${timeSlot}" var="slot" varStatus="status">
                                <li
                                        &lt;%&ndash;
                                        <j:if test="${consDate.time eq slot.value}">class="on"</j:if> ><a
                                        href="${ctx}/reserve/field/main?venueId=${reserveVenue.id}&t=${slot.value}">${slot.key}</a>&ndash;%&gt;

                                    <j:if test="${consDate.time eq slot.value}">class="on"</j:if> ><a
                                            href="javascript:filedStatus('${reserveVenue.id}','${slot.value}')">${slot.key}</a>
                                </li>
                            </c:forEach>
                        </div>
                    </ul>
                </div>
                <%-- 周几，日期 结束--%>

                <div class="sy-tab-cont">

                    <div class="table-left">
                        <%@include file="reserveAMField.jsp" %>
                        <%@include file="reservePMField.jsp" %>
                        <%@include file="reserveEveningField.jsp" %>
                    </div>

                    <script type="text/javascript">
                        $(".table-left-l ul").css("padding-top", parseInt($(".table-chang thead").eq(0).height()) + 3 + "px");
                    </script>

                </div>
            </div>
        </div>

    </div>
</div>
<%@include file="../include/modal.jsp" %>
<!--end dialog-->
<script>
    document.write("<script type='text/javascript' src='${ctxStatic}/modules/reserve/js/reserve_field.js?t=" + Math.random() + "'><\/script>");
</script>

</body>
</html>
