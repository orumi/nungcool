package com.nc.util;

import java.io.*;
import java.util.Vector;
import com.nc.util.Common;

import jxl.*;
import jxl.write.*;
import jxl.format.Alignment;
import jxl.format.Colour;
import jxl.format.ScriptStyle;
import jxl.format.UnderlineStyle;
import jxl.format.VerticalAlignment;

import java.sql.Connection;
import java.sql.ResultSet;

import com.nc.cool.CoolServer;
import com.nc.sql.CoolConnection;
import com.nc.util.DBObject;

public class PostExcel {
	/**
	 * Method Name : CreateExcelFile <br>
	 * Method Description	: 웹환경에서 엑셀파일을 만든다. <br>
	 * 
	 * @param			RowSet, String[], String[], int[], String, String
	 * @throws			Exception
	 */
	public void CreateExcelFile(DataSet data, String[] column, String[] columnName, int[] columntype, String FilePath, String SheetName) 
	throws Exception {
		
		try {
			int cellnum, rownum;
			WritableWorkbook workbook = Workbook.createWorkbook(new File(FilePath)); 
			WritableSheet sheet = workbook.createSheet(SheetName, 0); 

			jxl.write.WritableCellFormat format_column = new WritableCellFormat();
			jxl.write.WritableCellFormat format_data = new WritableCellFormat();
			
			jxl.write.NumberFormat moneytype1 = new NumberFormat("###,##0");
			jxl.write.NumberFormat moneytype2 = new NumberFormat("###,##0.00");
			
			jxl.write.WritableCellFormat format_integer1 = new WritableCellFormat(NumberFormats.INTEGER);
			jxl.write.WritableCellFormat format_float1 = new WritableCellFormat(NumberFormats.FLOAT);
			
			jxl.write.WritableCellFormat format_integer2 = new WritableCellFormat(moneytype1);
			jxl.write.WritableCellFormat format_float2 = new WritableCellFormat(moneytype2);
                       
			format_column.setBackground(jxl.format.Colour.GRAY_25 );
			format_column.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN );
			
			format_data.setBackground(jxl.format.Colour.WHITE );
			format_data.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN );

			format_integer1.setBackground(jxl.format.Colour.WHITE );
			format_integer1.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN );
			
			format_float1.setBackground(jxl.format.Colour.WHITE );
			format_float1.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN );
			
			format_integer2.setBackground(jxl.format.Colour.WHITE );
			format_integer2.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN );
			
			format_float2.setBackground(jxl.format.Colour.WHITE );
			format_float2.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN );
									
			jxl.write.Label label = null;                        
			jxl.write.Blank blank = null;
			jxl.write.Number num = null;

			//Create Column 
			for ( cellnum = 0; cellnum < column.length; cellnum++ ) {	
				label = new jxl.write.Label(cellnum,0,column[cellnum],format_column);
				sheet.addCell(label);
			}
            
			//Create Rows
			rownum = 1; 
			if (data != null)
			while(data.next()){
				for (cellnum = 0; cellnum < column.length; cellnum++) // create 50 cells (0-49) (the += 2 becomes apparent later
				{
					if ( columntype[cellnum] == 0 ) { // BSC에서 사용
						label = new jxl.write.Label(cellnum, rownum, data.getString(columnName[cellnum]),format_data); 
						sheet.addCell(label);
						
					} else if ( columntype[cellnum] == 1 ) {
						num = new jxl.write.Number(cellnum, rownum, Long.parseLong(data.getString(columnName[cellnum])),format_integer1);
						sheet.addCell(num);
						
					} else if ( columntype[cellnum] == 2 ) {
						num = new jxl.write.Number(cellnum, rownum, Float.parseFloat(data.getString(columnName[cellnum])),format_float1); 
						sheet.addCell(num);
						
					} else if ( columntype[cellnum] == 3 ) {
						num = new jxl.write.Number(cellnum, rownum, Long.parseLong(data.getString(columnName[cellnum])),format_integer2); 
						sheet.addCell(num);
						
					} else if ( columntype[cellnum] == 4 ) {
						num = new jxl.write.Number(cellnum, rownum, Float.parseFloat(data.getString(columnName[cellnum])),format_float2); 
						sheet.addCell(num);
						
					}else if ( columntype[cellnum] == 5 ) { // BSC에서 사용
						String useValue = "";
						String[] spstr  = Common.filter(columnName[cellnum]).split(":");
						
						if(spstr.length > 1) //:를 기준으로 앞에값이 있다면 앞에 값을 사용하고 그렇지 않으면 뒤에값을 사용한다.
							useValue  = Common.filter(data.getString(spstr[0])).equals("")?data.getString(spstr[1]):data.getString(spstr[0]);
                        else useValue = Common.filter(data.getString(columnName[cellnum]));
						
						if(!(useValue.equals(""))){
							num = new jxl.write.Number(cellnum, rownum, Float.parseFloat(useValue),format_data);
							
							sheet.addCell(num);
						}else{
							blank = new jxl.write.Blank(cellnum,rownum,format_data);
							sheet.addCell(blank);
						}
					}       					             
				}
				rownum++;
			}
		
			workbook.write(); 
			workbook.close(); 
			
		} catch(Exception e) {
      			throw new Exception();	
		}
	}
	/**
	 * Method Name : CreateFormedExcelFile <br>
	 * Method Description	: 웹환경에서 사용자서식(특정한 엑셀형식) 엑셀파일을 만든다. <br>
	 * 
	 * @param			RowSet, String[], String[], int[], String, String
	 * @throws			Exception
	 */
	public void CreateFormedExcelFile(DataSet data, String[] column, String[] columnName, int[] columntype, String FilePath, String SheetName) 
	throws Exception {
		CoolConnection conn = null;
		DBObject dbobject = null;
		ResultSet rs = null;
		try {
			conn = CoolServer.getDBService().getConnectionManager().getCoolConnection();
			conn.createStatement(false);
			
			if (dbobject==null) dbobject= new DBObject(conn.getConnection());
			
			int cellnum, rownum;
			WritableWorkbook workbook = Workbook.createWorkbook(new File(FilePath)); 
			WritableSheet sheet = workbook.createSheet(SheetName, 0);
			
			// cell widht setting.... 
			CellView view = new CellView();
			view.setSize(4000);
			sheet.setColumnView(0,view);

			
			jxl.write.Label label = null;
			jxl.write.Number num = null;

			// set title Format
			WritableFont TitleSet = new WritableFont(WritableFont.createFont("굴림"),20,WritableFont.NO_BOLD,false,UnderlineStyle.NO_UNDERLINE,Colour.BLACK,ScriptStyle.NORMAL_SCRIPT);
			jxl.write.WritableCellFormat format_title = new WritableCellFormat(TitleSet);
			format_title.setBackground(jxl.format.Colour.AQUA);
			format_title.setAlignment(Alignment.CENTRE);
			format_title.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN );
			
			jxl.write.WritableCellFormat format_sub = new WritableCellFormat();
			format_sub.setBackground(jxl.format.Colour.GRAY_25 );
			format_sub.setVerticalAlignment(VerticalAlignment.CENTRE);
			format_sub.setAlignment(Alignment.LEFT);
			format_sub.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN );
			
			
			jxl.write.WritableCellFormat format_column = new WritableCellFormat();
			format_column.setBackground(jxl.format.Colour.WHITE);
			format_column.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN );
			
			//Content Format
			jxl.write.WritableCellFormat format_data = new WritableCellFormat();
			format_data.setBackground(jxl.format.Colour.WHITE );
			format_data.setAlignment(Alignment.LEFT);
			format_data.setVerticalAlignment(VerticalAlignment.TOP);
			format_data.setWrap(true);
			format_data.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN );
			
			// repeat parameter
			int repeat = 1;
			int width = 14;
			int height = 25;
			
			while(data.next()){
				//Title Row,Column 
				sheet.mergeCells(0,repeat,width,repeat);
				label = new jxl.write.Label(0,repeat, "지표정의서", format_title);
				sheet.addCell(label);
				
				label = new Label(0,repeat+2,"1) 관  점",format_sub);
				sheet.addCell(label);
				sheet.mergeCells(1,repeat+2,7,repeat+2);
				label = new Label(1,repeat+2,data.getString("PNAME"),format_data);
				sheet.addCell(label);
				
				label = new Label(0,repeat+3,"2) 전략목표",format_sub);
				sheet.addCell(label);
				sheet.mergeCells(1,repeat+3,7,repeat+3);
				label = new Label(1,repeat+3,data.getString("ONAME"),format_data);
				sheet.addCell(label);
				
				label = new Label(0,repeat+4,"3) 지 표 명",format_sub);
				sheet.addCell(label);
				sheet.mergeCells(1,repeat+4,7,repeat+4);
				label = new Label(1,repeat+4,data.getString("MNAME"),format_data);
				sheet.addCell(label);
				
				label = new Label(0,repeat+5,"4) 지표의의",format_sub);
				sheet.addCell(label);
				sheet.mergeCells(1,repeat+5,width,repeat+5);
				label = new Label(1,repeat+5,data.getString("MEAN"),format_data);
				sheet.addCell(label);
				///////////////////////////////////////////////////////////////
				
				label = new Label(8,repeat+2,"8) KPI NO",format_sub);
				sheet.mergeCells(8,repeat+2,9,repeat+2);
				sheet.addCell(label);
				sheet.mergeCells(10,repeat+2,width,repeat+2);
				label = new Label(10,repeat+2,data.getString("ETLKEY"),format_data);
				sheet.addCell(label);
				
				label = new Label(8,repeat+3,"",format_data);
				sheet.mergeCells(8,repeat+3,width,repeat+3);
				sheet.addCell(label);
				
				label = new Label(8,repeat+4,"9) 지표유형",format_sub);
				sheet.mergeCells(8,repeat+4,9,repeat+4);
				sheet.addCell(label);
				sheet.mergeCells(10,repeat+4,width,repeat+4);
				label = new Label(10,repeat+4,data.getString("MEASUREMENT"),format_data);
				sheet.addCell(label);
				
				///////////////////////////////////////////////////////////////////////////
				label = new Label(0,repeat+7,"5) 평가산식",format_sub);
				sheet.addCell(label);			
				sheet.mergeCells(1,repeat+7,7,repeat+7);
				label = new Label(1,repeat+7,data.getString("EQUATIONDEFINE"),format_data);
				sheet.addCell(label);
				
				for (int i = 0; i < 7; i++) {
					sheet.setRowView(repeat+8+i,600);
				}
				label = new Label(0,repeat+8,"6) 착안점",format_sub);
				sheet.mergeCells(0,repeat+8,0,repeat+21);
				sheet.addCell(label);			
				sheet.mergeCells(1,repeat+8,7,repeat+21);
				label = new Label(1,repeat+8,data.getString("DETAILDEFINE").replaceAll("\n","<style>br{mso-data-placement:same-cell;}</style>"),format_data);	// Enter처리.
				sheet.addCell(label);
				
				label = new Label(0,repeat+22,"7) 비고",format_sub);
				sheet.addCell(label);			
				sheet.mergeCells(1,repeat+22,7,repeat+22);
				label = new Label(1,repeat+22,data.getString("DATASOURCE"),format_data);
				sheet.addCell(label);
				
				//////////////////////////////////////////////////////////////////////////
				label = new Label(8,repeat+7,"10) 평가주기",format_sub);
				sheet.mergeCells(8,repeat+7,9,repeat+7);
				sheet.addCell(label);
				sheet.mergeCells(10,repeat+7,width,repeat+7);
				label = new Label(10,repeat+7,data.getString("FREQUENCY"),format_data);
				sheet.addCell(label);

				label = new Label(8,repeat+8,"11) Data 단위",format_sub);
				sheet.mergeCells(8,repeat+8,9,repeat+8);
				sheet.addCell(label);
				sheet.mergeCells(10,repeat+8,width,repeat+8);
				label = new Label(10,repeat+8,data.getString("UNIT"),format_data);
				sheet.addCell(label);
				
				label = new Label(8,repeat+9,"12) 향상방향",format_sub);
				sheet.mergeCells(8,repeat+9,9,repeat+9);
				sheet.addCell(label);
				sheet.mergeCells(10,repeat+9,width,repeat+9);
				label = new Label(10,repeat+9,data.getString("TREND"),format_data);
				sheet.addCell(label);				
				
				label = new Label(8,repeat+10,"13) Data 입력부서",format_sub);
				sheet.mergeCells(8,repeat+10,9,repeat+10);
				sheet.addCell(label);
				sheet.mergeCells(10,repeat+10,width,repeat+10);
				label = new Label(10,repeat+10,data.getString("MNGDEPTNM"),format_data);
				sheet.addCell(label);
				
				label = new Label(8,repeat+11,"14) 담당자",format_sub);
				sheet.mergeCells(8,repeat+11,9,repeat+11);
				sheet.addCell(label);
				sheet.mergeCells(10,repeat+11,width,repeat+11);
				label = new Label(10,repeat+11,data.getString("UPDATER"),format_data);
				sheet.addCell(label);
				
				label = new Label(8,repeat+12,"15) 연계시스템",format_sub);
				sheet.mergeCells(8,repeat+12,9,repeat+12);
				sheet.addCell(label);
				sheet.mergeCells(10,repeat+12,width,repeat+12);
				label = new Label(10,repeat+12,data.getString("IFSYSTEM"),format_data);
				sheet.addCell(label);
				
				label = new Label(8,repeat+13,"16) 가중치",format_sub);
				sheet.mergeCells(8,repeat+13,9,repeat+13);
				sheet.addCell(label);
				sheet.mergeCells(10,repeat+13,width,repeat+13);
				label = new Label(10,repeat+13,data.getString("MWEIGHT"),format_data);
				sheet.addCell(label);
				
				label = new Label(8,repeat+14,"17) 등급구간",format_sub);
				sheet.mergeCells(8,repeat+14,8,repeat+16);
				sheet.addCell(label);
				
				label = new Label(9,repeat+14,"",format_sub);
				sheet.addCell(label);
				label = new Label(10,repeat+14,"S",format_sub);
				sheet.addCell(label);
				label = new Label(11,repeat+14,"A",format_sub);
				sheet.addCell(label);
				label = new Label(12,repeat+14,"B",format_sub);
				sheet.addCell(label);
				label = new Label(13,repeat+14,"C",format_sub);
				sheet.addCell(label);
				label = new Label(14,repeat+14,"D",format_sub);
				sheet.addCell(label);
				
				label = new Label(9,repeat+15,"목표구간",format_sub);
				sheet.addCell(label);
				label = new Label(10,repeat+15,data.getString("PLANNED"),format_data);
				sheet.addCell(label);
				label = new Label(11,repeat+15,data.getString("PLANNEDBASE"),format_data);
				sheet.addCell(label);
				label = new Label(12,repeat+15,data.getString("BASE"),format_data);
				sheet.addCell(label);
				label = new Label(13,repeat+15,data.getString("BASELIMIT"),format_data);
				sheet.addCell(label);
				label = new Label(14,repeat+15,data.getString("LIMIT"),format_data);
				sheet.addCell(label);
				
				label = new Label(9,repeat+16,"Target 설정근거",format_sub);
				sheet.addCell(label);
				sheet.mergeCells(10,repeat+16,width,repeat+16);
				label = new Label(10,repeat+16,data.getString("TARGETRATIONLE"),format_data);
				sheet.addCell(label);
				
				
				label = new Label(9,repeat+17," 항목",format_sub);
				sheet.addCell(label);
				label = new Label(10,repeat+17," 항목명",format_sub);
				sheet.mergeCells(10,repeat+17,12,repeat+17);
				sheet.addCell(label);
				label = new Label(13,repeat+17," 유형",format_sub);
				sheet.addCell(label);
				label = new Label(14,repeat+17," 방식",format_sub);
				sheet.addCell(label);
				
				String strItem ="SELECT * FROM TBLITEM WHERE MEASUREID=? ORDER BY CODE";
				Object[] param = {data.getString("MCID")};
				
				if (rs!=null){rs.close(); rs=null;}
				rs = dbobject.executePreparedQuery(strItem,param);
				
				int j = 1;
				if(rs != null){
					while(rs.next()){
						label = new Label(9,repeat+17+j,rs.getString("CODE"),format_data);
						sheet.addCell(label);
						
						label = new Label(10,repeat+17+j,rs.getString("ITEMNAME"),format_data);
						sheet.mergeCells(10,repeat+17+j,12,repeat+17+j);
						sheet.addCell(label);
						
						label = new Label(13,repeat+17+j,rs.getString("ITEMENTRY"),format_data);
						sheet.addCell(label);
						
						label = new Label(14,repeat+17+j,rs.getString("ITEMTYPE"),format_data);
						sheet.addCell(label);
						j++;
					}
				}
				
				label = new Label(8,repeat+17,"18) 요구데이터",format_sub);
				if(j < 6){
					sheet.mergeCells(8,repeat+17,8,repeat+17+5);
					sheet.addCell(label);
					
					for(int z=j;z<6;z++){
						label = new Label(9,repeat+17+z,"",format_data);
						sheet.addCell(label);
						
						label = new Label(10,repeat+17+z,"",format_data);
						sheet.mergeCells(10,repeat+17+z,12,repeat+17+z);
						sheet.addCell(label);
						
						label = new Label(13,repeat+17+z,"",format_data);
						sheet.addCell(label);
						
						label = new Label(14,repeat+17+z,"",format_data);
						sheet.addCell(label);
					}
				}else{
					sheet.mergeCells(8,repeat+17,8,repeat+17+j-1);
					sheet.addCell(label);
				}
				
				
				repeat += height;

			}
		
			workbook.write(); 
			workbook.close(); 
			
		} catch(Exception e) {
      			throw new Exception();	
		} finally {
			try{if (rs != null) {rs.close(); rs = null;} } catch (Exception e){}
			if (dbobject != null){dbobject.close(); dbobject = null;}
			if (conn != null) {conn.close(); conn = null;}
		}
	}
	/**
	 * Method Name : ReadExcelFile <br>
	 * Method Description	: 웹환경에서 엑셀파일을 읽어 Vector에 저장한다. <br>
	 * 
	 * @param			int, String, String
	 * @throws			Exception
	 */
	public Vector ReadExcelFile(int startRow,String FilePath, String FileName) 
	throws Exception {
		Vector vt = null;
		try{
			vt = new Vector();
			int cellLen = 0;
			
			Workbook workbook = Workbook.getWorkbook(new File(FilePath+"/"+FileName)); //엑셀파일을 읽는다.
			Sheet sheet = workbook.getSheet(0);
		  
			int col = sheet.getColumns();  // 시트의 컬럼의 수를 반환한다. 
			int row = sheet.getRows();     // 시트의 열의 수를 반환한다.
			int notCell = 0; //유효하지 않은 값을 포함하는 연속된 Cell의 갯수이며, 10이상이면 Sheet를 더이상 읽지 않는다.
			
        	for(int i=startRow ; i<row ; i++)  {  // Record를 읽어 배열로 저장, startRow부터 시작한다.
        	  Cell cell [] = sheet.getRow(i);
        	  
        	  cellLen      = cell.length;         // ArrayIndexOutOfBoundsException을 막기위해.
        	  String[] temp = new String[col];    // String array;
        	  
        	  for (int j=0; j<col ; j++) {        // 레코더의 전체 컬럼수 만큼 반복
        	  
	        	   if (j < cellLen){  
	        	   		temp[j] = (cell[j].getContents()).replaceAll("\n",""); //엑셀에서 Enter문자를 ''로 처리한다.
	        	   } else{
	        	   	    temp[j] = "";
	        	   }
	        	   
	        	   if(j==0){
		        	   if(temp[0].equals("")) {
		        	   		notCell++;
		        	   }else { 
		        	   		notCell=0;
		        	   }
	        	   }
        	  }
        	  if(notCell > 9 )break;
        	  vt.add(temp);
            }
		} catch(Exception e) {
  			throw new Exception();	
		}
		return vt;
	}
}

