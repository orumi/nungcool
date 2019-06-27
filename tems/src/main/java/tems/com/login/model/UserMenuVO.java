package tems.com.login.model;

import java.io.Serializable;

public class UserMenuVO  implements Serializable {
	
	private static final long serialVersionUID = 1L;

	private String menunm;
	private String lvl;
	private String orderby;
	private String mcnt;
	private String url;
	private String umenuno;
	private String menuno;
	private String menutitle;
	public void setMenunm(String menunm) {
		this.menunm = menunm; 
	}
	public String getMenunm() {
		return menunm; 
	}
	public void setLvl(String lvl) {
		this.lvl = lvl; 
	}
	public String getLvl() {
		return lvl; 
	}
	public void setOrderby(String orderby) {
		this.orderby = orderby; 
	}
	public String getOrderby() {
		return orderby; 
	}
	public void setMcnt(String mcnt) {
		this.mcnt = mcnt; 
	}
	public String getMcnt() {
		return mcnt; 
	}
	public void setUrl(String url) {
		this.url = url; 
	}
	public String getUrl() {
		return url; 
	}
	public void setUmenuno(String umenuno) {
		this.umenuno = umenuno; 
	}
	public String getUmenuno() {
		return umenuno; 
	}
	public void setMenuno(String menuno) {
		this.menuno = menuno; 
	}
	public String getMenuno() {
		return menuno; 
	}
	public String getMenutitle() {
		return menutitle;
	}
	public void setMenutitle(String menutitle) {
		this.menutitle = menutitle;
	}
	

}
