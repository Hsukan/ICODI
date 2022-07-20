package com.kh.icodi.product.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.icodi.member.model.dto.Member;
import com.kh.icodi.member.model.service.MemberService;

/**
 * Servlet implementation class ProductOrderServlet
 */
@WebServlet("/product/order")
public class ProductOrderServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();
	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			String[] productCode = request.getParameterValues("productCode");
			String[] _productCount = request.getParameterValues("productCount");
			int[] productCount = new int[_productCount.length];
			Member loginMember = (Member)request.getSession().getAttribute("loginMember");
			String memberId = loginMember.getMemberId();
			int cartNo = 0;

			for(int i = 0; i < _productCount.length; i++) {
				productCount[i] = Integer.parseInt(_productCount[i]);
			}
			
			for(int i = 0; i < productCode.length; i++) {
				Map<String, Object> data = new HashMap<>();	
				data.put("productCode", productCode[i]);
				data.put("productCount", productCount[i]);
				data.put("memberId", memberId);
				cartNo = memberService.insertCart(data);
			}
			
		} catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
