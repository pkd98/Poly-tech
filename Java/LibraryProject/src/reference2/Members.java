package reference2;

import java.util.ArrayList;
import java.util.List;

public class Members {

	private String name;			// 회원 이름
	private String phonenumber;		// 회원 전화번호
	private String id;				// 회원 아이디
	private String pw;				// 회원 비밀번호
	
	
	
	public Members() {};
	
	public Members(String name, String phonenumber, String id, String pw) {
		this.name = name;
		this.phonenumber = phonenumber;
		this.id = id;
		this.pw = pw;
	}
	
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhonenumber() {
		return phonenumber;
	}
	public void setPhonenumber(String phonenumber) {
		this.phonenumber = phonenumber;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}

	public List<String> memberinfo(){
		List<String> memberinfo = new ArrayList<>();
		memberinfo.add(this.name);
		memberinfo.add(this.phonenumber);
		memberinfo.add(this.id);
		memberinfo.add(this.pw);
		
		return memberinfo;
	}
	
	
	@Override
	public String toString() {
		return "Members [name=" + name + ", phonenumber=" + phonenumber + ", id=" + id + ", pw=" + pw + "]";
	}
	
	
	
}
