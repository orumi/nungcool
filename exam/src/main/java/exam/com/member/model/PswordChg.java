package exam.com.member.model;

/**
 * Created by owner1120 on 2016-03-02.
 */
public class PswordChg {

    private String currentPsword;
    private String newPsword;
    private String newPswordConfirm;
    private String memid;

    public String getMemid() {
        return memid;
    }

    public void setMemid(String memid) {
        this.memid = memid;
    }

    public String getCurrentPsword() {
        return currentPsword;
    }

    public void setCurrentPsword(String currentPsword) {
        this.currentPsword = currentPsword;
    }

    public String getNewPsword() {
        return newPsword;
    }

    public void setNewPsword(String newPsword) {
        this.newPsword = newPsword;
    }

    public String getNewPswordConfirm() {
        return newPswordConfirm;
    }

    public void setNewPswordConfirm(String newPswordConfirm) {
        this.newPswordConfirm = newPswordConfirm;
    }
}
