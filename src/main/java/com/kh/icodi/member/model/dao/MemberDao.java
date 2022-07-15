package com.kh.icodi.member.model.dao;

import static com.kh.icodi.common.JdbcTemplate.*;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Properties;

import com.kh.icodi.member.model.dto.Member;
import com.kh.icodi.member.model.dto.MemberRole;
import com.kh.icodi.member.model.exception.MemberException;

public class MemberDao {
	
	private Properties prop = new Properties();
	
	public MemberDao() {	
		String filename = MemberDao.class.getResource("/sql/member/member-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	
	public Member findById(Connection conn, String memberId) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		Member member = null;
		String sql = prop.getProperty("findById");	
		// select * from member where member_id = ?
	
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, memberId);
			
			rset = pstmt.executeQuery();
			
			while(rset.next()) {
				member = handleMemberResultSet(rset);
			}
			
		} catch (SQLException e) {
			throw new MemberException("회원 아이디 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return member;
	}
	
	private Member handleMemberResultSet(ResultSet rset) throws SQLException {
		String memberId = rset.getString("member_id"); 
		String memberName = rset.getString("member_name"); 
		String password = rset.getString("member_pwd"); 
		String email = rset.getString("member_email"); 
		String phone = rset.getString("member_phone"); 
		Timestamp enrollDate = rset.getTimestamp("member_enroll_date"); 
		MemberRole memberRole = MemberRole.valueOf(rset.getString("member_role")); 
		int point = rset.getInt("member_point"); 
		String address = rset.getString("member_address");
		String addressEx = rset.getString("member_address_extra");
		return new Member(memberId, memberName, password, email, phone, enrollDate, memberRole, point, address, addressEx);
	}
	
	public int insertMember(Connection conn, Member member) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertMember");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getMemberId());
			pstmt.setString(2, member.getMemberName());
			pstmt.setString(3, member.getPassword());
			pstmt.setString(4, member.getEmail());
			pstmt.setString(5, member.getPhone());
			pstmt.setString(6, member.getAddress());
			pstmt.setString(7, member.getAddressEx());
			
			result = pstmt.executeUpdate();
		}
		catch (SQLException e) {
			throw new MemberException("회원가입 오류", e);
		}
		finally {
			close(pstmt);
		}
		return result;
	}


	public String findMemberId(Connection conn, Member member) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String memberId = null;
		String sql = prop.getProperty("findMemberId");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getMemberName());
			pstmt.setString(2, member.getPhone());
			
			rset = pstmt.executeQuery();
			if(rset.next()) {
				memberId = rset.getString("member_id"); 				
			}
		} catch (SQLException e) {
			throw new MemberException ("회원 이름 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return memberId;
	}


	public String findMemberPw(Connection conn, Member member) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		String memberPw = null;
		String sql = prop.getProperty("findMemberPw");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, member.getMemberId());
			pstmt.setString(2, member.getPhone());
			
			rset = pstmt.executeQuery();
			if(rset.next()) {
				memberPw = rset.getString("member_pwd");
			}
		} catch (SQLException e) {
			throw new MemberException ("회원 비밀번호 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return memberPw;
	}

	// updateMemberPw = update member set member_pwd = ? where member_id = ?
	public int updateMemberPw(Connection conn, Member member, String newPwd) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("updateMemberPw");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, newPwd);
			pstmt.setString(2, member.getMemberId());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new MemberException("비밀번호 입시 발급 오류!", e);
		} finally {
			close(pstmt);
		}
		return result;
	}

}
