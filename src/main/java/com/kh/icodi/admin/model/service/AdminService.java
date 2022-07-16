package com.kh.icodi.admin.model.service;

import static com.kh.icodi.common.JdbcTemplate.close;
import static com.kh.icodi.common.JdbcTemplate.commit;
import static com.kh.icodi.common.JdbcTemplate.getConnection;
import static com.kh.icodi.common.JdbcTemplate.rollback;

import java.sql.Connection;
import java.util.List;

import com.kh.icodi.admin.model.dao.AdminDao;
import com.kh.icodi.admin.model.dto.Product;
import com.kh.icodi.admin.model.dto.ProductAttachment;
import com.kh.icodi.admin.model.dto.ProductExt;
import com.kh.icodi.admin.model.dto.ProductIO;

public class AdminService {
	private AdminDao adminDao = new AdminDao();

	// 상품등록
	public int insertProduct(Product product) {
		Connection conn = getConnection();
		int result = 0;
		try {
			// 상품 테이블 insert
			result = adminDao.insertProduct(conn, product);
			
			// 첨부파일 테이블 insert
			List<ProductAttachment> attachments = ((ProductExt)product).getAttachmentList();
			if(attachments != null && !attachments.isEmpty()) {
				for(ProductAttachment attach : attachments) {
					attach.setProductCode(product.getProductCode());
					result = adminDao.insertAttachment(conn, attach);
				}
			}
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}
	
	// 상품 입출고 관리
	public int insertIO(ProductIO productIo) {
		Connection conn = getConnection();
		int result = 0;
		try {
			result = adminDao.insertIO(conn, productIo);
			commit(conn);
		} catch(Exception e) {
			rollback(conn);
			throw e;
		} finally {
			close(conn);
		}
		return result;
	}

	
}
