package com.kh.icodi.codiBoard.controller;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.icodi.codiBoard.model.service.CodiBoardService;

/**
 * Servlet implementation class HotCodeListServlet
 */
@WebServlet("/codi/newCodiList")
public class NewCodeListServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CodiBoardService codiBoardService = new CodiBoardService();
	
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		int totalContent = codiBoardService.getTotalContentNewCodi();
		int numPerPage = 5;
		int totalPage = (int)Math.ceil((double)totalContent / numPerPage);
		
		request.setAttribute("totalPage", totalPage);
		request.getRequestDispatcher("/WEB-INF/views/codiBoard/newCodiList.jsp").forward(request, response);
	}
}
