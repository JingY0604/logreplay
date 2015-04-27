package com.sogou.map.logreplay.controller.base;

import javax.ws.rs.core.CacheControl;
import javax.ws.rs.core.Response;

import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;

import org.springframework.ui.ModelMap;

import com.sogou.map.logreplay.util.JsonUtil;

/**
 * �����Ĵ��ڣ�������Ϊ�˰��Ѷ�mengine-core��������������
 * ����������ʹ��jsonlib������fastjson��Ҳ�Ǽ��������ԭ��
 */
public abstract class BaseController {

	protected <T> Response successResultToJson(T response, boolean notCached) {
		return successResultToJson(response, new JsonConfig(), notCached);
	}
	
	protected <T> Response successResultToJson(T response, JsonConfig jsonConfig, boolean cachable) {
		CacheControl cacheControl = new CacheControl();
		cacheControl.setNoCache(cachable);
		return successResultToJson(response, jsonConfig, cacheControl);
	}
	
	protected <T> Response successResultToJson(T response, JsonConfig jsonConfig, CacheControl cacheControl) {
		if(jsonConfig == null){
			jsonConfig = JsonUtil.configInstance();
		}
		String result = JSONObject.fromObject(new ModelMap("code", 0)
			.addAttribute("response", response)
		, jsonConfig).toString();
		return Response
				.ok()
				.cacheControl(cacheControl)
				.type("application/json;charset=GBK")
				.entity(result)
				.build();
	}
	
}
