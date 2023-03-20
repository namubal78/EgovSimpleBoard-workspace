package egovframework.subBoard.model.vo;

import java.sql.Date;

import egovframework.common.model.vo.CommonVo;

public class SubBoard extends CommonVo {

	private int subBoardNo;
	private String subBoardTitle;
	private String subBoardContent;
	private String subBoardWriter;
	private Date subBoardDate;
	private int subBoardCount;
	private String subOriginName;
	private String subChangeName;
	private String subBoardStatus;

	private int memberNo;

	public SubBoard() {
		super();
	}

	public SubBoard(int subBoardNo, String subBoardTitle, String subBoardContent, String subBoardWriter,
			Date subBoardDate, int subBoardCount, String subOriginName, String subChangeName, String subBoardStatus,
			int memberNo) {
		super();
		this.subBoardNo = subBoardNo;
		this.subBoardTitle = subBoardTitle;
		this.subBoardContent = subBoardContent;
		this.subBoardWriter = subBoardWriter;
		this.subBoardDate = subBoardDate;
		this.subBoardCount = subBoardCount;
		this.subOriginName = subOriginName;
		this.subChangeName = subChangeName;
		this.subBoardStatus = subBoardStatus;
		this.memberNo = memberNo;
	}

	public int getSubBoardNo() {
		return subBoardNo;
	}

	public void setSubBoardNo(int subBoardNo) {
		this.subBoardNo = subBoardNo;
	}

	public String getSubBoardTitle() {
		return subBoardTitle;
	}

	public void setSubBoardTitle(String subBoardTitle) {
		this.subBoardTitle = subBoardTitle;
	}

	public String getSubBoardContent() {
		return subBoardContent;
	}

	public void setSubBoardContent(String subBoardContent) {
		this.subBoardContent = subBoardContent;
	}

	public String getSubBoardWriter() {
		return subBoardWriter;
	}

	public void setSubBoardWriter(String subBoardWriter) {
		this.subBoardWriter = subBoardWriter;
	}

	public Date getSubBoardDate() {
		return subBoardDate;
	}

	public void setSubBoardDate(Date subBoardDate) {
		this.subBoardDate = subBoardDate;
	}

	public int getSubBoardCount() {
		return subBoardCount;
	}

	public void setSubBoardCount(int subBoardCount) {
		this.subBoardCount = subBoardCount;
	}

	public String getSubOriginName() {
		return subOriginName;
	}

	public void setSubOriginName(String subOriginName) {
		this.subOriginName = subOriginName;
	}

	public String getSubChangeName() {
		return subChangeName;
	}

	public void setSubChangeName(String subChangeName) {
		this.subChangeName = subChangeName;
	}

	public String getSubBoardStatus() {
		return subBoardStatus;
	}

	public void setSubBoardStatus(String subBoardStatus) {
		this.subBoardStatus = subBoardStatus;
	}

	public int getMemberNo() {
		return memberNo;
	}

	public void setMemberNo(int memberNo) {
		this.memberNo = memberNo;
	}

	@Override
	public String toString() {
		return "SubBoard [subBoardNo=" + subBoardNo + ", subBoardTitle=" + subBoardTitle + ", subBoardContent="
				+ subBoardContent + ", subBoardWriter=" + subBoardWriter + ", subBoardDate=" + subBoardDate
				+ ", subBoardCount=" + subBoardCount + ", subOriginName=" + subOriginName + ", subChangeName="
				+ subChangeName + ", subBoardStatus=" + subBoardStatus + ", memberNo=" + memberNo + "]";
	}
	
	
	
}
