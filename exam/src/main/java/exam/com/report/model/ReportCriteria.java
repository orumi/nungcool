package exam.com.report.model;

import exam.com.common.Criteria;

/**
 * Created by owner1120 on 2016-02-12.
 */
public class ReportCriteria extends Criteria {

    private String issueDate1;
    private String issueDate2;
    private String requestDate1;
    private String requestDate2;

    public String getIssueDate1() {
        return issueDate1;
    }

    public void setIssueDate1(String issueDate1) {
        this.issueDate1 = issueDate1;
    }

    public String getIssueDate2() {
        return issueDate2;
    }

    public void setIssueDate2(String issueDate2) {
        this.issueDate2 = issueDate2;
    }

    public String getRequestDate1() {
        return requestDate1;
    }

    public void setRequestDate1(String requestDate1) {
        this.requestDate1 = requestDate1;
    }

    public String getRequestDate2() {

        if(requestDate2 != null) {
            requestDate2 = requestDate2.replace(",", "");
        }
        return requestDate2;
    }

    public void setRequestDate2(String requestDate2) {
        this.requestDate2 = requestDate2;
    }
}
