package com.kh.icodi.admin.model.dao;

import static com.kh.icodi.common.JdbcTemplate.*;
import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.Properties;

import com.kh.icodi.admin.model.dto.Product;
import com.kh.icodi.admin.model.dto.ProductAttachment;
import com.kh.icodi.admin.model.dto.ProductIO;
import com.kh.icodi.admin.model.exception.AdminException;

public class AdminDao {
	private Properties prop = new Properties();
	
	public AdminDao() {
		String filename = AdminDao.class.getResource("/sql/admin/admin-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// insertProduct = insert into product 
	// (product_code, category_code, product_name, product_price, product_size, product_color, product_info) values(?, ?, ?, ?, ?, ?, ?)
	public int insertProduct(Connection conn, Product product) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertProduct");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, product.getProductCode());
			pstmt.setInt(2, product.getCategoryCode());
			pstmt.setString(3, product.getProductName());
			pstmt.setInt(4, product.getProductPrice());
			pstmt.setString(5, product.getProductSize().name());
			pstmt.setString(6, product.getProductColor());
			pstmt.setString(7, product.getProductInfo());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new AdminException("상품 등록 오류!", e);
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	// 상품 입출고 관리
	// insertIO = insert into product_io values (seq_product_io_no.nextval, ?, ?, ?)
	public int insertIO(Connection conn, ProductIO productIo) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertIO");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productIo.getProductCode());
			pstmt.setString(2, productIo.getIoStatus());
			pstmt.setInt(3, productIo.getIoCount());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new AdminException("상품 입출고 관리 오류!", e);
		} finally {
			close(pstmt);
		}
		return result;
	}
	
	// 상품 이미지 추가
	// insert into product_attachment values (seq_product_attachment_no.nextval, ?, ?, ?, ?, ?)
	public int insertAttachment(Connection conn, ProductAttachment attach) {
		PreparedStatement pstmt = null;
		int result = 0;
		String sql = prop.getProperty("insertAttachment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, attach.getProductCode());
			pstmt.setString(2, attach.getProductOriginalFilename());
			pstmt.setString(3, attach.getProductRenamedFilename());
			pstmt.setString(4, attach.getCodiOriginalFilename());
			pstmt.setString(5, attach.getCodiRenamedFilename());
			result = pstmt.executeUpdate();
		} catch (SQLException e) {
			throw new AdminException("상품 첨부파일 등록 오류!", e);
		} finally {
			close(pstmt);
		}
		return result;
	}
}
