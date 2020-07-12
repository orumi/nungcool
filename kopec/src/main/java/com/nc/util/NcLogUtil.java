package com.nc.util;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Hashtable;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;

public class NcLogUtil {
	
	public static void InsLog(CoolConnection conn, Hashtable ht) throws Exception {
		
		StringBuffer query = new StringBuffer();
		//CoolConnection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		String imsi = "";
		int iRet = 0;
		
		try {
			//conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			//conn.createStatement(false);
			
			query.append(" SELECT NVL(MAX(ID), 0)+1 imsi FROM TBL_AUDIT ");
			pstmt = conn.getConnection().prepareStatement(query.toString());
			rs = pstmt.executeQuery();
			rs.next();
			imsi = rs.getString("imsi");
			rs.close();
			pstmt.close();
			
			query.delete(0, query.length());
			query.append(" INSERT INTO TBL_AUDIT(ID, USERID, WORKKIND, WORKNAME, TABLENAME, WORKTAG, DESCRIPTION, EXCEP, INPUTDATE) ");
			query.append(" VALUES(?, ?, ?, ?, ?, ?, ?, ?, TO_CHAR(SYSDATE, 'YYYYMMDDHH24MISS')) ");
			pstmt = conn.getConnection().prepareStatement(query.toString());
			int cntParam = 1;
			pstmt.setString(cntParam++, imsi);
			pstmt.setString(cntParam++, Common.filter((String) ht.get("userId")));
			pstmt.setString(cntParam++, Common.filter((String) ht.get("workKind")));
			pstmt.setString(cntParam++, Common.filter((String) ht.get("workName")));
			pstmt.setString(cntParam++, Common.filter((String) ht.get("tableName")));
			pstmt.setString(cntParam++, Common.filter((String) ht.get("workTag")));
			pstmt.setString(cntParam++, Common.filter((String) ht.get("description")));
			pstmt.setString(cntParam++, Common.filter((String) ht.get("excep")));
			iRet = pstmt.executeUpdate();
			pstmt.close();
			/*
			if(iRet > 0){
				conn.commit();
			}else{
				conn.rollback();
			}
			*/
		} catch (Exception e) {
			System.out.println(e.toString());
		} finally {
			try {
				if (pstmt!=null){try{pstmt.close(); pstmt = null;}catch(Exception e){}}
				if (rs!=null){try{rs.close(); rs = null;} catch(Exception e){}}
			} catch (Exception e) {
			}
		}
	}

}
