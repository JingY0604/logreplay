<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ include file="../include/include.jsp" %>
<!DOCTYPE html>
<html lang="zh_CN">
<head>
    <title>����У��</title>
	<%@ include file="../include/includeCss.jsp" %>
	<link rel="stylesheet" href="${static_path}/css/bootstrap-datetimepicker.min.css"/>
	<style>
		#J_replayArea {
			margin-top: 10px; height: 500px; overflow-y: auto; border-top: 1px solid #eee; padding: 0px;
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
						 &gt; <a href="${ctx_path}/replay/sequence.htm">����У��</a>
			        </li> 
			    </ul>
			</div>
			<div class="row"><!-- row2 -->
			    <div class="col-sm-12">
			     	<div id="J_queryArea" class="row" style="text-align: center;">
			     		<input type="hidden" name="limit" value="50"/>
			     		<form class="form-horizontal col-md-offset-1 col-md-10" role="form">
							<div class="form-group">
								<label for="J_deviceId" class="col-sm-2 control-label">�豸id��</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" id="J_deviceId" name="deviceId" placeholder="�������豸id" />
								</div>
								<label for="J_uvid" class="col-sm-2 control-label">�û�id��</label>
								<div class="col-sm-4">
									<input type="text" class="form-control" id="J_uvid" name="uvid" placeholder="�������û�id" />
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
								<label for="J_replayTimeSince" class="col-sm-2 control-label">��ʼʱ�䣺</label>
								<div class="col-sm-4">
									<div class="input-group date form_datetime" data-date-format="yyyy-MM-dd" data-link-field="J_replayTimeSince">
										<input id="J_replayTimeSince" name="replayTimeSince" class="form-control" type="text" value="" readonly />
										<span class="input-group-addon">
											<span class="glyphicon glyphicon-th"></span>
										</span>
									</div>
								</div>
								<label for="J_replayTimeUntil" class="col-sm-2 control-label">����ʱ�䣺</label>
								<div class="col-sm-4">
									<div class="input-group date form_datetime" data-date-format="yyyy-MM-dd" data-link-field="J_replayTimeUntil">
										<input id="J_replayTimeUntil" name="replayTimeUntil" class="form-control" type="text" value="" readonly />
										<span class="input-group-addon">
											<span class="glyphicon glyphicon-th"></span>
										</span>
									</div>
								</div>
							</div>
							<div class="form-group" style="_margin-bottom: 0px;">
								<div class="col-sm-12" style="margin-top: 10px;">
									<button id="J_openUploadLogModalBtn" type="button" class="btn btn-primary btn-lg-font">�ϴ���־</button>
									<button id="J_replaySwitchBtn" type="button" class="btn btn-primary btn-lg-font">��ʼУ��</button>
									<button id="J_lockScrollBtn" type="button"  class="btn btn-primary btn-lg-font" style="width: 90px;">��������</button>
									<button id="J_clearBtn" type="button"  class="btn btn-primary btn-lg-font" style="width: 90px;">��&nbsp;&nbsp;��</button>
								</div>
							</div>
						</form>
					</div>
				</div>
				<div class="col-sm-12" style="overflow-x: hidden;">
					<hr style="margin-top: 0px;">
				</div>
				<div class="col-sm-12">
			     	<div id="J_replayArea">
				     	<table id="J_replayTbl" class="table table-bordered table-striped table-condensed table-hover" >
				     		<thead>
				     			<tr>
				     				<th style="width: 125px;">ƽ̨</th>
				     				<th style="width: 100px;">��־���</th>
				     				<th>��־����</th>
				     				<th style="width: 250px;">��־����</th>
				     				<th style="width: 125px;">����</th>
				     			</tr>
				     		</thead>
				     		<tbody id="J_replayTbody" style="max-height: 500px;" >
				     		</tbody>
				     		<script type="text/x-jquery-tmpl" id="J_replayTmpl">
								<tr class="${'${'}$item.bgClass()}">
				     				<td>${'${'}os}</td>
				     				<td style="text-align: left">&nbsp;p[${'${'}pageNo}] t[${'${'}tagNo}]</td>
				     				<td>${'${'}$item.describe($data)}</td>
				     				<td title="${'${'}params}" style="max-width: 250px; overflow-x: hidden; text-align: left;">
										${'${'}params}
									</td>
				     				<td></td>
				     			</tr>
							</script>
				     	</table>
			     	</div>
			    </div>
			</div><!--/row2-->
		</div>
	</div><!-- /row1 -->
</div>
<!-- �ϴ���־�ĵ����� -->
<div class="modal" id="J_uploadLogModal" tabindex="-1">
    <div class="modal-dialog">
    	<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
				<h4 class="modal-title"><strong>�ϴ�nginx��־</strong></h4>
			</div>
			<div class="modal-body">
				<form class="form-horizontal" role="form">
					<div class="form-group">
						<label class="col-sm-3 control-label">��־�ļ���</label>
						<div class="col-sm-9">
							<input id="J_uploadLogFilePath" type="text" class="form-control" disabled="disabled"/>
						</div>
						<div class="col-sm-9 col-sm-offset-3 hide">
							<div id="J_uploadProgressBar" class="progress progress-striped" style="width: 100%; margin-top: 20px; margin-bottom: 0px;"></div>
						</div>
					</div>
				</form>
			</div>
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" id="J_browseLogFileBtn" >���</button>
				<button type="button" class="btn btn-primary" id="J_uploadLogFileBtn" style="margin-left:5px;">�ϴ�</button>
				<button type="button" class="btn btn-default" data-dismiss="modal">�ر�</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
<%@ include file="../include/includeJs.jsp" %>
<script>
seajs.use('app/replay/sequence', function(sequence) {
	sequence.init();
});
</script>
</body>
</html>

