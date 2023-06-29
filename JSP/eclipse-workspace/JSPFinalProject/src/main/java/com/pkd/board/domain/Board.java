package com.pkd.board.domain;

import java.sql.Timestamp;

public class Board {

    private int id; // db 시퀸스 사용
    private String name; // 작성자명
    private String title; // 제목
    private String content; // 내용
    private Timestamp createdAt; // 작성시간
    private int views; // 조회수
    private int parentId; // 부모 게시글 ID
    private int depth; // 띄어쓰기 레벨

    public Board() {}

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public Timestamp getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(Timestamp createdAt) {
        this.createdAt = createdAt;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }

    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }

    public int getDepth() {
        return depth;
    }

    public void setDepth(int depth) {
        this.depth = depth;
    }

    @Override
    public String toString() {
        return "Board [id=" + id + ", name=" + name + ", title=" + title + ", content=" + content
                + ", createdAt=" + createdAt + ", views=" + views + ", parentId=" + parentId
                + ", depth=" + depth + "]";
    }
}
