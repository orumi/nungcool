package com.nc.tree;

import java.io.IOException;
import java.util.ArrayList;

import com.nc.util.Common;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;


public class TreeNode {

	public double[] score = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
	public String [] grade = {"","","","","","","","","","","",""};
	public double weight;
	public String name;
	public int id;  // treeId
	public int pid; // parentId
	public int cid; // contentId
	public int level;
	public int orderby;
	public TreeNode parent;
	public ArrayList childs;
	private int meacount;
	public int cylinderId=-1;

	public double[] totWeight2 ={-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};
	public double[] sumScore2 = {-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1,-1};

	public TreeNode(){
		childs = new ArrayList();
	}

	public TreeNode getChild(int id){
		TreeNode temp = null;
		for (int i = 0; i < childs.size(); i++) {
			temp = (TreeNode)childs.get(i);
			if (id == temp.id) return temp;
		}
		return temp;
	}

	public void addChild(TreeNode treenode){
		treenode.pid = this.id;
		treenode.parent = this;
		childs.add(treenode);
	}

	public void removeChild(int id){
		TreeNode temp = getChild(id);
		if (temp != null){
			removeChild(temp);
		}
	}

	public void removeChild(TreeNode treenode){
		childs.remove(treenode);
	}

	public void removeAllChild(){
		TreeNode temp;
		for (int i = 0; i < childs.size(); i++) {
			temp = (TreeNode)childs.get(0);
			temp.removeAllChild();
			temp.parent = null;
			childs.remove(temp);
		}
		childs = null;
	}

	public void buildTextNode(StringBuffer out, int level) throws IOException{
		out.append(id+"|");
		out.append(this.level+"|");
		out.append(pid+"|");
		out.append(cid+"|");
		out.append((name!=null)?name+"|":"|");
		out.append(Common.round(weight,2)+"|");
		for (int i = 0; i < 12; i++)
			out.append( Common.round(score[i],1)+ ",");

		out.append("|");
		for (int i = 0; i < 12; i++)
			out.append( grade[i]+ ",5");

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
		/*jObj.put("weight", Common.round(weight,2));*/
		jObj.put("weight", "" );

		for(int i=0; i<score.length; i++){
			if(score[i]>-1){
				score[i] = Common.round(score[i], 1);
			}
		}
		jObj.put("score", score);
		jObj.put("grade", grade);


		jArray.add(jObj);

		if (this.level < level)
			for (int i = 0; i < childs.size(); i++) {
				((TreeNode)childs.get(i)).buildJsonNode(jArray, level);
			}

	}

	public void buildJsonMeasure(JSONArray jArray, int level) throws IOException{
		if (this.level < level)
			for (int i = 0; i < childs.size(); i++) {
				((TreeNode)childs.get(i)).buildJsonMeasure(jArray, level);
			}

	}


	public void buildPlanNode(StringBuffer out, int level) throws IOException{
		out.append(cylinderId+"|");
		out.append(id+"|");
		out.append(this.level+"|");
		out.append(pid+"|");
		out.append(cid+"|");
		out.append((name!=null)?name+"|":"|");
		out.append(Common.round(weight,2)+"|");
		for (int i = 0; i < 12; i++)
			out.append( Common.round(score[i],1)+ ",");

		out.append("\r\n");
		if (this.level < level)
			for (int i = 0; i < childs.size(); i++) {
				((TreeNode)childs.get(i)).buildPlanNode(out, level);
			}
	}
	public void setNode(ArrayList list, int level){
		if(this.level == level){
			list.add(this);
			return;
		} else if(this.level < level){
			for (int i = 0; i < childs.size(); i++) {
				((TreeNode)childs.get(i)).setNode(list, level);
			}
		}

	}
	public void setMeasure(ArrayList list){
		if (this.level==5){
			list.add(this);
			return;
		} else if (this.level<5){
			for (int i = 0; i < childs.size(); i++) {
				((TreeNode)childs.get(i)).setMeasure(list);
			}
		}
	}
	public String buildXMLScore(StringBuffer sb, int i){
		sb.append("<z:row id='"+this.id+"' level='"+this.level+"' weight='"+Common.round(this.weight,2)+"' ")
		  .append(" score='"+Common.round(this.score[i],2)+"' />\r\n");
		for (int i1 = 0; i1 < childs.size(); i1++) {
			((TreeNode)childs.get(i1)).buildXMLScore(sb, i);
		}
		return sb.toString();
	}




	public String buildXMLNodePlus(int level, StringBuffer sb){
		sb.append("<item text='"+this.name+"' id='"+this.id+"' score='"+Common.round(this.score[0],2)+"' color='#FFFF19'> \r\n");
		if (this.level < level){
			for (int i1 = 0; i1 < childs.size(); i1++) {
				((TreeNode)childs.get(i1)).buildXMLNodePlus(level, sb);
			}
		}
		sb.append("</item> \r\n");
		return sb.toString();
	}

	public TreeNode getNode(int id, int i) {
		if (this.level==i && this.cid == id){
			return this;
		} else {
			for (int j = 0; j < childs.size(); j++) {
				TreeNode node = ((TreeNode)childs.get(j)).getNode(id, i);
				if (node != null) return node;
			}
		}
		return null;
	}

	public TreeNode getNodebyId(int id, int level){
		if (this.level == level && this.id == id){
			return this;
		} else {
			for (int j=0;j<childs.size(); j++){
				TreeNode node = ((TreeNode)childs.get(j)).getNodebyId(id, level);
				if (node != null) return node;
			}
		}
		return null;

	}

	public void setScore(int index, double score){
		this.score[index] = score;
		if (parent != null) parent.setHierarchyScore(index);
	}

	public void setHierarchyScore(int index){
		double totWeight = 0.0D;
		double sumScore = 0.0D;
		TreeNode child = null;

		for (int i = 0; i < childs.size(); i++) {
			child = (TreeNode)childs.get(i);
			if (child.score[index] >= 0) {
				totWeight = totWeight + child.weight;
				sumScore = sumScore+(child.weight*child.score[index]);
			}
		}
		if (totWeight != 0)	{
			this.score[index] = sumScore/totWeight;
			this.weight = totWeight;
		}
		if (parent != null) parent.setHierarchyScore(index);
	}


	public String toString(){
		StringBuffer sb = new StringBuffer();
		sb.append("id:"+this.id+",parentId:"+this.pid+",name:"+this.name.trim()+",level:"+this.level+"childcnt:"+this.childs.size()+this.score[5]+"<br>");
		return sb.toString();
	}

}
