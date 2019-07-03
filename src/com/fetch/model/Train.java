package com.fetch.model;

public class Train {

	private long train_no;
	private String train_name;
	private String source_station_name;
	private String source_station_code;
	private String source_arrival;
	private String source_departure;
	private String dest_station_name;
	private String dest_station_code;
	private String dest_arrival;
	private String dest_departure;
	
	


	
	public long getTrain_no() {
		return train_no;
	}
	public String getSource_arrival() {
		return source_arrival;
	}
	public void setSource_arrival(String source_arrival) {
		this.source_arrival = source_arrival;
	}
	public String getSource_departure() {
		return source_departure;
	}
	public void setSource_departure(String source_departure) {
		this.source_departure = source_departure;
	}
	public String getDest_arrival() {
		return dest_arrival;
	}
	public void setDest_arrival(String dest_arrival) {
		this.dest_arrival = dest_arrival;
	}
	public String getDest_departure() {
		return dest_departure;
	}
	public void setDest_departure(String dest_departure) {
		this.dest_departure = dest_departure;
	}
	public void setTrain_no(long train_no) {
		this.train_no = train_no;
	}
	public String getTrain_name() {
		return train_name;
	}
	public void setTrain_name(String train_name) {
		this.train_name = train_name;
	}
	public String getSource_station_name() {
		return source_station_name;
	}
	public void setSource_station_name(String source_station_name) {
		this.source_station_name = source_station_name;
	}
	public String getSource_station_code() {
		return source_station_code;
	}
	public void setSource_station_code(String source_station_code) {
		this.source_station_code = source_station_code;
	}
	public String getDest_station_name() {
		return dest_station_name;
	}
	public void setDest_station_name(String dest_station_name) {
		this.dest_station_name = dest_station_name;
	}
	public String getDest_station_code() {
		return dest_station_code;
	}
	public void setDest_station_code(String dest_station_code) {
		this.dest_station_code = dest_station_code;
	}
	
	
	@Override
	public String toString() {
		// TODO Auto-generated method stub
		return super.toString();
	}
	

}
