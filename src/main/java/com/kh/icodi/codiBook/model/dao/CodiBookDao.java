package com.kh.icodi.codiBook.model.dao;

import static com.kh.icodi.common.JdbcTemplate.close;

import java.io.FileReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.Properties;

import com.kh.icodi.admin.model.dto.ProductAttachment;
import com.kh.icodi.admin.model.dto.ProductExt;
import com.kh.icodi.admin.model.dto.ProductSize;
import com.kh.icodi.codiBook.model.exception.CodiBookException;

public class CodiBookDao {
	private Properties prop = new Properties();
	
	public CodiBookDao() {
		String filename = CodiBookDao.class.getResource("/sql/codibook/codibook-query.properties").getPath();
		try {
			prop.load(new FileReader(filename));
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	
	// 상품 가져오기
	// findAllByCategoryNo = select * from product where categoryNo = ?
	public List<ProductExt> findAllByCategoryNo(Connection conn, int categoryNo) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<ProductExt> product = new ArrayList<>();
		String sql = prop.getProperty("findAllByCategoryNo");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, categoryNo);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				product.add(handleProductResultSet(rset));
			}
		} catch (SQLException e) {
			throw new CodiBookException("상품 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return product;
	}
	
	// 첨부파일 조회
	// findAttachment = select * from product_attachment where product_code = ?
	public List<ProductAttachment> findAttachmentByProductCode(Connection conn, String productCode) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<ProductAttachment> attachments = new ArrayList<>();
		String sql = prop.getProperty("findAttachment");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productCode);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				attachments.add(handleProductAttachmentResultSet(rset));
			}
		} catch (SQLException e) {
			throw new CodiBookException("첨부파일 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return attachments;
	}
	
	private ProductAttachment handleProductAttachmentResultSet(ResultSet rset) throws SQLException {
		ProductAttachment attachment = new ProductAttachment();
		attachment.setProductAttachNo(rset.getInt("product_attach_no"));
		attachment.setProductCode(rset.getString("product_code"));
		attachment.setProductOriginalFilename(rset.getString("product_original_filename"));
		attachment.setProductRenamedFilename(rset.getString("product_renamed_filename"));
		attachment.setCodiOriginalFilename(rset.getString("codi_original_filename"));
		attachment.setCodiRenamedFilename(rset.getString("codi_renamed_filename"));
		return attachment;
	}

	private ProductExt handleProductResultSet(ResultSet rset) throws SQLException {
		ProductExt product = new ProductExt();
		product.setProductCode(rset.getString("product_code"));
		product.setCategoryCode(rset.getInt("category_code"));
		product.setProductName(rset.getString("product_name"));
		product.setProductPrice(rset.getInt("product_price"));
		product.setProductRegDate(rset.getTimestamp("product_reg_date"));
		product.setProductStock(rset.getInt("product_stock"));
		product.setProductSize(ProductSize.valueOf(rset.getString("product_size")));
		product.setProductColor(rset.getString("product_color"));
		product.setProductInfo(rset.getString("product_info"));
		product.setProductPluspoint(rset.getDouble("product_pluspoint"));
		return product;
	}
}