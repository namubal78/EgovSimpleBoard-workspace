package egovframework.common.model.vo;

public class MasterBoard {

	private int boardNo;
	private String boardName;
	private String boardOpen;
	private String boardPath;
	
	public MasterBoard() {
		super();
	}
	public MasterBoard(int boardNo, String boardName, String boardOpen, String boardPath) {
		super();
		this.boardNo = boardNo;
		this.boardName = boardName;
		this.boardOpen = boardOpen;
		this.boardPath = boardPath;
	}
	
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getBoardName() {
		return boardName;
	}
	public void setBoardName(String boardName) {
		this.boardName = boardName;
	}
	public String getBoardOpen() {
		return boardOpen;
	}
	public void setBoardOpen(String boardOpen) {
		this.boardOpen = boardOpen;
	}
	public String getBoardPath() {
		return boardPath;
	}
	public void setBoardPath(String boardPath) {
		this.boardPath = boardPath;
	}
	@Override
	public String toString() {
		return "MasterBoard [boardNo=" + boardNo + ", boardName=" + boardName + ", boardOpen=" + boardOpen
				+ ", boardPath=" + boardPath + "]";
	}
	
}
