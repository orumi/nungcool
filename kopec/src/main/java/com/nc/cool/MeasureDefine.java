package com.nc.cool;

import java.util.ArrayList;

public class MeasureDefine {
	public int id;
	public int measureid;
	public String name;
	public double weighting;
	public int updaterid;
	public String updatername; 
	public String entryType;
	public String measureType;
	public String summaryType;
	public String trend;
	public String frequency;
	public String equation;
	public String etlkey;
	public String detaildefine;
	public double eval_s;
	public double eval_a;
	public double eval_b;
	public double eval_c;
	public int i_s;
	public int i_a;
	public int i_b;
	public int i_c;
	public double score_s;
	public double score_a;
	public double score_b;
	public double score_c;
	public String targetdefine;
	public String yb2;
	public String yb1;
	public String y;
	public String ya1;
	public String ya2;
	public String ya3;
	public String ya4;
	public String[] m;
	public String eval_frequency;
	public ArrayList itemList;
	
	public MeasureDefine(){
		m = new String[12];
		itemList = new ArrayList();
	}
	
	public String toString(){
		return this.id+"/"+this.name;
	}
}
