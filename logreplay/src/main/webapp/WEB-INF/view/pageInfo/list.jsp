<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ include file="../include/include.jsp" %>
<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <title>home</title>
	<%@ include file="../include/includeCss.jsp" %>
	<style>
		table.table {
			text-align: center;
		}
		table.table tr>th {
			text-align: center;
			background-color: #eee;
		}
	</style>
</head>
<body style="height: 3000px;">
<%@ include file="../include/includeTopBar.jsp" %>

<div class="container" style="_width: 1200px;">
	<div class="row">
	
		<%@ include file="../include/includeMenuBar.jsp" %>
		
		<div class="col-lg-10 col-sm-10">
			<div>
			    <ul class="breadcrumb">
			        <li>
			            	��ǰλ��: <a>��־�����</a> > <a>ҳ�����</a>
			        </li> 
			    </ul>
			</div>
			
			<div class="row">
			    <div class="col-md-12">
			     	<div id="J_queryArea" style="height: 100px; border: 1px solid #ccc; text-align: center;">
			     		<h2 style="line-height: 50px;">��ѯ��ռλ</h2>
			     	</div>
			     	<hr>
			     	<div>
			     		<button class="btn btn-primary">����</button>
			     	</div>
			     	<div style="margin-top: 20px;">
				     	<table class="table table-bordered table-striped table-condensed table-hover ">
				     		<thead>
				     			<tr>
				     				<th style="width: 100px;">ҳ����</th>
				     				<th>ҳ������</th>
				     				<th style="width: 150px;">����ʱ��</th>
				     				<th style="width: 150px;">�޸�ʱ��</th>
				     				<th style="width: 200px;">����</th>
				     			</tr>
				     		</thead>
				     		<tbody>
				     			<tr>
				     				<td>1</td>
				     				<td>��ҳ</td>
				     				<td>--</td>
				     				<td>--</td>
				     				<td>
				     					<a href="###">�޸�</a>
				     					|
				     					<a href="###">ɾ��</a>
				     					|
				     					<a href="###">��ǩ</a>
				     				</td>
				     			</tr>
				     			<tr>
				     				<td>2</td>
				     				<td>��һ��ҳ��</td>
				     				<td>--</td>
				     				<td>--</td>
				     				<td>
				     					<a href="###">�޸�</a>
				     					|
				     					<a href="###">ɾ��</a>
				     					|
				     					<a href="###">��ǩ</a>
				     				</td>
				     			</tr>
				     		</tbody>
				     	</table>
			     	</div>
			     	
			    </div>
			</div><!--/row-->
			
		</div>
		
	</div>
</div>

<%@ include file="../include/includeJs.jsp" %>
<script>
seajs.use('app/pageInfo/list', function(list) {
	list.init();
});
</script>
</body>
</html>

