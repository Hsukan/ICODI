package com.kh.icodi.admin.model.dao;

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

import com.kh.icodi.admin.model.dto.Product;
import com.kh.icodi.admin.model.dto.ProductAttachment;
import com.kh.icodi.admin.model.dto.ProductExt;
import com.kh.icodi.admin.model.dto.ProductIO;
import com.kh.icodi.admin.model.dto.ProductSize;
import com.kh.icodi.admin.model.exception.AdminException;
import com.kh.icodi.board.model.dto.BoardExt;

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

	// findAttachmentByProductCode = select * from product_attachment where product_code=?
	public List<ProductAttachment> findAttachmentByProductCode(Connection conn, String pdCode) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<ProductAttachment> attachments = new ArrayList<>();
		String sql = prop.getProperty("findAttachmentByProductCode");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, pdCode);
			rset = pstmt.executeQuery();
			while(rset.next())
				attachments.add(handleAttachmentResultSet(rset));
		}
		catch (SQLException e) {
			throw new AdminException("게시글별 첨부파일 조회 오류", e);
		}
		finally {
			close(rset);
			close(pstmt);			
		}
		
		return attachments;
	}

	private ProductAttachment handleAttachmentResultSet(ResultSet rset) throws SQLException {
		ProductAttachment attach = new ProductAttachment();
		attach.setProductAttachNo(rset.getInt("product_attach_no"));
		attach.setProductCode(rset.getString("product_code"));
		attach.setProductOriginalFilename(rset.getString("product_original_filename"));
		attach.setProductRenamedFilename(rset.getString("product_renamed_filename"));
		attach.setCodiOriginalFilename(rset.getString("codi_original_filename")); 
		attach.setCodiRenamedFilename(rset.getString("codi_renamed_filename"));
		return attach;
	}

	// deleteProduct = delete from product where product_code = ?
	public boolean deleteProduct(Connection conn, String[] pdCode) {
		PreparedStatement pstmt = null;
		String sql = prop.getProperty("deleteProduct");
		int count[] = new int[pdCode.length];
		
		
		try {
			pstmt = conn.prepareStatement(sql);

			for(int i = 0; i<pdCode.length; i++) {
				pstmt.setString(1, pdCode[i]);
				pstmt.addBatch();
			}
			count = pstmt.executeBatch();
		}
		catch (SQLException e) {
			throw new AdminException("상품 삭제 오류!", e);
		}
		finally {
			close(pstmt);
		}
		
		boolean result = true;
		
		for(int i = 0; i<count.length; i++) {
			System.out.println("count = " + count[i]);
			if(count[i] == -3) {
				result = false;
				break;
			}
		}
		return result;
	}
	
	// getTotalContentByCategoryNo = select count(*) from product where category_code = ?
	public int getTotalContentByCategoryNo(Connection conn, int categoryNo){
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalContent = 0;
		String sql = prop.getProperty("getTotalContentByCategoryNo");
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, categoryNo);
			rset = pstmt.executeQuery();
			while(rset.next()) 
				totalContent = rset.getInt(1);
			
		} catch (SQLException e) {
			throw new AdminException("상품수 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return totalContent;
	}

	public List<ProductExt> findProductList(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<ProductExt> productList = new ArrayList<>();
		String sql = prop.getProperty("findProductList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, (int)param.get("categoryNo"));
			pstmt.setInt(2, (int)param.get("start"));
			pstmt.setInt(3, (int)param.get("end"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				productList.add(handleProductResultSet(rset));
			}
		} catch (SQLException e) {
			throw new AdminException("상품 조회 실패!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return productList;
	}
	
	// 상품코드로 상품 찾기 (상품상세페이지)
	// findProductByProductName = select * from product where product_name = ?
	public List<ProductExt> findProductByProductName(Connection conn, String productName) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<ProductExt> productList = new ArrayList<>();
		String sql = prop.getProperty("findProductByProductName");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productName);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				productList.add(handleProductResultSet(rset));
			}
		} catch (SQLException e) {
			throw new AdminException("상품상세페이지 조회 오류!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return productList;
	}
	
	private ProductExt handleProductResultSet(ResultSet rset) throws SQLException {
		ProductExt productExt = new ProductExt();
		productExt.setProductCode(rset.getString("product_code"));
		productExt.setCategoryCode(rset.getInt("category_code"));
		productExt.setProductName(rset.getString("product_name"));
		productExt.setProductPrice(rset.getInt("product_price"));
		productExt.setProductRegDate(rset.getTimestamp("product_reg_date"));
		productExt.setProductStock(rset.getInt("product_stock"));
		productExt.setProductSize(ProductSize.valueOf(rset.getString("product_size")));
		productExt.setProductColor(rset.getString("product_color"));
		productExt.setProductInfo(rset.getString("product_info"));
		productExt.setProductPluspoint(rset.getDouble("product_pluspoint"));
		return productExt;
	}

	public List<String> findProductAll(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<String> list = new ArrayList<>();
		String sql = prop.getProperty("findProductAll");
		
		try {
			pstmt = conn.prepareStatement(sql);
			
			rset = pstmt.executeQuery();
			while(rset.next()) {
				list.add(rset.getString("product_name"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		return list;
	}

	public int getTotalContentBySearchKeyword(Connection conn, String searchKeyword) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		int totalContent = 0;
		String sql = prop.getProperty("getTotalContentBySearchKeyword");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + searchKeyword + "%");
			rset = pstmt.executeQuery();
			while(rset.next()) 
				totalContent = rset.getInt(1);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			close(rset);
			close(pstmt);
		}
		
		return totalContent;
	}

	public List<ProductExt> findProductLike(Connection conn, Map<String, Object> param) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<ProductExt> productList = new ArrayList<>();
		String sql = prop.getProperty("findProductLikeList");
		//select p.* from ( select row_number() over (order by product_reg_date) rnum, 
		//p.* from product p where product_name like ?) p where rnum between ? and ?
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "%" + (String) param.get("searchKeyword") + "%");
			pstmt.setInt(2, (int)param.get("start"));
			pstmt.setInt(3, (int)param.get("end"));
			rset = pstmt.executeQuery();
			while(rset.next()) {
				productList.add(handleProductResultSet(rset));
			}
		} catch (SQLException e) {
			throw new AdminException("상품 조회 실패!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return productList;
	}

	public List<ProductAttachment> findAttachmentLike(Connection conn, String productCode) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<ProductAttachment> attachments = new ArrayList<>();
		String sql = prop.getProperty("findAttachmentByProductCode");
		
		try {
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, productCode);
			rset = pstmt.executeQuery();
			while(rset.next())
				attachments.add(handleAttachmentResultSet(rset));
		}
		catch (SQLException e) {
			throw new AdminException("게시글별 첨부파일 조회 오류", e);
		}
		finally {
			close(rset);
			close(pstmt);			
		}
		
		return attachments;
	}

	public List<ProductExt> newProduct(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<ProductExt> productList = new ArrayList<>();
		String sql = prop.getProperty("newProduct");
		
		try {
			pstmt = conn.prepareStatement(sql);

			rset = pstmt.executeQuery();
			while(rset.next()) {
				productList.add(handleProductResultSet(rset));
			}
		} catch (SQLException e) {
			throw new AdminException("상품 조회 실패!", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return productList;
	}

	public List<String> findProductList(Connection conn) {
		PreparedStatement pstmt = null;
		ResultSet rset = null;
		List<String> list = new ArrayList<>();
		String sql = prop.getProperty("findProductList");
		
		try {
			pstmt = conn.prepareStatement(sql);
			rset = pstmt.executeQuery();
			while(rset.next()) {
				list.add(rset.getString("product_code"));
			}
		} catch (SQLException e) {
			throw new AdminException("상품 재고 관리 검색 오류", e);
		} finally {
			close(rset);
			close(pstmt);
		}
		return list;
	}
}
