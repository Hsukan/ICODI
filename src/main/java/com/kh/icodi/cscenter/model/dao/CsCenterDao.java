package com.kh.icodi.cscenter.model.dao;

import static com.kh.icodi.common.JdbcTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.kh.icodi.cscenter.model.dto.CsCenter;
import com.kh.icodi.cscenter.model.dto.CsCenterInquire;
import com.kh.icodi.cscenter.model.dto.SelectType;

public class CsCenterDao {
	
	private Properties prop = new Properties();
	
	public CsCenterDao() {
		String filename = CsCenterDao.class.getResource("/sql/cscenter/cscenter-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	public List<CsCenter> findAll(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<CsCenter> list = new ArrayList<>();
		String sql = prop.getProperty("findAll");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				int noticeNo = rset.getInt("notice_no");
				String noticeTitle = rset.getString("notice_title");
				String noticeContent = rset.getString("notice_content");
				Date noticeDate = rset.getDate("notice_date");
				String noticeWriter = rset.getString("notice_writer");
				CsCenter csCenter = new CsCenter(noticeNo, noticeTitle, noticeContent, noticeDate, noticeWriter);
				list.add(csCenter);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return list;
	}

	public CsCenter findNoticeContentByNo(Connection conn, int noticeNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		CsCenter csCenter = null;
		String sql = prop.getProperty("findNoticeContentByNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, noticeNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				String noticeTitle = rset.getString("notice_title");
				String noticeContent = rset.getString("notice_content");
				Date noticeDate = rset.getDate("notice_date");
				String noticeWriter = rset.getString("notice_writer");
				csCenter = new CsCenter(noticeNo, noticeTitle, noticeContent, noticeDate, noticeWriter);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return csCenter;
	}

	public int insertInquire(Connection conn, CsCenterInquire csCenterInquire) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertInquire");
//		insert into inquire (inquire_no,writer,inquire_title,inquire_content,inquire_date,inquire_type) values (seq_inquire_no.nextval,?,?,?,default,?)
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, csCenterInquire.getMemberId());
			pstmt.setString(2, csCenterInquire.getTitle());
			pstmt.setString(3, csCenterInquire.getContent());
			pstmt.setString(4, csCenterInquire.getSelectType().name());
			
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(pstmt);
		}
		
		return result;
	}

	

	
	public List<CsCenterInquire> findMyInquire(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<CsCenterInquire> list = new ArrayList<>();
		String sql = prop.getProperty("findMyInquire");
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				int no = rset.getInt("inquire_no");
				String memberId = rset.getString("writer");
				String inquireTitle = rset.getString("inquire_title");
				String inquireContent = rset.getString("inquire_content");				
				Date inquireDate = rset.getDate("inquire_date");
				SelectType selectType = SelectType.valueOf(rset.getString("inquire_type"));
				
				
				CsCenterInquire csCenterInquire = new CsCenterInquire(no, memberId, inquireTitle, selectType, inquireContent, inquireDate);
				System.out.println(csCenterInquire.getSelectType());
				list.add(csCenterInquire);
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}

	public CsCenterInquire findInquireContentByNo(Connection conn, int inquireNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		CsCenterInquire  csCenterInquire = null;
		String sql = prop.getProperty("findInquireContentByNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, inquireNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				int no = rset.getInt("inquire_no");
				String memberId = rset.getString("writer");
				String inquireTitle = rset.getString("inquire_title");
				String inquireContent = rset.getString("inquire_content");				
				Date inquireDate = rset.getDate("inquire_date");
				String inquireType = rset.getString("inquire_type");
				
				csCenterInquire = new CsCenterInquire(no, memberId, inquireTitle, null, inquireContent, inquireDate);
				
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}finally {
			close(rset);
			close(pstmt);
		}
		
		return csCenterInquire;
	}

}
