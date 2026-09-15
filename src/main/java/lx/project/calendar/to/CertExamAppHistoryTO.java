package lx.project.calendar.to;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data 
@Builder
@NoArgsConstructor  
@AllArgsConstructor

public class CertExamAppHistoryTO {
	private String certExamAppId;
	private int memberId;
	private String certCode;
	private String examSession;
	
}




//CERT_EXAM_APP_ID VARCHAR(200) NOT NULL,
//MEMBER_ID VARCHAR(200) NOT NULL,
//CERT_CODE VARCHAR(200),
//EXAM_SESSION VARCHAR(50),
//PRIMARY KEY (CERT_EXAM_APP_ID)
