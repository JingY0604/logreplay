<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<nav class="navbar navbar-default navbar-fixed-top top-bar" role="navigation">
	<div class="container-fluit">
		<div class="collapse navbar-collapse">
			<div class="col-sm-3 col-md-4"></div>
			<ul class="nav navbar-left" style="margin-top:6px; padding-left: 50px;">
				<li class="title"><strong>Sogou�ͻ�����־���ط�ϵͳ</strong></li>
			</ul>
			<shiro:user>
				<ul class="nav navbar-nav navbar-right">
					<li><a href="${ctx_path}/home.htm">��ҳ</a></li>
					<li><a href="###"><shiro:principal/></a></li>
					<li><a href="${ctx_path}/logout.htm">�˳�</a></li>
					<li style="width: 10px;"></li>
				</ul>
			</shiro:user>
		</div>
	</div>
</nav>
