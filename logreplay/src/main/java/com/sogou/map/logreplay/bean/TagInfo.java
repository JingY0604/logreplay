package com.sogou.map.logreplay.bean;

import java.sql.Timestamp;

import javax.persistence.Column;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * ��������Ϣ����Ϊ����ͨ������͡����������
 * ������������������ض���ҳ����Ϣ(PageInfo)���������>10000
 */
@Table(name = "tag_info")
public class TagInfo extends AbstractBean {
	
	/** ����������Ĳ�����ű�����ڴ�ֵ **/
	public static final Integer COMMON_TAG_NO_MIN_VALUE = 10000;

	@Id
	@Column
	private Long id;
	
	@Column(name = "product_id")
	private Long productId;
	
	/**  �������� **/
	@Column(name = "tag_no")
	private Integer tagNo;

	/** ���������� **/
	@Column
	private String name;
	
	/** ��Ӧ��ҳ����Ϣ��id **/
	@Column(name = "page_info_id")
	private Long pageInfoId;
	
	/** ��Ӧ��ҳ���� **/
	@Column(name = "page_no")	// ���࣬Ϊ�˲�ѯ����
	private Integer pageNo;
	
	/** ҳ����Ϣ���� **/
	@Transient
	private PageInfo pageInfo;
	
	/** ��������id�������TagAction **/
	@Column(name = "action_id")
	private Long actionId;
	
	/** ����Ŀ��id�������TagTarget **/
	@Column(name = "target_id")
	private Long targetId;
	
	/** ע����Ϣ **/
	@Column
	private String comment;
	
	/** �״���app������˲�����ʱ��app�İ汾�� **/
	@Column(name = "origin_version")
	private Integer originVersion;
	
	/** У��״̬������״̬���ö����InspectStatus **/
	@Column(name = "inspect_status")
	private Integer inspectStatus;
	
	/** ������ԱУ��״̬������ͬinspectStatus **/
	@Column(name = "dev_inspect_status")
	private Integer devInspectStatus;
	
	@Column(name = "create_time")
	private Timestamp createTime;
	
	@Column(name = "update_time")
	private Timestamp updateTime;
	
	/** �˲������Ƿ�����صĲ�����Ϣ(TagParam) **/
	@Transient
	private Boolean hasParams;
	
	public TagInfo() {}
	
	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getProductId() {
		return productId;
	}

	public void setProductId(Long productId) {
		this.productId = productId;
	}

	public Integer getTagNo() {
		return tagNo;
	}

	public void setTagNo(Integer tagNo) {
		this.tagNo = tagNo;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}
	
	public Long getPageInfoId() {
		return pageInfoId;
	}

	public void setPageInfoId(Long pageInfoId) {
		this.pageInfoId = pageInfoId;
	}

	public Integer getPageNo() {
		return pageNo;
	}

	public void setPageNo(Integer pageNo) {
		this.pageNo = pageNo;
	}

	public PageInfo getPageInfo() {
		return pageInfo;
	}

	public void setPageInfo(PageInfo pageInfo) {
		this.pageInfo = pageInfo;
	}

	public Long getActionId() {
		return actionId;
	}

	public void setActionId(Long actionId) {
		this.actionId = actionId;
	}

	public Long getTargetId() {
		return targetId;
	}

	public void setTargetId(Long targetId) {
		this.targetId = targetId;
	}

	public String getComment() {
		return comment;
	}

	public void setComment(String comment) {
		this.comment = comment;
	}

	public Integer getOriginVersion() {
		return originVersion;
	}

	public void setOriginVersion(Integer originVersion) {
		this.originVersion = originVersion;
	}

	public Integer getInspectStatus() {
		return inspectStatus;
	}

	public void setInspectStatus(Integer inspectStatus) {
		this.inspectStatus = inspectStatus;
	}

	public Integer getDevInspectStatus() {
		return devInspectStatus;
	}

	public void setDevInspectStatus(Integer devInspectStatus) {
		this.devInspectStatus = devInspectStatus;
	}

	public Timestamp getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Timestamp createTime) {
		this.createTime = createTime;
	}

	public Timestamp getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Timestamp updateTime) {
		this.updateTime = updateTime;
	}
	
	public Boolean getHasParams() {
		return hasParams;
	}

	public void setHasParams(Boolean hasParams) {
		this.hasParams = hasParams;
	}

	/** ������У�������� **/
	public enum InspectStatus {
		
		SUCCESS(1, "У����ȷ"), ERROR(2, "У�����"), UNCHECKED(0, "δУ��"), UNKNOWN(-1, "δ֪״̬");
		
		private int intValue;
		private String description;
		
		private InspectStatus(int value, String description) {
			this.intValue = value;
			this.description = description;
		}
		
		public int getIntValue() {
			return intValue;
		}
		
		public String getDescription() {
			return description;
		}
		
		public static InspectStatus from(Integer intValue) {
			if(intValue == null) {
				return UNKNOWN;
			}
			for(InspectStatus status: values()) {
				if(intValue.equals(status.intValue)) {
					return status;
				}
			}
			return UNKNOWN;
		}
		
		public static String toDescription(Integer intValue) {
			return from(intValue).getDescription();
		}
	}
	
}
