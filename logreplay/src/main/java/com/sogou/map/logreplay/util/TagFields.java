package com.sogou.map.logreplay.util;

import java.util.Collections;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.collections.MapUtils;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;

import com.google.common.collect.Lists;
import com.sogou.map.logreplay.bean.ParamInfo;
import com.sogou.map.logreplay.bean.TagParam;
import com.sogou.map.logreplay.dto.TagInfoDto;

/**
 * TagInfo����excelʱ�����е�����
 */
public class TagFields {
	
	private TagFields() {}

	public static String pageNo = "ҳ����";
	public static String pageName = "ҳ������";
	public static String tagNo = "�������";
	public static String tagName = "����������";
	public static String actionName = "��������";
	public static String targetName = "����Ŀ��";
	public static String originVersionDisplay = "��ʼ�汾";
	public static String devInspectStatus = "�Բ���";
	public static String inspectStatus = "���Խ��";
	public static String comment = "�����ע";
	public static String tagParamDisplay = "��������";
	public static String tagParamComment = "����������ע";
	
	private static final Pattern PARAM_INFO_PATTERN = Pattern.compile("^(.+)\\{(.+)\\}=(.*)$");
	
	public static List<TagInfoDto> convertToTagInfoDtoList(List<Map<String, String>> mapList) {
		if(CollectionUtils.isEmpty(mapList)) {
			return Collections.emptyList();
		}
		List<TagInfoDto> dtoList = Lists.newArrayList();
		for(Map<String, String> map: mapList) {
			dtoList.add(convertToTagInfoDto(map));
		}
		return dtoList;
	}
	
	public static TagInfoDto convertToTagInfoDto(Map<String, String> map) {
		if(MapUtils.isEmpty(map)) {
			return null;
		}
		TagInfoDto dto = new TagInfoDto();
		dto.setProductId(ProductUtil.getProductId());
		dto.setPageNo(Double.valueOf(NumberUtils.toDouble((map.get(pageNo)))).intValue());
		dto.setPageName(map.get(pageName));
		dto.setTagNo(Double.valueOf(NumberUtils.toDouble((map.get(tagNo)))).intValue());
		dto.setTagName(map.get(tagName));
		dto.setActionName(map.get(actionName));
		dto.setTargetName(map.get(targetName));
		dto.setOriginVersion(ProductUtil.parseAppVersion(map.get(originVersionDisplay)));
		dto.setComment(map.get(comment));
		dto.setDevInspectStatus(map.get(devInspectStatus));
		dto.setInspectStatus(map.get(inspectStatus));
		dto.setTagParamDisplay(map.get(tagParamDisplay));
		dto.setTagParamComment(map.get(tagParamComment));
		dto.setTagParam(parseTagParam(dto.getTagParamDisplay(), dto.getTagParamComment()));
		return dto;
	}
	
	private static TagParam parseTagParam(String tagParamDisplay, String tagParamComment) {
		if(StringUtils.isBlank(tagParamComment) && StringUtils.isBlank(tagParamDisplay)) {
			return null;
		}
		TagParam tagParam = new TagParam();
		tagParam.setComment(tagParamComment);
		if(StringUtils.isNotBlank(tagParamDisplay)) {
			List<ParamInfo> paramInfoList = Lists.newArrayList();
			for(String paramInfoDisplay: StringUtils.split(tagParamDisplay, ';')) {
				paramInfoList.add(parseParamInfo(paramInfoDisplay));
			}
			tagParam.setParamInfoList(paramInfoList);
		}
		return tagParam;
	}
	
	private static ParamInfo parseParamInfo(String paramInfoDisplay) {
		if(StringUtils.isBlank(paramInfoDisplay)) {
			return null;
		}
		Matcher matcher = PARAM_INFO_PATTERN.matcher(paramInfoDisplay);
		if(!matcher.matches()) {
			return null;
		}
		ParamInfo paramInfo = new ParamInfo();
		paramInfo.setName(matcher.group(1).trim());
		paramInfo.setValue(matcher.group(2).trim());
		paramInfo.setDescription(matcher.group(3).trim());
		if("?".equals(paramInfo.getValue())) {
			paramInfo.setValue("");
		}
		return paramInfo;
	}
	
}
