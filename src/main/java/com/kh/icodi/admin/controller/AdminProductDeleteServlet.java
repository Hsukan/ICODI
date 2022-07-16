package com.kh.icodi.admin.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.icodi.admin.model.service.AdminService;

/**
 * Servlet implementation class AdminProductDeleteServlet
 */
@WebServlet("/admin/productDel")
public class AdminProductDeleteServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminService adminService = new AdminService();

	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String[] pdCode = request.getParameterValues("pdCode");
			// 파일 이름 가져오기
			List<> delView = adminService.findAttachmentByProductCode(pdCode);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
