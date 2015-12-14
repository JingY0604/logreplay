package com.sogou.map.logreplay.controller;

import java.util.List;
import java.util.concurrent.TimeUnit;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.sogou.map.logreplay.controller.base.BaseController;
import com.sogou.map.logreplay.util.MonitorUtil;
import com.sogou.map.logreplay.util.MonitorUtil.Data;
import com.sogou.map.logreplay.util.SystemInfoUtil;

@Controller
@RequestMapping("/monitor")
public class MonitorController extends BaseController {
	
	/**
	 * ��ȡϵͳ��ز���
	 */
	@ResponseBody
	@RequestMapping("/systemInfo")
	public ModelMap getSystemInfo(HttpSession session) {
		String serverInfo = session.getServletContext().getServerInfo();
		ModelMap result = new ModelMap()
				.addAttribute("startTime", 				SystemInfoUtil.getStartTime())
				.addAttribute("javaVersion", 			SystemInfoUtil.getJavaVersion())
				.addAttribute("jvmVersion", 			SystemInfoUtil.getJvmVersion())
				.addAttribute("jvmArguments", 			SystemInfoUtil.getJvmArguments())
				.addAttribute("osInfo", 				SystemInfoUtil.getOsInfo())
				.addAttribute("osIcon", 				SystemInfoUtil.getOsIcon())
				.addAttribute("availableProcessors", 	SystemInfoUtil.getAvailableProcessors())
				.addAttribute("serverInfo", 			serverInfo)
				.addAttribute("serverIcon", 			SystemInfoUtil.getServerIcon(serverInfo))
				.addAttribute("pid", 					SystemInfoUtil.getPID())
		;
		return successResult(result);
	}
	
	/**
	 * ��ȡ�ڴ�������
	 * @param startTime	��ʼʱ��(����ʱ���)
	 * @param endTime	����ʱ��(����ʱ���)
	 * @param step		ȡ�����(��)
	 */
	@ResponseBody
	@RequestMapping("/memoryData")
	public ModelMap getMemoryData(
			@RequestParam(defaultValue = "0") long startTime,
			@RequestParam(defaultValue = "0") long endTime,
			@RequestParam(defaultValue = "300") long step,
			HttpSession session) {
		
		if(startTime == 0) {
			startTime = System.currentTimeMillis() - TimeUnit.HOURS.toMillis(3);
		}
		
		if(endTime == 0) {
			endTime = System.currentTimeMillis();
		}
		
		String application = MonitorUtil.getCurrentApplication(session.getServletContext());
		
		List<Data<Long, Double>> usedMemoryDataList = MonitorUtil.getDataList(application, "usedMemory", startTime, endTime, step);
		
		List<Data<Long, Double>> usedNonHeapMemoryDataList = MonitorUtil.getDataList(application, "usedNonHeapMemory", startTime, endTime, step);
		
		List<Data<Long, Double>> usedPhysicalMemoryDataList = MonitorUtil.getDataList(application, "usedPhysicalMemorySize", startTime, endTime, step);
		
		List<Data<Long, Double>> usedSwapSpaceDataList = MonitorUtil.getDataList(application, "usedSwapSpaceSize", startTime, endTime, step);
		
		ModelMap result = new ModelMap()
				.addAttribute("usedMemoryDataList", usedMemoryDataList)
				.addAttribute("usedNonHeapMemoryDataList", usedNonHeapMemoryDataList)
				.addAttribute("usedPhysicalMemoryDataList", usedPhysicalMemoryDataList)
				.addAttribute("usedSwapSpaceDataList", usedSwapSpaceDataList)
		;
		
		return successResult(result);
	}
	
	
}
