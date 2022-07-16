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
import com.kh.icodi.myCodi.model.dto.MyCodi;

public class CodiBoardService {
	private CodiBoardDao codiBoardDao = new CodiBoardDao();

	public int getTotalContentNewCodi() {
		Connection conn = getConnection();
		int totalContent = codiBoardDao.getTotalContentNewCodi(conn);
		close(conn);
		return totalContent;
	}

	public List<CodiBoardExt> newCodiMore(Map<String, Object> page) {
		Connection conn = getConnection();
		List<CodiBoardExt> codiBoardList = codiBoardDao.newCodiMore(conn, page);
		if(codiBoardList != null && !codiBoardList.isEmpty()) {
			for(CodiBoardExt codiBoard : codiBoardList) {
				MyCodi myCodi = codiBoardDao.findMyCodiByCodiNo(conn, codiBoard.getCodiNo());
				codiBoard.addMyCodi(myCodi);
				List<LikeThat> likeList = codiBoardDao.findLikeThatByCodiBoardNo(conn, codiBoard.getCodiBoardNo());
				if(likeList != null && !likeList.isEmpty()) {
					for(LikeThat like : likeList) {
						codiBoard.addLike(like);
					}
				}
			}			
		}
		close(conn);
		return codiBoardList;
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
}
