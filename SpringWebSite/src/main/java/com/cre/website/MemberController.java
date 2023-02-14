package com.cre.website;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.SessionAttributes;
import org.springframework.web.bind.support.SessionStatus;

import com.cre.domain.MemberVO;
import com.cre.domain.PageVO;
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

	@GetMapping("/myPage")
	public String loginCheck(HttpServletRequest request,
			@RequestParam(value = "mode", defaultValue = "post") String mode) {
		HttpSession session = request.getSession();
		MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
		if (loginMember != null) {
			switch (mode) {
			case "post":
				return "redirect:/member/myPage/post";
			case "reply":
				return "redirect:/member/myPage/reply";
			case "email":
				return "redirect:/member/myPage/email";
			default:
				return "redirect:/home";
			}
		} else
			return "redirect:/member/login";
	}

	@GetMapping("/myPage/post")
	public String myPost(@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
			HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
		if (loginMember == null)
			return "redirect:/member/login";
		model.addAttribute("page", service.page(loginMember.getMember_id()));
		model.addAttribute("currentPage", currentPage);
		int startIndex = (currentPage - 1) * PageVO.PER_PAGE;
		String member_id = loginMember.getMember_id();
		model.addAttribute("myPost", service.myPost(member_id, startIndex));
		return "member/myPage/post";
	}

	@GetMapping("/myPage/reply")
	public String myReply(@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
			HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
		if (loginMember == null)
			return "redirect:/member/login";
		model.addAttribute("page", service.page2(loginMember.getMember_id()));
		model.addAttribute("currentPage", currentPage);
		int startIndex = (currentPage - 1) * PageVO.PER_PAGE;
		String member_id = loginMember.getMember_id();
		model.addAttribute("myReply", service.myReply(member_id, startIndex));
		return "member/myPage/reply";
	}

	@GetMapping("/myPage/email")
	public void myEmail() {
	}

	@PostMapping("/myPage/email")
	public String myEmail(HttpServletRequest request, SessionStatus status, MemberVO mvo, Model model) {
		HttpSession session = request.getSession();
		service.myEmail(mvo);
		MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
		if (loginMember == null)
			return "redirect:/member/login";
		loginMember.setEmail(mvo.getEmail());
		model.addAttribute("loginMember", loginMember);
		request.setAttribute("msg", "이메일 정보가 변경되었습니다.");
		request.setAttribute("url", "/member/myPage?mode=post");
		return "alert";
	}

	@GetMapping("/join")
	public void join() {
	}

	@PostMapping("/join")
	public String join(HttpServletRequest request, @RequestParam("pwCheck") String pwCheck, MemberVO mvo) {
		String alert = service.memberJoin(mvo, pwCheck);
		if (!alert.equals("")) {
			request.setAttribute("msg", alert);
			request.setAttribute("url", "/member/join");
			return "alert";
		}
		return "redirect:/";
	}

	@GetMapping("/login")
	public void login() {
	}

	@PostMapping("/login")
	public String login(HttpServletRequest request, @RequestParam("location") String location, MemberVO mvo,
			Model model) {
		String alert = service.memberLogin(mvo);
		if (alert.equals("")) {
			MemberVO loginMember = service.getMember(mvo.getMember_id());
			// model.addAttribute를 하면 session에도 자동으로 저장됨.
			model.addAttribute("loginMember", loginMember);
		} else {
			request.setAttribute("msg", alert);
			request.setAttribute("url", "/member/login");
			return "alert";
		}
		return "redirect:" + location;
	}

	@GetMapping("/logout")
	public String logout(SessionStatus status, @RequestParam("location") String location) {
		// session초기화(@SessionAttributes 로 가져온 값은 이걸로만 지울 수 있음)
		// session.removeAttribute로는 지울 수 없음.
		status.setComplete();
		return "redirect:" + location;
	}

	@GetMapping("/rps")
	public String rps(HttpServletRequest request, @RequestParam("input") String input, Model model) {
		HttpSession session = request.getSession();
		MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
		int random = (int) Math.floor(Math.random() * 3) + 1;
		String com = "r";
		switch (random) {
		case 1:
			com = "s";
			break;
		case 2:
			com = "p";
			break;
		}
		String inputStr = switchRps(input);
		String comStr = switchRps(com);
		String alert = "나: " + inputStr + "\\n컴퓨터: " + comStr;
		String result = rps(input, com);

		switch (result) {
		case "win":
			loginMember.setHeart_count(loginMember.getHeart_count() + 2);
			alert += "\\n우와! 이겼습니다!";
			break;
		case "draw":
			alert += "\\n앗! 비겼습니다~";
			break;
		case "lose":
			loginMember.setHeart_count(loginMember.getHeart_count() - 1);
			alert += "\\n으악! 졌습니다ㅠ";
			break;
		}
		service.rps(loginMember.getMember_id(), result);
		model.addAttribute("loginMember", loginMember);
		request.setAttribute("msg", alert);
		request.setAttribute("url", "/");
		return "alert";
	}

	public String switchRps(String str) {
		String s = "";
		switch (str) {
		case "r":
			s = "바위✊";
			break;
		case "p":
			s = "보🖐";
			break;
		case "s":
			s = "가위✌";
			break;
		}
		return s;
	}

	public String rps(String input, String com) {
		String result = "draw";
		switch (input) {
		case "s":
			if (com.equals("r")) {
				result = "lose";
			} else if (com.equals("p")) {
				result = "win";
			}
			break;

		case "r":
			if (com.equals("p")) {
				result = "lose";
			} else if (com.equals("s")) {
				result = "win";
			}
			break;

		case "p":
			if (com.equals("s")) {
				result = "lose";
			} else if (com.equals("r")) {
				result = "win";
			}
			break;
		}

		return result;
	}
}
