package com.booking.model;

import java.util.ArrayList;
import java.util.List;


public class BookingModel {

	private int train_no;
	private int no_of_tickets;
	private int date;
	private String booked_class;
	private String curr_status;
	private List<String> plist;
	private String booked_source;
	private String booked_dest;
	private int jdate;
	public int getJdate() {
		return jdate;
	}
	public void setJdate(int jdate) {
		this.jdate = jdate;
	}
	public String getBooked_source() {
		return booked_source;
	}
	public void setBooked_source(String booked_source) {
		this.booked_source = booked_source;
	}
	public String getBooked_dest() {
		return booked_dest;
	}
	public void setBooked_dest(String booked_dest) {
		this.booked_dest = booked_dest;
	}
	public String getCurr_status() {
		return curr_status;
	}
	public void setCurr_status(String curr_status) {
		this.curr_status = curr_status;
	}
	public int getTrain_no() {
		return train_no;
	}
	public void setTrain_no(int train_no) {
		this.train_no = train_no;
	}
	public int getNo_of_tickets() {
		return no_of_tickets;
	}
	public void setNo_of_tickets(int no_of_tickets) {
		this.no_of_tickets = no_of_tickets;
	}
	public int getDate() {
		return date;
	}
	public void setDate(int date) {
		this.date = date;
	}
	public String getBooked_class() {
		return booked_class;
	}
	public void setBooked_class(String booked_class) {
		this.booked_class = booked_class;
	}
	public List<String> getPlist() {
		return plist;
	}
	public void setPlist(List<String> plist) {
		this.plist = plist;
	}
	
}
