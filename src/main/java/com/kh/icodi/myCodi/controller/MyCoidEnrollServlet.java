package com.kh.icodi.myCodi.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class MyCoidEnrollServlet
 */
@WebServlet("/mycodi/mycoidEnroll")
public class MyCoidEnrollServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		
		String writer = request.getParameter("memberId");
		String codiArr = request.getParameter("codiArr");
		
		System.out.println("writer = " + writer);
		System.out.println("codiArr = " + codiArr);
	}

}
