package mailtest;

import javax.mail.Authenticator;
import javax.mail.PasswordAuthentication;

public class GoogleAuthentication extends Authenticator{
	PasswordAuthentication passAuth;
	// 생성자
	public GoogleAuthentication() {
		// 구글인증 p364 => 369 생성된 앱 비밀번호(인증받은 코드)
		passAuth=new PasswordAuthentication("hssp122","xfcfrhckjrdnfbqs");
	}
	// 외부에서 메서드 호출 passAuth 인증 받은 값 리턴 해주는 메서드
	public PasswordAuthentication getPasswordAuthentication() {
		return passAuth;
	}
}
