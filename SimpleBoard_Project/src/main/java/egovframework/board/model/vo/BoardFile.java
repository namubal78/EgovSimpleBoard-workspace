package egovframework.board.model.vo;

public class BoardFile {

	private int fileNo;
	private String originName;
	private String changeName;
	private String filePath;
	private String fileStatus;
	
	private int boardNo;

	
	public BoardFile() {
		super();
	}
	public BoardFile(int fileNo, String originName, String changeName, String filePath, String fileStatus, int boardNo) {
		super();
		this.fileNo = fileNo;
		this.originName = originName;
		this.changeName = changeName;
		this.filePath = filePath;
		this.fileStatus = fileStatus;
		this.boardNo = boardNo;
	}
	public int getFileNo() {
		return fileNo;
	}
	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}	
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public String getOriginName() {
		return originName;
	}
	public void setOriginName(String originName) {
		this.originName = originName;
	}
	public String getChangeName() {
		return changeName;
	}
	public void setChangeName(String changeName) {
		this.changeName = changeName;
	}
	public String getFilePath() {
		return filePath;
	}
	public void setFilePath(String filePath) {
		this.filePath = filePath;
	}
	public String getFileStatus() {
		return fileStatus;
	}
	public void setFileStatus(String fileStatus) {
		this.fileStatus = fileStatus;
	}
	@Override
	public String toString() {
		return "BoardFile [fileNo=" + fileNo + ", originName=" + originName + ", changeName=" + changeName + ", filePath="
				+ filePath + ", fileStatus=" + fileStatus + ", boardNo=" + boardNo + "]";
	}

	
}
