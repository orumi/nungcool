package ncsys.com.bsc.admin.service.model;

public class HierarchyNode {

	private String year;
	private String id;
	private String parentid;
	private String value;
	private String label;
	private String lvl;
	private String rank;
	private String icon;
	private String contentid;
	private String treelevel;
	private String weight;



	public String getContentid() {
		return contentid;
	}
	public void setContentid(String contentid) {
		this.contentid = contentid;
	}
	public String getTreelevel() {
		return treelevel;
	}
	public void setTreelevel(String treelevel) {
		this.treelevel = treelevel;
	}
	public String getWeight() {
		return weight;
	}
	public void setWeight(String weight) {
		this.weight = weight;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getParentid() {
		return parentid;
	}
	public void setParentid(String parentid) {
		this.parentid = parentid;
	}
	public String getValue() {
		return value;
	}
	public void setValue(String value) {
		this.value = value;
	}
	public String getLabel() {
		return label;
	}
	public void setLabel(String label) {
		this.label = label;
	}
	public String getLvl() {
		return lvl;
	}
	public void setLvl(String lvl) {
		this.lvl = lvl;
	}
	public String getRank() {
		return rank;
	}
	public void setRank(String rank) {
		this.rank = rank;
	}
	public String getIcon() {
		return "../../resource/jqwidgets/images/folder.png";
	}
	public void setIcon(String icon) {
		this.icon = icon;
	}





}
