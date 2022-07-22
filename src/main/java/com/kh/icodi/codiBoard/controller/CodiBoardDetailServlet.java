package com.kh.icodi.codiBoard.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.icodi.admin.model.dto.ProductExt;
import com.kh.icodi.admin.model.service.AdminService;

/**
 * Servlet implementation class CodiBoardDetailServlet
 */
@WebServlet("/codiBoard/codiDetail")
public class CodiBoardDetailServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private AdminService adminService = new AdminService();

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String useProduct = request.getParameter("useProduct");
		//System.out.println("useProduct@detail = " + useProduct);
		String codiBoardNo = request.getParameter("codiBoardNo");
		//System.out.println("codiBoardNo@detail = " + codiBoardNo);
		int likeCount = Integer.parseInt(request.getParameter("likeCount"));
		System.out.println("likeCount@detail = " + likeCount);
		
		
		String codiImg = adminService.getCodiImg(codiBoardNo);
		//System.out.println("codiImg = " + codiImg.length());

		List<ArrayList<ProductExt>> list = new ArrayList<ArrayList<ProductExt>>();
		String arr[] = useProduct.split(", ");
		//System.out.println("useProductArr = " + Arrays.toString(arr));
		
		for(String product : arr) {
			int underBar = product.indexOf("_");
			String productName = product.substring(0, underBar);
			List<ProductExt> productList = adminService.findProductByProductName(productName);
			//System.out.println("productList =" + productList);
			list.add((ArrayList<ProductExt>) productList);
		}
		//System.out.println("list = " + list);
		
		request.setAttribute("list", list);
		request.setAttribute("codiImg", codiImg);
		request.setAttribute("likeCount", likeCount);
		request.getRequestDispatcher("/WEB-INF/views/codiBoard/codiDetail.jsp").forward(request, response);
	}
}
