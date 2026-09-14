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

public class CertExamTO {
	private String examSession;
	private LocalDate examDate;
	// private String examLocation; 자격증시험 시험장소 삭제
	private String certCode;
	private String certName; // 추가
	private String certInfo;
}

//EXAM_SESSION VARCHAR(50) NOT NULL,
//EXAM_DATE DATE,
//EXAM_LOCATION TEXT,
//CERT_CODE VARCHAR(200) NOT NULL,
// PRIMARY KEY (CERT_CODE, EXAM_SESSION)