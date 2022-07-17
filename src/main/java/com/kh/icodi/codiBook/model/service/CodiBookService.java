package com.kh.icodi.codiBook.model.service;

import static com.kh.icodi.common.JdbcTemplate.close;
import static com.kh.icodi.common.JdbcTemplate.getConnection;

import java.sql.Connection;
import java.util.List;

import com.kh.icodi.admin.model.dto.ProductAttachment;
import com.kh.icodi.admin.model.dto.ProductExt;
import com.kh.icodi.codiBook.model.dao.CodiBookDao;

public class CodiBookService {
	private CodiBookDao codiBookDao = new CodiBookDao();

	public List<ProductExt> findAllByCategoryNo(int categoryNo) {
		Connection conn = getConnection();
		List<ProductExt> products = codiBookDao.findAllByCategoryNo(conn, categoryNo);
		if(products != null && !products.isEmpty()) {
			for(ProductExt product : products) {
				List<ProductAttachment> attachments = codiBookDao.findAttachmentByProductCode(conn, product.getProductCode());
				product.setAttachmentList(attachments);
			}
		}
		close(conn);
		return products;
	}

	public int insertCodi(String img1, String img2, String img3, String img4) {
		System.out.println("codiservice 도착");
		Connection conn = getConnection();
		int result = 0;
		
		result = codiBookDao.insertCodi(conn, img1, img2, img3, img4);
		
		return result;
	}
}
