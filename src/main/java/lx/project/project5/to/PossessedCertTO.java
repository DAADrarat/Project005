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
public class PossessedCertTO {
 
    private String historyNo;   // HISTORY_NO
    private String possessedCertName;   // POSSESSED_CERT_NAME
    private String memberId;   // MEMBER_ID
}


//HISTORY_NO VARCHAR(200) NOT NULL,
//POSSESSED_CERT_NAME VARCHAR(100),
//MEMBER_ID VARCHAR(200) NOT NULL,
//PRIMARY KEY (MEMBER_ID, HISTORY_NO)