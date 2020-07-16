package ncsys.com.bsc.admin.service.model;

import java.util.List;

public class MeasureDetail {

	private String id;
	private String measureid;
	private String frequency;
	private String weight;

	private String ym;
	private String planned;
	private String plannedbase;
	private String base;
	private String baselimit;

	private String limit;
	private String plannedbaseplus;
	private String baseplus;
	private String baselimitplus;
	private String limitplus;

	private List<String> months;



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
	public String getFrequency() {
		return frequency;
	}
	public void setFrequency(String frequency) {
		this.frequency = frequency;
	}
	public String getWeight() {
		return weight;
	}
	public void setWeight(String weight) {
		this.weight = weight;
	}
	public String getYm() {
		return ym;
	}
	public void setYm(String ym) {
		this.ym = ym;
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
	public String getPlannedbaseplus() {
		return plannedbaseplus;
	}
	public void setPlannedbaseplus(String plannedbaseplus) {
		this.plannedbaseplus = plannedbaseplus;
	}
	public String getBaseplus() {
		return baseplus;
	}
	public void setBaseplus(String baseplus) {
		this.baseplus = baseplus;
	}
	public String getBaselimitplus() {
		return baselimitplus;
	}
	public void setBaselimitplus(String baselimitplus) {
		this.baselimitplus = baselimitplus;
	}
	public String getLimitplus() {
		return limitplus;
	}
	public void setLimitplus(String limitplus) {
		this.limitplus = limitplus;
	}
	public List<String> getMonths() {
		return months;
	}
	public void setMonths(List<String> months) {
		this.months = months;
	}





}
