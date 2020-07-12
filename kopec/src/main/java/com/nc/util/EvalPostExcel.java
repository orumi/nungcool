package com.nc.util;

import java.io.*;
import java.util.Vector;
import javax.sql.RowSet;

import com.nc.util.Common;

import jxl.*;
import jxl.write.*;
import jxl.format.Colour;
import jxl.format.ScriptStyle;
import jxl.format.UnderlineStyle;

/**
 * <pre>
 * <li>Program Name : PostExcel
 * <li>��ƿ java Class
 * <li>Version : 1.00
 * <li>History : 2005/07/06 �ֿ�ö  �����ۼ�
 * <li>edit : 2005/07/06 �ֿ�ö
 * </pre>
 * @author �ֿ�ö 
 */    
public class EvalPostExcel 
{
	/**
	 * Method Name : CreateExcelFile <br>
	 * Method Description	: ��ȯ�濡�� ���������� �����. <br>
	 * 
	 * @param			RowSet, String[], String[], int[], String, String
	 * @throws			Exception
	 */
	public void CreateExcelFile(RowSet data, String[] column, String[] columnName, int[] columntype, String FilePath, String SheetName) 
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
			while(data.next()){
				for (cellnum = 0; cellnum < column.length; cellnum++) // create 50 cells (0-49) (the += 2 becomes apparent later
				{
					if ( columntype[cellnum] == 0 ) { // BSC���� ���
						label = new jxl.write.Label(cellnum, rownum, data.getString(columnName[cellnum]),format_data); 
						sheet.addCell(label);
						
					} 
					else if ( columntype[cellnum] == 1 ) {
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
						
					}else if ( columntype[cellnum] == 5 ) { // BSC���� ���
						String useValue = "";
						String[] spstr  = Common.filter(columnName[cellnum]).split(":");
						
						if(spstr.length > 1) //:�� �������� �տ����� �ִٸ� �տ� ���� ����ϰ� �׷��� ������ �ڿ����� ����Ѵ�.
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
	 * Method Description	: ��ȯ�濡�� ����ڼ���(Ư���� ��������) ���������� �����. <br>
	 * 
	 * @param			RowSet, String[], String[], int[], String, String
	 * @throws			Exception
	 */
	public void CreateFormedExcelFile(RowSet data, String[] column, String[] columnName, int[] columntype, String FilePath, String SheetName) 
	throws Exception {
		
		try {
			int cellnum, rownum;
			WritableWorkbook workbook = Workbook.createWorkbook(new File(FilePath)); 
			WritableSheet sheet = workbook.createSheet(SheetName, 0);
			
			jxl.write.Label label = null;
			jxl.write.Blank blank = null;
			jxl.write.Number num = null;

			WritableFont TitleSet = new WritableFont(WritableFont.createFont("����"),25, WritableFont.NO_BOLD,  false,  UnderlineStyle.NO_UNDERLINE, Colour.BLACK,ScriptStyle.NORMAL_SCRIPT);
			
			jxl.write.WritableCellFormat format_column1 = new WritableCellFormat();
			jxl.write.WritableCellFormat format_column2 = new WritableCellFormat();
			jxl.write.WritableCellFormat format_column3 = new WritableCellFormat(TitleSet);
			
			format_column1.setBackground(jxl.format.Colour.GRAY_25 );
			format_column2.setBackground(jxl.format.Colour.AQUA);
			format_column3.setBackground(jxl.format.Colour.WHITE);
			
			format_column1.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN );
			format_column2.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN );
			format_column3.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN );
			
			
			//Title Row,Column 
			sheet.mergeCells(0,0,6,0);
			label = new jxl.write.Label( 0, 0, "�򰡺���", format_column3);
			sheet.addCell(label);
			
			System.out.println(data.getMaxRows());
			System.out.println(data.getMaxRows());
			System.out.println(data.getMaxRows());
			System.out.println(data.getMaxRows());
			//Blank Row, column
			blank = new jxl.write.Blank(6,1);
			sheet.addCell(blank);
			
			//Column List
			for ( cellnum = 0; cellnum < column.length; cellnum++ ) {
				if(cellnum < 5)
					label = new jxl.write.Label(cellnum,2,column[cellnum],format_column1);
				else
					label = new jxl.write.Label(cellnum,2,column[cellnum],format_column2);
				sheet.addCell(label);
			}
			
			//Content Format
			jxl.write.WritableCellFormat format_data = new WritableCellFormat();
			
			format_data.setBackground(jxl.format.Colour.WHITE );
			format_data.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN );

			rownum = 3;
			while(data.next()){
				for (cellnum = 0; cellnum < column.length; cellnum++)
				{
					if ( columntype[cellnum] == 0 ) { // BSC���� ���
						label = new jxl.write.Label(cellnum, rownum, data.getString(columnName[cellnum]),format_data); 
						sheet.addCell(label);
						
					} else if ( columntype[cellnum] == 5 ) { // BSC���� ���
						String useValue = "";
						String[] spstr  = Common.filter(columnName[cellnum]).split(":");
						
						if(spstr.length > 1) //:�� �������� �տ����� �ִٸ� �տ� ���� ����ϰ� �׷��� ������ �ڿ����� ����Ѵ�.
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
	 * Method Name : ReadExcelFile <br>
	 * Method Description	: ��ȯ�濡�� ���������� �о� Vector�� �����Ѵ�. <br>
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
			Workbook workbook = Workbook.getWorkbook(new File(FilePath+"/"+FileName)); //���������� �д´�.
			Sheet sheet = workbook.getSheet(0);
		  
			int col = sheet.getColumns();  // ��Ʈ�� �÷��� ���� ��ȯ�Ѵ�. 
			int row = sheet.getRows();     // ��Ʈ�� ���� ���� ��ȯ�Ѵ�.
			int notCell = 0; //��ȿ���� ���� ���� �����ϴ� ���ӵ� Cell�� �����̸�, 10�̻��̸� Sheet�� ���̻� ���� �ʴ´�.
			
        	for(int i=startRow ; i<row ; i++)  {  // Record�� �о� �迭�� ����, startRow���� �����Ѵ�.
        	  Cell cell [] = sheet.getRow(i);
        	  
        	  cellLen      = cell.length;         // ArrayIndexOutOfBoundsException�� ��������.
        	  String[] temp = new String[col];    // String array;
        	  
        	  for (int j=0; j<col ; j++) {        // ���ڴ��� ��ü �÷��� ��ŭ �ݺ�
        	  
	        	   if (j < cellLen){  
	        	   		temp[j] = (cell[j].getContents()).replaceAll("\n",""); //�������� Enter���ڸ� ''�� ó���Ѵ�.
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
        	  
        	  if(notCell > 50 )break;
        	  vt.add(temp);
            }
		} catch(Exception e) {
  			throw new Exception();	
		}
		return vt;
	}
}

