package com.sogou.map.logreplay.dao.base;

import java.beans.PropertyEditorSupport;

public class CustomPropertyEditor extends PropertyEditorSupport {
	
	/**
	 * �����������޷�ת�����򷵻�null
	 */
	public Object convertValue(Object value) {
		return value;
	}

}
