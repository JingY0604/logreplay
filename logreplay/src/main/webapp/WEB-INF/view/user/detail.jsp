<%@page import="com.sogou.map.logreplay.util.AuthUtil"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ include file="../include/include.jsp" %>
<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <title>�ʻ�����</title>
	<%@ include file="../include/includeCss.jsp" %>
	<style>
		.panel-heading {
			text-align: center;
		}
		.panel-heading > .title {
			font-size: 18px;
			font-family: 'Microsoft Yahei'
		}
	</style>
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
						��ǰλ��: <a data-toggle="collapse" href="#J_systemManageSubmenu">ϵͳ����</a>
						 &gt; <a href="${ctx_path}/user/detail.htm">�ʻ�����</a>
			        </li> 
			    </ul>
			</div>
			<div class="row"><!-- row2 -->
			    <div class="col-sm-6 col-sm-offset-3">
			     	<div class="panel panel-default">
			     		<div class="panel-heading"><strong class="title">�ʻ���Ϣ</strong></div>
			     		<table class="table table-bordered">
			     			<tbody>
			     				<tr>
			     					<td><strong>�û���</strong></td>
			     					<td><shiro:principal/></td>
			     				</tr>
			     				<tr>
			     					<td><strong>�ǳ�</strong></td>
			     					<td><%=AuthUtil.getScreenName()%></td>
			     				</tr>
			     				<tr>
			     					<td><strong>��ɫ</strong></td>
			     					<td><%=AuthUtil.getCurrentRoleObj().getDisplayName()%></td>
			     				</tr>
			     				<tr>
			     					<td colspan="2">
			     						<button class="btn btn-primary" id="J_openUpdatePasswordModalBtn">�޸�����</button>
			     					</td>
			     				</tr>
			     			</tbody>
			     		</table>
			     	</div>
				</div>
			</div><!--/row2-->
		</div>
	</div><!-- /row1 -->
</div>

<!-- �޸�����ĵ����� -->
<div class="modal" id="J_passwordModal" tabindex="-1">
    <div class="modal-dialog">
    	<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title"><strong>����</strong></h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" role="form">
					<div class="form-group">
						<label for="PW_oldPassword" class="col-sm-4 control-label">ԭ���룺</label>
						<div class="col-sm-8">
							<input type="password" class="form-control" id="PW_oldPassword" name="oldPassword" placeholder="������ԭ����" />
						</div>
					</div>
					<div class="form-group">
						<label for="PW_newPassword" class="col-sm-4 control-label">�����룺</label>
						<div class="col-sm-8">
							<input type="password" class="form-control" id="PW_newPassword" name="newPassword" placeholder="������������" />
						</div>
					</div>
					<div class="form-group">
						<label for="PW_newPasswordAgain" class="col-sm-4 control-label">ȷ�������룺</label>
						<div class="col-sm-8">
							<input type="password" class="form-control" id="PW_newPasswordAgain" name="newPasswordAgain" placeholder="���ٴ�����������" />
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary update-user-password" id="J_updatePasswordBtn" >�ύ</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">�ر�</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<%@ include file="../include/includeJs.jsp" %>
<script>
seajs.use('app/user/detail', function(detail) {
	detail.init();
});
</script>
</body>
</html>

