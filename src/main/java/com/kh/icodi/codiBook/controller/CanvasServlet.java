package com.kh.icodi.codiBook.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.icodi.codiBook.model.service.CodiBookService;

/**
 * Servlet implementation class CanvasServlet
 */
@WebServlet("/canvas")
public class CanvasServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
     
	private CodiBookService codiBookService = new CodiBookService();


	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String imgSrc = request.getParameter("imgSrc");
			String writer = request.getParameter("memberId");
			String codiArr = request.getParameter("codiArr");
			
			//System.out.println("writer@canvas = " + writer);
			//System.out.println("codiArr@canvas = " + codiArr);
			//System.out.println("imgSrc = " + imgSrc);
			
			long length = imgSrc.length();
			System.out.println("imgSrc length = " + length);
			
			int middle = (int) length / 2;
			System.out.println("middle = " + middle);
			
			String image1 = imgSrc.substring(0, middle);
			String image2 = imgSrc.substring(middle);

			int middle1 = image1.length() / 2;
			int middle2 = image2.length() / 2;
//			System.out.println("middle1 = " + middle1);
//			System.out.println("middle2 = " + middle2);
			
			String img1 = image1.substring(0, middle1);
			String img2 = image1.substring(middle1);
			String img3 = image2.substring(0, middle2);
			String img4 = image2.substring(middle2);
			
//			System.out.println("img1 = " + img1);
//			System.out.println("img2 = " + img2);
//			System.out.println("img3 = " + img3);
//			System.out.println("img4 = " + img4);
			
			Map<String, Object> param = new HashMap<>();
			param.put("img1", img1);
			param.put("img2", img2);
			param.put("img3", img3);
			param.put("img4", img4);
			int result = codiBookService.insertCodi(writer, codiArr, param);
			
//			request.setAttribute("imgSrc", imgSrc);
//			request.getRequestDispatcher("/WEB-INF/views/codiBook/codi.jsp")
//			.forward(request, response);
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
