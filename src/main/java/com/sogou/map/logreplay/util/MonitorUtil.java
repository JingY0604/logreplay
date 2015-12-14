package com.sogou.map.logreplay.util;

import java.io.File;
import java.net.InetAddress;
import java.net.MalformedURLException;
import java.net.URL;
import java.net.UnknownHostException;
import java.util.Collections;
import java.util.List;

import javax.servlet.ServletContext;

import org.apache.commons.io.FilenameUtils;
import org.apache.commons.lang.SystemUtils;
import org.apache.commons.lang.builder.ReflectionToStringBuilder;
import org.apache.commons.lang.builder.ToStringStyle;
import org.jrobin.core.Util;
import org.jrobin.data.DataProcessor;

import com.google.common.collect.Lists;

public class MonitorUtil {

	private MonitorUtil() {}
	
	/**
	 * ��ȡ��name���Ӧ��ͳ������
	 * @param application
	 * @param name
	 * @param startTime ��ʼʱ��(����)
	 * @param endTime	����ʱ��(����)
	 * @param step		ȡ�����(��)
	 */
	public static List<Data<Long, Double>> getDataList(String application, String name, long startTime, long endTime, long step) {
		File rrdFile = getStorageRrdFile(application, name);
		if(!rrdFile.exists()) {
			return Collections.emptyList();
		}
		try {
			String dsName = name;
			if(dsName.length() > 20) {	// ò����melody�еĻ���
				dsName = dsName.substring(0, 20);
			}
			DataProcessor processor = new DataProcessor(Util.getTimestamp() - 10 * 60, Util.getTimestamp());
			processor.addDatasource("average", rrdFile.getAbsolutePath(), dsName, "AVERAGE");
			processor.setStep(60);
			// poolUsed��Ϊtrue����ʹ��read_writeģʽ��
			// ֻ����������rrd�ļ��͵���fileChannel.map����ʱ�Ķ�дģʽ�Ż�ǰ��һ��
			processor.setPoolUsed(true);
			processor.processData();
			
			
			double[] values = processor.getValues("average");
			long[] timestamps = processor.getTimestamps();
			assert values.length == timestamps.length;
			
			List<Data<Long, Double>> dataList = Lists.newArrayList();
			for(int i = 0, l = timestamps.length; i < l; i++) {
				dataList.add(new Data<Long, Double>()
					.key(timestamps[i] * 1000)
					.value(Double.isNaN(values[i])? 0D: values[i])
				);
			}
			return dataList;
		} catch (Exception e) {
			e.printStackTrace();
			return Collections.emptyList();
		}
		
	}
	
	/**
	 * ��ȡ���ָ������Ӧ��rrd�ļ�
	 */
	public static File getStorageRrdFile(String application, String name) {
		return new File(getStorageDirectory(application), name + ".rrd");
	}
	
	/**
	 * ��ȡ��ż��ָ���Ŀ¼
	 */
	public static File getStorageDirectory(String application) {
		String directoryPath = FilenameUtils.concat(SystemUtils.JAVA_IO_TMPDIR, "javamelody");
		return new File(FilenameUtils.concat(directoryPath, application));
	}
	
	/**
	 * ��ȡӦ������
	 */
	public static String getCurrentApplication(ServletContext servletContext) {
		return getContextPath(servletContext).substring(1) + '_' + getHostName();
	}
	
	private static String getContextPath(ServletContext context) {
		// cette méthode retourne le contextPath de la webapp
		// en utilisant ServletContext.getContextPath si servlet api 2.5
		// ou en se débrouillant sinon
		// (on n'a pas encore pour l'instant de request pour appeler HttpServletRequest.getContextPath)
		if (context.getMajorVersion() == 2 && context.getMinorVersion() >= 5
				|| context.getMajorVersion() > 2) {
			// api servlet 2.5 (Java EE 5) minimum pour appeler ServletContext.getContextPath
			return context.getContextPath();
		}
		URL webXmlUrl;
		try {
			webXmlUrl = context.getResource("/WEB-INF/web.xml");
		} catch (final MalformedURLException e) {
			throw new IllegalStateException(e);
		}
		String contextPath = webXmlUrl.toExternalForm();
		contextPath = contextPath.substring(0, contextPath.indexOf("/WEB-INF/web.xml"));
		final int indexOfWar = contextPath.indexOf(".war");
		if (indexOfWar > 0) {
			contextPath = contextPath.substring(0, indexOfWar);
		}
		// tomcat peut renvoyer une url commençant pas "jndi:/localhost"
		// (v5.5.28, webapp dans un répertoire)
		if (contextPath.startsWith("jndi:/localhost")) {
			contextPath = contextPath.substring("jndi:/localhost".length());
		}
		final int lastIndexOfSlash = contextPath.lastIndexOf('/');
		if (lastIndexOfSlash != -1) {
			contextPath = contextPath.substring(lastIndexOfSlash);
		}
		return contextPath;
	}
	
	public static String getHostName() {
		try {
			return InetAddress.getLocalHost().getHostName();
		} catch (final UnknownHostException ex) {
			return "localhost";
		}
	}
	
	public static class Data<K, V> {
		
		private K key;
		private V value;
		
		public K getKey() {
			return key;
		}
		public Data<K, V> key(K key) {
			this.key = key;
			return this;
		}
		public V getValue() {
			return value;
		}
		public Data<K, V> value(V value) {
			this.value = value;
			return this;
		}
		
		@Override
		public String toString() {
			return ReflectionToStringBuilder.toString(this, ToStringStyle.SHORT_PREFIX_STYLE);
		}
	}
}
