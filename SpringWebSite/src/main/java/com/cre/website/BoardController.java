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
@SessionAttributes({ "loginMember", "currentPage", "category", "temp" })
@AllArgsConstructor
@Controller
public class BoardController {
	private BoardService service;
	private MemberService serviceMember;

//	@Autowired
//	private HttpServletRequest request;
//	HttpSession session = request.getSession();

	@GetMapping("/list")
	public String list(HttpServletRequest request,
			@RequestParam(value = "category", defaultValue = "popular") String category,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage, Model model) {
		HttpSession session = request.getSession();
		if (category.equals("popular")) {
			model.addAttribute("list", service.listPopular());
		} else {
			model.addAttribute("page", service.page(category));
			int startIndex = (currentPage - 1) * PageVO.PER_PAGE;
			model.addAttribute("list", service.listBoard(startIndex, category));
		}
		model.addAttribute("loginMember", session.getAttribute("loginMember"));
		model.addAttribute("category", category);
		model.addAttribute("currentPage", currentPage);
		return "board/list";
	}

	@GetMapping(path = { "/read", "/edit" })
	public String read(HttpServletRequest request, @RequestParam(value = "category", defaultValue = "") String category,
			@RequestParam(value = "currentPage", defaultValue = "1") int currentPage,
			@RequestParam("post_num") Long post_num, Model model) {
		HttpSession session = request.getSession();
		String path = request.getServletPath();
		if (service.read(post_num) == null)
			return "redirect:/board/list";
		if (!category.equals(""))
			model.addAttribute("category", category);
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("loginMember", session.getAttribute("loginMember"));
		service.view(post_num);
		model.addAttribute("read", service.read(post_num));
		model.addAttribute("reply", service.listReply(post_num));
		return path;
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
	public String delete(HttpServletRequest request,
			@RequestParam(value = "confirm", defaultValue = "false") boolean confirm, BoardVO bvo, Model model) {
		HttpSession session = request.getSession();
		if (confirm) {
			BoardVO temp = (BoardVO) session.getAttribute("temp");
			String category = (String) session.getAttribute("category");
			service.delete(temp);
			model.addAttribute("loginMember", serviceMember.getMember(temp.getWriter_id()));
			String alert = "게시글이 삭제되었습니다.";
			String url = "/board/list?category=" + category;
			request.setAttribute("msg", alert);
			request.setAttribute("url", url);
			return "alert";
		} else {
			String msg = "해당 게시글을 삭제하시겠습니까?";
			String url_yes = "/board/delete?confirm=true";
			String url_no = "/board/read?post_num=" + bvo.getPost_num();
			model.addAttribute("temp", bvo);
			request.setAttribute("msg", msg);
			request.setAttribute("url_yes", url_yes);
			request.setAttribute("url_no", url_no);
			return "confirm";
		}
	}

	@GetMapping("/delReply")
	public String delReply(HttpServletRequest request,
			@RequestParam(value = "confirm", defaultValue = "false") boolean confirm, ReplyVO rvo, Model model) {
		HttpSession session = request.getSession();
		if (confirm) {
			ReplyVO temp = (ReplyVO) session.getAttribute("temp");
			service.delReply(temp);
			MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
			model.addAttribute("loginMember", serviceMember.getMember(loginMember.getMember_id()));
			String alert = "댓글이 삭제되었습니다.";
			String url = "/board/read?post_num=" + temp.getPost_num();
			request.setAttribute("msg", alert);
			request.setAttribute("url", url);
			return "alert";
		} else {
			String msg = "해당 댓글을 삭제하시겠습니까?";
			String url_yes = "/board/delReply?confirm=true";
			String url_no = "/board/read?post_num=" + rvo.getPost_num();
			model.addAttribute("temp", rvo);
			request.setAttribute("msg", msg);
			request.setAttribute("url_yes", url_yes);
			request.setAttribute("url_no", url_no);
			return "confirm";
		}
	}

	@PostMapping("/write")
	public String write(HttpServletRequest request, BoardVO bvo, Model model) {
		HttpSession session = request.getSession();
		bvo.setCategory((String) session.getAttribute("category"));
		service.write(bvo);
		model.addAttribute("loginMember", serviceMember.getMember(bvo.getWriter_id()));
		log.info("글씀");
		return "redirect:/board/list";
	}

	@GetMapping("/write")
	public void write(HttpServletRequest request, Model model) {
		HttpSession session = request.getSession();
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
