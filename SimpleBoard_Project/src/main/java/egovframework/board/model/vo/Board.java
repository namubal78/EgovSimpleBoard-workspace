package egovframework.board.model.vo;

import java.sql.Date;

import egovframework.common.model.vo.CommonVo;

public class Board extends CommonVo {

	private int boardNo;
	private String boardTitle;
	private String boardContent;
	private String boardWriter;
	private Date boardDate;
	private int boardCount;
	/*
	 * private String originName; private String changeName;
	 */
	private String boardStatus;

	private int memberNo;

	public Board() {
		super();
	}

	public Board(int boardNo, String boardTitle, String boardContent, String boardWriter, Date boardDate,
			int boardCount, String boardStatus, int memberNo) {
		super();
		this.boardNo = boardNo;
		this.boardTitle = boardTitle;
		this.boardContent = boardContent;
		this.boardWriter = boardWriter;
		this.boardDate = boardDate;
		this.boardCount = boardCount;
		this.boardStatus = boardStatus;
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

	public String getBoardWriter() {
		return boardWriter;
	}

	public void setBoardWriter(String boardWriter) {
		this.boardWriter = boardWriter;
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

	public String getBoardStatus() {
		return boardStatus;
	}

	public void setBoardStatus(String boardStatus) {
		this.boardStatus = boardStatus;
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
				+ ", boardWriter=" + boardWriter + ", boardDate=" + boardDate + ", boardCount=" + boardCount
				+ ", boardStatus=" + boardStatus + ", memberNo=" + memberNo + "]";
	}

	
	
	
	
}
