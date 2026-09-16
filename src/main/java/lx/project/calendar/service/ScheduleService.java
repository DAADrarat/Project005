package lx.project.calendar.service;

import java.util.List;

import lx.project.calendar.to.CertExamTO;
import lx.project.calendar.to.GovSupportPolicyTO;
import lx.project.calendar.to.RecruitmentTO;
import lx.project.calendar.to.ScheduleTO;

public interface ScheduleService {
	// ===== 달력에 뿌릴 일정 =====
    List<ScheduleTO> getAllSchedules();               // 전체
    List<ScheduleTO> getSchedulesByType(String type); // POLICY / CERT / JOB
	
 // ===== 달력 아래 체크박스 목록용 =====
 	List<GovSupportPolicyTO> getPolicyList(); // 정부사업
 	List<CertExamTO> getCertExamList(); // 자격증시험
 	List<RecruitmentTO> getJobList(); // 채용공고
 	
 	// ajax
 	List<CertExamTO> searchCert(String keyword);
 	
 	List<GovSupportPolicyTO> searchPolicy(String keyword);
 	
 	List<RecruitmentTO> searchJob(String keyword);
 	
 	List<ScheduleTO> searchAll(String keyword);
}

