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
<template:addResources type="css" resources="bootstrap.css"/>
<template:addResources type="javascript" resources="jquery.min.js,bootstrap.js"/>

<c:set var="containerType" value="${currentNode.properties['containerType'].string}"/>
<c:set var="containerClass" value="container"/>
<c:if test="${containerType == 'fluid'}">
    <c:set var="containerClass" value="container-fluid"/>
</c:if>
<div class="${containerClass}" id="${currentNode.name}">
    <c:forEach items="${jcr:getChildrenOfType(currentNode, 'jnt:bootstrapRow')}" var="bootstrapRow">
        <template:module node="${bootstrapRow}" editable="true">
            <template:param name="containerType" value="${containerType}"/>
        </template:module>
    </c:forEach>
</div>
<c:if test="${renderContext.editMode}">
    <template:module path="*" nodeTypes="jnt:bootstrapRow"/>
</c:if>

