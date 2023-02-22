package com.cre.website;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.SessionAttributes;

import com.cre.domain.ReportVO;
import com.cre.website.service.AdminService;

import lombok.AllArgsConstructor;

@RequestMapping("/admin/*")
@SessionAttributes({ "loginMember" })
@AllArgsConstructor
@Controller
public class AdminController {
	private AdminService service;

	@GetMapping("/report")
	public void report(Model model) {
		model.addAttribute("list", service.listReport());
	}

	@GetMapping("/delReport")
	public String report(ReportVO rvo) {
		service.delReport(rvo);
		return "redirect:/admin/report";
	}

}
