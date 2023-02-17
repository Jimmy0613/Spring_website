package com.cre.domain;

import lombok.Data;

@Data
public class ReportVO {
	private Long post_num;
	private Long report_num;
	private String reporter_id;
	private String reported_user;
	private String reason;
	private String content;
	private String report_date;
	private String proc;
}
