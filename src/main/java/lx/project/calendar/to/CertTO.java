package lx.project.calendar.to;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data 
@Builder
@NoArgsConstructor  
@AllArgsConstructor

public class CertTO {
	private String certCode; //CERT_CODE
	private String certInfo; //CERT_INFO
	private String certName; //CERT_NAME 
}



//CERT_CODE VARCHAR(200) NOT NULL,
//CERT_INFO VARCHAR(200),
//CERT_NAME VARCHAR(100),
//PRIMARY KEY (CERT_CODE)