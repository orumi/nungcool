package tems.com.testBaseManagement.testItemManagement.genReqTestProp.model;

/**
 * Created by owner1120 on 2015-12-21.
 */
public class GroupVO {

    private String officeID;
    private String name;
    private String uppOfficeID;
    private String uppName;
    private String treeView;
    private int cnt;


    public String getOfficeID() {
        return officeID;
    }

    public void setOfficeID(String officeID) {
        this.officeID = officeID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUppOfficeID() {
        return uppOfficeID;
    }

    public void setUppOfficeID(String uppOfficeID) {
        this.uppOfficeID = uppOfficeID;
    }

    public String getUppName() {
        return uppName;
    }

    public void setUppName(String uppName) {
        this.uppName = uppName;
    }

    public String getTreeView() {
        return treeView;
    }

    public void setTreeView(String treeView) {
        this.treeView = treeView;
    }

    public int getCnt() {
        return cnt;
    }

    public void setCnt(int cnt) {
        this.cnt = cnt;
    }
}
