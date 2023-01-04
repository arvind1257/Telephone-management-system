<%@page import="java.time.Period"%>
<%@page import="java.time.LocalDate"%>
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
    public String convert(String date,int n)
    {
        LocalDate dates = LocalDate.parse(date+"-01");
        dates = dates.plusMonths(n);
        String date2 = dates.toString();
        String[] date1 = date2.split("-");
        return date1[0]+"-"+date1[1];
    }
    public char alpha(int n)
    {
        n+=65;
        return (char)n;
    }
    
    
%>
<% 
    
    session.getAttribute("uid");
    String imagepath = getServletContext().getRealPath("images") + File.separator + "myLogo.png";
    String bill_month1=request.getParameter("dmonth1");
    String bill_month2=request.getParameter("dmonth2");
    String operator=request.getParameter("mobile5");
    String Operators = "";
    
    int sum=0;
    double cgst = 0.0;
    double sgst = 0.0;
    int i;
    
    DateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
    Calendar obj = Calendar.getInstance();
    String date = formatter.format(obj.getTime());
    double[] extra = new double[11];
    String[] name = {"Fixed Monthly Charges","Usage Charges","Miscellaneous Charges","Late Charge","Sub Total","Discounts","Adjustments","Total Charges","CGST","SGST","Total"};
    if(operator.equals("airtel")) Operators="Airtel Mobile";
    else if(operator.equals("bsnl")) Operators="Bsnl Mobile";
    else if(operator.equals("jio")) Operators="Jio Mobile";
    else if(operator.equals("vodofone")) Operators="Vodofone Mobile";
    else if(operator.equals("airtellandline")) Operators="Airtel Landline";
    else if(operator.equals("airtelvip")) Operators="Airtel Vip Mobile";
    else if(operator.equals("bsnllandline")) Operators="Bsnl Landline";
    
    Class.forName("com.mysql.cj.jdbc.Driver");
    Connection con = (Connection)session.getAttribute("connection");
    Statement stm = con.createStatement();
    ResultSet rs = null;
    
    LocalDate date1 = LocalDate.parse(bill_month1+"-01");
    LocalDate date2 = LocalDate.parse(bill_month2+"-01");
    Period period = Period.between(date1,date2);
    int count = 0;
    if(period.getYears()>0)
        count =period.getYears()*12 + period.getMonths() + 1;
    else
        count=period.getMonths() + 1;
    
    XSSFWorkbook wb = new XSSFWorkbook();
    XSSFSheet sheet = wb.createSheet();
    
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
    sheet.setColumnWidth(0,1300);
    sheet.setColumnWidth(1,7500);
    sheet.setColumnWidth(2,3000);
    sheet.setColumnWidth(3,9000);
    sheet.setColumnWidth(4,9400);
    sheet.setColumnWidth(5,2800);
    for(i=0;i<count;i++)
        sheet.setColumnWidth(i+6,2800);
        
    createCell(wb,header,0,HorizontalAlignment.CENTER,true,12,"S No","");
    createCell(wb,header,1,HorizontalAlignment.CENTER,true,12,"Name","");
    createCell(wb,header,2,HorizontalAlignment.CENTER,true,12,"Staff Id","");
    createCell(wb,header,3,HorizontalAlignment.CENTER,true,12,"Designation","");
    createCell(wb,header,4,HorizontalAlignment.CENTER,true,12,"Mobile No","");
    for(i=0;i<count;i++)
        createCell(wb,header,(i+5),HorizontalAlignment.CENTER,true,12,convert(bill_month1,i),"");
    createCell(wb,header,(i+5),HorizontalAlignment.CENTER,true,12,"Total","");
    XSSFRow row ;
    rs=stm.executeQuery("select * from "+operator);           
    int index=7;
    while(rs.next())
    {
        Statement stm1 = con.createStatement();
        ResultSet rs1 = null;
        int rowsum = 0;
        rs1 = stm1.executeQuery("select * from bills where operator='"+operator+"' and phone='"+rs.getString("phone")+"'");
        row = sheet.createRow(index);
        for(i=0;i<count;i++)
            createCell(wb,row,i+5,HorizontalAlignment.RIGHT,false,12,"",""); 
        while(rs1.next())
        {
            createCell(wb,row,0,HorizontalAlignment.CENTER,false,12,Integer.toString(index-6),"");
            createCell(wb,row,1,HorizontalAlignment.LEFT,false,12,rs1.getString("name"),"");
            createCell(wb,row,2,HorizontalAlignment.CENTER,false,12,rs1.getString("emp"),"");
            createCell(wb,row,3,HorizontalAlignment.LEFT,false,12,rs1.getString("desi"),"");
            createCell(wb,row,4,HorizontalAlignment.CENTER,false,12,rs1.getString("phone"),"");
            for(i=0;i<count;i++)
            {
                if(rs1.getString("date").equals(convert(bill_month1,i)))
                {
                    createCell(wb,row,i+5,HorizontalAlignment.RIGHT,false,12,rs1.getString("amount"),"0.00");                      
                    rowsum+=(int)Double.parseDouble(rs1.getString("amount"));
                }    
            }
            
        }
        createCell(wb,row,count+5,HorizontalAlignment.RIGHT,false,12,Integer.toString(rowsum),"0.00");
        index++;
    }
    if(operator.equals("bsnl"))
    {
        for(int j=0;j<name.length;j++)
        {
            row = sheet.createRow(index);
            createCell(wb,row,0,HorizontalAlignment.CENTER,false,13,"","");
            createCell(wb,row,1,HorizontalAlignment.CENTER,false,13,"","");
            createCell(wb,row,2,HorizontalAlignment.CENTER,false,13,"","");
            createCell(wb,row,3,HorizontalAlignment.CENTER,false,13,"","");
            createCell(wb,row,4,HorizontalAlignment.LEFT,true,13,name[j],"");
            for(i=0;i<count;i++)
            {
                rs=stm.executeQuery("select * from bills where operator='"+operator+"' and date='"+convert(bill_month1,i)+"'");
                if(rs.next())
                {
                    do
                    {
                        extra[0] = Double.parseDouble(rs.getString("fixed"));
                        extra[1] = Double.parseDouble(rs.getString("usages"));
                        extra[2] = Double.parseDouble(rs.getString("misc"));
                        extra[3] = Double.parseDouble(rs.getString("late"));
                        extra[4] = extra[0]+extra[1]+extra[2]+extra[3];
                        extra[5] = Double.parseDouble(rs.getString("discount"));
                        extra[6] = Double.parseDouble(rs.getString("adj"));
                        extra[7] = extra[4]-extra[5]-extra[6];
                        extra[8] = extra[7]*Double.parseDouble(rs.getString("cgst"));
                        extra[9] = extra[7]*Double.parseDouble(rs.getString("sgst"));
                        extra[10] = extra[8] + extra[9] + extra[7];
                    }while(rs.next());
                }
                createCell(wb,row,i+5,HorizontalAlignment.RIGHT,false,13,Double.toString(extra[j]),"0.00");
            }
            index+=1;
        }    
    }   
    else
    {
        row = sheet.createRow(index);
        createCell(wb,row,0,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,1,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,2,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,3,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,4,HorizontalAlignment.LEFT,true,13,"TAX","");
        for(i=0;i<count;i++)
        {
            rs=stm.executeQuery("select * from bills where operator='"+operator+"' and date='"+convert(bill_month1,i)+"'");
            if(rs.next())
            {
                do
                {
                    sum+=Double.parseDouble(rs.getString("amount"));
                    cgst=Double.parseDouble(rs.getString("cgst"));
                    sgst=Double.parseDouble(rs.getString("sgst"));
                }while(rs.next());
            }
            createCellFormula(wb,row,i+5,HorizontalAlignment.RIGHT,false,13,"sum("+alpha(i+5)+"1:"+alpha(i+5)+index+")*("+sgst+"+"+cgst+")");
        }
        index+=1;
        row = sheet.createRow(index);
        createCell(wb,row,0,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,1,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,2,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,3,HorizontalAlignment.CENTER,false,13,"","");
        createCell(wb,row,4,HorizontalAlignment.LEFT,true,13,"Total Rs","");
        for(i=0;i<count;i++)
            createCellFormula(wb,row,i+5,HorizontalAlignment.RIGHT,false,13,"sum("+alpha(i+5)+"1:"+alpha(i+5)+index+")");
        index+=1;
    }
    
    
    
           
    ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
    wb.write(outByteStream);
    byte [] outArray = outByteStream.toByteArray();
    response.setContentType("application/ms-excel");
    response.setContentLength(outArray.length); 
    response.setHeader("Expires:", "0"); // eliminates browser caching
    response.setHeader("Content-Disposition", "attachment; filename="+operator+".xls");
    OutputStream outStream = response.getOutputStream();
    outStream.write(outArray);
    outStream.flush();
    
%>