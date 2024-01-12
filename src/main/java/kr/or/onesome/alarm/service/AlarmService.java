package kr.or.onesome.alarm.service;

import kr.or.onesome.alarm.vo.AlarmVO;
import kr.or.onesome.vo.FranchiseVO;

public interface AlarmService {

	public int saveAlarm(AlarmVO alarmVO);

	public FranchiseVO getFrcsInfo(FranchiseVO franchiseVO);

	public int updateAlarmChecked(AlarmVO alarmVO);

}
