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

	@GetMapping("/idCheck.do")
	public String idCheck(@RequestParam("member_id") String member_id, Model model) {
		int result = service.idCheck(member_id);
		log.info("아이디 체크함");
		model.addAttribute("member_id", member_id);
		model.addAttribute("result", result);
		return "/member/idCheck";
	}

	@GetMapping("/myPage/*")
	public String loginCheck(HttpServletRequest request,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage, Model model) {
		HttpSession session = request.getSession();
		MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
		if (loginMember != null) {
			model.addAttribute("currentPage", currentPage);
			int startIndex = (currentPage - 1) * PageVO.PER_PAGE;
			String path = request.getServletPath();
			model.addAttribute("path", path);
			switch (path) {
			case "/member/myPage/":
				path = "/member/myPage/post";
			case "/member/myPage/post":
				model.addAttribute("page", service.page(loginMember.getMember_id(), "board"));
				model.addAttribute("myPost", service.myPost(loginMember.getMember_id(), startIndex));
				return path;
			case "/member/myPage/reply":
				model.addAttribute("page", service.page(loginMember.getMember_id(), "reply"));
				model.addAttribute("myReply", service.myReply(loginMember.getMember_id(), startIndex));
				return path;
			case "/member/myPage/email":
				return path;
			default:
				return "redirect:/";
			}
		} else
			return "redirect:/member/login";
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
		request.setAttribute("url", "/member/myPage/post");
		return "alert";
	}

	@GetMapping({ "/join", "/login" })
	public void sign() {
	}

	@GetMapping("/joinMember")
	public String join(HttpServletRequest request, MemberVO mvo) {
		service.memberJoin(mvo);
		request.setAttribute("msg", "회원가입이 완료되었습니다.");
		request.setAttribute("url", "/");
		return "alert";
	}

	@PostMapping("/login")
	public String login(HttpServletRequest request, MemberVO mvo, Model model) {
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
		return "redirect:/";
	}

	@GetMapping("/logout")
	public String logout(SessionStatus status) {
		// session초기화(@SessionAttributes 로 가져온 값은 이걸로만 지울 수 있음)
		// session.removeAttribute로는 지울 수 없음.
		status.setComplete();
		return "redirect:/";
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
