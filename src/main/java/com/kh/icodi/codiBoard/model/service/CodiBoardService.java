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
import com.kh.icodi.codiBoard.model.dto.CodiBoardExt;
import com.kh.icodi.codiBoard.model.dto.LikeThat;
import com.kh.icodi.member.model.dto.Member;

public class CodiBoardService {
	private CodiBoardDao codiBoardDao = new CodiBoardDao();

	public int getTotalContentNewCodi() {
		Connection conn = getConnection();
		int totalContent = codiBoardDao.getTotalContentNewCodi(conn);
		close(conn);
		return totalContent;
	}

	public List<CodiBoardExt> findCodiBoard(Map<String, Object> param) {
		Connection conn = getConnection();
		List<CodiBoardExt> codiBoardList =  codiBoardDao.findCodiBoard(conn, param);
		close(conn);
		return codiBoardList;
	}

	public LikeThat checkLiked(Map<String, Object> data) {
		Connection conn = getConnection();
		LikeThat liked = codiBoardDao.checkLiked(conn, data);
		close(conn);
		return liked;
	}

	public int deleteLike(Map<String, Object> data) {
		Connection conn = getConnection();
		int likeCount = 0;
		try {
			int result = codiBoardDao.deleteLiked(conn, data);
			likeCount = codiBoardDao.countLiked(conn, data);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return likeCount;
	}

	public int insertLike(Map<String, Object> data) {
		Connection conn = getConnection();
		int likeCount = 0;
		try {
			int result = codiBoardDao.insertLiked(conn, data);
			likeCount = codiBoardDao.countLiked(conn, data);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return likeCount;
	}
	
	
}
