package com.sogou.map.logreplay.dao.base;

import java.util.Collection;
import java.util.Map;
import java.util.Map.Entry;

import org.apache.commons.collections.MapUtils;
import org.springframework.beans.BeanWrapper;
import org.springframework.jdbc.core.namedparam.BeanPropertySqlParameterSource;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;

import com.sogou.map.logreplay.bean.base.AbstractBean;

/**
 * ���һЩ��������(��ö��)���ڳ��������ݿ�֮��������ת��
 */
public abstract class AbstractEditPropertyJdbcDaoImpl<E extends AbstractBean> extends AbstractJdbcDaoImpl<E> {
	
	protected abstract Map<Class<?>, CustomPropertyEditor> getPropertyEditorMap();
	
	/**
	 * �������������Ϊ�������ֶε�����
	 * ����ֵ������Ϊ���ݿ����ֶζ�Ӧ������
	 */
	protected Object processValueBeforeQuery(Object value) {
		Map<Class<?>, CustomPropertyEditor> editorMap = getPropertyEditorMap();
		if(MapUtils.isEmpty(editorMap)) {
			return value;
		}
		Object newValue = null;
		Object oldValue = value;
		if(value instanceof Collection<?>) {
			value = ((Collection<?>) value).toArray();
		}
		for(CustomPropertyEditor editor: editorMap.values()) {
			if((newValue = editor.convertValue(value)) != null) {
				break;
			}
		}
		return newValue != null? newValue: oldValue;
	}

	// �����ѯ�ķ��ؽ��ʱ��
	@Override
	protected BeanMapping<E> createBeanMapping(Class<E> entityClass) {
		return new BeanMapping<E>(entityClass) {
			@Override
			protected void afterInitBeanWrapper(BeanWrapper bw) {
				for(Entry<Class<?>, CustomPropertyEditor> entry: getPropertyEditorMap().entrySet()) {
					bw.registerCustomEditor(entry.getKey(), entry.getValue());
				}
			}
		};
	}
	
	// ���Ͳ�ѯ����ʱ��
	@Override
	protected SqlParameterSource createSqlParameterSource(Map<String, Object> params) {
		return new MapSqlParameterSource(params) {
			@Override
			public Object getValue(String paramName) {
				Object value = super.getValue(paramName);
				return processValueBeforeQuery(value);
			}
		};
	}
	
	// ���и��²���ʱ��
	@Override
	protected SqlParameterSource createSqlParameterSource(E entity) {
		return new BeanPropertySqlParameterSource(entity) {
			@Override
			public Object getValue(String paramName) { 
				Object value = super.getValue(paramName);
				return processValueBeforeQuery(value);
			}
		};
	}
	
}
