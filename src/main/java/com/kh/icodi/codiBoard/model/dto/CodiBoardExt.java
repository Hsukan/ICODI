package com.kh.icodi.codiBoard.model.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.kh.icodi.myCodi.model.dto.MyCodi;

public class CodiBoardExt extends CodiBoard{
	private List<MyCodi> myCodiList = new ArrayList<>();

	public CodiBoardExt() {
		super();
		// TODO Auto-generated constructor stub
	}

	public CodiBoardExt(int codiBoardNo, int codiNo, String codiBoardContent, Date codiBoardRegDate, int likeCount) {
		super(codiBoardNo, codiNo, codiBoardContent, codiBoardRegDate, likeCount);
		// TODO Auto-generated constructor stub
	}

	public List<MyCodi> getMyCodiList() {
		return myCodiList;
	}

	public void setMyCodiList(List<MyCodi> myCodiList) {
		this.myCodiList = myCodiList;
	}
	
	public void addMyCodi(MyCodi myCodi) {
		this.myCodiList.add(myCodi);
	}
	
	@Override
	public String toString() {
		return "CodiBoardExt [myCodiList=" + myCodiList + ", toString()=" + super.toString() + "]";
	}
}
