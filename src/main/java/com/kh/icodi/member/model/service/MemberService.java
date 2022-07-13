package com.kh.icodi.member.model.service;

import static com.kh.icodi.common.JdbcTemplate.*;

import java.sql.Connection;
import java.util.List;
import java.util.Map;

import com.kh.icodi.member.model.dao.MemberDao;
import com.kh.icodi.member.model.dto.Member;

public class MemberService {
	private MemberDao memberDao = new MemberDao();
	
	public Member findById(String memberId) {
		Connection conn = getConnection(); // 커넥션 요청
		Member member = memberDao.findById(conn, memberId); // dao 반환
		close(conn);
		return member;
	}
	
	public int insertMember(Member member) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = memberDao.insertMember(conn, member);
			commit(conn);
		}
		catch(Exception e) {
			rollback(conn);
			throw e;
		}
		finally {
			close(conn);
		}
		return result;
	}

	public List<Member> findMemberLike(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Member> list = memberDao.findMemberLike(conn, param);
		close(conn);
		return list;
	}

	public int getTotalContentLike(Map<String, Object> param) {
		Connection conn = getConnection();
		int totalContent = memberDao.getTotalContentLike(conn, param);
		close(conn);
		return totalContent;
	}

	public List<Member> findAll(Map<String, Object> param) {
		Connection conn = getConnection();
		List<Member> list = memberDao.findAll(conn, param);
		close(conn);
		return list;
	}

	public int getTotalContent() {
		Connection conn = getConnection();
		int totalContent = memberDao.getTotalContent(conn);
		close(conn);
		return totalContent;
	}

	public int updateMemberRole(Member member) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = memberDao.updateMemberRole(conn, member);
			commit(conn);
		}
		catch(Exception e) {
			rollback(conn);
			throw e;
		}
		finally {
			close(conn);
		}
		return result;
	}

}
