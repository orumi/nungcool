package com.nc.tree;

import java.io.DataOutputStream;
import java.io.IOException;
import java.util.ArrayList;

import com.nc.util.Common;
import com.nc.util.ServerUtil;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


public class TreeMeasure extends TreeNode{

	public double planned;
	public double plannedbase;
	public double base;
	public double baselimit;
	public double limit;

	public String unit;
	public String frequency;
	public String measurement;
	public double[] actual = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
	public String[] grade  = {"","","","","","","","","","","",""};


	public void buildTextNode(StringBuffer out, int level) throws IOException{
		out.append(id+"|");
		out.append(this.level+"|");
		out.append(pid+"|");
		out.append(cid+"|");
		out.append((name!=null)?name+"|":"|");
		out.append(Common.round(weight,2)+"|");
		for (int i = 0; i < 12; i++)
			out.append(Common.round(score[i],1)+",");
		out.append("|");
		out.append((unit!=null)?unit+"|":"|");
		out.append((frequency!=null)?frequency+"|":"|");
		out.append((measurement!=null)?measurement+"|":"|");

		out.append(planned+"|");
		out.append(plannedbase+"|");
		out.append(base+"|");
		out.append(baselimit+"|");
		out.append(limit+"|");

		//out.append(childs.size()+"|");

		for (int i = 0; i < 12; i++) {
			out.append(Common.round(actual[i],1)+ ",");
		}

		out.append("|");
		for (int i = 0; i < 12; i++) {
			out.append(grade[i]+ ",");
		}

		out.append("\r\n");
		if (this.level < level)
			for (int i = 0; i < childs.size(); i++) {
				((TreeNode)childs.get(i)).buildTextNode(out, level);
			}


	}

	public void buildJsonNode(JSONArray jArray, int level) throws IOException{
		JSONObject jObj = new JSONObject();

		jObj.put("id", this.id);
		jObj.put("level", this.level);
		jObj.put("pid", pid);
		jObj.put("cid", cid);
		jObj.put("name", (name!=null)?name:"");
		jObj.put("weight", Common.round(weight,2));

		for(int i=0; i<score.length; i++){
			if(score[i]>-1){
				score[i] = Common.round(score[i], 1);
			}
		}

		jObj.put("score", score);
		jObj.put("grade", grade);


		jObj.put("unit",(unit!=null)?unit:"");
		jObj.put("frequency",(frequency!=null)?frequency:"");
		jObj.put("measurement", (measurement!=null)?measurement:"");

		jObj.put("planned",planned);
		jObj.put("plannedbase",plannedbase);
		jObj.put("base",base);
		jObj.put("baselimit",baselimit);
		jObj.put("limit",limit);

		jObj.put("actual", actual);


		jArray.add(jObj);


		if (this.level < level)
			for (int i = 0; i < childs.size(); i++) {
				((TreeNode)childs.get(i)).buildJsonNode(jArray, level);
			}

	}

	public void buildJsonMeasure(JSONArray jArray, int level) throws IOException{
		JSONObject jObj = new JSONObject();

		jObj.put("id", this.id);
		jObj.put("level", this.level);
		jObj.put("pid", pid);
		jObj.put("cid", cid);
		jObj.put("name", (name!=null)?name:"");
		jObj.put("weight", Common.round(weight,2));

		for(int i=0; i<score.length; i++){
			if(score[i]>-1){
				score[i] = Common.round(score[i], 1);
			}
		}

		jObj.put("score", score);
		jObj.put("grade", grade);


		jObj.put("unit",(unit!=null)?unit:"");
		jObj.put("frequency",(frequency!=null)?frequency:"");
		jObj.put("measurement", (measurement!=null)?measurement:"");

		jObj.put("planned",planned);
		jObj.put("plannedbase",plannedbase);
		jObj.put("base",base);
		jObj.put("baselimit",baselimit);
		jObj.put("limit",limit);

		jObj.put("actual", actual);


		jArray.add(jObj);


		if (this.level < level)
			for (int i = 0; i < childs.size(); i++) {
				((TreeNode)childs.get(i)).buildJsonNode(jArray, level);
			}

	}
}
