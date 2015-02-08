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
		table.table > thead > tr > th {
			text-align: center;
			background-color: #eee;
		}
		table.table > tbody > tr > td {
			line-height: 25px;
		}
	</style>
</head>
<body>

<%@ include file="../include/includeTopBar.jsp" %>

<div class="container" style="margin-bottom: 50px;">
	<div class="row"><!-- row1 -->
		<%@ include file="../include/includeMenuBar.jsp" %>
		<div class="col-lg-10 col-sm-10">
			<div>
			    <ul class="breadcrumb">
			        <li>
						��ǰλ��: <a>��־�����</a> > <a>ҳ�����</a>
			        </li> 
			    </ul>
			</div>
			<div class="row"><!-- row2 -->
			    <div class="col-md-12">
			     	<div id="J_queryArea" style="height: 100px; border: 1px solid #ccc; text-align: center;">
			     		<h2 style="line-height: 50px;">��ѯ��ռλ</h2>
			     	</div>
			     	<hr>
			     	<div class="row">
			     		<div class="col-sm-2">
			     			<button class="btn btn-primary btn-lg-font" id="J_openCreateModalBtn">����</button>
			     		</div>
			     		<div id="J_pagebar" class="col-sm-10">
			     			
			     		</div>
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
				     		<tbody id="J_pageInfoTbody">
				     		</tbody>
							<script type="text/x-jquery-tmpl" id="J_pageInfoTmpl">
								<tr data-id="${'${'}id}">
				     				<td>${'${'}pageNo}</td>
				     				<td>${'${'}name}</td>
				     				<td>${'${'}createTime? new Date(createTime).format('yyyy-MM-dd hh:mm:ss'): '--'}</td>
				     				<td>${'${'}updateTime? new Date(updateTime).format('yyyy-MM-dd hh:mm:ss'): '--'}</td>
				     				<td>
				     					<button class="btn btn-primary btn-xs open-update-modal">�޸�</button>
				     						<button class="btn btn-primary btn-xs open-create-tag-modal">��������</button>
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

<!-- ����/�޸�pageInfo�ĵ����� -->
<div class="modal" id="J_pageInfoModal" tabindex="-1">
    <div class="modal-dialog">
    	<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title"><strong>����</strong></h4>
			</div>
			<div class="modal-body">
					<form class="form-horizontal" role="form">
						<input type="hidden" id="P_id" name="id" />
						<div class="form-group">
							<label for="P_pageNo" class="col-sm-4 control-label">ҳ���ţ�</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="P_pageNo" name="pageNo" placeholder="������ҳ����" />
							</div>
						</div>
						<div class="form-group">
							<label for="P_name" class="col-sm-4 control-label">ҳ�����ƣ�</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="P_name" name="name" placeholder="������ҳ������" />
							</div>
						</div>
					</form>
				</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary create-page-info" id="J_createPageInfoBtn" >����</button>
				<button type="button" class="btn btn-primary update-page-info" id="J_updatePageInfoBtn" >����</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">�ر�</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->

<!-- ����/�޸�tagInfo�ĵ����� -->
<div class="modal" id="J_tagInfoModal" tabindex="-1">
    <div class="modal-dialog">
    	<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title"><strong>����</strong></h4>
			</div>
			<div class="modal-body">
					<form class="form-horizontal" role="form">
						<input type="hidden" id="T_id" name="id" />
						<input type="hidden" id="T_pageInfoId" name="pageInfoId" />
						<div class="form-group">
							<label for="T_pageNo" class="col-sm-4 control-label">ҳ���ţ�</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="T_pageNo" name="pageNo" placeholder="������ҳ����" />
							</div>
						</div>
						<div class="form-group">
							<label for="T_pageName" class="col-sm-4 control-label">ҳ�����ƣ�</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="T_pageName" name="pageName" placeholder="������ҳ������" />
							</div>
						</div>
						<div class="form-group">
							<label for="T_tagNo" class="col-sm-4 control-label">������ţ�</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="T_tagNo" name="tagNo" placeholder="������������" />
							</div>
						</div>
						<div class="form-group">
							<label for="T_name" class="col-sm-4 control-label">�������ƣ�</label>
							<div class="col-sm-8">
								<input type="text" class="form-control" id="T_name" name="name" placeholder="�������������" />
							</div>
						</div>
						<div class="form-group">
							<label for="T_actionId" class="col-sm-4 control-label">����������</label>
							<div class="col-sm-8">
								<select id="T_actionId" name="actionId" class="form-control">
									<option value="1">��</option>
									<option value="2">���</option>
									<option value="3">����</option>
									<option value="4">�϶�</option>
									<option value="5">˫ָ�Ŵ�</option>
									<option value="6">˫ָ��С</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="T_targetId" class="col-sm-4 control-label">����Ŀ�꣺</label>
							<div class="col-sm-8">
								<select id="T_targetId" name="targetId" class="form-control">
									<option value="1">ҳ��</option>
									<option value="2">��ť</option>
									<option value="3">״̬</option>
									<option value="4">��ʱ��</option>
									<option value="5">��ʱҳ��</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label for="T_comment" class="col-sm-4 control-label">��ע��</label>
							<div class="col-sm-8">
								<textarea id="T_comment" name="comment" class="form-control" rows="5" placeholder="�����뱸ע��100������"></textarea>
							</div>
						</div>
					</form>
				</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary create-tag-info" id="J_createTagInfoBtn" >����</button>
				<button type="button" class="btn btn-primary update-tag-info" id="J_updateTagInfoBtn" >����</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">�ر�</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<%@ include file="../include/includeJs.jsp" %>
<script>
seajs.use('app/pageInfo/list', function(list) {
	list.init();
});
</script>
</body>
</html>

