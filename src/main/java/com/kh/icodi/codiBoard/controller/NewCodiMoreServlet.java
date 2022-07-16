package com.kh.icodi.codiBoard.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.google.gson.Gson;
import com.kh.icodi.codiBoard.model.dto.CodiBoardExt;
import com.kh.icodi.codiBoard.model.dto.LikeThat;
import com.kh.icodi.codiBoard.model.service.CodiBoardService;

/**
 * Servlet implementation class HotCodiMoreServlet
 */
@WebServlet("/codi/newCodiMore")
public class NewCodiMoreServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private CodiBoardService codiBoardService = new CodiBoardService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			int cPage = Integer.parseInt(request.getParameter("cPage"));
			int numPerPage = 5;
			int start = (cPage - 1) * numPerPage + 1;
			int end = cPage * numPerPage;
			
			Map<String, Object> page = new HashMap<>();
			page.put("start", start);
			page.put("end", end);
			
			List<CodiBoardExt> codiBoardList = codiBoardService.newCodiMore(page);

			response.setContentType("application/json; charset=utf-8");
			new Gson().toJson(codiBoardList, response.getWriter());
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
