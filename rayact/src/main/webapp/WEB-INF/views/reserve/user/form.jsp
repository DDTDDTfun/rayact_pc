<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ include file="/WEB-INF/views/include/taglib.jsp" %>
<html>
<head>
    <title>用户管理</title>
    <meta name="decorator" content="main"/>
    <%@include file="/WEB-INF/views/include/upload.jsp" %>
</head>
<body>
<jsp:include page="/WEB-INF/views/include/sidebar.jsp">
    <jsp:param name="action" value="user"></jsp:param>
</jsp:include>
<div class="container-fluid" id="pcont">
    <div class="page-head">
        <h3>用户管理</h3>
    </div>
    <div class="cl-mcont">
        <div class="block-flat">
            <form:form id="inputForm" modelAttribute="user" action="${ctx}/reserve/user/save"
                       class="form-horizontal" role="form">
                <form:hidden path="id"/>
                <input type="hidden" name="token" value="${token}"/>
                <sys:msg content="${message}"/>
                <div class="form-group">
                    <label class="col-sm-2 control-label">工号:</label>

                    <div class="col-sm-4">
                        <form:input path="no" htmlEscape="false" maxlength="50" class="required form-control"/>
                        <span class="help-inline"> </span>
                    </div>
                </div>
                <div class="form-group">
                    <label class="col-sm-2 control-label">姓名:</label>

                    <div class="col-sm-4">
                        <form:input path="name" htmlEscape="false" maxlength="50" class="required form-control"/>
                        <span class="help-inline"> </span>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label">手机:</label>

                    <div class="col-sm-4">
                        <form:input path="phone" htmlEscape="false" maxlength="50" class="required form-control"/>
                        <span class="help-inline"> </span>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label">登录名:</label>

                    <div class="col-sm-4">
                        <input id="oldLoginName" name="oldLoginName" type="hidden"
                               value="${user.loginName}">
                        <form:input path="loginName" htmlEscape="false" maxlength="50"
                                    class="required userName form-control"/>
                        <span class="help-inline"> </span>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label">密码:</label>

                    <div class="col-sm-4">
                        <input id="newPassword" name="newPassword" type="password" value=""
                               maxlength="50" minlength="3"
                               class="${empty user.id?'required':''} form-control"/>
                        <c:if test="${empty user.id}"><span class="help-inline"><font
                                color="red">*</font> </span></c:if>
                        <c:if test="${not empty user.id}"><span
                                class="help-inline">若不修改密码，请留空。</span></c:if>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label">场馆管理:</label>

                    <div class="col-sm-10">
                        <c:forEach items="${venueList}" var="venue" varStatus="status">
                            <label>
                                <c:set var="vchecked" value=""/>
                                <c:forEach items="${userRole.venueList}" var="v">
                                    <c:if test="${venue.id eq v}">
                                        <c:set var="vchecked" value="checked=\"checked\""/>
                                    </c:if>
                                </c:forEach>
                                <input type="checkbox" id="userRoleCheck" ${vchecked}
                                       name="reserveRole.venueList[${status.index}]" class="icheck"
                                       value="${venue.id}"/>${venue.name}</label>
                        </c:forEach>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label">角色:</label>

                    <div class="col-sm-10">
                        <label><input type="radio" <j:if test="${'1' eq userRole.userType}"> checked="checked" </j:if>
                                      name="userType" class="icheck userType" value="1"/>超级管理员</label>
                        <label><input type="radio" <j:if test="${'2' eq userRole.userType}"> checked="checked" </j:if>
                                      name="userType" class="icheck userType" value="2"/>场馆管理员</label>
                        <label><input type="radio" <j:if test="${'3' eq userRole.userType}"> checked="checked" </j:if>
                                      name="userType" class="icheck userType" value="3"/>场地管理员</label>
                        <label><input type="radio" <j:if test="${'4' eq userRole.userType}"> checked="checked" </j:if>
                                      name="userType" class="icheck userType" value="4"/>收银</label>
                        <label><input type="radio" <j:if test="${'5' eq userRole.userType}"> checked="checked" </j:if>
                                      name="userType" class="icheck userType" value="5"/>财务</label>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label">结账密码:</label>

                    <div class="col-sm-4">
                        <form:input path="checkoutPwd" htmlEscape="false" maxlength="50"
                                    class="form-control"/>
                    </div>

                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label">权限:</label>

                    <div class="col-sm-10">

                        <c:forEach items="${authList}" var="auth" varStatus="astatus">
                            <%--遍历所有权限--%>
                            <div class="row">
                                <div class="col-sm-6 col-md-8 col-lg-10 cl-mcont">
                                    <div class="block-flat">
                                            <%--权限组--%>
                                        <div class="header">
                                            <c:set value="" var="checked"></c:set>
                                            <c:forEach items="${userRole.authorityList}" var="ur">
                                                <%--遍历用户的已有权限--%>
                                                <c:if test="${ur.code eq auth.code}">
                                                    <c:set value="checked='checked'" var="checked"></c:set>
                                                </c:if>
                                                <%--遍历用户的已有权限 end--%>
                                            </c:forEach>
                                            <label>
                                                <input type="checkbox" ${checked}
                                                       name="reserveRole.authorityList[${astatus.index}].code"
                                                       class="icheck authCheck"
                                                       value="${auth.code}"/>
                                                    ${auth.name}
                                            </label>
                                        </div>
                                            <%--权限组结束--%>

                                        <c:forEach items="${auth.authorityList}" var="a" varStatus="s">
                                            <%-- 权限组的子权限--%>
                                            <div class="radio col-lg-4">
                                                <c:set value="" var="childchecked"></c:set>
                                                <c:forEach items="${userRole.authorityList}" var="ur">
                                                    <%--遍历用户的已有权限--%>
                                                    <c:if test="${ur.code eq auth.code}">
                                                        <c:forEach items="${ur.authorityList}" var="child">
                                                            <c:if test="${a.code eq child.code}">
                                                                <c:set value="checked='checked'"
                                                                       var="childchecked"></c:set>
                                                            </c:if>
                                                        </c:forEach>
                                                    </c:if>
                                                    <%--遍历用户的已有权限 end--%>
                                                </c:forEach>

                                                <label> <input data-parent="${auth.code}"
                                                               type="checkbox" ${childchecked} value="${a.code}"
                                                               name="reserveRole.authorityList[${astatus.index}].authorityList[${s.index}].code"
                                                               class="icheck childAuthCheck"> ${a.name}</label>
                                            </div>
                                            <%-- 子权限 end--%>
                                        </c:forEach>
                                    </div>
                                </div>
                            </div>
                            <%--遍历所有权限 end--%>
                        </c:forEach>
                    </div>
                </div>

                <div class="form-group">
                    <label class="col-sm-2 control-label">备注:</label>

                    <div class="col-sm-6">
                        <form:textarea path="remarks" cssClass="form-control"></form:textarea>
                    </div>
                </div>

                <div class="form-group">
                    <div class="col-sm-offset-2 col-sm-10">
                        <button type="submit" id="btnSubmit" class="btn btn-primary">保存</button>
                        <button class="btn btn-default" onclick="history.go(-1)">返回</button>
                    </div>
                </div>
            </form:form>
        </div>
    </div>
</div>
<script type="text/javascript">
    $(document).ready(function () {
        var childCheck = false;
        $(".authCheck").on('ifChecked', function () {
            if (childCheck) {
                return;
            }
            var id = $(this).attr("value");
            $(".childAuthCheck[data-parent='" + id + "']").iCheck('check');
        });
        $(".authCheck").on('ifUnchecked', function () {
            var id = $(this).attr("value");
            $(".childAuthCheck[data-parent='" + id + "']").iCheck('uncheck');
        });
        $(".childAuthCheck").on('ifChecked', function (event) {
            var id = $(this).attr("data-parent");
            childCheck = true;
            $(".authCheck[value='" + id + "']").iCheck('check');
            childCheck = false;
        });
    });
</script>
<script type="text/javascript">
    $(document).ready(function () {

        $("#no").focus();
        $("#inputForm").validate({
            rules: {
                loginName: {remote: "${ctx}/reserve/user/checkLoginName?oldLoginName=" + encodeURIComponent('${user.loginName}')}
            },
            messages: {
                loginName: {remote: "用户登录名已存在"},
                confirmNewPassword: {equalTo: "输入与上面相同的密码"}
            },
            submitHandler: function (form) {
                formLoding('正在提交，请稍等...');
                form.submit();
            },
            errorContainer: "#messageBox",
            errorPlacement: function (error, element) {
                $("#messageBox").text("输入有误，请先更正。");
                if (element.is(":checkbox") || element.is(":radio") || element.parent().is(".input-append")) {
                    error.appendTo(element.parent().parent());
                } else {
                    error.insertAfter(element);
                }
            }
        });
    });
</script>
</body>
</html>
