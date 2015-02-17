<%@ page language="java" contentType="text/html; charset=GBK" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<div class="col-sm-2">
	<div class="sidebar-nav row">
			<ul class="nav nav-pills nav-stacked">
				<li class="active">
					<a href="${ctx_path}/home.htm"><i class="glyphicon glyphicon-home"></i><span> ��ҳ</span></a>
				</li>
				<li class="active">
					<a data-toggle="collapse" href="#J_logConfigSubmenu">
						<i class="glyphicon glyphicon-plus"></i>
						<span> ��־�����</span>
						<span class="pull-right glyphicon glyphicon-chevron-down"></span>
					</a>
					<c:set var="showConfigSubmenu" value="${fn:contains(requestURI, '/pageInfo') or fn:contains(requestURI, '/tagInfo')}"></c:set>
					<ul id="J_logConfigSubmenu" class="nav submenu ${showConfigSubmenu eq true? 'in': ''}" ${showConfigSubmenu eq false? 'style="height: 0px;"': ''}>
						<li><a href="${ctx_path}/pageInfo/list.htm"><i class="glyphicon glyphicon-chevron-right"></i> ҳ����Ϣ����</a></li>
						<li><a href="${ctx_path}/tagInfo/list.htm"><i class="glyphicon glyphicon-chevron-right"></i> ���������</a></li>
					</ul>
				</li>
				<li class="active">
					<a data-toggle="collapse" href="#J_logReplaySubmenu">
						<i class="glyphicon glyphicon-plus"></i>
						<span> ��־��У��</span>
						<span class="pull-right glyphicon glyphicon-chevron-down"></span>
					</a>
					<c:set var="showReplaySubmenu" value="${fn:contains(requestURI, '/replay')}"></c:set>
					<ul id="J_logReplaySubmenu" class="nav submenu ${showReplaySubmenu eq true? 'in': ''}" ${showReplaySubmenu eq false? 'style="height: 0px;"': ''}>
						<li><a href="${ctx_path}/replay/realtime.htm"><i class="glyphicon glyphicon-chevron-right"></i> ��ʱУ��</a></li>
						<li><a href="${ctx_path}/replay/sequence.htm"><i class="glyphicon glyphicon-chevron-right"></i> ����У��</a></li>
					</ul>
				</li>
				<li class="active">
					<a href="###"><i class="glyphicon glyphicon-plus"></i><span> ϵͳ����</span></a>
				</li>
			</ul>
	</div>
</div>
