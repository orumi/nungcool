package tems.com.login.model;

import java.io.Serializable;

/**
 * Created by owner1120 on 2016-01-19.
 */
public class FavoriteVO implements Serializable {
	
	private static final long serialVersionUID = 1L;

    private String adminID;
    private String menuNo;
    private String mainView;
    private String orderBy;
    private String regID2;
    private String regDate2;
    private String regID;
    private String regDate;
    private String modifyID;
    private String modifyDate;
    private String url;
    private String menuName;

    public String getMenuName() {
        return menuName;
    }

    public void setMenuName(String menuName) {
        this.menuName = menuName;
    }

    public String getMenuNo() {
        return menuNo;
    }

    public void setMenuNo(String menuNo) {
        this.menuNo = menuNo;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getAdminID() {
        return adminID;
    }

    public void setAdminID(String adminID) {
        this.adminID = adminID;
    }

    public String getMainView() {
        return mainView;
    }

    public void setMainView(String mainView) {
        this.mainView = mainView;
    }

    public String getOrderBy() {
        return orderBy;
    }

    public void setOrderBy(String orderBy) {
        this.orderBy = orderBy;
    }

    public String getRegID2() {
        return regID2;
    }

    public void setRegID2(String regID2) {
        this.regID2 = regID2;
    }

    public String getRegDate2() {
        return regDate2;
    }

    public void setRegDate2(String regDate2) {
        this.regDate2 = regDate2;
    }

    public String getRegID() {
        return regID;
    }

    public void setRegID(String regID) {
        this.regID = regID;
    }

    public String getRegDate() {
        return regDate;
    }

    public void setRegDate(String regDate) {
        this.regDate = regDate;
    }

    public String getModifyID() {
        return modifyID;
    }

    public void setModifyID(String modifyID) {
        this.modifyID = modifyID;
    }

    public String getModifyDate() {
        return modifyDate;
    }

    public void setModifyDate(String modifyDate) {
        this.modifyDate = modifyDate;
    }
}
