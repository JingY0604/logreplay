package com.sogou.map.logreplay.util;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

public class EnumUtil {
	
	private EnumUtil() {}
	
	public static <E extends Enum<E>> E parse(Object value, Class<E> enumType) {
		if(value == null) {
			return null;
		}
		E e = null;
		if(value instanceof Number) {
			e = parse((Number) value, enumType);
		}
		String str = value.toString();
		if(e == null) {
			e = parse(str, enumType);
		}
		return e;
	}
	
	public static <E extends Enum<E>> E parse(Number value, Class<E> enumType) {
		E[] values = enumType.getEnumConstants();
		int i = value.intValue();
		if(i < 0 || i >= values.length) {
			return null;
		}
		return values[i];
	}
	
	public static <E extends Enum<E>> E parse(String value, Class<E> enumType) {
		try {
			return Enum.valueOf(enumType, value);
		} catch (Exception e) {
			return null;
		}
	}
	
	/**
	 * ��ö������ת����һЩ��������
	 * @param value		ö��������ص�ʵ���������ǵ���ʵ����Ҳ�������������Collection����
	 * @param enumType
	 * @param converter
	 */
	@SuppressWarnings("unchecked")
	public static <E extends Enum<E>> Object convertValue(Object value, Class<E> enumType, EnumConverter converter) {
		if(value instanceof Collection) {	// ��������������if��
			Collection<?> coll = (Collection<?>) value;
			if(coll.size() > 0) {
				return convertValue(coll.toArray(), enumType, converter);
			} else {
				return null;
			}
		}
		if(value instanceof Object[] && enumType.isAssignableFrom(value.getClass().getComponentType())) {
			Object[] array = (Object[]) value;
			List<Object> list = new ArrayList<Object>();
			for(Object obj: array) {
				list.add(convertValue(obj, enumType, converter));
			}
			return list;
		}
		if(enumType.isInstance(value)) {
			E e = (E) value;
			return converter.convert(e);
		}
		return null;
	}
	
	public static enum EnumConverter {
		
		ORDINAL_CONVERTER {
			@Override
			public Object convert(Enum<?> value) {
				return value.ordinal();
			}
		}, 
		STRING_CONVERTER {
			@Override
			public Object convert(Enum<?> value) {
				return value.name();
			}
		},
		LOWER_CASE_STRING_CONVERTER {
			@Override
			public Object convert(Enum<?> value) {
				return value.name().toLowerCase();
			}
		},
		UPPER_CASE_STRING_CONVERTER {
			@Override
			public Object convert(Enum<?> value) {
				return value.name().toUpperCase();
			}
		};
		
		public abstract Object convert(Enum<?> value);
		
	}

}
