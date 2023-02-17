package com.cre.domain;

import lombok.Data;

@Data
public class MemberVO {
	private String member_id;
	private String password;
	private String member_name;
	private String email;
	private String join_date;
	private Long post_count;
	private Long reply_count;
	private Long heart_count;
	private String character1;
	private String character2;

	public String info() {
		String info;
		return info = "🙂 " + member_id + "(" + member_name + ") 님";
	}
}
