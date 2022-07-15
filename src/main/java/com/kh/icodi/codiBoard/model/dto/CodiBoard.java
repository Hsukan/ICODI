package com.kh.icodi.codiBoard.model.dto;

import java.util.Date;

public class CodiBoard {
	private int codiBoardNo;
	private int codiNo;
	private String codiBoardContent;
	private Date codiBoardRegDate;
	private int likeCount;
	
	public CodiBoard() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CodiBoard(int codiBoardNo, int codiNo, String codiBoardContent, Date codiBoardRegDate, int likeCount) {
		super();
		this.codiBoardNo = codiBoardNo;
		this.codiNo = codiNo;
		this.codiBoardContent = codiBoardContent;
		this.codiBoardRegDate = codiBoardRegDate;
		this.likeCount = likeCount;
	}

	public int getCodiBoardNo() {
		return codiBoardNo;
	}

	public void setCodiBoardNo(int codiBoardNo) {
		this.codiBoardNo = codiBoardNo;
	}

	public int getCodiNo() {
		return codiNo;
	}

	public void setCodiNo(int codiNo) {
		this.codiNo = codiNo;
	}

	public String getCodiBoardContent() {
		return codiBoardContent;
	}

	public void setCodiBoardContent(String codiBoardContent) {
		this.codiBoardContent = codiBoardContent;
	}

	public Date getCodiBoardRegDate() {
		return codiBoardRegDate;
	}

	public void setCodiBoardRegDate(Date codiBoardRegDate) {
		this.codiBoardRegDate = codiBoardRegDate;
	}

	public int getLikeCount() {
		return likeCount;
	}

	public void setLikeCount(int likeCount) {
		this.likeCount = likeCount;
	}

	@Override
	public String toString() {
		return "CodiBoard [codiBoardNo=" + codiBoardNo + ", codiNo=" + codiNo + ", codiBoardContent=" + codiBoardContent
				+ ", codiBoardRegDate=" + codiBoardRegDate + ", likeCount=" + likeCount + "]";
	}
}
