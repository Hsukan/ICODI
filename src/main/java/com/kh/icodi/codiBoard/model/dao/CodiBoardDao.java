package com.kh.icodi.codiBoard.model.dao;

import static com.kh.icodi.common.JdbcTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Properties;

import com.kh.icodi.codiBoard.model.dto.CodiBoard;
import com.kh.icodi.codiBoard.model.dto.CodiBoardExt;
import com.kh.icodi.codiBoard.model.dto.LikeThat;
import com.kh.icodi.codiBoard.model.exception.CodiBoardException;
import com.kh.icodi.myCodi.model.dto.MyCodi;

public class CodiBoardDao {
	private Properties prop = new Properties();
	
	public CodiBoardDao() {
		String filename = CodiBoardDao.class.getResource("/sql/codiboard/codiboard-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// 최신 코디 조회
	// getTotalContentHotCodi = select count(*) from my_codi
	public int getTotalContentNewCodi(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalContent = 0;
		String sql = prop.getProperty("getTotalContentNewCodi");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			if(rset.next()) {
				totalContent = rset.getInt(1);
			}
		} catch (SQLException e) {
			throw new CodiBoardException("최신 코디게시판 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return totalContent;
	}
	
	// 최신 코디 더보기
	// newCodiMore = select * from ( select row_number() over (order by codi_no desc) rnum, c.* from my_codi c) c where rnum between ? and ?
	public List<CodiBoardExt> newCodiMore(Connection conn, Map<String, Object> page) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<CodiBoardExt> codiBoardList = new ArrayList<>();
		String sql = prop.getProperty("newCodiMore");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int) page.get("start"));
			pstmt.setInt(2, (int) page.get("end"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				codiBoardList.add(handleCodiBoardResultSet(rset));
			}
		} catch (SQLException e) {
			throw new CodiBoardException("최신 코디 더보기 조회 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return codiBoardList;
	}
	
	// 코디번호에 맞는 첨부파일 가져오기
	// findMyCodiByCodiNo = select * from my_codi where codi_no = ?
	public MyCodi findMyCodiByCodiNo(Connection conn, int codiNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		MyCodi myCodi = null;
		String sql = prop.getProperty("findMyCodiByCodiNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, codiNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				myCodi = handleMyCodiResultSet(rset);
			}
		} catch (SQLException e) {
			throw new CodiBoardException("내 코디 첨부파일 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return myCodi;
	}
	
	// 좋아요 추가하기
	// insertLike = insert into likeThat values (?, ?, seq_like_no.nextval)
	public int insertLike(Connection conn, LikeThat likeIt) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertLike");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, likeIt.getMemberId());
			pstmt.setInt(2, likeIt.getCodiBoardNo());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new CodiBoardException("좋아요 추가하기 오류!", e);
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	// 좋아요 번호 조회
	// select like_no from likeThat where codi_board_no = ? and member_id = ?
	public int selectLikeNo(Connection conn, LikeThat delLike) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int delLikeNo = 0;
		String sql = prop.getProperty("selectLikeNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, delLike.getCodiBoardNo());
			pstmt.setString(2, delLike.getMemberId());
			rset = pstmt.executeQuery();
			if(rset.next()) {
				delLikeNo = rset.getInt(1);
			}
		} catch (SQLException e) {
			throw new CodiBoardException("좋아요 번호 조회", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return delLikeNo;
	}
	
	// 좋아요 삭제하기
	// deleteLike = delete from likeThat where like_no ?
	public int deleteLike(Connection conn, int likeNo) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("deleteLike");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, likeNo);
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return 0;
	}
	private MyCodi handleMyCodiResultSet(ResultSet rset) throws SQLException {
		MyCodi myCodi = new MyCodi();
		myCodi.setCodiNo(rset.getInt("codi_no"));
		myCodi.setMemberId(rset.getString("member_id"));
		myCodi.setMyCodiFilename(rset.getString("my_codi_filename"));
		myCodi.setMyCodiRegDate(rset.getDate("my_codi_reg_date"));
		return myCodi;
	}

	private CodiBoardExt handleCodiBoardResultSet(ResultSet rset) throws SQLException {
		CodiBoardExt codiBoard = new CodiBoardExt();
		codiBoard.setCodiBoardNo(rset.getInt("codi_board_no"));
		codiBoard.setCodiNo(rset.getInt("codi_no"));
		codiBoard.setCodiBoardContent(rset.getString("codi_board_content"));
		codiBoard.setCodiBoardRegDate(rset.getDate("codi_board_reg_date"));
		codiBoard.setLikeCount(rset.getInt("like_count"));
		return codiBoard;
	}
}
