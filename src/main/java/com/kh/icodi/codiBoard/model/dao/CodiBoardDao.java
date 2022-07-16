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
import com.kh.icodi.codiBoard.model.dto.LikeThat;
import com.kh.icodi.codiBoard.model.exception.CodiBoardException;

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
	// getTotalContentNewCodi = select count(*) from codi_board
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
	// selectLikeNo = select like_no from likeThat where codi_board_no = ? and member_id = ?
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
			throw new CodiBoardException("좋아요 번호 조회 오류!", e);
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
			throw new CodiBoardException("좋아요 삭제하기 오류!", e);
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	// 좋아요 테이블 조회
	// findLikeThatAll = select * from likeThat order by like_no
	public List<LikeThat> findLikeThatAll(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<LikeThat> likeList = new ArrayList<>();
		String sql = prop.getProperty("findLikeThatAll");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				likeList.add(handleLikeThatResultSet(rset));
			}
		} catch (SQLException e) {
			throw new CodiBoardException("좋아요 테이블 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return likeList;
	}
	
	private LikeThat handleLikeThatResultSet(ResultSet rset) throws SQLException {
		LikeThat likeThat = new LikeThat();
		likeThat.setMemberId(rset.getString("member_id"));
		likeThat.setCodiBoardNo(rset.getInt("codi_board_no"));
		likeThat.setLikeNo(rset.getInt("like_no"));
		return likeThat;
	}
	
	// 좋아요 조회
	// findLikeThatByCodiBoardNo = select * from likeThat where codi_board_no = ?
	public List<LikeThat> findLikeThatByCodiBoardNo(Connection conn, int codiBoardNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<LikeThat> likeList = new ArrayList<>();
		String sql = prop.getProperty("findLikeThatByCodiBoardNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, codiBoardNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				likeList.add(handleLikeThatResultSet(rset));
			}
		} catch (SQLException e) {
			throw new CodiBoardException("좋아요 테이블 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return likeList;
	}
	
	// 코디 게시판 조회 (is_open Y)
	// findCodiBoardIsOpenY = select * from ( select row_number () over (order by reg_date desc) rnum, b.* from codi_board b where is_open = 'Y') b where rnum between ? and ?
	public List<CodiBoard> findCodiBoardIsOpenY(Connection conn, Map<String, Object> page) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<CodiBoard> codiBoardList = new ArrayList<>();
		String sql = prop.getProperty("findCodiBoardIsOpenY");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int)page.get("start"));
			pstmt.setInt(2, (int)page.get("end"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				codiBoardList.add(handleCodiBoardResultSet(rset));
			}
		} catch (SQLException e) {
			throw new CodiBoardException("최신 코디 게시판 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return codiBoardList;
	}

	private CodiBoard handleCodiBoardResultSet(ResultSet rset) throws SQLException {
		CodiBoard codiBoard = new CodiBoard();
		codiBoard.setCodiBoardNo(rset.getInt("codi_board_no"));
		codiBoard.setMemberId(rset.getString("member_id"));
		codiBoard.setCodiBoardContent(rset.getString("codi_board_content"));
		codiBoard.setLikeCount(rset.getInt("like_count"));
		codiBoard.setCodiFilename(rset.getBlob("codi_filename"));
		codiBoard.setIsOpen(rset.getString("is_open"));
		codiBoard.setUseProduct(rset.getString("use_product"));
		codiBoard.setRegDate(rset.getDate("reg_date"));
		return codiBoard;
	}
}
