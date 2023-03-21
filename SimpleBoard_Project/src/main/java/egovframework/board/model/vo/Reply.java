package egovframework.board.model.vo;

import java.sql.Date;

public class Reply {

	private int replyNo;
	private String replyContent;
	private String replyWriter;
	private String replyDate;
	private String replyStatus;
	
	private int boardNo;
	
	public Reply() {
		super();
	}
	public Reply(int replyNo, String replyContent, String replyWriter, String replyDate, String replyStatus, int boardNo) {
		super();
		this.replyNo = replyNo;
		this.replyContent = replyContent;
		this.replyWriter = replyWriter;
		this.replyDate = replyDate;
		this.replyStatus = replyStatus;
		this.boardNo = boardNo;
	}
	
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public int getReplyNo() {
		return replyNo;
	}
	public void setReplyNo(int replyNo) {
		this.replyNo = replyNo;
	}
	public String getReplyContent() {
		return replyContent;
	}
	public void setReplyContent(String replyContent) {
		this.replyContent = replyContent;
	}
	public String getReplyWriter() {
		return replyWriter;
	}
	public void setReplyWriter(String replyWriter) {
		this.replyWriter = replyWriter;
	}
	public String getReplyDate() {
		return replyDate;
	}
	public void setReplyDate(String replyDate) {
		this.replyDate = replyDate;
	}
	public String getReplyStatus() {
		return replyStatus;
	}
	public void setReplyStatus(String replyStatus) {
		this.replyStatus = replyStatus;
	}
	@Override
	public String toString() {
		return "Reply [replyNo=" + replyNo + ", replyContent=" + replyContent + ", replyWriter=" + replyWriter
				+ ", replyDate=" + replyDate + ", replyStatus=" + replyStatus + ", boardNo=" + boardNo + "]";
	}
	
	
	
	
}
