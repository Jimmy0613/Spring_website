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
import com.cre.website.service.BoardService;
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

	@GetMapping("/myPost")
	public void myPost(@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
			HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
		model.addAttribute("page", service.page(loginMember.getMember_id()));
		model.addAttribute("currentPage", currentPage);
		int startIndex = (currentPage - 1) * PageVO.PER_PAGE;
		String member_id = loginMember.getMember_id();
		model.addAttribute("myPost", service.myPost(member_id, startIndex));
	}

	@GetMapping("/myReply")
	public void myReply(@RequestParam(value="currentPage", defaultValue="1") int currentPage,
			HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
		model.addAttribute("page", service.page2(loginMember.getMember_id()));
		model.addAttribute("currentPage", currentPage);
		int startIndex = (currentPage -1) * PageVO.PER_PAGE;
		String member_id = loginMember.getMember_id();
		model.addAttribute("myReply", service.myReply(member_id, startIndex));
	}
	
	@GetMapping("/join")
	public void join() {
	}

	@PostMapping("/join")
	public String join(@RequestParam("pwCheck") String pwCheck, MemberVO mvo) {
		service.memberJoin(mvo, pwCheck);
		return "redirect:/";
	}

	@GetMapping("/login")
	public void login() {
	}

	@PostMapping("/login")
	public String login(@RequestParam("location") String location, MemberVO mvo, Model model) {
		MemberVO member = service.memberLogin(mvo);
		if (member != null) {
			// session.setAttribute("loginMember", member);
			// model.addAttribute를 하면 session에도 자동으로 저장됨.
			model.addAttribute("loginMember", member);
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
}
