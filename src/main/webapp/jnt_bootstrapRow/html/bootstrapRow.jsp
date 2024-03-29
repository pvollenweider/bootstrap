<%@ taglib prefix="jcr" uri="http://www.jahia.org/tags/jcr" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="utility" uri="http://www.jahia.org/tags/utilityLib" %>
<%@ taglib prefix="template" uri="http://www.jahia.org/tags/templateLib" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="functions" uri="http://www.jahia.org/tags/functions" %>
<%@ taglib prefix="ui" uri="http://www.jahia.org/tags/uiComponentsLib" %>
<%--@elvariable id="currentNode" type="org.jahia.services.content.JCRNodeWrapper"--%>
<%--@elvariable id="propertyDefinition" type="org.jahia.services.content.nodetypes.ExtendedPropertyDefinition"--%>
<%--@elvariable id="type" type="org.jahia.services.content.nodetypes.ExtendedNodeType"--%>
<%--@elvariable id="out" type="java.io.PrintWriter"--%>
<%--@elvariable id="script" type="org.jahia.services.render.scripting.Script"--%>
<%--@elvariable id="scriptInfo" type="java.lang.String"--%>
<%--@elvariable id="workspace" type="java.lang.String"--%>
<%--@elvariable id="renderContext" type="org.jahia.services.render.RenderContext"--%>
<%--@elvariable id="currentResource" type="org.jahia.services.render.Resource"--%>
<%--@elvariable id="url" type="org.jahia.services.render.URLGenerator"--%>

<c:set var="containerType" value="${currentResource.moduleParams.containerType}"/>
<c:set var="rowType" value="${currentNode.properties['rowType'].string}"/>
<c:set var="rowName" value="${currentNode.name}"/>

<c:set var="rowClass" value="row"/>
<c:if test="${containerType == 'fluid'}">
    <c:set var="rowClass" value="row-fluid"/>
</c:if>
<div class="${rowClass}" id="${rowName}">
    <c:choose>
        <c:when test="${rowType == 'predefined'}">
            <c:set var="layout" value="${currentNode.properties['layout'].string}"/>
            <c:choose>
                <c:when test="${layout == '4_8'}">
                    <div class="span4"><template:area path="${rowName}-1"/></div>
                    <div class="span8"><template:area path="${rowName}-2"/></div>
                </c:when>
                <c:when test="${layout == '8_4'}">
                    <div class="span8"><template:area path="${rowName}-2"/></div>
                    <div class="span4"><template:area path="${rowName}-1"/></div>
                </c:when>
                <c:when test="${layout == '3_9'}">
                    <div class="span3"><template:area path="${rowName}-1"/></div>
                    <div class="span9"><template:area path="${rowName}-2"/></div>
                </c:when>
                <c:when test="${layout == '9_3'}">
                    <div class="span9"><template:area path="${rowName}-2"/></div>
                    <div class="span3"><template:area path="${rowName}-1"/></div>
                </c:when>
                <c:when test="${layout == '2_10'}">
                    <div class="span2"><template:area path="${rowName}-1"/></div>
                    <div class="span10"><template:area path="${rowName}-2"/></div>
                </c:when>
                <c:when test="${layout == '10_2'}">
                    <div class="span10"><template:area path="${rowName}-2"/></div>
                    <div class="span2"><template:area path="${rowName}-1"/></div>
                </c:when>
                <c:when test="${layout == '4_4_4'}">
                    <div class="span4"><template:area path="${rowName}-1"/></div>
                    <div class="span4"><template:area path="${rowName}-2"/></div>
                    <div class="span4"><template:area path="${rowName}-3"/></div>
                </c:when>
                <c:when test="${layout == '6_6'}">
                    <div class="span6"><template:area path="${rowName}-1"/></div>
                    <div class="span6"><template:area path="${rowName}-2"/></div>
                </c:when>
                <c:when test="${layout == '12'}">
                    <div class="span12"><template:area path="${rowName}-1"/></div>
                </c:when>
                <c:otherwise>
                    <c:if test="${renderContext.editMode}">
                        <div class="span12">
                            <div class="alert">
                                <button type="button" class="close" data-dismiss="alert">×</button>
                                <strong><fmt:message key="bootstrap.message.warning"/>!</strong> <fmt:message
                                    key="bootstrap.message.couldNotDisplayLayout"/> ${layout}.
                            </div>
                        </div>
                    </c:if>
                </c:otherwise>
            </c:choose>
        </c:when>
        <c:otherwise>
            <c:set var="columns" value="${currentNode.properties['columns'].string}"/>
            <c:forTokens items="${columns}" delims="," varStatus="status" var="col">
                <div class="${col}"><template:area path="${rowName}-${status.index}"/></div>
            </c:forTokens>
        </c:otherwise>
    </c:choose>
</div>
