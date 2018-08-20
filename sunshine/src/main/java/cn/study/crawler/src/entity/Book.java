package cn.study.crawler.src.entity;

public class Book {
	private String book_name; // 书本名字
	private String author; // 作者
	private String type; // 类型
	private String status; // 连载状态
	private String update_time; // 更新时间
	private String book_Introduction; // 书本简介
	private String url; // 书本链接
	private String content;//书本内容z
	public Book(String url1) {
	this.url=url1;
	}
	public Book(String url1,String type1 ) {
		this.url=url1;
		this.type=type1;
	}
	
	public String getBook_name() {
		return book_name;
	}
	public void setBook_name(String book_name) {
		this.book_name = book_name;
	}
	public String getAuthor() {
		return author;
	}
	public void setAuthor(String author) {
		this.author = author;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getUpdate_time() {
		return update_time;
	}
	public void setUpdate_time(String update_time) {
		this.update_time = update_time;
	}
	public String getBook_Introduction() {
		return book_Introduction;
	}
	public void setBook_Introduction(String book_Introduction) {
		this.book_Introduction = book_Introduction;
	}
	public String getUrl() {
		return url;
	}
	public void setUrl(String url) {
		this.url = url;
	}

	public String getContent() {
		return content;
	}
	public void setContent(String content) {
		this.content = content;
	}

}
