package lx.project.project5.to;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor

public class RecruitmentTO {
	private String jobPostingCode;
	private String jobPostingName;
	private LocalDate jobPostingDate;
	private String recruitmentInfo;
}


//JOB_POSTING_CODE VARCHAR(200) NOT NULL,
//JOB_POSTING_NAME VARCHAR(100),
//JOB_POSTING_DATE DATE,
//RECRUITMENT_INFO VARCHAR(200),
//PRIMARY KEY (JOB_POSTING_CODE)
