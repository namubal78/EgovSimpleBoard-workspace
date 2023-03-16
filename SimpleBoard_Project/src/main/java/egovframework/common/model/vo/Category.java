package egovframework.common.model.vo;

public class Category {

	private String category;
	private String keyword;
	public Category() {
		super();
	}
	public Category(String category, String keyword) {
		super();
		this.category = category;
		this.keyword = keyword;
	}
	public String getCategory() {
		return category;
	}
	public void setCategory(String category) {
		this.category = category;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	@Override
	public String toString() {
		return "Category [category=" + category + ", keyword=" + keyword + "]";
	}
	
	
	
}
