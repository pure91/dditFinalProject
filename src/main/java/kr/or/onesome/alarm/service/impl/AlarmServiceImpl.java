package kr.or.onesome.alarm.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import kr.or.onesome.alarm.mapper.AlarmMapper;
import kr.or.onesome.alarm.service.AlarmService;
import kr.or.onesome.alarm.vo.AlarmVO;
import kr.or.onesome.vo.FranchiseVO;

@Service
public class AlarmServiceImpl implements AlarmService{
	
	@Autowired
	private AlarmMapper alarmMapper;
	
	@Override
	public int saveAlarm(AlarmVO alarmVO) {
		return alarmMapper.saveAlarm(alarmVO);
	}

	@Override
	public FranchiseVO getFrcsInfo(FranchiseVO franchiseVO) {
		return alarmMapper.getFrcsInfo(franchiseVO);
	}

	@Override
	public int updateAlarmChecked(AlarmVO alarmVO) {
		return alarmMapper.updateAlarmChecked(alarmVO);
	}
	
}
