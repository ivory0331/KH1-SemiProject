package main.model;

public class NoticeVO {
	private int notice_num;
	private String subject;
	private String content;
	private String write_date;
	private int hit;
	
	
	public NoticeVO() {}
	
	public NoticeVO(int notice_num, String subject, String content, String write_date, int hit) {
		
		this.notice_num = notice_num;
		this.subject = subject;
		this.content = content;
		this.write_date = write_date;
		this.hit = hit;
	}
	
	
	public int getNotice_num() {
		return notice_num;
	}
	public void setNotice_num(int notice_num) {
		this.notice_num = notice_num;
	}
	
	
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	
	
	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}
	
	
	public String getWrite_date() {
		return write_date;
	}
	public void setWrite_date(String write_date) {
		this.write_date = write_date;
	}
	
	
	public int getHit() {
		return hit;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	
	
	
}
