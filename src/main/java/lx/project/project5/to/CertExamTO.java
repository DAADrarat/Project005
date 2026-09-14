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

public class CertExamTO {
	private String examSession;
	private LocalDate examDate;
	private String examLocation;
	private String certCode;
}


//EXAM_SESSION VARCHAR(50) NOT NULL,
//EXAM_DATE DATE,
//EXAM_LOCATION TEXT,
//CERT_CODE VARCHAR(200) NOT NULL,
// PRIMARY KEY (CERT_CODE, EXAM_SESSION)