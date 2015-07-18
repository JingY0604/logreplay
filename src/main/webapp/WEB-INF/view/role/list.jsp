<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ include file="../include/include.jsp" %>
<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <title>��ɫ����</title>
	<%@ include file="../include/includeCss.jsp" %>
</head>
<body>

<%@ include file="../include/includeTopBar.jsp" %>

<div class="container" style="margin-bottom: 50px;">
	<div class="row"><!-- row1 -->
		<%@ include file="../include/includeLeftMenu.jsp" %>
		<div class="col-sm-10">
			<div>
			    <ul class="breadcrumb">
			        <li>
						��ǰλ��: <a data-toggle="collapse" href="#J_logConfigSubmenu">�����Ϣ����</a>
						 &gt; <a href="${ctx_path}/role/list.htm">��ɫ����</a>
			        </li> 
			    </ul>
			</div>
			<div class="row"><!-- row2 -->
			     <div class="col-sm-12">
			     	<div style="margin-top: 20px;">
				     	<table class="table table-bordered table-striped table-condensed table-hover ">
				     		<thead>
				     			<tr>
				     				<th style="width: 100px;">��ɫ</th>
				     				<th style="width: 150px;">����</th>
				     				<th>����</th>
				     				<th style="width: 200px;">����</th>
				     			</tr>
				     		</thead>
				     		<tbody id="J_roleTbody">
				     		</tbody>
							<script type="text/x-jquery-tmpl" id="J_roleTmpl">
								<tr data-id="${'${'}id}">
				     				<td>${'${'}name}</td>
				     				<td>${'${'}displayName}</td>
				     				<td>${'${'}comment}</td>
				     				<td>
				     					<button class="btn btn-primary btn-xs open-update-modal">�޸�</button>
				     					<button class="btn btn-primary btn-xs open-relate-permission-modal">����Ȩ��</button>
				     				</td>
				     			</tr>
							</script>
				     	</table>
			     	</div>
			    </div>
			</div><!--/row2-->
		</div>
	</div><!-- /row1 -->
</div>

<%@ include file="../include/includeJs.jsp" %>
<script>
seajs.use('app/role/list', function(list) {
	list.init();
});
</script>
</body>
</html>

