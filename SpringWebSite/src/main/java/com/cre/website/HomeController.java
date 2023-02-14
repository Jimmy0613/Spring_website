package com.cre.website;

import java.text.SimpleDateFormat;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.cre.domain.MemberVO;
import com.cre.website.service.BoardService;
import com.cre.website.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

/**
 * Handles requests for the application home page.
 */
@Log4j
@SessionAttributes("loginMember")
@AllArgsConstructor
@Controller
public class HomeController {
	private BoardService service;
	private MemberService serviceMember;
	/**
	 * Simply selects the home view to render by returning its name.
	 */
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
		MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
		if (loginMember != null) {
			Date date = new Date();
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			String today = format.format(date);
			int rps_count = serviceMember.getTodayCount(today, loginMember.getMember_id());
			model.addAttribute("loginMember", loginMember);
			model.addAttribute("count", rps_count);
			log.info("로그인 상태임");
		} else {
			log.info("로그아웃 상태임");
		}
		model.addAttribute("homeNotice", service.homeNotice());
		model.addAttribute("homePopular", service.homePopular());
		return "home";
	}

}
