package com.cre.website.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cre.domain.ReportVO;
import com.cre.mapper.AdminMapper;

import lombok.Setter;

@Service
public class AdminServiceImpl implements AdminService{
	@Setter(onMethod_ = @Autowired)
	private AdminMapper mapper;
	
	@Override
	public void delReport(ReportVO rvo) {
		mapper.delReport(rvo);
	}

	@Override
	public List<ReportVO> listReport() {
		return mapper.listReport();
	}
}
