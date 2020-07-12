package ncsys.com.bsc.admin.service.model;

import java.util.ArrayList;

public class MeasureDefine {


	private String mode;
	private String bid;
	private String pcid;
	private String ocid;

	private String pname;
	private String oname;
	private String mname;


	private String year;

	private String mid;
	private String id;
	private String measureid;
	private String mean;
	private String detaildefine;
	private String weight;
	private String unit;
	private String planned;
	private String plannedBasePlus;
	private String plannedBase;
	private String basePlus;
	private String base;
	private String baseLimitPlus;
	private String baseLimit;
	private String limitPlus;
	private String limit;
	private String measurement;
	private String trend;
	private String frequency;
	private String eval_frq;
	private String evalmethod;
	private String equation;
	private String equationdefine;
	private String etlkey;
	private String updateid;
	private String equationType;
	private String plannedFlag;





	private ArrayList<MeasureUser> authority = new ArrayList<MeasureUser>();
	private ArrayList<Item> items = new ArrayList<Item>();

	private String itemcnt;




	public String getMid() {
		return mid;
	}
	public void setMid(String mid) {
		this.mid = mid;
	}
	public String getPlannedFlag() {
		return plannedFlag;
	}
	public void setPlannedFlag(String plannedFlag) {
		this.plannedFlag = plannedFlag;
	}
	public String getEquationType() {
		return equationType;
	}
	public void setEquationType(String equationType) {
		this.equationType = equationType;
	}


	public String getMode() {
		return mode;
	}
	public void setMode(String mode) {
		this.mode = mode;
	}
	public String getPlannedBasePlus() {
		return plannedBasePlus;
	}
	public void setPlannedBasePlus(String plannedBasePlus) {
		this.plannedBasePlus = plannedBasePlus;
	}
	public String getPlannedBase() {
		return plannedBase;
	}
	public void setPlannedBase(String plannedBase) {
		this.plannedBase = plannedBase;
	}
	public String getBasePlus() {
		return basePlus;
	}
	public void setBasePlus(String basePlus) {
		this.basePlus = basePlus;
	}
	public String getBaseLimitPlus() {
		return baseLimitPlus;
	}
	public void setBaseLimitPlus(String baseLimitPlus) {
		this.baseLimitPlus = baseLimitPlus;
	}
	public String getBaseLimit() {
		return baseLimit;
	}
	public void setBaseLimit(String baseLimit) {
		this.baseLimit = baseLimit;
	}
	public String getLimitPlus() {
		return limitPlus;
	}
	public void setLimitPlus(String limitPlus) {
		this.limitPlus = limitPlus;
	}
	public ArrayList<MeasureUser> getAuthority() {
		return authority;
	}
	public void setAuthority(ArrayList<MeasureUser> authority) {
		this.authority = authority;
	}
	public ArrayList<Item> getItems() {
		return items;
	}
	public void setItems(ArrayList<Item> items) {
		this.items = items;
	}
	public String getYear() {
		return year;
	}
	public void setYear(String year) {
		this.year = year;
	}
	public String getBid() {
		return bid;
	}
	public void setBid(String bid) {
		this.bid = bid;
	}
	public String getOcid() {
		return ocid;
	}
	public void setOcid(String ocid) {
		this.ocid = ocid;
	}
	public String getPcid() {
		return pcid;
	}
	public void setPcid(String pcid) {
		this.pcid = pcid;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}
	public String getMeasureid() {
		return measureid;
	}
	public void setMeasureid(String measureid) {
		this.measureid = measureid;
	}
	public String getMean() {
		return mean;
	}
	public void setMean(String mean) {
		this.mean = mean;
	}
	public String getDetaildefine() {
		return detaildefine;
	}
	public void setDetaildefine(String detaildefine) {
		this.detaildefine = detaildefine;
	}
	public String getWeight() {
		return weight;
	}
	public void setWeight(String weight) {
		this.weight = weight;
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
	public String getBase() {
		return base;
	}
	public void setBase(String base) {
		this.base = base;
	}
	public String getLimit() {
		return limit;
	}
	public void setLimit(String limit) {
		this.limit = limit;
	}
	public String getMeasurement() {
		return measurement;
	}
	public void setMeasurement(String measurement) {
		this.measurement = measurement;
	}
	public String getTrend() {
		return trend;
	}
	public void setTrend(String trend) {
		this.trend = trend;
	}
	public String getFrequency() {
		return frequency;
	}
	public void setFrequency(String frequency) {
		this.frequency = frequency;
	}
	public String getEval_frq() {
		return eval_frq;
	}
	public void setEval_frq(String eval_frq) {
		this.eval_frq = eval_frq;
	}
	public String getEvalmethod() {
		return evalmethod;
	}
	public void setEvalmethod(String evalmethod) {
		this.evalmethod = evalmethod;
	}
	public String getEquation() {
		return equation;
	}
	public void setEquation(String equation) {
		this.equation = equation;
	}
	public String getEquationdefine() {
		return equationdefine;
	}
	public void setEquationdefine(String equationdefine) {
		this.equationdefine = equationdefine;
	}
	public String getEtlkey() {
		return etlkey;
	}
	public void setEtlkey(String etlkey) {
		this.etlkey = etlkey;
	}
	public String getUpdateid() {
		return updateid;
	}
	public void setUpdateid(String updateid) {
		this.updateid = updateid;
	}
	public String getItemcnt() {
		return itemcnt;
	}
	public void setItemcnt(String itemcnt) {
		this.itemcnt = itemcnt;
	}



	public String getPname() {
		return pname;
	}
	public void setPname(String pname) {
		this.pname = pname;
	}
	public String getOname() {
		return oname;
	}
	public void setOname(String oname) {
		this.oname = oname;
	}
	public String getMname() {
		return mname;
	}
	public void setMname(String mname) {
		this.mname = mname;
	}


}
