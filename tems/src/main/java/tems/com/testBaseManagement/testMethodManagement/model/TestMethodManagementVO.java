package tems.com.testBaseManagement.testMethodManagement.model;

/**
 * Created by Administrator on 2015-11-18.
 */
public class TestMethodManagementVO {

     private static final long serialVersionUID = 1L;

     private String methodID;
     private String name;
     private String version;
     private String kName;
     private String kUrl;
     private String regDate;
     private String regID;
     private String modifyDate;
     private String modifyID;
     private String state;

     public String getState() {
          return state;
     }

     public void setState(String state) {
          this.state = state;
     }

     public static long getSerialVersionUID() {
          return serialVersionUID;
     }

     public String getMethodID() {
          return methodID;
     }

     public void setMethodID(String methodID) {
          this.methodID = methodID;
     }

     public String getName() {
          return name;
     }

     public void setName(String name) {
          this.name = name;
     }

     public String getVersion() {
          return version;
     }

     public void setVersion(String version) {
          this.version = version;
     }

     public String getkName() {
          return kName;
     }

     public void setkName(String kName) {
          this.kName = kName;
     }

     public String getkUrl() {
          return kUrl;
     }

     public void setkUrl(String kUrl) {
          this.kUrl = kUrl;
     }

     public String getRegDate() {
          return regDate;
     }

     public void setRegDate(String regDate) {
          this.regDate = regDate;
     }

     public String getRegID() {
          return regID;
     }

     public void setRegID(String regID) {
          this.regID = regID;
     }

     public String getModifyDate() {
          return modifyDate;
     }

     public void setModifyDate(String modifyDate) {
          this.modifyDate = modifyDate;
     }

     public String getModifyID() {
          return modifyID;
     }

     public void setModifyID(String modifyID) {
          this.modifyID = modifyID;
     }
}
