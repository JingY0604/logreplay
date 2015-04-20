package com.sogou.map.logreplay.util;

import java.util.ArrayList;
import java.util.Collections;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import com.google.common.collect.Lists;
import com.sogou.map.logreplay.bean.Product;
import com.sogou.map.logreplay.dao.base.QueryParamMap;
import com.sogou.map.logreplay.service.ProductService;

/**
 * �����cookie����Я����product_id��ͨ��
 * com.sogou.map.logreplay.filter.ProductFilter
 * �󶨵���ǰ�̵߳�PRODUCT_ID_HOLDER��
 * �����п�ͨ���˹�����ķ�������ȡproductId
 * ��Ҫ�����Ʒ����ʱ��ǰ�˸ı�cookie��product_id��ֵ����
 */
public class ProductUtil {
	
	/** app�����汾��λ **/
	private static final int MAJOR_UNIT = 10000000;
	
	/** app��С�汾��λ **/
	private static final int MINOR_UNIT = 100000;
	
	/** app���޶��汾��λ **/
	private static final int REVISION_UNIT = 1000;
	
	public static final String COOKIE_KEY = "product_id";
	
	private static final ThreadLocal<Long> PRODUCT_ID_HOLDER = new ThreadLocal<Long>();
	
	private static Map<Long, Product> productMap = null;
	
	private ProductUtil() {}
	
	public static void setProductId(Long productId) {
		PRODUCT_ID_HOLDER.set(productId);
	}
	
	public static Long getProductId() {
		return PRODUCT_ID_HOLDER.get();
	}
	
	public static Product getCurrentProduct() {
		Long productId = getProductId();
		return getProductById(productId);
	}
	
	public static Product getProductById(Long id) {
		Product product = ensureProductMap().get(id);
		product = product != null? product.clone(): new Product();
		return product;
	}
	
	public static List<Product> getProductList() {
		List<Product> newList = new ArrayList<Product>();
		for(Product product: ensureProductMap().values()) {
			newList.add(product.clone());
		}
		return Collections.unmodifiableList(newList);
	}
	
	private static Map<Long, Product> ensureProductMap() {
		if(productMap == null) {
			List<Product> list = doGetProductList();
			Map<Long, Product> map = new LinkedHashMap<Long, Product>();
			for(Product product: list) {
				map.put(product.getId(), product);
			}
			productMap = map;
		}
		return productMap;
	}
	
	private static List<Product> doGetProductList() {
		return SpringUtil.getBean(ProductService.class).getProductListResult(QueryParamMap.emptyMap());
	}
	
	public static String formatAppVersion(Integer version) {
		if(version == null || version < MAJOR_UNIT) {
			return "";
		}
		int major = version / MAJOR_UNIT;
		int minor = ( version % MAJOR_UNIT ) /  MINOR_UNIT;
		int revision = ( version % MINOR_UNIT ) / REVISION_UNIT;
		List<Integer> list = Lists.newArrayList(major, minor);
		if(revision > 0) {
			list.add(revision);
		}
		return StringUtils.join(list, '.');
	}
	
}
