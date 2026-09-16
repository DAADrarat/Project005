package lx.project.calendar.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import lx.project.calendar.to.CertExamTO;
import lx.project.calendar.to.GovSupportPolicyTO;
import lx.project.calendar.to.RecruitmentTO;
import lx.project.calendar.to.ScheduleTO;

@Repository
public class ScheduleDAO {

	@Autowired
	SqlSession session;

	// ===== 달력용 (ScheduleTO 로 통일) =====

	// 전체일정 - 정책+자격증+채용 UNION 결과
	// "schedule" = mapper-schedule.xml 의 namespace
	public List<ScheduleTO> getAllSchedules() {
		return session.selectList("schedule.selectAll");
	}

	// 타입별 일정 - POLICY / CERT / JOB
	public List<ScheduleTO> getSchedulesByType(String type) {
		return session.selectList("schedule.selectByType", type);
	}

	// ===== 체크박스 목록용  =====

	public List<GovSupportPolicyTO> getPolicyList() {
		return session.selectList("schedule.selectPolicy");
	}

	public List<CertExamTO> getCertExamList() {
		return session.selectList("schedule.selectCert");
	}

	public List<RecruitmentTO> getJobList() {
		return session.selectList("schedule.selectJob");
	}

	// ===== 검색용 (AJAX) =====

	// Cert 자격증 이름으로 검색 - keyword 가 비어 있으면 전체 조회
	public List<CertExamTO> searchCert(String keyword) {
		return session.selectList("schedule.selectCertByKeyword", keyword);
	}
	
	// Policy
	public List<GovSupportPolicyTO> searchPolicy(String keyword) {
		return session.selectList("schedule.selectPolicyByKeyword", keyword);
	}
	
	// Job
	public List<RecruitmentTO> searchJob(String keyword) {
		return session.selectList("schedule.selectJobByKeyword", keyword);
	}
	// All
	public List<ScheduleTO> searchAll(String keyword) {
		return session.selectList("schedule.selectAllByKeyword", keyword);
	}
}