package com.sogou.map.logreplay.util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import com.sogou.map.logreplay.bean.ParamInfo;

/**
 * ����tagInfoId,�������Ͳ���ֵ����ȡ������Ϣ�İ�����
 */
public class TagParamParser {
	
	private static final String[] EXCLUDED_PARAM_KEYS = {"p", "tag", "t", "reqid", "dataid", "ucNavigateId"};
	
	/** <tagInfoId, tagParams> **/
	private Map<Long, TagParamHolder> holderMap = new HashMap<Long, TagParamHolder>();
	
	public TagParamParser() {}
	
	public void addParamInfo(Long tagInfoId, ParamInfo paramInfo) {
		ensureHolder(tagInfoId).addParamInfo(paramInfo);
	}
	
	private TagParamHolder ensureHolder(Long tagInfoId) {
		TagParamHolder holder = holderMap.get(tagInfoId);
		if(holder != null) {
			return holder;
		}
		holder = new TagParamHolder();
		holder.tagInfoId = tagInfoId;
		holderMap.put(tagInfoId, holder);
		return holder;
	}
	
	public ParamInfo parse(Long tagInfoId, String paramName, String paramValue) {
		if(!holderMap.containsKey(tagInfoId)) {
			return null;
		}
		return holderMap.get(tagInfoId).parse(paramName, paramValue);
	}
	
	public List<String> getRequiredParamNameList(Long tagInfoId) {
		TagParamHolder tagParamHolder = holderMap.get(tagInfoId);
		if(tagParamHolder == null) {
			return Collections.emptyList();
		}
		List<String> list = new ArrayList<String>();
		for(ParamInfoHolder paramInfoHolder: tagParamHolder.holderMap.values()) {
			if(paramInfoHolder.merelyRequired()) {
				list.add(paramInfoHolder.paramName);
			}
		}
		return list;
	}
	
	/**
	 * �ж�info�е�ĳ�������Ƿ���Ҫ����
	 * ���� p, tag, t, reqid֮��Ĳ������ǲ���Ҫ������������Ĳ������н�����
	 */
	public static boolean isParamKeyExcluded(String key) {
		for(String excludedKey: EXCLUDED_PARAM_KEYS) {
			if(excludedKey.equalsIgnoreCase(key)) {
				return true;
			}
		}
		return false;
	}
	
	/**
	 * ͬһtagInfo�µ����в�ͬ���Ƶ�param
	 */
	public static class TagParamHolder {
		
		private Long tagInfoId;
		
		public Long getTagInfoId() {
			return tagInfoId;
		}
		
		/** <paramName, ParamInfoHolder **/
		Map<String, ParamInfoHolder> holderMap = new HashMap<String, ParamInfoHolder>();
		
		public void addParamInfo(ParamInfo paramInfo) {
			ensureHolder(paramInfo.getName()).addParamInfo(paramInfo);;
		}
		
		public ParamInfoHolder ensureHolder(String paramName) {
			ParamInfoHolder holder = holderMap.get(paramName);
			if(holder != null) {
				return holder;
			}
			holder = new ParamInfoHolder();
			holder.paramName = paramName;
			holderMap.put(paramName, holder);
			return holder;
		}
		
		public ParamInfo parse(String paramName, String paramValue) {
			if(!holderMap.containsKey(paramName)) {
				return null;
			}
			return holderMap.get(paramName).parse(paramValue);
		}
		
	}
	
	/**
	 * ͬһtagInfo��ͬһparamName�µĲ�ͬparamValue
	 */
	public static class ParamInfoHolder {
		
		public static final String PARAM_VALUE_NOT_EXIST_DESCRIPTION = "������ֵ������!";
		
		private String paramName;
		
		public String getParamName() {
			return paramName;
		}
		
		/** <paramValue, ParamInfo> **/
		Map<String, ParamInfo> paramInfoMap = new HashMap<String, ParamInfo>();
		
		/**
		 * ��ĳ��paramNameֻ��Ӧһ��paramValue��paramValueΪ""ʱ
		 * �����������������ڣ�������Ϊ����ֵ
		 */
		public boolean merelyRequired() {
			return paramInfoMap.size() == 1 && paramInfoMap.containsKey("");
		}
		
		public void addParamInfo(ParamInfo paramInfo) {
			paramInfoMap.put(paramInfo.getValue(), paramInfo);
		}
		
		public ParamInfo parse(String paramValue) {
			if(merelyRequired()) {
				return paramInfoMap.get("");
			}
			if(!paramInfoMap.containsKey(paramValue)) {
				return new ParamInfo(paramName, paramValue, PARAM_VALUE_NOT_EXIST_DESCRIPTION);
			}
			return paramInfoMap.get(paramValue);
		}
		
		/**
		 * ����tagParamParser#parse�������ص�paramInfo���ж�������Я���Ĳ����Ƿ���ȷ��Ч
		 * ���ڲ������еĲ���������Ϣ����������Ч�Ĳ�������
		 * 1) ����ȱʧ
		 * 2) ��������
		 */
		public static boolean isValid(ParamInfo paramInfo) {
			return paramInfo != null && !PARAM_VALUE_NOT_EXIST_DESCRIPTION.equals(paramInfo.getDescription());
		}
	}
	
}
