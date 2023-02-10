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

import com.cre.domain.BoardVO;
import com.cre.domain.MemberVO;
import com.cre.domain.PageVO;
import com.cre.domain.ReplyVO;
import com.cre.website.service.BoardService;
import com.cre.website.service.MemberService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/board/*")
@SessionAttributes({ "loginMember", "currentPage", "category" })
@AllArgsConstructor
@Controller
public class BoardController {
	private BoardService service;
	private MemberService serviceMember;
	HttpSession session;

	@GetMapping("/list")
	public void list(@RequestParam(value = "category", defaultValue = "popular") String category,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage, HttpServletRequest request,
			Model model) {
		session = request.getSession();
		if (category.equals("popular")) {
			model.addAttribute("list", service.listPopular());
		} else {
			model.addAttribute("page", service.page(category));
			log.info("페이지 계산함");
			int startIndex = (currentPage - 1) * PageVO.PER_PAGE;
			model.addAttribute("list", service.listBoard(startIndex, category));
		}
		model.addAttribute("loginMember", session.getAttribute("loginMember"));
		model.addAttribute("category", category);
		model.addAttribute("currentPage", currentPage);
		log.info("글 목록 가져옴");
	}

	@GetMapping({ "/read", "/edit" })
	public void read(HttpServletRequest request, @RequestParam("post_num") Long post_num, Model model) {
		session = request.getSession();
		model.addAttribute("loginMember", session.getAttribute("loginMember"));
		service.view(post_num);
		model.addAttribute("read", service.read(post_num));
		model.addAttribute("reply", service.listReply(post_num));
		log.info("글 가져옴");
	}

	@GetMapping("/heart")
	public String heart(BoardVO bvo, MemberVO mvo, Model model) {
		service.heart(bvo.getPost_num(), bvo.getWriter_id(), mvo.getMember_id());
		model.addAttribute("loginMember", serviceMember.getMember(mvo.getMember_id()));
		return "redirect:/board/read?post_num=" + bvo.getPost_num();
	}

	@PostMapping("/reply")
	public String reply(ReplyVO rvo, Model model) {
		service.reply(rvo);
		model.addAttribute("loginMember", serviceMember.getMember(rvo.getWriter_id()));
		return "redirect:/board/read?post_num=" + rvo.getPost_num();
	}

	@GetMapping("/delete")
	public String delete(BoardVO bvo, Model model) {
		service.delete(bvo);
		model.addAttribute("loginMember", serviceMember.getMember(bvo.getWriter_id()));
		log.info("글 삭제함");
		return "redirect:/board/list";
	}

	@GetMapping("/delReply")
	public String delReply(ReplyVO rvo, Model model) {
		service.delReply(rvo);
		model.addAttribute("loginMember", serviceMember.getMember(rvo.getWriter_id()));
		log.info("댓글 삭제함");
		return "redirect:/board/read?post_num=" + rvo.getPost_num();
	}

	@PostMapping("/write")
	public String write(BoardVO bvo, Model model) {
		bvo.setCategory((String) session.getAttribute("category"));
		service.write(bvo);
		model.addAttribute("loginMember", serviceMember.getMember(bvo.getWriter_id()));
		log.info("글씀");
		return "redirect:/board/list";
	}

	@GetMapping("/write")
	public void write(HttpServletRequest request, Model model) {
		session = request.getSession();
		model.addAttribute("category", session.getAttribute("category"));
		log.info("글쓰기");
	}

	@PostMapping("/edit")
	public String edit(@RequestParam("post_num") Long post_num, BoardVO bvo) {
		service.edit(bvo);
		log.info("수정함");
		return "redirect:/board/read?post_num=" + post_num;
	}

}
