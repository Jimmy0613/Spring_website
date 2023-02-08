package com.cre.website;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cre.domain.MemberVO;
import com.cre.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/member/*")
@AllArgsConstructor
@Controller
public class MemberController {
		
	private MemberService service;
	
	
	@GetMapping("/join")
	public void join() {
		
	}
	@PostMapping("/join")
	public String join(MemberVO mvo) {
		service.join(mvo);
		return "redirect:/";
	}
	
	@GetMapping("/login")
	public void login() {
		
	}
	@PostMapping("/login")
	public String login(HttpServletRequest request, @RequestParam("location") String location, MemberVO mvo, Model model) {
		HttpSession session = request.getSession();
		List<MemberVO> memberList = (List<MemberVO>)service.memberList();
		String loginAlert = mvo.login(memberList, mvo);
		if(loginAlert.equals("")) {
			log.info("로그인 성공");
			session.setAttribute("loginMember", service.getMember(mvo.getMember_id()));
			model.addAttribute("loginMember", service.getMember(mvo.getMember_id()));
		} else {
			log.info("로그인 실패-" + loginAlert);
		}
		return "redirect:" + location;
	}
}
