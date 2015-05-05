package com.sogou.map.logreplay.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.shiro.web.util.SavedRequest;
import org.apache.shiro.web.util.WebUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.sogou.map.logreplay.util.AuthUtil;

/**
 * ��¼��ص���ת�ӿ�
 * @author yangziwen
 */
@Controller
public class LoginController {

	@RequestMapping(value = "/login.htm", method = RequestMethod.GET)
	public String toLogin(HttpServletRequest request) {
		SavedRequest savedRequest = WebUtils.getSavedRequest(request);
		if(savedRequest != null) {
			String savedUri = savedRequest.getRequestURI();
			if(StringUtils.isBlank(savedUri) 
					|| !savedUri.endsWith(".htm") 
					|| savedUri.endsWith("404.htm")) {
				WebUtils.getAndClearSavedRequest(request);
			}
		}
		return "login";
	}
	
	/**
	 * �˽ӿ����ڴ����¼���������
	 * �û��������������ʱ������Ż����shiro�Ĺ����������ִ�˷���
	 */
	@RequestMapping(value = "/login.htm", method = RequestMethod.POST)
	public String afterLoginSubmission(
			HttpServletRequest request,
			HttpServletResponse response
			) throws IOException {
		if(AuthUtil.isAuthenticated()) {
			org.apache.shiro.web.util.WebUtils.redirectToSavedRequest(request, response, "/home.htm");
			return null;
		} 
		if(AuthUtil.isRemembered()) {
			request.setAttribute("errorMessage", "�������������!");
		} else {
			request.setAttribute("errorMessage", "�û������������������!");
		}
		return "login";
	}
}
