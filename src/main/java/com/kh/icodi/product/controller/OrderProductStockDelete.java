package com.kh.icodi.product.controller;

import java.io.IOException;
import java.util.Arrays;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.JsonArray;

/**
 * Servlet implementation class OrderProductStockDelete
 */
@WebServlet("/product/deleteStock")
public class OrderProductStockDelete extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String[] productList = request.getParameterValues("productCodeList");
//		String[] _productAmount = request.getParameterValues("productAmountList");
//		System.out.println("productList = " + Arrays.toString(productList));
//		System.out.println("productAmount = " + Arrays.toString(_productAmount));
//		String[] productList = request.getParameterValues("productList");
		System.out.println("productlsit = " + Arrays.toString(productList));
		
	}

}
