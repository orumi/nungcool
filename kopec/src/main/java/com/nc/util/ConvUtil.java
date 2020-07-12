package com.nc.util;

import java.util.ArrayList;

import com.nc.util.DataSet;

public class ConvUtil {

	/**
	 * DataSet�� ��� �÷��� StringBuffer�� ��ȯ�Ҷ�
	 * @param ds
	 * @return
	 */
	static public StringBuffer allCols(DataSet ds){
		StringBuffer sb = new StringBuffer();

		if(ds == null || ds.getRowCount() < 1){ //�����ͼ��� ���̰ų� row�� 0�ϰ�� "" ����
			sb.append("");
		}else{
			while(ds.next()){
				for(int i = 0; i < ds.getColumnCount(); i++){
					String s = " ";
					try{
					s = ds.isEmpty(i+1)? "" : ds.getString(i+1);
					}catch(Exception e){
						e.printStackTrace();
					}
					sb.append(s+"|");
				}
				sb.append("\r\n");
			}
		}
		return sb;
	}

	/**
	 * DataSet�� �÷����� ������ �÷����� StringBuffer�� ��ȯ�Ҷ�
	 * @param ds �����ͼ�
	 * @param colNms �÷���
	 * @return
	 */
	static public StringBuffer selectedCols(DataSet ds, String[] colNms){
		StringBuffer sb = new StringBuffer();

		if(ds == null || ds.getRowCount() < 1){ //�����ͼ��� ���̰ų� row�� 0�ϰ�� "" ����
			sb.append("");
		}else{
			if(colNms.length < 1){ //header(�÷���) ������ ���� ��� ��� �÷� ����
				sb = allCols(ds);
			}else{

				while(ds.next()){
					for(int i = 0; i < colNms.length; i++){
						sb.append(ds.isEmpty(colNms[i].toString())? ""+"|" : ds.getString(colNms[i].toString())+"|");
					}
					sb.append("\r\n");
				}
			}
		}

		return sb;
	}

	/**
	 * DataList�� json�� ��ȯ���ִ� �Լ�
	 * @param ds
	 * @return
	 */
	public static String DsToJson(DataSet ds){
		String sJson = "";
		String colValue = "";
		ArrayList al = new ArrayList();

		if(ds.getRowCount() < 1){
			return "";
		}else{
			for(int i=0; i < ds.getColumnCount(); i++){		//�÷�����ŭ ������ ���鼭
				al.add(i,ds.getColumnName(i+1).toString().toLowerCase());    //ArrayList�� �÷��� ����
			}
		}

		sJson = "{\"rs\" : [ \n";

		for(int i = 1; i <= ds.getRowCount(); i++){
		ds.setRow(i);
			sJson +=	"{" ;
			for(int j=0; j < al.size(); j++){
				colValue = Util.ReplaceJson(ds.getString(al.get(j).toString()));
				if(j == (al.size()-1)){
					sJson +=	    "\""+al.get(j)+"\" : \"" + (ds.isEmpty(al.get(j).toString())?"":colValue) + "\"" ;
				}else{
					sJson +=	    "\""+al.get(j)+"\" : \"" + (ds.isEmpty(al.get(j).toString())?"":colValue) + "\"," ;
				}
			}
			if(i < ds.getRowCount()){
				sJson +=	"},\n";
			}else{
				sJson +=	"}\n";
			}
		}//for
		sJson += "]}";

		//System.out.println(debug("DsToJson :: json : " + sJson));

		//System.out.println("DsToJson :: json : " + sJson);
		//System.out.println("ds.getRCount() : " + ds.getRowCount());
		return sJson;

	}

	/**
	 * sql�� ?���ڸ� �Ķ������ ������ ġȯ
	 * @param sql
	 * @param params
	 * @return
	 */
	public static String replaceSql(String sql, Object[] params){
		if (params == null)
            return sql;
        for (int j = 0; j < params.length; j++) {
            if (params[j] == null) {
            	sql = sql.replaceFirst("\\?", " ");
            } else if (params[j] instanceof java.lang.String) {
            	sql = sql.replaceFirst("\\?", "'"+params[j].toString()+"'");
            } else if (params[j] instanceof Integer){
            	sql = sql.replaceFirst("\\?", params[j].toString());
            } else if (params[j] instanceof Double){
            	sql = sql.replaceFirst("\\?", params[j].toString());
            } else if (params[j] instanceof Long) {
            	sql = sql.replaceFirst("\\?", params[j].toString());
            } else {
            	sql = sql.replaceFirst("\\?", params[j].toString());
            }
        }
		return sql;
	}

	/**
	 * ArrayList�� XML�� ��ȯ��Ű�� �Լ�
	 * @param al : ArrayList (double ArrayList)
	 * 				ArrayList�� 0�� �ε������� �÷��� �� �־�� �Ѵ�.
	 *
	 * @return XML�� ��ȯ�� �Լ�
	 */
	public static String AlToXml(ArrayList alRow){
		String sXml = "";
		ArrayList alName = new ArrayList();

		if(alRow.size() < 1){
			return "";
		}else{
			alName.add(alRow.get(0));    //ArrayList�� �÷��� ����
		}
		sXml="<result_set>";
		for(int i = 1; i < alRow.size(); i++){
			ArrayList alCol = (ArrayList)alRow.get(1);
			sXml +="<record>";
			for(int j = 0; j < alName.size(); j++){
					sXml += "<"+alName.get(j)+">"+alCol.get(j)+"</"+alName.get(j)+">";
			}
			sXml +="</record>";
		}
		sXml += "</result_set>";
		//System.out.println(alRow.size() + "//" + sXml);
		return sXml;
	}

	/**
	 * DataList�� XML�� ��ȯ���ִ� �Լ�
	 * @param ds
	 * @return
	 */
	public static String DsToXml(DataSet ds){
		String sXml = "";
		ArrayList al = new ArrayList();

		if(ds.getRowCount() < 1){
			return "";
		}else{
			for(int i=0; i < ds.getColumnCount(); i++){		//�÷�����ŭ ������ ���鼭
				al.add(i,ds.getColumnName(i+1).toString());    //ArrayList�� �÷��� ����
			}
		}
		sXml="<result_set>";
		for(int i = 1; i <= ds.getRowCount(); i++){
			ds.setRow(i);
			sXml +="<record>";
			for(int j = 0; j < al.size(); j++){
					try {
						sXml += "<"+al.get(j)+">"+ds.getString(j+1)+"</"+al.get(j)+">";
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
			}
			sXml +="</record>";
		}
		sXml += "</result_set>";
		//System.out.println(dl.getRowCount() + "//" + sXml);
		return sXml;

	}

	/**
	 * DataList�� XML�� ��ȯ���ִ� �Լ�
	 * @param dl
	 * @param resultSetName
	 * @param recordName
	 * @author 1010
	 * @return
	 */
	public static String DsToXml(DataSet ds, String resultSetName, String recordName){
		String sXml = "";
		ArrayList al = new ArrayList();

		if(ds.getRowCount() < 1){
			return "";
		}else{
			for(int i=0; i < ds.getColumnCount(); i++){		//�÷�����ŭ ������ ���鼭
				al.add(i,ds.getColumnName(i+1).toString().toLowerCase());    //ArrayList�� �÷��� ����
			}
		}
		sXml="<"+resultSetName+">";
		for(int i = 1; i <= ds.getRowCount(); i++){
			ds.setRow(i);
			sXml +="<"+recordName+">";
			for(int j = 0; j < al.size(); j++){
					try {
						sXml += "<"+al.get(j)+">"+ds.getString(j+1)+"</"+al.get(j)+">";
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
			}
			sXml +="</"+recordName+">";
		}
		sXml += "</"+resultSetName+">";
		//System.out.println(dl.getRowCount() + "//" + sXml);
		return sXml;

	}

	/**
	 * ��Ʈ�� ���� XML ��ȯ1
	 *
	 * XML ��)<items><item actual="120"/></items>
	 *
	 */
	public static String DsToXmlForPie(DataSet dl, String resultSetName, String recordName, String colName, String itemName){
		String sXml = "";
		ArrayList al = new ArrayList();
		int iTargetCol = 0;

		if(dl.getRowCount() < 1){
			return "";
		}else{
			for(int i=0; i < dl.getColumnCount(); i++){		//�÷�����ŭ ������ ���鼭
				if(colName.toLowerCase().equals(dl.getColumnName(i+1).toString().toLowerCase())){
					iTargetCol = i;
				}
			}
		}
		sXml="<"+resultSetName+">";
		for(int i = 1; i <= dl.getRowCount(); i++){
			dl.setRow(i);
			try {
				sXml +="<"+recordName+" "+itemName+"=\""+dl.getString(iTargetCol)+"\"/>";
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		sXml += "</"+resultSetName+">";
		//System.out.println(dl.getRowCount() + "//" + sXml);
		return sXml;

	}

	/**
	 * DataSet�� ��Ʈ�� ����  XML�� ��ȯ���ִ� �Լ�
	 * XML ��)<Sample month="January" revenue="120" costs="45" overhead="102" oneTime="23" />
	 * @param dl
	 * @param resultSetName
	 * @param recordName
	 * @author 1010
	 * @return
	 */
	public static String DsToXmlForChart(DataSet dl, String resultSetName, String recordName){
		String sXml = "";
		ArrayList al = new ArrayList();

		if(dl.getRowCount() < 1){
			return "";
		}else{
			for(int i=0; i < dl.getColumnCount(); i++){		//�÷�����ŭ ������ ���鼭
				al.add(i,dl.getColumnName(i+1).toString().toLowerCase());    //ArrayList�� �÷��� ����
			}
		}
		sXml="<"+resultSetName+">";
		for(int i = 1; i <= dl.getRowCount(); i++){
			dl.setRow(i);
			sXml +="<"+recordName;
			for(int j = 0; j < al.size(); j++){
					try {
						sXml += " "+al.get(j)+"=\""+dl.getString(j+1)+"\"";
					} catch (Exception e) {
						// TODO Auto-generated catch block
						e.printStackTrace();
					}
			}
			sXml +="></"+recordName+">";
		}
		sXml += "</"+resultSetName+">";
		System.out.println(dl.getRowCount() + "//" + sXml);
		return sXml;

	}

}
