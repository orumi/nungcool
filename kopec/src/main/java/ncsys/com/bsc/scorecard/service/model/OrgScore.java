package ncsys.com.bsc.scorecard.service.model;

import java.util.HashMap;

public class OrgScore {

	private String year;
	private String bid;
	private String bpid;
	private String bcid;
	private String blevel;
	private String brank;
	private String bweight;
	private String bname;
	private String bcscore;
	private String bcweight;
	private String pid;
	private String ppid;
	private String pcid;
	private String plevel;
	private String prank;
	private String pweight;
	private String pname;
	private String pcscore;
	private String pcweight;
	private String pcnt;
	private String pnum;
	private String oid;
	private String opid;
	private String ocid;
	private String olevel;
	private String orank;
	private String oweight;
	private String oname;
	private String ocscore;
	private String ocweight;
	private String ocnt;
	private String onum;
	private String mid;
	private String mpid;
	private String mcid;
	private String mlevel;
	private String mrank;
	private String mweight;
	private String mname;
	private String measurement;
	private String frequency;
	private String trend;
	private String etlkey;
	private String unit;
	private String planned;
	private String plannedbase;
	private String base;
	private String baselimit;
	private String limit ;
	private String actual;
	private String grade;
	private String score;
	private String gradeScore;
	private String mcscore;
	private String calcscore;

private HashMap<String, Object> attr;

	public HashMap<String, Object> getAttr() {
		attr = new HashMap<String, Object>( );

		HashMap<String, Object> pname = new HashMap<String, Object>();

		if( this.pnum.equals("1") ){
			pname.put("rowspan", this.pcnt);
		} else {
			pname.put("display", "none");
		}
		attr.put("pname", pname);

		HashMap<String, Object> oname = new HashMap<String, Object>();

		if(this.onum.equals("1")){
			oname.put("rowspan", this.ocnt);
		} else {
			oname.put("display", "none");
		}
		attr.put("oname", oname);

		return attr;
	}

	public void setAttr(HashMap<String, Object> attr) {
		this.attr = attr;
	}


	public String getBid() {
		return bid;
	}
	public void setBid(String bid) {
		this.bid = bid;
	}
	public String getBpid() {
		return bpid;
	}
	public void setBpid(String bpid) {
		this.bpid = bpid;
	}
	public String getBcid() {
		return bcid;
	}
	public void setBcid(String bcid) {
		this.bcid = bcid;
	}
	public String getBlevel() {
		return blevel;
	}
	public void setBlevel(String blevel) {
		this.blevel = blevel;
	}
	public String getBrank() {
		return brank;
	}
	public void setBrank(String brank) {
		this.brank = brank;
	}
	public String getBweight() {
		return bweight;
	}
	public void setBweight(String bweight) {
		this.bweight = bweight;
	}
	public String getBname() {
		return bname;
	}
	public void setBname(String bname) {
		this.bname = bname;
	}
	public String getBcscore() {
		return bcscore;
	}
	public void setBcscore(String bcscore) {
		this.bcscore = bcscore;
	}
	public String getBcweight() {
		return bcweight;
	}
	public void setBcweight(String bcweight) {
		this.bcweight = bcweight;
	}
	public String getPid() {
		return pid;
	}
	public void setPid(String pid) {
		this.pid = pid;
	}
	public String getPpid() {
		return ppid;
	}
	public void setPpid(String ppid) {
		this.ppid = ppid;
	}
	public String getPcid() {
		return pcid;
	}
	public void setPcid(String pcid) {
		this.pcid = pcid;
	}
	public String getPlevel() {
		return plevel;
	}
	public void setPlevel(String plevel) {
		this.plevel = plevel;
	}
	public String getPrank() {
		return prank;
	}
	public void setPrank(String prank) {
		this.prank = prank;
	}
	public String getPweight() {
		return pweight;
	}
	public void setPweight(String pweight) {
		this.pweight = pweight;
	}
	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getPcscore() {
		return pcscore;
	}
	public void setPcscore(String pcscore) {
		this.pcscore = pcscore;
	}
	public String getPcweight() {
		return pcweight;
	}
	public void setPcweight(String pcweight) {
		this.pcweight = pcweight;
	}
	public String getPcnt() {
		return pcnt;
	}
	public void setPcnt(String pcnt) {
		this.pcnt = pcnt;
	}
	public String getPnum() {
		return pnum;
	}
	public void setPnum(String pnum) {
		this.pnum = pnum;
	}
	public String getOid() {
		return oid;
	}
	public void setOid(String oid) {
		this.oid = oid;
	}
	public String getOpid() {
		return opid;
	}
	public void setOpid(String opid) {
		this.opid = opid;
	}
	public String getOcid() {
		return ocid;
	}
	public void setOcid(String ocid) {
		this.ocid = ocid;
	}
	public String getOlevel() {
		return olevel;
	}
	public void setOlevel(String olevel) {
		this.olevel = olevel;
	}
	public String getOrank() {
		return orank;
	}
	public void setOrank(String orank) {
		this.orank = orank;
	}
	public String getOweight() {
		return oweight;
	}
	public void setOweight(String oweight) {
		this.oweight = oweight;
	}
	public String getOname() {
		return oname;
	}
	public void setOname(String oname) {
		this.oname = oname;
	}
	public String getOcscore() {
		return ocscore;
	}
	public void setOcscore(String ocscore) {
		this.ocscore = ocscore;
	}
	public String getOcweight() {
		return ocweight;
	}
	public void setOcweight(String ocweight) {
		this.ocweight = ocweight;
	}
	public String getOcnt() {
		return ocnt;
	}
	public void setOcnt(String ocnt) {
		this.ocnt = ocnt;
	}
	public String getOnum() {
		return onum;
	}
	public void setOnum(String onum) {
		this.onum = onum;
	}
	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getMpid() {
		return mpid;
	}
	public void setMpid(String mpid) {
		this.mpid = mpid;
	}
	public String getMcid() {
		return mcid;
	}
	public void setMcid(String mcid) {
		this.mcid = mcid;
	}
	public String getMlevel() {
		return mlevel;
	}
	public void setMlevel(String mlevel) {
		this.mlevel = mlevel;
	}
	public String getMrank() {
		return mrank;
	}
	public void setMrank(String mrank) {
		this.mrank = mrank;
	}
	public String getMweight() {
		return mweight;
	}
	public void setMweight(String mweight) {
		this.mweight = mweight;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}
	public String getMeasurement() {
		return measurement;
	}
	public void setMeasurement(String measurement) {
		this.measurement = measurement;
	}
	public String getFrequency() {
		return frequency;
	}
	public void setFrequency(String frequency) {
		this.frequency = frequency;
	}
	public String getTrend() {
		return trend;
	}
	public void setTrend(String trend) {
		this.trend = trend;
	}
	public String getEtlkey() {
		return etlkey;
	}
	public void setEtlkey(String etlkey) {
		this.etlkey = etlkey;
	}
	public String getUnit() {
		return unit;
	}
	public void setUnit(String unit) {
		this.unit = unit;
	}
	public String getPlanned() {
		return planned;
	}
	public void setPlanned(String planned) {
		this.planned = planned;
	}
	public String getPlannedbase() {
		return plannedbase;
	}
	public void setPlannedbase(String plannedbase) {
		this.plannedbase = plannedbase;
	}
	public String getBase() {
		return base;
	}
	public void setBase(String base) {
		this.base = base;
	}
	public String getBaselimit() {
		return baselimit;
	}
	public void setBaselimit(String baselimit) {
		this.baselimit = baselimit;
	}
	public String getLimit() {
		return limit;
	}
	public void setLimit(String limit) {
		this.limit = limit;
	}
	public String getActual() {
		return actual;
	}
	public void setActual(String actual) {
		this.actual = actual;
	}
	public String getGrade() {
		return grade;
	}
	public void setGrade(String grade) {
		this.grade = grade;
	}
	public String getScore() {
		return score;
	}
	public void setScore(String score) {
		this.score = score;
	}
	public String getGradeScore() {
		return gradeScore;
	}
	public void setGradeScore(String gradeScore) {
		this.gradeScore = gradeScore;
	}
	public String getMcscore() {
		return mcscore;
	}
	public void setMcscore(String mcscore) {
		this.mcscore = mcscore;
	}
	public String getCalcscore() {
		return calcscore;
	}
	public void setCalcscore(String calcscore) {
		this.calcscore = calcscore;
	}

	public String getYear() {
		return year;
	}

	public void setYear(String year) {
		this.year = year;
	}









}
