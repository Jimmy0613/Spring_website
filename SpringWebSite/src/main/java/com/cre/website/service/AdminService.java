package com.cre.website.service;

import java.util.List;

import com.cre.domain.ReportVO;

public interface AdminService {
	public void delReport(ReportVO rvo);

	public List<ReportVO> listReport();
}
