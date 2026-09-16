package lx.project.calendar.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import lx.project.calendar.dao.ScheduleDAO;
import lx.project.calendar.to.CertExamTO;
import lx.project.calendar.to.GovSupportPolicyTO;
import lx.project.calendar.to.RecruitmentTO;
import lx.project.calendar.to.ScheduleTO;

@Service("ScheduleServiceImpl")
public class ScheduleServiceImpl implements ScheduleService {

    @Autowired
    private ScheduleDAO scheduleDAO;

    @Override
    public List<ScheduleTO> getAllSchedules() {
        return scheduleDAO.getAllSchedules();
    }

    @Override
    public List<ScheduleTO> getSchedulesByType(String type) {
        return scheduleDAO.getSchedulesByType(type);
    }
    @Override
	public List<GovSupportPolicyTO> getPolicyList() {
		return scheduleDAO.getPolicyList();
	}

	@Override
	public List<CertExamTO> getCertExamList() {
		return scheduleDAO.getCertExamList();
	}

	@Override
	public List<RecruitmentTO> getJobList() {
		return scheduleDAO.getJobList();
	}
	
	//ajax 검색용
	@Override
	public List<CertExamTO> searchCert(String keyword) {
		return scheduleDAO.searchCert(keyword);
	}
	@Override
	public List<GovSupportPolicyTO> searchPolicy(String keyword) {
		return scheduleDAO.searchPolicy(keyword);	
	}
	@Override
	public List<RecruitmentTO> searchJob(String keyword) {
		return scheduleDAO.searchJob(keyword);
	}
	@Override
	public List<ScheduleTO> searchAll(String keyword) {
		return scheduleDAO.searchAll(keyword);
	}
}

