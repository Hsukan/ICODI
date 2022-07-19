package com.kh.icodi.codiBook.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class CreateServlet
 */
@WebServlet("/create/canvas")
public class CreateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		String imgSrc = request.getParameter("imgSrc");
		String memberId = request.getParameter("memberId");
		String codiArr = request.getParameter("codiArr");
		String content = request.getParameter("content");
		String isOpen = request.getParameter("isOpen");
		System.out.println("imgSrc = " + imgSrc);
		System.out.println("memberId = " + memberId);
		System.out.println("codiArr = " + codiArr);
		System.out.println("content = " + content);
		System.out.println("isOpen = " + isOpen);
	}

}
