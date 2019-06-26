package tems.com.testBaseManagement.testItemManagement.genReqTestProp.model;

/**
 * Created by owner1120 on 2015-12-08.
 */
public class ReqPropVO {

    private String itemID;
    private String itemPID;
    private String name;
    private String methodID;
    private String unitID;
    private String smpAmount;
    private String range;
    private String ruleID;
    private String displayType;
    private String displayScript;
    private String repeat;
    private String kolasFlag;
    private String cycle;
    private String term;
    private String calc;
    private String temperCond;
    private String timeCond;
    private String regID;
    private String regDate;
    private String modifyID;
    private String modifyDate;
    private String methodName;  // tce_method테이블의 name이다 중복이름 때문에 methodName으로 명명
    private String useFlag;
    private String state;
    private String admin;

    public String getAdmin() {
        return admin;
    }

    public void setAdmin(String admin) {
        this.admin = admin;
    }

    public String getUseFlag() {
        return useFlag;
    }

    public void setUseFlag(String useFlag) {
        this.useFlag = useFlag;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getMethodName() {
        return methodName;
    }

    public void setMethodName(String methodName) {
        this.methodName = methodName;
    }

    public String getItemID() {
        return itemID;
    }

    public void setItemID(String itemID) {
        this.itemID = itemID;
    }

    public String getItemPID() {
        return itemPID;
    }

    public void setItemPID(String itemPID) {
        this.itemPID = itemPID;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getMethodID() {
        return methodID;
    }

    public void setMethodID(String methodID) {
        this.methodID = methodID;
    }

    public String getUnitID() {
        return unitID;
    }

    public void setUnitID(String unitID) {
        this.unitID = unitID;
    }

    public String getSmpAmount() {
        return smpAmount;
    }

    public void setSmpAmount(String smpAmount) {
        this.smpAmount = smpAmount;
    }

    public String getRange() {
        return range;
    }

    public void setRange(String range) {
        this.range = range;
    }

    public String getRuleID() {
        return ruleID;
    }

    public void setRuleID(String ruleID) {
        this.ruleID = ruleID;
    }

    public String getDisplayType() {
        return displayType;
    }

    public void setDisplayType(String displayType) {
        this.displayType = displayType;
    }

    public String getDisplayScript() {
        return displayScript;
    }

    public void setDisplayScript(String displayScript) {
        this.displayScript = displayScript;
    }

    public String getRepeat() {
        return repeat;
    }

    public void setRepeat(String repeat) {
        this.repeat = repeat;
    }

    public String getKolasFlag() {
        return kolasFlag;
    }

    public void setKolasFlag(String kolasFlag) {
        this.kolasFlag = kolasFlag;
    }

    public String getCycle() {
        return cycle;
    }

    public void setCycle(String cycle) {
        this.cycle = cycle;
    }

    public String getCalc() {
        return calc;
    }

    public String getTerm() {
        return term;
    }

    public void setTerm(String term) {
        this.term = term;
    }

    public void setCalc(String calc) {
        this.calc = calc;
    }

    public String getTemperCond() {
        return temperCond;
    }

    public void setTemperCond(String temperCond) {
        this.temperCond = temperCond;
    }

    public String getTimeCond() {
        return timeCond;
    }

    public void setTimeCond(String timeCond) {
        this.timeCond = timeCond;
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
