package com.cre.domain;

import java.util.List;

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

	public String getInfo() {
		String info = "🙂 " + this.member_id + "(" + this.member_name + ") 님";
		return info;
	}
	public String login(List<MemberVO> memberList, MemberVO mvo) {
		String loginAlert = "";
		if(isId(memberList, mvo.getMember_id())) {
			if(pwCheck(memberList, mvo.getMember_id(), mvo.getPassword())) {
				return loginAlert;
			} else {
				return loginAlert = "비밀번호 틀림";
			}
		} else {
			return loginAlert = "아이디 없음";
		}
	}

	public boolean isId(List<MemberVO> memberList, String member_id) {
		boolean isId = false;
		for (MemberVO mvo : memberList) {
			if (mvo.getMember_id().equals(member_id)) {
				return isId = true;
			}
		}
		return isId;
	}
	
	public boolean pwCheck(List<MemberVO> memberList, String member_id, String password) {
		boolean pwCheck = false;
		for (MemberVO mvo: memberList) {
			if(mvo.getMember_id().equals(member_id)) {
				if(mvo.getPassword().equals(password)) {
					return pwCheck = true;
				} else {
					return pwCheck;
				}
			}
		}
		return pwCheck;
	}
}
