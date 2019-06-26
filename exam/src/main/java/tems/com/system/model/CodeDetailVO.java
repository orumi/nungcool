package tems.com.system.model;

/**
 * Created by owner1120 on 2015-12-30.
 */
public class CodeDetailVO {

    private String codeGroupID;
    private String codeID;
    private String codeName;
    private String useFlag;
    private String regID;
    private String regDate;
    private String modifyID;
    private String modifyDate;
    private String state;

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCodeGroupID() {
        return codeGroupID;
    }

    public void setCodeGroupID(String codeGroupID) {
        this.codeGroupID = codeGroupID;
    }

    public String getCodeID() {
        return codeID;
    }

    public void setCodeID(String codeID) {
        this.codeID = codeID;
    }

    public String getCodeName() {
        return codeName;
    }

    public void setCodeName(String codeName) {
        this.codeName = codeName;
    }

    public String getUseFlag() {
        return useFlag;
    }

    public void setUseFlag(String useFlag) {
        this.useFlag = useFlag;
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
