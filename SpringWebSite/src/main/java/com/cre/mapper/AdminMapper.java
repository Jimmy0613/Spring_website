package com.cre.mapper;

import java.util.List;

import com.cre.domain.ReportVO;

public interface AdminMapper {
	public void delReport(ReportVO rvo);

	public List<ReportVO> listReport();
}
