package Exam;

import java.util.Date;
import java.util.Objects;

public class Book implements Cloneable, Comparable<Book> {
    private String title;
    private Date publishDate;
    private String comment;

    public Book(String title, Date publishDate, String comment) {
        this.title = title;
        this.publishDate = publishDate;
        this.comment = comment;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Date getPublishDate() {
        return publishDate;
    }

    public void setPublishDate(Date publishDate) {
        this.publishDate = publishDate;
    }

    public String getComment() {
        return comment;
    }

    public void setComment(String comment) {
        this.comment = comment;
    }

    // 제목과 출간일이 같으면 같은 책으로 판단
    @Override
    public int hashCode() {
        return Objects.hash(publishDate, title);
    }

    @Override
    public boolean equals(Object obj) {
        if (this == obj)
            return true;
        if (obj == null)
            return false;
        if (getClass() != obj.getClass())
            return false;
        Book other = (Book) obj;
        return Objects.equals(publishDate, other.publishDate) && Objects.equals(title, other.title);
    }

    // 출간일이 오래된 순서대로 정렬
    @Override
    public int compareTo(Book o) {
        // TODO Auto-generated method stub
        // return this.publishDate.compareTo(o.publishDate);
        if (this.publishDate.getTime() < o.publishDate.getTime()) {
            return -1;
        } else if (this.publishDate.getTime() > o.publishDate.getTime()) {
            return 1;
        } else {
            return 0;
        }
    }

    @Override
    protected Book clone() {
        Book result = new Book(this.title, this.publishDate, this.comment);
        return result;
    }

    @Override
    public String toString() {
        return "Book [title=" + title + "]";
    }
}
