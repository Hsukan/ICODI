package com.kh.icodi.member.controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.kh.icodi.common.IcodiMvcUtils;
import com.kh.icodi.member.model.dto.Member;
import com.kh.icodi.member.model.service.MemberService;

/**
 * Servlet implementation class memberPasswordUpdateServlet
 */
@WebServlet("/member/memberPasswordUpdate")
public class memberPasswordUpdateServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private MemberService memberService = new MemberService();   

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.getRequestDispatcher("/WEB-INF/views/member/memberPasswordUpdate.jsp")
			.forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		try {
			request.setCharacterEncoding("utf-8");
			
			String memberId = request.getParameter("memberId");
			String oldPassword = IcodiMvcUtils.getEncryptedPassword(request.getParameter("oldPassword"), memberId);
			String newPassword = IcodiMvcUtils.getEncryptedPassword(request.getParameter("newPassword"), memberId);
			
			Member member = memberService.findById(memberId);
			
			String msg = null;
			String location = request.getContextPath();
			if(member != null && oldPassword.equals(member.getPassword())) {
				int result = memberService.updatePassword(memberId, newPassword);
				
				msg = "비밀번호를 성공적으로 변경했습니다.";
				location += "/member/memberMyPage";
			}
			else {
				msg = "기존 비밀번호가 일치하지 않습니다.";
				location += "/member/memberPasswordUpdate";
				
				Member loginMember = (Member) request.getSession().getAttribute("loginMember");
				loginMember.setPassword(newPassword);
			}
			
			request.getSession().setAttribute("msg", msg);
			response.sendRedirect(location);
		}
		catch(Exception e) {
			e.printStackTrace();
			throw e;
		}
	}

}
