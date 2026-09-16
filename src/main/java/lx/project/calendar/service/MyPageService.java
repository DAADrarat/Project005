package lx.project.calendar.service;

import java.util.List;
import lx.project.calendar.to.ScheduleTO;

public interface MyPageService {

    // 내가 신청한 공고 일정 조회
    List<ScheduleTO> getMySchedule(int memberId);
    
    // 선택한 공고들 신청 저장
    void applyJobs(int memberId, List<String> jobPostingCodes);
    
 // 선택한 정부사업 신청
 	void applyPolicies(int memberId, List<String> govProjectCodes);

 	// 선택한 자격증시험 접수 - 값 형식 "certCode|examSession"
 	void applyCerts(int memberId, List<String> certKeys);

 	// 신청 취소 - type 은 POLICY / CERT / JOB
 	void cancelApply(String type, String appId);

}
