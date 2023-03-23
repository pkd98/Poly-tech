package reference2;

import java.util.ArrayList;
import java.util.List;

public class Books {

	private String name;		// 책 이름
	private String author;		// 책 저자
	private String genre;		// 책 장르
	private String codenumber;	// 책 번호
	
	public Books() {};
	
	public Books(String name, String author, String genre, String codenumber) {
		super();
		this.name = name;
		this.author = author;
		this.genre = genre;
		this.codenumber = codenumber;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getGenre() {
		return genre;
	}

	public void setGenre(String genre) {
		this.genre = genre;
	}

	public String getCodenumber() {
		return codenumber;
	}

	public void setCodenumber(String codenumber) {
		this.codenumber = codenumber;
	}

	public String getAuthor() {
		return author;
	}

	public void setAuthor(String author) {
		this.author = author;
	}
	
	public List<String> bookinfo() {
		List<String> bookinfo = new ArrayList<>();
		bookinfo.add(this.name);
		bookinfo.add(this.author);
		bookinfo.add(this.genre);
		bookinfo.add(this.codenumber);
		
		return bookinfo;
	}

	@Override
	public String toString() {
		return "[책 제목=" + name + ", 작가=" + author + ", 장르=" + genre + ", 책 번호=" + codenumber + "]";
	}

	
}
