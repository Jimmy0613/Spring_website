package com.cre.website;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.cre.domain.BoardVO;
import com.cre.domain.PageVO;
import com.cre.service.BoardService;

import lombok.AllArgsConstructor;
import lombok.extern.log4j.Log4j;

@Log4j
@RequestMapping("/board/*")
@AllArgsConstructor
@Controller
public class BoardController {
	private BoardService service;

	@GetMapping("/list")
	public void list(@RequestParam(value="currentPage",defaultValue="1") int currentPage, Model model) {
		model.addAttribute("currentPage", currentPage);
		model.addAttribute("page", service.page());
		log.info("페이지 계산함");
		int startIndex = (currentPage - 1) * PageVO.PER_PAGE;
		model.addAttribute("list", service.list(startIndex));
		log.info("글 목록 가져옴");
	}

	@GetMapping({"/read","/edit"})
	public void read(@RequestParam("post_num") Long post_num, Model model) {
		log.info("글 가져옴");
		model.addAttribute("read", service.read(post_num));
	}

	@GetMapping("/delete")
	public String delete(@RequestParam("post_num") Long post_num) {
		log.info("삭제함");
		service.delete(post_num);
		return "redirect:/board/list";
	}

	@PostMapping("/write")
	public String write(BoardVO bvo) {
		log.info("글씀");
		service.write(bvo);
		return "redirect:/board/list";
	}

	@GetMapping("/write")
	public void write() {
		log.info("글쓰기");
	}

	@PostMapping("/edit")
	public String edit(@RequestParam("post_num") Long post_num, BoardVO bvo) {
		log.info("수정함");
		service.edit(bvo);
		return "redirect:/board/read?post_num=" + post_num;
	}
	
}
