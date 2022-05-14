package member;

import java.sql.Timestamp;

public class MemberBean {

	private String name;
	private String pass;
	private String id;
	private Timestamp reg_data;
	private String email;
	private String address;
	private String phone;
	private String mobile;
	
	
	public String getEmail() {
		return email;
	}
	public void setEmail(String email) {
		this.email = email;
	}
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getMobile() {
		return mobile;
	}
	public void setMobile(String mobile) {
		this.mobile = mobile;
	}
	public Timestamp getReg_data() {
		return reg_data;
	}
	public void setReg_data(Timestamp reg_data) {
		this.reg_data = reg_data;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPass() {
		return pass;
	}
	public void setPass(String pass) {
		this.pass = pass;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}	
	
}
