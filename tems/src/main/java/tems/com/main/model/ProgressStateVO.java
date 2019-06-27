package tems.com.main.model;

/**
 * Created by owner1120 on 2016-01-14.
 */
public class ProgressStateVO {

    private String rowNum;
    private String reqID;
    private String requestCDate;
    private String reportNO;
    private String compName;
    private String regName;
    private String smpCNT;
    private String itemCNT;
    private String reqState;

    public String getReqState() {
        return reqState;
    }

    public void setReqState(String reqState) {
        this.reqState = reqState;
    }

    public String getRowNum() {
        return rowNum;
    }

    public void setRowNum(String rowNum) {
        this.rowNum = rowNum;
    }

    public String getReqID() {
        return reqID;
    }

    public void setReqID(String reqID) {
        this.reqID = reqID;
    }

    public String getRequestCDate() {
        return requestCDate;
    }

    public void setRequestCDate(String requestCDate) {
        this.requestCDate = requestCDate;
    }

    public String getReportNO() {
        return reportNO;
    }

    public void setReportNO(String reportNO) {
        this.reportNO = reportNO;
    }

    public String getCompName() {
        return compName;
    }

    public void setCompName(String compName) {
        this.compName = compName;
    }

    public String getRegName() {
        return regName;
    }

    public void setRegName(String regName) {
        this.regName = regName;
    }

    public String getSmpCNT() {
        return smpCNT;
    }

    public void setSmpCNT(String smpCNT) {
        this.smpCNT = smpCNT;
    }

    public String getItemCNT() {
        return itemCNT;
    }

    public void setItemCNT(String itemCNT) {
        this.itemCNT = itemCNT;
    }
}
