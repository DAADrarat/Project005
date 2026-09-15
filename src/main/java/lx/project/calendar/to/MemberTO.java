package lx.project.calendar.to;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data 
@Builder
@NoArgsConstructor  
@AllArgsConstructor

public class MemberTO {

	private int memberId; // MEMBER_ID
	private String userId;  // USER_ID
	private String password; // PASSWORD
	private String email;  // EMAIL
	private Integer userAge; // USER_AGE
	private String name ; //NAME
	private String educationLevel; //EDUCATION_LEVEL
	private String major; //MAJOR
	private String empStatus; //EMP_STATUS 
	
}

//MEMBER_ID int auto_increment not null,
//USER_ID VARCHAR(50),
//PASSWORD VARCHAR(50),
//EMAIL VARCHAR(100),
//USER_AGE INT,
//NAME VARCHAR(100),
//EDUCATION_LEVEL VARCHAR(50),
//MAJOR VARCHAR(100),
//EMP_STATUS CHAR(10),
//PRIMARY KEY (MEMBER_ID)
