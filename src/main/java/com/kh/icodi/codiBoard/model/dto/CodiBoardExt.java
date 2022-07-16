package com.kh.icodi.codiBoard.model.dto;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import com.kh.icodi.myCodi.model.dto.MyCodi;

public class CodiBoardExt extends CodiBoard{
	private List<MyCodi> myCodiList = new ArrayList<>();
	private List<LikeThat> likeList = new ArrayList<>();

	public CodiBoardExt() {
		super();
		// TODO Auto-generated constructor stub
	}

	
	public CodiBoardExt(List<MyCodi> myCodiList, List<LikeThat> likeList) {
		super();
		this.myCodiList = myCodiList;
		this.likeList = likeList;
	}


	public List<MyCodi> getMyCodiList() {
		return myCodiList;
	}

	public void setMyCodiList(List<MyCodi> myCodiList) {
		this.myCodiList = myCodiList;
	}

	public List<LikeThat> getLikeList() {
		return likeList;
	}

	public void setLikeList(List<LikeThat> likeList) {
		this.likeList = likeList;
	}

	public void addMyCodi(MyCodi myCodi) {
		this.myCodiList.add(myCodi);
	}
	
	public void addLike(LikeThat like) {
		this.likeList.add(like);
	}


	@Override
	public String toString() {
		return "CodiBoardExt [myCodiList=" + myCodiList + ", likeList=" + likeList + ", toString()=" + super.toString()
				+ "]";
	}
}
