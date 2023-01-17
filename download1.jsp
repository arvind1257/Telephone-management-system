<%@page import="java.sql.*"%>
<%@page import="java.text.*"%>
<%@page import="java.util.*"%>
<%@page import="java.io.*" %>
<%@page import="org.apache.poi.hssf.*"%>
<%@page import="org.apache.poi.ss.usermodel.*"%>
<%@page import="org.apache.poi.ss.util.*"%>
<%@page import="org.apache.poi.xssf.usermodel.*"%>
<%@page import="org.apache.poi.util.IOUtils"%>

<%!
    private static void createCell(XSSFWorkbook wb, XSSFRow row, int column, HorizontalAlignment align, boolean bold, int size,String val,String format) 
    {
        XSSFCell cell = row.createCell(column);
        XSSFCellStyle cellStyle = wb.createCellStyle();
        XSSFDataFormat dataFormat = wb.createDataFormat();
        try 
        {
            cell.setCellValue(Math.round(Double.parseDouble(val)*100.00)/100.00);
        } 
        catch (NumberFormatException e) 
        {
            cell.setCellValue(val);
        } 
        catch(NullPointerException e) 
        {
            cell.setCellValue(val);
        }
        if(format.equals("0.00"))
            cellStyle.setDataFormat(dataFormat.getFormat("0.00"));
        Font font = wb.createFont();
        font.setBold(bold);
        font.setFontHeightInPoints((short)size);  
        font.setFontName("Times New Roman");  
        cellStyle.setFont(font);
        cellStyle.setAlignment(align);
        cellStyle.setBorderBottom(BorderStyle.THIN);
        cellStyle.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        cellStyle.setBorderLeft(BorderStyle.THIN);
        cellStyle.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        cellStyle.setBorderRight(BorderStyle.THIN);
        cellStyle.setRightBorderColor(IndexedColors.BLACK.getIndex());
        cellStyle.setBorderTop(BorderStyle.THIN);
        cellStyle.setTopBorderColor(IndexedColors.BLACK.getIndex());
        cell.setCellStyle(cellStyle);
    }
    private static void createCellFormula(XSSFWorkbook wb, XSSFRow row, int column, HorizontalAlignment align, boolean bold, int size,String val) 
    {
        XSSFCell cell = row.createCell(column);
        cell.setCellFormula(val);
        XSSFDataFormat dataFormat = wb.createDataFormat();
        XSSFCellStyle cellStyle = wb.createCellStyle();
        cellStyle.setDataFormat(dataFormat.getFormat("0.00"));
        Font font = wb.createFont();
        font.setBold(bold);
        font.setFontHeightInPoints((short)size);  
        font.setFontName("Times New Roman");  
        cellStyle.setFont(font);
        cellStyle.setAlignment(align);
        cellStyle.setBorderBottom(BorderStyle.THIN);
        cellStyle.setBottomBorderColor(IndexedColors.BLACK.getIndex());
        cellStyle.setBorderLeft(BorderStyle.THIN);
        cellStyle.setLeftBorderColor(IndexedColors.BLACK.getIndex());
        cellStyle.setBorderRight(BorderStyle.THIN);
        cellStyle.setRightBorderColor(IndexedColors.BLACK.getIndex());
        cellStyle.setBorderTop(BorderStyle.THIN);
        cellStyle.setTopBorderColor(IndexedColors.BLACK.getIndex());
        cell.setCellStyle(cellStyle);
    }
    private static String numberToWord(int number) {
        String words = "";
        String unitsArray[] = { "Zero", "One", "Two", "Three", "Four", "Five", "Six", 
                      "Seven", "Eight", "Nine", "Ten", "Eleven", "Twelve",
                      "Thirteen", "Fourteen", "Fifteen", "Sixteen", "Seventeen", 
                      "Eighteen", "Nineteen" };
	String tensArray[] = { "Zero", "Ten", "Twenty", "Thirty", "Forty", "Fifty",
                      "Sixty", "Seventy", "Eighty", "Ninety" };
 
	if (number == 0) {
	    return "zero";
	}
	if ((number / 1000) > 0) {
	    words += numberToWord(number / 1000) + " thousand ";
	    number %= 1000;
	}
	if ((number / 100) > 0) {
	     words += numberToWord(number / 100) + " hundred ";
	     number %= 100;
	}
        if (number > 0) {
	    if (number < 20) { 
                words += unitsArray[number];
            } 
            else{ 
                words += tensArray[number / 10]; 
                if ((number % 10) > 0) {
		    words += "-" + unitsArray[number % 10];
                }  
	    }
        }
	return words;
    }
    
%>
<% 
    
    session.getAttribute("uid");
    String imagepath = getServletContext().getRealPath("images") + File.separator + "myLogo.png";
    String bill_month=request.getParameter("dmonth1");
    String month[] = bill_month.split("-",2);
    int months1 = Integer.parseInt(month[1]);
    int months2 = months1-1;
    String month1[] = {"JAN-"+month[0],"FEB-"+month[0],"MAR-"+month[0],"APR-"+month[0],"MAY-"+month[0],"JUN-"+month[0],"JUL-"+month[0],"AUG-"+month[0],"SEP-"+month[0],"OCT-"+month[0],"NOV-"+month[0],"DEC-"+month[0]};
    if(months1==1)
    {
        month[0]=Integer.toString(Integer.parseInt(month[0])-1);
        months2=12;
    }
    String month3[] = {"JAN","FEB","MAR","APR","MAY","JUN","JUL","AUG","SEP","OCT","NOV","DEC"};
    String month2[] = {"JAN-"+month[0],"FEB-"+month[0],"MAR-"+month[0],"APR-"+month[0],"MAY-"+month[0],"JUN-"+month[0],"JUL-"+month[0],"AUG-"+month[0],"SEP-"+month[0],"OCT-"+month[0],"NOV-"+month[0],"DEC-"+month[0]};
    String month22[] = {"JANUARY-"+month[0],"FEBRUARY-"+month[0],"MARCH-"+month[0],"APRIL-"+month[0],"MAY-"+month[0],"JUNE-"+month[0],"JULY-"+month[0],"AUGEST-"+month[0],"SEPTEMBER-"+month[0],"OCTOBER-"+month[0],"NOVEMBER-"+month[0],"DECEMBER-"+month[0]};
    String Operators = "";
    double cgst = 0.0;
    double sgst = 0.0;
    int sum = 0;
    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    Calendar obj = Calendar.getInstance();
    String date = formatter.format(obj.getTime());
    double[] extra = new double[12];
    String[] name = {"One Time Charges","Fixed Monthly Charges","Usage Charges","Miscellaneous Charges","Late Charge","Sub Total","Discounts","Adjustments","Total Charges","CGST","SGST","Total"};
    String operator=request.getParameter("mobile5");
    if(operator.equals("airtel")) Operators="AIRTEL MOBILE";
    else if(operator.equals("bsnl")) Operators="BSNL";
    else if(operator.equals("jio")) Operators="JIO MOBILE";
    else if(operator.equals("vodofone")) Operators="VODOFONE MOBILE";
    else if(operator.equals("airtellandline")) Operators="AIRTEL LANDLINE";
    else if(operator.equals("airtelvip")) Operators="AIRTEL VIP MOBILE";
    else if(operator.equals("bsnllandline")) Operators="BSNL LANDLINE";
    
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = (Connection)session.getAttribute("connection");
    Statement stm = con.createStatement();
    ResultSet rs = null;
    
    XSSFWorkbook wb = new XSSFWorkbook();
    XSSFSheet sheet;
    if(operator.equals("airtel"))
    sheet = wb.createSheet(month3[months2-1]+"-"+month1[months1-1]);
    else
    sheet = wb.createSheet(month2[months2-1]);
    InputStream inputStream = new FileInputStream(imagepath);
    byte[] bytes = IOUtils.toByteArray(inputStream);
    int pictureIdx = wb.addPicture(bytes, Workbook.PICTURE_TYPE_PNG);
    inputStream.close();
    CreationHelper helper = wb.getCreationHelper();
    Drawing drawing = sheet.createDrawingPatriarch();
    ClientAnchor anchor = helper.createClientAnchor();
    anchor.setCol1(1);
    anchor.setRow1(1);
    Picture pict = drawing.createPicture(anchor, pictureIdx);
    pict.resize();

    XSSFRow header = sheet.createRow(6);
    if(operator.equals("bsnl"))
    createCell(wb,header,0,HorizontalAlignment.CENTER,true,10,""+Operators+" MONTHLY STATEMENT FOR THE MONTH OF  "+month22[months2-1]+"     BILL-DATE: "+date+""," ");
    else
    createCell(wb,header,0,HorizontalAlignment.CENTER,true,10,"Statement of "+Operators+" Bill for the Period of  "+month2[months2-1]+" to "+month1[months1-1]+"    DATE: "+date+""," ");
    createCell(wb,header,1,HorizontalAlignment.CENTER,true,10,"","");
    createCell(wb,header,2,HorizontalAlignment.CENTER,true,10,"","");
    createCell(wb,header,3,HorizontalAlignment.CENTER,true,10,"","");
    createCell(wb,header,4,HorizontalAlignment.CENTER,true,10,"","");
    createCell(wb,header,5,HorizontalAlignment.CENTER,true,10,"","");

    sheet.addMergedRegion(new CellRangeAddress(6,6,0,5));
        
    sheet.setColumnWidth(0,1300);
    sheet.setColumnWidth(1,6500);
    sheet.setColumnWidth(2,2000);
    sheet.setColumnWidth(3,7000);
    sheet.setColumnWidth(4,3400);
    sheet.setColumnWidth(5,2800);
    
    header = sheet.createRow(7);
    createCell(wb,header,0,HorizontalAlignment.CENTER,true,12,"S No","");
    createCell(wb,header,1,HorizontalAlignment.CENTER,true,12,"Name","");
    createCell(wb,header,2,HorizontalAlignment.CENTER,true,12,"Staff Id","");
    createCell(wb,header,3,HorizontalAlignment.CENTER,true,12,"Designation","");
    createCell(wb,header,4,HorizontalAlignment.CENTER,true,12,"Mobile No","");
    createCell(wb,header,5,HorizontalAlignment.CENTER,true,12,"Total    ","");
    
    XSSFRow row ;
    rs=stm.executeQuery("select * from bills where operator='"+operator+"' and date='"+bill_month+"'");           
    int index=8;
    while(rs.next())
    {
        if(rs.getString("operator")!=null)
        {                    
            row = sheet.createRow(index);
            createCell(wb,row,0,HorizontalAlignment.CENTER,false,11,Integer.toString(index-7),"");
            createCell(wb,row,1,HorizontalAlignment.LEFT,false,11,rs.getString("name"),"");
            createCell(wb,row,2,HorizontalAlignment.CENTER,false,11,rs.getString("emp"),"");
            createCell(wb,row,3,HorizontalAlignment.LEFT,false,11,rs.getString("desi"),"");
            createCell(wb,row,4,HorizontalAlignment.CENTER,false,11,rs.getString("phone"),"");
            createCell(wb,row,5,HorizontalAlignment.RIGHT,false,11,rs.getString("amount"),"0.00");
            cgst = Double.parseDouble(rs.getString("cgst"));
            sgst = Double.parseDouble(rs.getString("sgst"));
            sum+=Double.parseDouble(rs.getString("amount"));
            index++;
            if(rs.getString("operator").equals("bsnl"))
            {
            
            extra[0] = Double.parseDouble(rs.getString("one"));
            extra[1] = Double.parseDouble(rs.getString("fixed"));
            extra[2] = Double.parseDouble(rs.getString("usages"));
            extra[3] = Double.parseDouble(rs.getString("misc"));
            extra[4] = Double.parseDouble(rs.getString("late"));
            extra[5] = extra[0]+extra[1]+extra[2]+extra[3]+extra[4];
            extra[6] = Double.parseDouble(rs.getString("discount"));
            extra[7] = Double.parseDouble(rs.getString("adj"));
            extra[8] = extra[5]-extra[6]-extra[7];
            extra[9] = extra[8]*Double.parseDouble(rs.getString("cgst"));
            extra[10] = extra[8]*Double.parseDouble(rs.getString("sgst"));
            extra[11] = extra[9] + extra[10] + extra[8];
            sum=(int)extra[11];
            }
        }
    }
    
    if(operator.equals("bsnl"))
    {
    for(int i=0;i<12;i++,index++)
    {
        row = sheet.createRow(index);
        createCell(wb,row,0,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,1,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,2,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,3,HorizontalAlignment.RIGHT,true,13,name[i],"");
        createCell(wb,row,4,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,5,HorizontalAlignment.RIGHT,false,13,Double.toString(extra[i]),"0.00");
    }
    }   
    else
    {
    sum+=sum*(cgst+sgst);
    row = sheet.createRow(index);
    createCell(wb,row,0,HorizontalAlignment.CENTER,false,13,"","");
    createCell(wb,row,1,HorizontalAlignment.CENTER,false,13,"","");
    createCell(wb,row,2,HorizontalAlignment.CENTER,false,13,"","");
    createCell(wb,row,3,HorizontalAlignment.CENTER,false,13,"","");
    createCell(wb,row,4,HorizontalAlignment.LEFT,true,13,"TAX","");
    createCellFormula(wb,row,5,HorizontalAlignment.RIGHT,false,13,"sum(F1:F"+index+")*("+sgst+"+"+cgst+")");
    index+=1;
    
    row = sheet.createRow(index);
    createCell(wb,row,0,HorizontalAlignment.CENTER,false,13,"","");
    createCell(wb,row,1,HorizontalAlignment.CENTER,false,13,"","");
    createCell(wb,row,2,HorizontalAlignment.CENTER,false,13,"","");
    createCell(wb,row,3,HorizontalAlignment.CENTER,false,13,"","");
    createCell(wb,row,4,HorizontalAlignment.LEFT,true,13,"Total Rs","");
    createCellFormula(wb,row,5,HorizontalAlignment.RIGHT,true,13,"sum(F1:F"+index+")");
    index+=1;
    }
    
    sheet.addMergedRegion(new CellRangeAddress(index,index,0,5));
    row = sheet.createRow(index);
    createCell(wb,row,0,HorizontalAlignment.CENTER,true,14,"Rupees : "+numberToWord(sum),"0.00");
    createCell(wb,row,1,HorizontalAlignment.CENTER,false,13,"","");
    createCell(wb,row,2,HorizontalAlignment.CENTER,false,13,"","");
    createCell(wb,row,3,HorizontalAlignment.RIGHT,true,13,"","");
    createCell(wb,row,4,HorizontalAlignment.CENTER,false,13,"","");
    createCell(wb,row,5,HorizontalAlignment.RIGHT,false,13,"","");
    index+=5;
    
    row = sheet.createRow(index);
    sheet.addMergedRegion(new CellRangeAddress(index,index,3,4));
    XSSFCell cell = row.createCell(1);
    cell.setCellValue("Dept,Manager-CTS");
    cell=row.createCell(3);
    XSSFCellStyle cellStyle = wb.createCellStyle();
    cellStyle.setAlignment(HorizontalAlignment.RIGHT);
    cell.setCellStyle(cellStyle);
    cell.setCellValue("Dept. Director - Systems  (CTS)");
    
    if(operator.equals("airtel"))
    {
        index+=10;
        CreationHelper helper1 = wb.getCreationHelper();
        Drawing drawing1 = sheet.createDrawingPatriarch();
        ClientAnchor anchor1 = helper1.createClientAnchor();
        anchor1.setCol1(1);
        anchor1.setRow1(index-5);
        Picture pict1 = drawing1.createPicture(anchor1, pictureIdx);
        pict1.resize();
        
        row = sheet.createRow(index);
        sheet.addMergedRegion(new CellRangeAddress(index,index,0,5));
        createCell(wb,row,0,HorizontalAlignment.CENTER,true,10,"Statement of "+Operators+" Bill for the Period of  "+month2[months2-1]+" to "+month1[months1-1]+"    DATE: "+date+""," ");
        createCell(wb,row,1,HorizontalAlignment.CENTER,true,10,"","");
        createCell(wb,row,2,HorizontalAlignment.CENTER,true,10,"","");
        createCell(wb,row,3,HorizontalAlignment.CENTER,true,10,"","");
        createCell(wb,row,4,HorizontalAlignment.CENTER,true,10,"","");
        createCell(wb,row,5,HorizontalAlignment.CENTER,true,10,"","");
        
        index++;
        row = sheet.createRow(index);
        createCell(wb,row,0,HorizontalAlignment.CENTER,true,12,"S No","");
        createCell(wb,row,1,HorizontalAlignment.CENTER,true,12,"Name","");
        createCell(wb,row,2,HorizontalAlignment.CENTER,true,12,"Staff Id","");
        createCell(wb,row,3,HorizontalAlignment.CENTER,true,12,"Designation","");
        createCell(wb,row,4,HorizontalAlignment.CENTER,true,12,"Mobile No","");
        createCell(wb,row,5,HorizontalAlignment.CENTER,true,12,"Total    ","");
        
        int newindex = index;
        rs=stm.executeQuery("select * from bills where operator='airtel_2' and date='"+bill_month+"'");           
        index++;
        sum=0;
        while(rs.next())
        {
            if(rs.getString("operator")!=null)
            {                    
                row = sheet.createRow(index);
                createCell(wb,row,0,HorizontalAlignment.CENTER,false,11,Integer.toString(index-newindex),"");
                createCell(wb,row,1,HorizontalAlignment.LEFT,false,11,rs.getString("name"),"");
                createCell(wb,row,2,HorizontalAlignment.CENTER,false,11,rs.getString("emp"),"");
                createCell(wb,row,3,HorizontalAlignment.LEFT,false,11,rs.getString("desi"),"");
                createCell(wb,row,4,HorizontalAlignment.CENTER,false,11,rs.getString("phone"),"");
                createCell(wb,row,5,HorizontalAlignment.RIGHT,false,11,rs.getString("amount"),"0.00");
                cgst = Double.parseDouble(rs.getString("cgst"));
                sgst = Double.parseDouble(rs.getString("sgst"));
                sum+=Double.parseDouble(rs.getString("amount"));
                index++;
            }
        }
        sum+=sum*(cgst+sgst);
        row = sheet.createRow(index);
        createCell(wb,row,0,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,1,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,2,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,3,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,4,HorizontalAlignment.LEFT,true,13,"TAX","");
        createCellFormula(wb,row,5,HorizontalAlignment.RIGHT,false,13,"sum(F"+newindex+":F"+index+")*("+sgst+"+"+cgst+")");
        index+=1;

        row = sheet.createRow(index);
        createCell(wb,row,0,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,1,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,2,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,3,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,4,HorizontalAlignment.LEFT,true,13,"Total Rs","");
        createCellFormula(wb,row,5,HorizontalAlignment.RIGHT,true,13,"sum(F"+newindex+":F"+index+")");
        index+=1;

        sheet.addMergedRegion(new CellRangeAddress(index,index,0,5));
        row = sheet.createRow(index);
        createCell(wb,row,0,HorizontalAlignment.CENTER,true,14,"Rupees : "+numberToWord(sum),"0.00");
        createCell(wb,row,1,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,2,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,3,HorizontalAlignment.RIGHT,true,13,"","");
        createCell(wb,row,4,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,5,HorizontalAlignment.RIGHT,false,13,"","");
        index+=5;

        row = sheet.createRow(index);
        sheet.addMergedRegion(new CellRangeAddress(index,index,3,4));
        cell = row.createCell(1);
        cell.setCellValue("Dept,Manager-CTS");
        cell=row.createCell(3);
        cellStyle = wb.createCellStyle();
        cellStyle.setAlignment(HorizontalAlignment.RIGHT);
        cell.setCellStyle(cellStyle);
        cell.setCellValue("Dept. Director - Systems  (CTS)");
    }
           
    ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
    wb.write(outByteStream);
    byte [] outArray = outByteStream.toByteArray();
    response.setContentType("application/ms-excel");
    response.setContentLength(outArray.length); 
    response.setHeader("Expires:", "0");
    response.setHeader("Content-Disposition", "attachment; filename="+Operators+" "+month2[months2-1]+".xls");
    OutputStream outStream = response.getOutputStream();
    outStream.write(outArray);
    outStream.flush();
    
%>