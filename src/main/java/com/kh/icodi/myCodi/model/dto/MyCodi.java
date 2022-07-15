package com.kh.icodi.myCodi.model.dto;

import java.util.Date;

public class MyCodi {
	private int codiNo;
	private String memberId;
	private String myCodiFilename;
	private Date myCodiRegDate;
	
	public MyCodi() {
		super();
		// TODO Auto-generated constructor stub
	}

	public MyCodi(int codiNo, String memberId, String myCodiFilename, Date myCodiRegDate) {
		super();
		this.codiNo = codiNo;
		this.memberId = memberId;
		this.myCodiFilename = myCodiFilename;
		this.myCodiRegDate = myCodiRegDate;
	}

	public int getCodiNo() {
		return codiNo;
	}

	public void setCodiNo(int codiNo) {
		this.codiNo = codiNo;
	}

	public String getMemberId() {
		return memberId;
	}

	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}

	public String getMyCodiFilename() {
		return myCodiFilename;
	}

	public void setMyCodiFilename(String myCodiFilename) {
		this.myCodiFilename = myCodiFilename;
	}

	public Date getMyCodiRegDate() {
		return myCodiRegDate;
	}

	public void setMyCodiRegDate(Date myCodiRegDate) {
		this.myCodiRegDate = myCodiRegDate;
	}

	@Override
	public String toString() {
		return "MyCodi [codiNo=" + codiNo + ", memberId=" + memberId + ", myCodiFilename=" + myCodiFilename
				+ ", myCodiRegDate=" + myCodiRegDate + "]";
	}
}
