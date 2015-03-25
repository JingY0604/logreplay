<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ include file="../include/include.jsp" %>
<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <title>У����</title>
	<%@ include file="../include/includeCss.jsp" %>
	<link rel="stylesheet" href="${static_path}/css/bootstrap-datetimepicker.min.css"/>
	<style>
		#J_detailModal .modal-dialog {
			width: 700px;
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
						��ǰλ��: <a data-toggle="collapse" href="#J_logReplaySubmenu">��־��У��</a>
						 &gt; <a href="${ctx_path}/inspectionRecord/list.htm">У����</a>
			        </li> 
			    </ul>
			</div>
			<div class="row"><!-- row2 -->
			    <div class="col-sm-12">
			     	<div id="J_queryArea" style="text-align: center;">
			     		<form class="form-horizontal col-md-offset-1 col-md-10" role="form">
							<div class="form-group">
								<label for="J_submitterName" class="col-sm-2 control-label">�ύ�ߣ�</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" id="J_submitterName" name="submitterName" placeholder="�������ύ���û������ǳ�" />
								</div>
								<label for="J_sovlerName" class="col-sm-2 control-label">�����ߣ�</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" id="J_sovlerName" name="solverName" placeholder="�����봦�����û������ǳ�" />
								</div>
							</div>
							<div class="form-group">
								<label for="J_pageNo" class="col-sm-2 control-label">ҳ���ţ�</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" id="J_pageNo" name="pageNo" placeholder="������ҳ����" />
								</div>
								<label for="J_tagNo" class="col-sm-2 control-label">������ţ�</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" id="J_tagNo" name="tagNo" placeholder="������������" />
								</div>
							</div>
							<div class="form-group">
								<label for="J_valid" class="col-sm-2 control-label">У������</label>
								<div class="col-sm-4">
									<select id="J_valid" name="valid" class="form-control">
										<option value="">ȫ��</option>
										<option value="true">��ȷ</option>
										<option value="false">����</option>
									</select>
								</div>
								<label for="J_solved" class="col-sm-2 control-label">����״̬��</label>
								<div class="col-sm-4">
									<select id="J_solved" name="solved" class="form-control">
										<option value="">ȫ��</option>
										<option value="true">�Ѵ���</option>
										<option value="false">δ����</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="J_submitTimeSince" class="col-sm-2 control-label">��ʼʱ�䣺</label>
								<div class="col-sm-4">
									<div class="input-group date form_datetime" data-date-format="yyyy-MM-dd" data-link-field="J_submitTimeSince">
										<input id="J_submitTimeSince" name="submitTimeSince" class="form-control" type="text" value="" style="cursor: pointer;" />
										<span class="input-group-addon">
											<span class="glyphicon glyphicon-th"></span>
										</span>
									</div>
								</div>
								<label for="J_submitTimeUntil" class="col-sm-2 control-label">����ʱ�䣺</label>
								<div class="col-sm-4">
									<div class="input-group date form_datetime" data-date-format="yyyy-MM-dd" data-link-field="J_submitTimeUntil">
										<input id="J_submitTimeUntil" name="submitTimeUntil" class="form-control" type="text" value="" style="cursor: pointer;"/>
										<span class="input-group-addon">
											<span class="glyphicon glyphicon-th"></span>
										</span>
									</div>
								</div>
							</div>
							<div class="form-group" style="margin-bottom: 0px;">
								<div class="col-sm-12" style="margin-top: 10px;">
									<button id="J_queryBtn" type="button" class="btn btn-primary btn-lg-font" style="width: 90px;">��&nbsp;&nbsp;ѯ</button>
									<button id="J_clearBtn" type="button"  class="btn btn-primary btn-lg-font" style="width: 90px;">�������</button>
								</div>
							</div>
						</form>
			     	</div>
			     </div>
			     <div class="col-sm-12"><hr/></div>
			     <div class="col-sm-12">
			     	<div class="row">
			     		<div id="J_pagebar" class="col-sm-12"></div>
			     	</div>
			     	<div style="margin-top: 20px;">
				     	<table class="table table-bordered table-striped table-condensed table-hover ">
				     		<thead>
				     			<tr>
				     				<th style="width: 90px;">ҳ����</th>
				     				<th style="width: 150px">ҳ������</th>
				     				<th style="width: 90px;">�������</th>
				     				<th style="width: 150px;">��������</th>
				     				<th style="width: 150px;">�ύʱ��</th>
				     				<th style="width: 90px;">У����</th>
				     				<th style="width: 90px;">����״̬</th>
				     				<shiro:hasAnyRoles name="admin,test">
				     				<th>����</th>
				     				</shiro:hasAnyRoles>
				     			</tr>
				     		</thead>
				     		<tbody id="J_inspectionRecordTbody">
				     		</tbody>
							<script type="text/x-jquery-tmpl" id="J_inspectionRecordTmpl">
								<tr data-id="${'${'}id}">
				     				<td>${'${'}pageNo}</td>
				     				<td>${'${'}pageName}</td>
				     				<td>${'${'}tagNo}</td>
				     				<td>${'${'}tagName}</td>
									<td>${'${'}createTime? new Date(createTime).format('yyyy-MM-dd hh:mm:ss'): '--'}</td>
									<td>{{html $item.displayValidStatus($data) }}</td>
									<td>{{html $item.displaySolvedStatus($data) }}</td>
									<shiro:hasAnyRoles name="admin,test">
				     				<td>
										<button class="btn btn-primary btn-xs open-detail-modal">����</button>
									</td>
									</shiro:hasAnyRoles>
				     			</tr>
							</script>
				     	</table>
			     	</div>
			    </div>
			</div><!--/row2-->
		</div>
	</div><!-- /row1 -->
</div>

<!-- inspectionRecord����ĵ����� -->
<div class="modal" id="J_detailModal" tabindex="-1">
    <div class="modal-dialog">
    	<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title"><strong>У��������</strong></h4>
			</div>
			<div class="modal-body">
				<div class="panel panel-default">
					<table class="table table-bordered">
						<tbody>
						</tbody>
						<script type="text/x-jquery-tmpl" id="J_inspectionRecordDetailTmpl">
						<tr>
							<td style="width: 150px;"><strong>ҳ����</strong></td>
							<td style="width: 250px;">${'${'}pageNo}</td>
							<td style="width: 150px;"><strong>ҳ������</strong></td>
							<td style="width: 250px;">${'${'}pageName}</td>
						</tr>
						<tr>
							<td><strong>�������</strong></td>
							<td>${'${'}tagNo}</td>
							<td><strong>��������</strong></td>
							<td>${'${'}tagName}</td>
						</tr>
						<tr>
							<td><strong>У����</strong></td>
							<td>{{html $item.displayValidStatus($data) }}</td>
							<td><strong>����״̬</strong></td>
							<td>{{html $item.displaySolvedStatus($data) }}</td>
						</tr>
						<tr>
							<td><strong>�ύ��</strong></td>
							<td>${'${'}$item.displaySubmitterName($data)}</td>
							<td><strong>�ύʱ��</strong></td>
							<td>${'${'}createTime? new Date(createTime).format('yyyy-MM-dd hh:mm:ss'): '--'}</td>
						</tr>
						<tr>
							<td><strong>������</strong></td>
							<td>${'${'}$item.displaySolverName($data)}</td>
							<td><strong>����ʱ��</strong></td>
							<td>${'${'}updateTime? new Date(updateTime).format('yyyy-MM-dd hh:mm:ss'): '--'}</td>
						</tr>
						<tr>
							<td><strong>��ע</strong></td>
							<td colspan="3">
							${'${'}comment || '--'}
							</td>
						</tr>
						</script>
					</table>
				</div>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary resolve-inspection-record" id="J_resolveBtn">�Ѵ���</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">�ر�</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<%@ include file="../include/includeJs.jsp" %>
<script>
seajs.use('app/inspectionRecord/list', function(list) {
	list.init();
});
</script>
</body>
</html>

