<%@page import="org.springframework.http.HttpStatus"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ include file="./include/include.jsp" %>
<% response.setStatus(HttpStatus.NOT_FOUND.value()); %>
<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <title>404</title>
	<%@ include file="./include/includeCss.jsp" %>
</head>
<body>
<%@ include file="./include/includeTopBar.jsp" %>

<div class="container">
	<div style="text-align: center; font-family: 'Microsoft Yahei'; margin-top: 200px;">
		<h2><strong>�Բ��𣬵�ǰҳ�治����! <a href="javascript: history.back();">�뷵��</a></strong></h2>
	</div>
</div>
</body>
</html>

