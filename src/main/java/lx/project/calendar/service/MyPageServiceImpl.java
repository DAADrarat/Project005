package lx.project.calendar.service;

import java.util.List;
import java.util.UUID;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import lx.project.calendar.dao.MyPageDAO;
import lx.project.calendar.to.CertExamAppHistoryTO;
import lx.project.calendar.to.CertExamTO;
import lx.project.calendar.to.JobAppHistoryTO;
import lx.project.calendar.to.PolicyAppHistoryTO;
import lx.project.calendar.to.ScheduleTO;

/**
 * 마이페이지 서비스 구현 클래스
 * - 채용공고 / 정부사업 / 자격증시험 신청 처리
 * - 신청 내역 조회 및 취소
 */
@Service("MyPageServiceImpl")   // 스프링 빈으로 등록 (컨트롤러에서 주입받아 사용)
public class MyPageServiceImpl implements MyPageService {

	// DB 접근 객체 자동 주입
	@Autowired
	MyPageDAO myPageDAO;

	
	@Override
	public List<ScheduleTO> getMySchedule(int memberId) {
	    return myPageDAO.selectMySchedule(memberId);
	}
	
	/**
	 * 선택한 채용공고들을 신청 처리
	 * @param memberId 회원 ID
	 * @param codes 체크박스로 선택한 공고 코드 목록
	 */
	@Override
	public void applyJobs(int memberId, List<String> codes) {
		// 하나도 선택 안 했으면 아무것도 안 함 (NullPointerException 방지)
		if (codes == null)
			return;

		// 선택한 공고 수만큼 반복해서 INSERT
		for (String code : codes) {
			JobAppHistoryTO to = JobAppHistoryTO.builder()
					.jobAppId(UUID.randomUUID().toString())  // 신청 고유 ID 생성
					.jobPostingCode(code)                    // 공고 코드
					.memberId(memberId)                      // 신청한 회원
					.build();
			myPageDAO.insertJob(to);
		}
	}

	/**
	 * 선택한 정부사업들을 신청 처리
	 * @param memberId 회원 ID
	 * @param govProjectCodes 선택한 정부사업 코드 목록
	 */
	@Override
	public void applyPolicies(int memberId, List<String> govProjectCodes) {
		if (govProjectCodes == null)
			return;

		for (String code : govProjectCodes) {
			PolicyAppHistoryTO to = PolicyAppHistoryTO.builder()
					.policyAppId(UUID.randomUUID().toString())
					.govProjectCode(code)
					.memberId(memberId)
					.build();
			myPageDAO.insertPolicy(to);
		}
	}

	/**
	 * 선택한 자격증 시험을 접수 처리
	 * @param memberId 회원 ID
	 * @param certKeys "자격증코드|시험회차" 형식의 문자열 목록
	 *                 (같은 자격증이라도 회차가 다르면 별개 접수이므로 두 값을 합쳐서 전달받음)
	 */
	@Override
	public void applyCerts(int memberId, List<String> certKeys) {
		if (certKeys == null)
			return;

		for (String key : certKeys) {
			// "certCode|examSession" 형식이므로 | 기준으로 분리
			// split의 인자는 정규식이라 |는 특수문자 → \\| 로 이스케이프 필요
			String[] parts = key.split("\\|");

			// 분리 결과가 2개 미만이면 잘못된 값이므로 건너뜀
			if (parts.length < 2)
				continue;

			CertExamAppHistoryTO to = CertExamAppHistoryTO.builder()
					.certExamAppId(UUID.randomUUID().toString())
					.certCode(parts[0])       // 앞부분: 자격증 코드
					.examSession(parts[1])    // 뒷부분: 시험 회차
					.memberId(memberId)
					.build();
			myPageDAO.insertCert(to);
		}
	}

	/**
	 * 신청 내역 취소
	 * @param type 신청 유형 (JOB: 채용공고 / POLICY: 정부사업 / CERT: 자격증시험)
	 * @param appId 취소할 신청 건의 고유 ID
	 */
	@Override
	public void cancelApply(String type, String appId) {
		// 값이 안 넘어왔으면 처리 중단
		if (type == null || appId == null)
			return;

		// 대소문자 구분 없이 처리하기 위해 대문자로 변환 후 분기
		switch (type.toUpperCase()) {
		case "JOB":     // 채용공고 신청 취소
			myPageDAO.deleteJob(appId);
			break;
		case "POLICY":  // 정부사업 신청 취소
			myPageDAO.deletePolicy(appId);
			break;
		case "CERT":    // 자격증시험 접수 취소
			myPageDAO.deleteCert(appId);
			break;
		default:        // 정의되지 않은 유형이 넘어온 경우 → 예외 발생시켜 잘못된 요청임을 알림
			throw new IllegalArgumentException("알 수 없는 신청 유형: " + type);
		}
	}
	
	
}