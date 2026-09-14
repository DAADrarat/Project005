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
public class GovSupportPolicyTO {

	private String govProjectCode;
	private String govProjectName;
	private LocalDate govProjectDate;
	private String govProjectInfo;
	private String targetCondition;
}
//GOV_PROJECT_CODE VARCHAR(200) NOT NULL,
//GOV_PROJECT_NAME VARCHAR(100),
//GOV_PROJECT_DATE DATE,
//GOV_PROJECT_INFO VARCHAR(200),
//TARGET_CONDITION VARCHAR(100),
//PRIMARY KEY (GOV_PROJECT_CODE)