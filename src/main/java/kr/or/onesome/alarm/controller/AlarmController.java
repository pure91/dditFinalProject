package kr.or.onesome.alarm.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import kr.or.onesome.alarm.service.AlarmService;
import kr.or.onesome.alarm.vo.AlarmVO;
import kr.or.onesome.vo.FranchiseVO;
import lombok.extern.slf4j.Slf4j;

@Controller
@Slf4j
@RequestMapping("/alarm")
public class AlarmController {
	
	@Autowired
	private AlarmService alarmService;
	
	// 알람 인서트 (카트리스트에서 넘어옴)
	@ResponseBody
	@PostMapping("/saveAlarm")
	public int saveAlarm(@RequestBody AlarmVO alarmVO) {
		log.info("saveAlarm ->  alarmVO: {}", alarmVO);
		int result = alarmService.saveAlarm(alarmVO);
		
		log.info("result: {}", result);
		return result;
	}
	
	// 카트리스트에서 받아온 frcsNo로 그 가맹점의 가맹점주 이메일 가져와야함
	@ResponseBody
	@PostMapping("/getFrcsInfo")
	public FranchiseVO getFrcsInfo(@RequestBody FranchiseVO franchiseVO) {
		log.info("getFrcsInfo -> frcsNo: {}", franchiseVO);
		
		franchiseVO = alarmService.getFrcsInfo(franchiseVO);
		
		log.info("getFrcsInfo -> franchiseVO: {}", franchiseVO);
		
		return franchiseVO;
	}
	
	// 
	@ResponseBody
	@PostMapping("/updateAlarmChecked")
	public int updateAlarmChecked(@RequestBody AlarmVO alarmVO) {
		
		int result = alarmService.updateAlarmChecked(alarmVO);
		
		return result;
	}
}
