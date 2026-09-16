package lx.project.calendar.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lx.project.calendar.to.CertExamAppHistoryTO;
import lx.project.calendar.to.JobAppHistoryTO;
import lx.project.calendar.to.PolicyAppHistoryTO;
import lx.project.calendar.to.ScheduleTO;

@Repository
public class MyPageDAO {

	@Autowired
	SqlSession session;

	// 마이페이지 통합 - 정책+자격증+채용 한 번에
	public List<ScheduleTO> selectMySchedule(int memberId) {
	    return session.selectList("appHistory.selectMySchedule", memberId);
	}

	// 채용공고 신청 저장
	public int insertJob(JobAppHistoryTO to) {
		return session.insert("appHistory.insertJob", to);

	}

	public int insertPolicy(PolicyAppHistoryTO to) {
		return session.insert("appHistory.insertPolicy", to);
	}

	public int insertCert(CertExamAppHistoryTO to) {
		return session.insert("appHistory.insertCert", to);
	}
	// ===== 신청 취소 =====

	public int deleteJob(String jobAppId) {
		return session.delete("appHistory.deleteJob", jobAppId);
	}

	public int deletePolicy(String policyAppId) {
		return session.delete("appHistory.deletePolicy", policyAppId);
	}

	public int deleteCert(String certExamAppId) {
		return session.delete("appHistory.deleteCert", certExamAppId);
	}

}
