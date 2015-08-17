<%@page import="com.sogou.map.logreplay.util.AuthUtil"%>
<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ include file="../include/include.jsp" %>
<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <title>У��״̬��ѯ</title>
	<%@ include file="../include/includeCss.jsp" %>
	<style>
		table.inner-table {
			width: 100%;
		}
		table.inner-table tr > th, table.inner-table tr > td {
			text-align: center;
		}
		table.inner-table td {
			padding: 5px;
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
						��ǰλ��: <a data-toggle="collapse" href="#J_logReplaySubmenu">�����ϢУ��</a> 
						&gt; <a href="${ctx_path}/inspectionRecord/statusList.htm">У��״̬��ѯ</a>
			        </li> 
			    </ul>
			</div>
			<div class="row"><!-- row2 -->
			    <div class="col-md-12">
			     	<div id="J_queryArea" style="text-align: center;">
			     		<form class="form-horizontal col-md-offset-1 col-md-10" role="form">
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
								<label for="J_pageName" class="col-sm-2 control-label">ҳ�����ƣ�</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" id="J_pageName" name="pageName" placeholder="������ҳ������" />
								</div>
								<label for="J_tagName" class="col-sm-2 control-label">�������ƣ�</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" id="J_tagName" name="tagName" placeholder="�������������" />
								</div>
							</div>
							<div class="form-group">
								<label for="J_devInspectStatus" class="col-sm-2 control-label">�Բ�����</label>
								<div class="col-sm-4">
									<select id="J_devInspectStatus" name="devInspectStatus" class="form-control">
										<option value="">ȫ��</option>
										<option value="0">δУ��</option>
										<option value="1">У����ȷ</option>
										<option value="2">У�����</option>
									</select>
								</div>
								<label for="J_inspectStatus" class="col-sm-2 control-label">���Խ����</label>
								<div class="col-sm-4">
									<select id="J_inspectStatus" name="inspectStatus" class="form-control">
										<option value="">ȫ��</option>
										<option value="0">δУ��</option>
										<option value="1">У����ȷ</option>
										<option value="2">У�����</option>
									</select>
								</div>
							</div>
							<div class="form-group">
								<label for="J_originVersionSince" class="col-sm-2 control-label">��ʼ�汾��</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" id="J_originVersionSince" name="originVersionSince" placeholder="��������ʼ�汾" />
								</div>
								<label for="J_originVersionUntil" class="col-sm-2 control-label">��ֹ�汾��</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" id="J_originVersionUntil" name="originVersionUntil" placeholder="��������ֹ�汾" />
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
			     <div class="col-sm-12"><hr /></div>
			     <div class="col-sm-12">
			     	<div class="row">
			     		<div id="J_pagebar" class="col-sm-12"></div>
			     	</div>
			     	<div style="margin-top: 20px;">
				     	<table class="table table-bordered table-striped table-condensed table-hover ">
				     		<thead>
				     			<tr>
				     				<th style="width: 85px;">ҳ����</th>
				     				<th style="width: 100px;">ҳ������</th>
				     				<th style="width: 85px;">�������</th>
				     				<th>��������</th>
				     				<th style="width: 85px;">��������</th>
				     				<th style="width: 85px;">����Ŀ��</th>
				     				<th style="width: 85px;">��ʼ�汾</th>
				     				<th style="width: 85px;">�Բ���</th>
				     				<th style="width: 85px;">���Խ��</th>
				     			</tr>
				     		</thead>
				     		<tbody id="J_tagInfoTbody">
				     		</tbody>
							<script type="text/x-jquery-tmpl" id="J_tagInfoTmpl">
								<tr data-id="${'${'}id}" title="${'${'}comment}">
				     				<td>${'${'}pageInfo && pageInfo.pageNo || '--'}</td>
				     				<td>${'${'}pageInfo && pageInfo.name || '--'}</td>
				     				<td>${'${'}tagNo}</td>
				     				<td>${'${'}name}</td>
				     				<td>${'${'}$item.getActionName(actionId)}</td>
				     				<td>${'${'}$item.getTargetName(targetId)}</td>
									<td>${'${'}$item.displayOriginVersion(originVersion)}</td>
				     				<td>{{html $item.displayInspectStatus(devInspectStatus)}}</td>
									<td>{{html $item.displayInspectStatus(inspectStatus)}}</td>
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
seajs.use('app/inspectionRecord/statusList', function(list) {
	list.init();
});
</script>
</body>
</html>

