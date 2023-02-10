package com.cre.domain;

import lombok.Data;

@Data
public class ReplyVO {
	private Long reply_num;
	private Long post_num;
	private String writer;
	private String writer_id;
	private String content;
	private String reply_date;
}
