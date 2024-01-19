package kr.or.onesome.franchise.mapper;

import java.util.List;
import java.util.Map;

import kr.or.onesome.vo.AttendanceManagementVO;
import kr.or.onesome.vo.ComCodeInfoVO;
import kr.or.onesome.vo.ComDetCodeInfoVO;
import kr.or.onesome.vo.FranchiseEmployeeVO;
import kr.or.onesome.vo.FranchiseVO;

public interface FranchiseEmployeeMapper {

	//가맹점 직원 목록
	public List<FranchiseEmployeeVO> list(Map<String, Integer> map);

	//전체 직원 수
	public int getCount();
	
	//가맹점 직원 상세
	public FranchiseEmployeeVO detail(FranchiseEmployeeVO franchiseEmployeeVO);

	//가맹점 직원 등록
	public int createPost(FranchiseEmployeeVO franchiseEmployeeVO);
	
	//가맹점 가져오기
	public List<FranchiseVO> getFranchise();
	
	//근무 상태 정보 가져오기
	public List<ComDetCodeInfoVO> getCWST();
	
	//근무 타입 정보 가져오기
	public List<ComDetCodeInfoVO> getWKTP();

	/*수정 모드에서 첨부파일을 수정하고자 할 때 ATCH_FILE_DETAIL테이블의 데이터를 먼저 삭제함 
	파라미터 : String atchFileId
	*/
	//<delete id="delAtch" parameterType="int">
	public int delAtch(int frcsEmpNo);

	//가맹점 직원 정보 수정
	public int update(FranchiseEmployeeVO franchiseEmployeeVO);

	//가맹점 직원 정보 삭제
	public int delete(FranchiseEmployeeVO franchiseEmployeeVO);

	//가맹점 직원 근무일정 -- 추가하기
	public int addEvent(AttendanceManagementVO event);

	//가맹점 직원 근무일정 -- 변경하기
	public int updateEvent(AttendanceManagementVO event);

	//가맹점 직원 근무일정 -- 삭제하기
	public int deleteEvent(int attndceNo);

	//가맹점 직원 근무일정 -- 불러오기
	public List<Map<String, Object>> getEvents(AttendanceManagementVO attendanceManagementVO);
}
