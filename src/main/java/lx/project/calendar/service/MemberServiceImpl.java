package lx.project.calendar.service;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sendgrid.Method;
import com.sendgrid.Request;
import com.sendgrid.Response;
import com.sendgrid.SendGrid;
import com.sendgrid.helpers.mail.Mail;
import com.sendgrid.helpers.mail.objects.Content;
import com.sendgrid.helpers.mail.objects.Email;

import lx.project.calendar.dao.MemberDAO;
import lx.project.calendar.to.CertTO;
import lx.project.calendar.to.GovSupportPolicyTO;
import lx.project.calendar.to.MemberTO;

@Service("MemberServiceImpl")
public class MemberServiceImpl implements MemberService {

	@Autowired
	MemberDAO memdao;

	public int loginCheck(String userId, String password) {
		MemberTO member = memdao.loginCheck(userId, password);

		if (member != null) {
			int memberId = member.getMemberId();
			return memberId;
		} else {
			System.out.println("입력이 올바르지 않습니다");
			return 0;
		}
	}

	public MemberTO selectOne(int memberId) {
		return memdao.selectOne(memberId);
	}
	
	public MemberTO updateMember(MemberTO member) {
		int upval = memdao.updateMember(member);
		int memberId = member.getMemberId();
		MemberTO memberlist = memdao.selectOne(memberId);
		if(upval == 1) {
			return memberlist;
		} else {
			return null;
		}
	}
	
	@Override
	public boolean signUpMember(MemberTO member) {
		// 기본 회원 정보만 DB에 저장
		int result = memdao.signUpAction(member);

		if (result > 0) {
			// 저장이 성공하면 환영 메일 발송 (이메일 변수명 확인 필수)
			sendWelcomeEmail(member.getEmail());
			return true;
		}
		return false;
	}

	private void sendWelcomeEmail(String userEmail) {
		Email from = new Email("lck6183@naver.com");
		String subject = "Team5 Project 회원가입을 환영합니다!";
		Email to = new Email(userEmail);
		Content content = new Content("text/plain", "가입이 완료되었습니다. 캘린더에서 다양한 일정을 확인해 보세요!");

		Mail mail = new Mail(from, subject, to, content);
		SendGrid sg = new SendGrid("");
		Request request = new Request();

		try {
			request.setMethod(Method.POST);
			request.setEndpoint("mail/send");
			request.setBody(mail.build());
			Response response = sg.api(request);
			System.out.println("메일 발송 성공 상태코드: " + response.getStatusCode());
		} catch (IOException ex) {
			System.out.println("메일 발송 실패: " + ex.getMessage());
		}
	}
	// 시연용 이메일
	// lck6183@naver.com
	// alen1@naver.com
	// guswjd6248@gmail.com
	// gi70759@gmail.con
	// 3031ju@naver.com

	public void removeAction(int memberId) {
		memdao.remove(memberId);
	}

	// 뱃지만들기
	@Override
	public List<CertTO> getCertsByCodes(List<String> certCodes) {
		return memdao.getCertsByCodes(certCodes);
	}
	
	

}
