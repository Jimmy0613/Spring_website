package com.cre.website.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cre.domain.BoardVO;
import com.cre.domain.MemberVO;
import com.cre.domain.PageVO;
import com.cre.domain.ReplyVO;
import com.cre.mapper.MemberMapper;

import lombok.Setter;
import lombok.extern.log4j.Log4j;

@Log4j
@Service
//@AllArgsConstructor
public class MemberServiceImpl implements MemberService {

	@Setter(onMethod_ = @Autowired)
	private MemberMapper mapper;
	List<MemberVO> memberList;

	boolean isId(String id) {
		memberList = memberList();
		for (MemberVO m : memberList) {
			if (m.getMember_id().equals(id)) {
				return true;
			}
		}
		return false;
	}

	boolean isEmail(String email) {
		memberList = memberList();
		for (MemberVO m : memberList) {
			if (m.getEmail().equals(email)) {
				return true;
			}
		}
		return false;
	}

	@Override
	public MemberVO getMember(String member_id) {
		return mapper.getMember(member_id);
	}

	@Override
	public int idCheck(String member_id) {
		return mapper.idCheck(member_id);
	}

	@Override
	public void memberJoin(MemberVO mvo) {
		if (mvo.getEmail().equals("")) {
			mvo.setEmail("미등록");
		}
		mapper.join(mvo);
		return;
	}

	@Override
	public List<MemberVO> memberList() {
		return mapper.memberList();
	}

	@Override
	public List<BoardVO> myPost(String member_id, int startIndex) {
		return mapper.myPost(member_id, startIndex);
	}

	@Override
	public List<ReplyVO> myReply(String member_id, int startIndex) {
		return mapper.myReply(member_id, startIndex);
	}

	@Override
	public void myEmail(MemberVO mvo) {
		mapper.myEmail(mvo);
	}

	@Override
	public PageVO page(String member_id, String table) {
		return mapper.page(member_id, table);
	}

	@Override
	public String memberLogin(MemberVO mvo) {
		memberList = memberList();
		MemberVO member = null;
		String alert = "";
		String pw = "";
		if (isId(mvo.getMember_id())) {
			member = getMember(mvo.getMember_id());
			pw = member.getPassword();
		} else {
			log.info("로그인 실패: 존재하지 않는 아이디");
			return alert = "존재하지 않는 아이디입니다.";
		}
		if (pw.equals(mvo.getPassword())) {
			log.info("로그인 성공");
			return alert;
		} else {
			log.info("로그인 실패: 비밀번호 틀림");
			return alert = "비밀번호가 일치하지 않습니다.";
		}
	}

	@Override
	public int getTodayCount(String today, String member_id) {
		return mapper.rpsCount(today, member_id);
	}

	@Override
	public void rps(String member_id, String result) {
		mapper.rps(member_id, result);
	}
}
