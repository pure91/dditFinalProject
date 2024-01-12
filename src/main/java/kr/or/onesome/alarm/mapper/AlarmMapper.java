package kr.or.onesome.alarm.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.web.socket.WebSocketSession;

import kr.or.onesome.alarm.vo.AlarmVO;
import kr.or.onesome.vo.FranchiseVO;

@Mapper
public interface AlarmMapper {
	
	/**
	 * 알림 조회
	 * @param alarmRcverId
	 * @return
	 */
	public List<AlarmVO> selectAlarm(String alarmRcverId);
	
	/**
	 * 알람 저장
	 * @param alarmVO
	 * @return
	 */
	public int saveAlarm(AlarmVO alarmVO);
	
	/**
	 * 가맹점 번호로 가맹점주 아이디 가져오는 메서드
	 * @param franchiseVO
	 * @return
	 */
	public FranchiseVO getFrcsInfo(FranchiseVO franchiseVO);
	
	/**
	 * 알람 확인 유무 'Y'로 업데이트
	 * @param alarmVO
	 * @return
	 */
	public int updateAlarmChecked(AlarmVO alarmVO);

}
