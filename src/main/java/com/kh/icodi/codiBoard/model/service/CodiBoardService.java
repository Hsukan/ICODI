package com.kh.icodi.codiBoard.model.service;

import static com.kh.icodi.common.JdbcTemplate.close;
import static com.kh.icodi.common.JdbcTemplate.commit;
import static com.kh.icodi.common.JdbcTemplate.getConnection;
import static com.kh.icodi.common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import com.kh.icodi.codiBoard.model.dao.CodiBoardDao;
import com.kh.icodi.codiBoard.model.dto.CodiBoard;
import com.kh.icodi.codiBoard.model.dto.LikeThat;

public class CodiBoardService {
	private CodiBoardDao codiBoardDao = new CodiBoardDao();

	public int getTotalContentNewCodi() {
		Connection conn = getConnection();
		int totalContent = codiBoardDao.getTotalContentNewCodi(conn);
		close(conn);
		return totalContent;
	}

	public int insertLike(LikeThat likeIt) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = codiBoardDao.insertLike(conn, likeIt);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	public int deleteLike(LikeThat delLike) {
		Connection conn = getConnection();
		int result = 0;
		try {
			int likeNo = codiBoardDao.selectLikeNo(conn, delLike);
			result = codiBoardDao.deleteLike(conn, likeNo);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e; 
		} finally {
			close(conn);
		}
		return result;
	}

	public List<LikeThat> findLikeThatAll() {
		Connection conn = getConnection();
		List<LikeThat> likeList = codiBoardDao.findLikeThatAll(conn);
		close(conn);
		return likeList;
	}

	public List<CodiBoard> findCodiBoardIsOpenY(Map<String, Object> page) {
		Connection conn = getConnection();
		List<CodiBoard> codiBoardList = codiBoardDao.findCodiBoardIsOpenY(conn, page);
		close(conn);
		return codiBoardList;
	}
}
