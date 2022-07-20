package com.kh.icodi.order.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ProductOrderServlet
 */
@WebServlet("/product/order")
public class ProductOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String productName = request.getParameter("productName");
		String productColor = request.getParameter("productColor");
		String productSize = request.getParameter("productSize");
		//int productCount = Integer.parseInt(request.getParameter("productCount"));
		System.out.println("productName = " + productName);
		System.out.println("productColor = " + productColor);
		System.out.println("productSize = " + productSize);
		//System.out.println("productCount = " + productCount);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
