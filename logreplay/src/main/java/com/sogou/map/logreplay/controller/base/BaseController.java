package com.sogou.map.logreplay.controller.base;

import org.springframework.ui.ModelMap;

/**
 * �ڰ��Ѷ�mengine-core����������
 * Ϊ����ǰ�˴��뱣�ּ��ݣ�
 * ��ͳһ��successResult�������json���
 */
public abstract class BaseController {
	
	protected ModelMap successResult(Object response) {
		return new ModelMap("code", 0).addAttribute("response", response);
	}

}
