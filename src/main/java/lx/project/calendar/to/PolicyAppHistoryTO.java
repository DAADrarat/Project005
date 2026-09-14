package lx.project.calendar.to;

import java.time.LocalDate;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor

public class PolicyAppHistoryTO {
	
	private String policyAppId;
	private String govProjectCode;
	private String memberId;
	private LocalDate appDate;
	private String appStatus;
}

//POLICY_APP_ID VARCHAR(200) NOT NULL,
//GOV_PROJECT_CODE VARCHAR(200) NOT NULL,
//MEMBER_ID VARCHAR(200) NOT NULL,
//APP_DATE DATE,
//APP_STATUS CHAR(1),
//PRIMARY KEY (POLICY_APP_ID)
