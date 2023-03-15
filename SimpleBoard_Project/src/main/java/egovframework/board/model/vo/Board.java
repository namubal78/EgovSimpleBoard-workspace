package egovframework.board.model.vo;

import java.sql.Date;

public class Board {

	private int boardNo;
	private String boardTitle;
	private String boardContent;
	private Date boardDate;
	private int boardCount;
	private String boardReply;
	private String boardFile;
	private String boardStatus;
	
	private String memberName;
	private int memberNo;
	public Board() {
		super();
	}
	public Board(int boardNo, String boardTitle, String boardContent, Date boardDate, int boardCount, String boardReply,
			String boardFile, String boardStatus, String memberName, int memberNo) {
		super();
		this.boardNo = boardNo;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.boardDate = boardDate;
		this.boardCount = boardCount;
		this.boardReply = boardReply;
		this.boardFile = boardFile;
		this.boardStatus = boardStatus;
		this.memberName = memberName;
		this.memberNo = memberNo;
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardContent() {
		return boardContent;
	}
	public void setBoardContent(String boardContent) {
		this.boardContent = boardContent;
	}
	public Date getBoardDate() {
		return boardDate;
	}
	public void setBoardDate(Date boardDate) {
		this.boardDate = boardDate;
	}
	public int getBoardCount() {
		return boardCount;
	}
	public void setBoardCount(int boardCount) {
		this.boardCount = boardCount;
	}
	public String getBoardReply() {
		return boardReply;
	}
	public void setBoardReply(String boardReply) {
		this.boardReply = boardReply;
	}
	public String getBoardFile() {
		return boardFile;
	}
	public void setBoardFile(String boardFile) {
		this.boardFile = boardFile;
	}
	public String getBoardStatus() {
		return boardStatus;
	}
	public void setBoardStatus(String boardStatus) {
		this.boardStatus = boardStatus;
	}
	public String getMemberName() {
		return memberName;
	}
	public void setMemberName(String memberName) {
		this.memberName = memberName;
	}
	public int getMemberNo() {
		return memberNo;
	}
	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}
	@Override
	public String toString() {
		return "Board [boardNo=" + boardNo + ", boardTitle=" + boardTitle + ", boardContent=" + boardContent
				+ ", boardDate=" + boardDate + ", boardCount=" + boardCount + ", boardReply=" + boardReply
				+ ", boardFile=" + boardFile + ", boardStatus=" + boardStatus + ", memberName=" + memberName
				+ ", memberNo=" + memberNo + "]";
	}
	
	
	
}
