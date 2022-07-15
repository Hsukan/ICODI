package com.kh.icodi.codiBoard.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.icodi.codiBoard.model.dto.LikeThat;
import com.kh.icodi.codiBoard.model.dto.LikeThat;
import com.kh.icodi.codiBoard.model.service.CodiBoardService;

/**
 * Servlet implementation class LikeThatServlet
 */
@WebServlet("/codiBoard/likeInsert")
public class LikeInsertServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CodiBoardService codiBoardService = new CodiBoardService();
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String memberId = request.getParameter("memberId");
			int codiBoardNo = Integer.parseInt(request.getParameter("codiBoardNo"));
			System.out.println("memberId = " + memberId);
			LikeThat likeIt = new LikeThat(0, memberId, codiBoardNo);
			
			int result = codiBoardService.insertLike(likeIt); 
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}
}
