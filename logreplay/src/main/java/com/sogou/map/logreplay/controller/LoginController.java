package com.sogou.map.logreplay.controller;

import java.io.IOException;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.GET;
import javax.ws.rs.POST;
import javax.ws.rs.Path;
import javax.ws.rs.core.Context;

import org.springframework.stereotype.Component;

import com.sogou.map.logreplay.util.AuthUtil;
import com.sun.jersey.api.view.Viewable;

/**
 * ��¼��ص���ת�ӿ�
 * @author yangziwen
 */
@Component
@Path("/login.htm")
public class LoginController {

	@GET
	public Viewable toLogin() {
		return new Viewable("/login.jsp");
	}
	
	@POST
	public Viewable afterLoginSubmission(
			@Context HttpServletRequest request,
			@Context HttpServletResponse response
			) throws IOException {
		if(AuthUtil.isAuthenticated()) {
			org.apache.shiro.web.util.WebUtils.redirectToSavedRequest(request, response, "/home");
			return null;
		} 
		if(AuthUtil.isRemembered()) {
			request.setAttribute("errorMessage", "�������������!");
		} else {
			request.setAttribute("errorMessage", "�û������������������!");
		}
		return new Viewable("/login.jsp");
	}
}
