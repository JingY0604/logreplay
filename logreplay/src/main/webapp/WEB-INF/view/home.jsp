<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ include file="./include/include.jsp" %>
<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <title>��ҳ</title>
	<%@ include file="./include/includeCss.jsp" %>
</head>
<body style="height: 3000px;">
<%@ include file="./include/includeTopBar.jsp" %>

<div class="container" style="_width: 1200px;">
	<div class="row">
	
		<%@ include file="./include/includeLeftMenu.jsp" %>
		
		<div class="col-lg-10 col-sm-10">
			<div>
			    <ul class="breadcrumb">
			        <li>
						��ǰλ��: <a href="${ctx_path}/home.htm">��ҳ</a>
			        </li> 
			    </ul>
			</div>
			
			<div class="row">
			    <div class="box col-md-12">
			    	<div style="font-family: 'Microsoft Yahei'; text-align: center;">
				    	<h2><strong>��ӭ�㣬<shiro:principal />��</strong></h2>
				    	<h2><strong>�ֽ������õ�һ�죡</strong></h2>
			    	</div>
			    	<%--
			        <div class="box-inner"> 
			            <div class="box-content" style="height: 500px;">
			                <!-- put your content here -->
			                <p>Welcome <shiro:principal />!</p>
			                <button id="J_alertTest" class="btn btn-default">alert</button>
							<button id="J_confirmTest" class="btn btn-default">confirm</button>
							<div id="J_pagebar"></div>
							<h2>${fn:endsWith(pageContext.request.requestURI, '/home.jsp')}</h2>
			            </div>
			        </div>
			         --%>
			    </div>
			</div><!--/row-->
			
		</div>
	</div>
</div>
<%@ include file="./include/includeJs.jsp" %>
<script>
seajs.use('app/home', function(home) {
	home.init();
});
</script>
</body>
</html>

