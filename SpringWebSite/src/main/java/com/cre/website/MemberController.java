package com.cre.website;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.cre.domain.MemberVO;
import com.cre.website.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/member/*")
@SessionAttributes("loginMember") // session값 가져오기
@AllArgsConstructor
@Controller
public class MemberController {

	private MemberService service;

	@GetMapping("/join")
	public void join() {
		log.info("가입하기 화면");
	}

	@PostMapping("/join")
	public String join(@RequestParam("pwCheck") String pwCheck, MemberVO mvo) {
		service.memberJoin(mvo, pwCheck);
		return "redirect:/";
	}

	@GetMapping("/login")
	public void login() {
		log.info("로그인 화면");
	}

	@PostMapping("/login")
	public String login(@RequestParam("location") String location, MemberVO mvo, Model model) {
		MemberVO member = service.memberLogin(mvo);
		if (member != null) {
			// session.setAttribute("loginMember", member);
			// model.addAttribute를 하면 session에도 자동으로 저장됨.
			model.addAttribute("loginMember", member);
			log.info("로그인 성공");
		} else {
			log.info("로그인 실패");
		}
		return "redirect:" + location;
	}

	@PostMapping("/logout")
	public String logout(SessionStatus status, @RequestParam("location") String location) {
		// session초기화(@SessionAttributes 로 가져온 값은 이걸로만 지울 수 있음)
		// session.removeAttribute로는 지울 수 없음.
		status.setComplete();
		return "redirect:" + location;
	}
}
