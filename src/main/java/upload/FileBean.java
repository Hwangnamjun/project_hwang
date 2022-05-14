package upload;

import java.sql.Timestamp;

public class FileBean {

    private int num;
    private String author;
    private String title;
    private String file;
    private String pass;
    private Timestamp day;
	
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public int getNum() {
		return num;
	}
	public String getAuthor() {
		return author;
	}
	public String getTitle() {
		return title;
	}
	public String getFile() {
		return file;
	}
	public Timestamp getDay() {
		return day;
	}

	public void setNum(int num) {
		this.num = num;
	}

	public void setAuthor(String author) {
		this.author = author;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public void setFile(String file) {
		this.file = file;
	}

	public void setDay(Timestamp day) {
		this.day = day;
	}
    
    
}
