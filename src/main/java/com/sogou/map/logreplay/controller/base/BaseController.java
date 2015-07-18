package com.sogou.map.logreplay.controller.base;

import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sogou.map.logreplay.exception.LogReplayException;

public abstract class BaseController {
	
	/**
	 * �ڰ��Ѷ�mengine-core����������
	 * Ϊ����ǰ�˴��뱣�ּ��ݣ�
	 * ��ͳһ��successResult�������json���
	 */
	protected ModelMap successResult(String response) {
		return new ModelMap("code", 0).addAttribute("response", response);
	}
	
	protected ModelMap successResult(String response, Object... args) {
		return new ModelMap("code", 0).addAttribute("response", String.format(response, args));
	}
	
	protected ModelMap successResult(Object response) {
		return new ModelMap("code", 0).addAttribute("response", response);
	}
	
	/**
	 * ͳһ����LogReplayException
	 */
	@ResponseBody
	@ExceptionHandler(LogReplayException.class)
	protected ModelMap handleLogReplayException(LogReplayException e) {
		return new ModelMap("code", e.getErrorId()).addAttribute("errorMsg", e.getErrorMsg());
	}
	
}
