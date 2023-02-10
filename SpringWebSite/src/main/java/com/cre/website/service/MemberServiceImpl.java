package com.cre.website.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.cre.domain.MemberVO;
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
	public void memberJoin(MemberVO mvo, String pwCheck) {
		if (mvo.getEmail().equals("")) {
			mvo.setEmail("미등록");
		}
		if (isId(mvo.getMember_id())) {
			log.info("가입 실패: 중복 아이디");
			return;
		} else if (mvo.getMember_id().length() < 6) {
			log.info("가입 실패: 아이디 글자 수 확인");
			return;
		} else if (mvo.getPassword().length() < 8) {
			log.info("가입 실패: 비밀번호 글자 수 확인");
			return;
		} else if (!mvo.getPassword().equals(pwCheck)) {
			log.info("가입 실패: 비밀번호 불일치");
			return;
		} else if (mvo.getMember_name().length() < 2) {
			log.info("가입 실패: 이름 글자 수 확인");
			return;
		} else if ((!mvo.getEmail().equals("미등록")) && isEmail(mvo.getEmail())) {
			log.info("가입 실패: 중복 이메일");
			return;
		}
		log.info("가입 성공");
		mapper.join(mvo);
	}

	@Override
	public List<MemberVO> memberList() {
		return mapper.memberList();
	}

	@Override
	public MemberVO getMember(String member_id) {
		return mapper.getMember(member_id);
	}

	@Override
	public MemberVO memberLogin(MemberVO mvo) {
		memberList = memberList();
		MemberVO member = null;
		String pw = "";
		if (isId(mvo.getMember_id())) {
			member = getMember(mvo.getMember_id());
			pw = member.getPassword();
		} else {
			log.info("로그인 실패: 존재하지 않는 아이디");
			return member = null;
		}
		if (pw.equals(mvo.getPassword())) {
			log.info("로그인 성공");
			return member;
		} else {
			log.info("로그인 실패: 비밀번호 틀림");
			return member = null;
		}
	}

}
