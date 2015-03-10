<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ include file="../include/include.jsp" %>
<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <title>У����</title>
	<%@ include file="../include/includeCss.jsp" %>
	<link rel="stylesheet" href="${static_path}/css/bootstrap-datetimepicker.min.css"/>
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
										<input id="J_submitTimeSince" name="submitTimeSince" class="form-control" type="text" value="" readonly />
										<span class="input-group-addon">
											<span class="glyphicon glyphicon-th"></span>
										</span>
									</div>
								</div>
								<label for="J_submitTimeUntil" class="col-sm-2 control-label">����ʱ�䣺</label>
								<div class="col-sm-4">
									<div class="input-group date form_datetime" data-date-format="yyyy-MM-dd" data-link-field="J_submitTimeUntil">
										<input id="J_submitTimeUntil" name="submitTimeUntil" class="form-control" type="text" value="" readonly />
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
				     				<th>����</th>
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
				     				<td>
										<button class="btn btn-primary btn-xs open-detail-modal">����</button>
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
seajs.use('app/inspectionRecord/list', function(list) {
	list.init();
});
</script>
</body>
</html>

