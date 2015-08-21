package com.sogou.map.logreplay.dao.base;

import java.util.Map;
import java.util.Map.Entry;

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
	protected abstract Object processValueForPersistence(Object value);

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
				return processValueForPersistence(value);
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
				return processValueForPersistence(value);
			}
		};
	}
	
}
