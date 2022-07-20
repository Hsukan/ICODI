package com.kh.icodi.product.controller;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ProductAddCartServlet
 */
@WebServlet("/product/addCart")
public class ProductAddCartServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String[] productCode = request.getParameterValues("productCode");
			String[] productCount = request.getParameterValues("productCount");
			System.out.println("productCount = " + Arrays.toString(productCount));
			System.out.println("productCode = " + Arrays.toString(productCode));
			//System.out.println("productCount = " + productCount);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
