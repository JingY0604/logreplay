package com.sogou.map.logreplay.controller;

import javax.ws.rs.GET;
import javax.ws.rs.Path;
import javax.ws.rs.core.Response;

import org.springframework.stereotype.Component;
import org.springframework.ui.ModelMap;

import com.sogou.map.mengine.common.service.BaseService;

@Component
@Path("/common")
public class CommonController extends BaseService {

	/**
	 * ��һ�η���ʵʱУ������ʱ����Ҫ�ͻ��˸������У��ʱ��
	 */
	@GET
	@Path("/serverTimestamp")
	public Response getServerTimestamp() {
		return successResultToJson(new ModelMap("timestamp", System.currentTimeMillis()), true);
	}
}
