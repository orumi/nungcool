<%@ page language="java"%>
<%@ page contentType="text/html; charset=euc-kr"%>
<%@ page import="com.nc.actual.*,
				 com.nc.util.*,
				 java.util.*,
				 java.io.*,
				 java.io.File,
				 java.util.Date,
				 jxl.*,
				 jxl.write.*"%>
<%

	response.setContentType("application/vnd.ms-excel;charset=euc-kr");
	request.setCharacterEncoding("euc-kr");

	String imgUri = request.getRequestURI();
	imgUri = imgUri.substring(1);
	imgUri = "../../../../" + imgUri.substring(0, imgUri.indexOf("/"));

	String year = request.getParameter("year") != null ? request.getParameter("year") : "____";
	String month1 = request.getParameter("month1") != null ? request.getParameter("month1") : "01";
	String month2 = request.getParameter("month2") != null ? request.getParameter("month2") : "01";
	String mode = (String) request.getParameter("mode")!= null ? request.getParameter("mode") : "";
	String mname = (String) request.getParameter("mname")!= null ? (request.getParameter("mname")).trim() : "taskExport";

	mname = mname.replaceAll(" ","");

	String sF_nm = null;
 	sF_nm = "/"+mname+"_"+year+month1+"_"+year+month2+".xls";  //�������ϸ� : ������_�׸��+��+��������

	String sF_nm2 = new String(sF_nm.getBytes("euc-kr"),"8859_1");  //was�� os�� charset�� ������ ��� �̷������� ���ڵ��� �ؾ� �Ѵ�.
	sF_nm2 =sF_nm;  //was�� os�� charset�� ������ ��� �̷������� ���ڵ��� �ؾ� �Ѵ�.

	ActualUtil util = new ActualUtil();
	util.getOrgMeasure(request, response);

	DataSet ds            = (DataSet)request.getAttribute("ds");
	DataSet dsItem      = (DataSet)request.getAttribute("dsItem");
	DataSet dsItemAct = (DataSet)request.getAttribute("dsItemAct");

	int itemcnt = 0;
	if(dsItem != null)
		itemcnt = dsItem.getRowCount();

	int dsCnt = 0;
	if(ds != null)
		dsCnt = ds.getRowCount();

	System.out.println("mode:"+mode+"/"+year+"/"+month1+"/"+month2+"/"+itemcnt+"/"+dsCnt);

	String Filepath = ServerStatic.REAL_CONTEXT_ROOT+File.separator+"excelFile"+File.separator+"download"+File.separator;

	//exel���ϻ���
	File f = new File(Filepath+sF_nm);  //���Ⱑ �߿�..���⼭ ���� �����

	String path = f.getAbsolutePath();
	//System.out.println("path:"+path);
	WritableWorkbook workbook = Workbook.createWorkbook(f);
	WritableSheet sheet = workbook.createSheet("First Sheet", 0);

	//cell�� ũ��(�ʺ�) ����
	CellView cv = new CellView();
	//cv.setAutosize(true);		//���ڼ��� ���� �ڵ����� ����� �����شٴ� �� ������ �׷��� �ʾҴ�.
	sheet.setColumnView(0,10);	//�׷��� �̿Ͱ��� �ϵ��ڵ����� �ߴ�.
	sheet.setColumnView(1,15);
	sheet.setColumnView(2,30);
	sheet.setColumnView(3,20);
	sheet.setColumnView(4,10);

	jxl.write.WritableCellFormat format= new WritableCellFormat();
	jxl.write.WritableCellFormat format1= new WritableCellFormat();
	jxl.write.WritableCellFormat format2= new WritableCellFormat();
	format.setBackground(jxl.format.Colour.LIGHT_GREEN );
	format.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN );
	format.setAlignment(jxl.format.Alignment.CENTRE);
	format.setVerticalAlignment(jxl.format.VerticalAlignment.CENTRE);
	format1.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN );
	format1.setAlignment(jxl.format.Alignment.LEFT);
	format2.setBackground(jxl.format.Colour.LIGHT_GREEN );
	format2.setBorder(jxl.format.Border.ALL,jxl.format.BorderLineStyle.THIN );
	format2.setAlignment(jxl.format.Alignment.LEFT);
	format2.setWrap(true);

	Label label = null;

	//----------------------------------------------------------------------------------------------------
	// Title ����
	//----------------------------------------------------------------------------------------------------

	int ix = 0;  //���� �ε���
	//	�÷� �Է�
	label = new Label(ix++,0,"�׸����",format);
	sheet.addCell(label);
	label = new Label(ix++,0,"�⵵",format);
	sheet.addCell(label);
	label = new Label(ix++,0,"ETLKEY",format);
	sheet.addCell(label);
	label = new Label(ix++,0,"��ǥ��",format);
	sheet.addCell(label);
	label = new Label(ix++,0,"���",format);
	sheet.addCell(label);
	label = new Label(ix++,0,"�������",format);
	sheet.addCell(label);
	label = new Label(ix++,0,"�׷�",format);
	sheet.addCell(label);
	label = new Label(ix++,0,"�μ�",format);
	sheet.addCell(label);

	if(dsItem != null){
		while (dsItem.next()){
			label = new Label(ix++,0,(dsItem.getString("Code")==null?"":dsItem.getString("Code"))+"_"+(dsItem.getString("ITEMNAME")==null?"":dsItem.getString("ITEMNAME")),format);
			sheet.addCell(label);
		}
	}


	//----------------------------------------------------------------------------------------------------
	//  ���� �Է�...
	//----------------------------------------------------------------------------------------------------
	int iy = 1; //���� �÷� �ε���

	if(ds != null){
		while (ds.next()){
			ix = 0;
			label = new Label(ix++,iy,String.valueOf(iy),format1);
			sheet.addCell(label);
			label = new Label(ix++,iy,year,format1);
			sheet.addCell(label);
			label = new Label(ix++,iy,((String)ds.getString("ETLKEY")).trim()==null?"":((String)ds.getString("ETLKEY")).trim(),format1);
			sheet.addCell(label);
			label = new Label(ix++,iy,((String)ds.getString("MNAME")).trim()==null?"":((String)ds.getString("MNAME")).trim(),format1);
			sheet.addCell(label);
			label = new Label(ix++,iy,((String)ds.getString("EQUATION")).trim()==null?"":((String)ds.getString("EQUATION")).trim(),format1);
			sheet.addCell(label);
			label = new Label(ix++,iy,((String)ds.getString("YM")).trim().equals("")?"":((String)ds.getString("YM")).trim(),format1);
			sheet.addCell(label);
			label = new Label(ix++,iy,((String)ds.getString("SNAME")).trim()==null?"":((String)ds.getString("SNAME")).trim(),format1);
			sheet.addCell(label);
			label = new Label(ix++,iy,((String)ds.getString("BNAME")).trim()==null?"":((String)ds.getString("BNAME")).trim(),format1);
			sheet.addCell(label);


			// ���� �׸��� ���� �߰��ؾ���...
			String   strYM    = (String)ds.getString("YM").trim();
			String   strDID   = (String)ds.getString("DID").trim();

			if (dsItemAct != null){

					for(int i=0;i<itemcnt;i++){

						int z= 0;
					 	while(dsItemAct.next()){

					 		if(z == itemcnt) {
		    					dsItemAct.resetCursor();
		    					break;
		    				}

					 		// ��ǥ���Ǽ� ID�� ��������� ���� ���
					 		if (dsItemAct.getString("STRDATE").equals(strYM) && dsItemAct.getString("MEASUREID").equals(strDID) ){
					 				String strItemActual = (String)dsItemAct.getString("ACTUAL")==null?"":(String)dsItemAct.getString("ACTUAL") ;

					 				label = new Label(ix++,iy,strItemActual, format1);
									sheet.addCell(label);

									System.out.println("���� ���Ƽ� :::" + z+"/"+itemcnt+"=="+dsItemAct.getString("STRDATE")+"/"+strYM+"---"+dsItemAct.getString("MEASUREID")+"/"+ds.getString("MCID")+ " : " + dsItemAct.getString("CODE") + " Actaul : "  + dsItemAct.getString("ACTUAL") );


					 		} //----------- itemActual end.

					 	}

					}	//----------- for loop itemcnt end.

			 		dsItemAct.resetCursor();

			}else{

				for(int i=0;i<itemcnt;i++){
					label = new Label(ix++,iy,"", format1);
					sheet.addCell(label);
				}
			}

			 iy++;
		}
	}

	workbook.write();
	workbook.close();

	/*
	* ��ȯ�� �������� �ٿ�ε� �ϱ�
	*/
	File file = new File(path);
	System.out.println("���� ���� ����(�����ٿ��) : "+file.exists());
	byte b[] = new byte[4096];

	response.setHeader("Content-Disposition", "attachment; filename="+sF_nm2);

	if (file.isFile()){
		BufferedInputStream fin = new BufferedInputStream(new FileInputStream(file));
		BufferedOutputStream outs = new BufferedOutputStream(response.getOutputStream());
		int read = 0;
		while ((read = fin.read(b)) != -1){
	   		outs.write(b,0,read);
	  	}
		outs.close();
		fin.close();

		//���ϻ���
		try{
 			file.delete();
 		}catch(Exception e){
   			System.out.println("���� ���� ���� : "+ e.getMessage());
 		}
	}
%>