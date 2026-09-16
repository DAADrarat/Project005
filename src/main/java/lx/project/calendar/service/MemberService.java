package lx.project.calendar.service;

import java.util.List;

import lx.project.calendar.to.CertTO;
import lx.project.calendar.to.GovSupportPolicyTO;
import lx.project.calendar.to.MemberTO;

public interface MemberService {

	public int loginCheck(String userId, String password);

	public MemberTO selectOne(int memberId);

	public MemberTO updateMember(MemberTO member);

	public void removeAction(int memberId);

	// 회원가입, 이메일보내기
	public boolean signUpMember(MemberTO member);

	// 뱃지만들기
	public List<CertTO> getCertsByCodes(List<String> certCodes);
	
	
}
