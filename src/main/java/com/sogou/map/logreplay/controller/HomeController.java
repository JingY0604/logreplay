package com.sogou.map.logreplay.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
public class HomeController {

	/**
	 * ����·������ת����/home.htm
	 */
	@RequestMapping("/")
	public String toHome() {
		return "redirect:home.htm";
	}
	
}
