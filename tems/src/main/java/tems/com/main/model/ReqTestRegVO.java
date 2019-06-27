package tems.com.main.model;

/**
 * Created by owner1120 on 2016-01-14.
 */
public class ReqTestRegVO {

    private String reqID;
    private String compName;
    private String reqState;
    private String sampleCNT;
    private String regName;
    private String itemCNT;
    private String requestCdate;

    public String getRequestCdate() {
        return requestCdate;
    }

    public void setRequestCdate(String requestCdate) {
        this.requestCdate = requestCdate;
    }

    public String getReqID() {
        return reqID;
    }

    public void setReqID(String reqID) {
        this.reqID = reqID;
    }

    public String getCompName() {
        return compName;
    }

    public void setCompName(String compName) {
        this.compName = compName;
    }

    public String getReqState() {
        return reqState;
    }

    public void setReqState(String reqState) {
        this.reqState = reqState;
    }

    public String getSampleCNT() {
        return sampleCNT;
    }

    public void setSampleCNT(String sampleCNT) {
        this.sampleCNT = sampleCNT;
    }

    public String getRegName() {
        return regName;
    }

    public void setRegName(String regName) {
        this.regName = regName;
    }

    public String getItemCNT() {
        return itemCNT;
    }

    public void setItemCNT(String itemCNT) {
        this.itemCNT = itemCNT;
    }
}
