package com.kh.icodi.cscenter.model.dto;

import java.sql.Date;

public class Alarm {
	private int no;
	private String memberId;
	private Date alarmDate;
	private String alarmMessage;
	public Alarm() {
		super();
		// TODO Auto-generated constructor stub
	}
	public Alarm(int no, String memberId, Date alarmDate, String alarmMessage) {
		super();
		this.no = no;
		this.memberId = memberId;
		this.alarmDate = alarmDate;
		this.alarmMessage = alarmMessage;
	}
	public int getNo() {
		return no;
	}
	public void setNo(int no) {
		this.no = no;
	}
	public String getMemberId() {
		return memberId;
	}
	public void setMemberId(String memberId) {
		this.memberId = memberId;
	}
	public Date getAlarmDate() {
		return alarmDate;
	}
	public void setAlarmDate(Date alarmDate) {
		this.alarmDate = alarmDate;
	}
	public String getAlarmMessage() {
		return alarmMessage;
	}
	public void setAlarmMessage(String alarmMessage) {
		this.alarmMessage = alarmMessage;
	}
	@Override
	public String toString() {
		return "Alarm [no=" + no + ", memberId=" + memberId + ", alarmDate=" + alarmDate + ", alarmMessage="
				+ alarmMessage + "]";
	}
	
	
}
