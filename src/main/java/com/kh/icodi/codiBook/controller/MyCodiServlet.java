package com.kh.icodi.codiBook.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.icodi.codiBook.model.service.CodiBookService;

/**
 * Servlet implementation class MyCodiServlet
 */
@WebServlet("/codi/myCodi")
public class MyCodiServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CodiBookService codiBookService = new CodiBookService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String writer = request.getParameter("memberId");
		System.out.println("writer@myCodiServlet = " + writer);
		
		List<String> imgSrc = codiBookService.find1(writer);
		System.out.println("imgSrc = " + imgSrc);
		
		request.setAttribute("imgSrc", imgSrc);
		request.getRequestDispatcher("/WEB-INF/views/codiBook/myCodi.jsp").forward(request, response);
	}

}
