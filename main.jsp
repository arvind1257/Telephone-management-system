<%@page import="java.util.Calendar"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.File"%>
<%@page import="java.time.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="jquery.min.js"></script>
        <link rel="stylesheet" href="bootstrap.min.css">
        <link rel="stylesheet" href="bootstrap-datepicker.min.css">
        <script src="bootstrap-datepicker.min.js"></script>
        <script src="jquery.dataTables.min.js"></script>
        <link href="jquery.dataTables.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.5.0/css/all.css" integrity="sha384-B4dIYHKNBt8Bc12p+WXckhzcICo0wtJAoU8YZTY5qE0Id1GSseTk6S+L3BlXeVIU" crossorigin="anonymous">
        <link rel='stylesheet' href='https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css'>
        <link href="jquery-ui.css" rel="stylesheet" type="text/css" />
        <link rel="icon" href="VITLogoEmblem.png">
        <title>TELEBILL</title>
        <%
            response.setHeader("Cache-Control","no-store");
            response.setHeader("Pragma","no-cache"); 
            response.setHeader ("Expires", "0"); //prevents caching at the proxy server
        %>
        <style>
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }
            
            body {
                font-family: sans-serif;
                background-color:#e8e8e8;
            }
            .tab {
                top:52px;
                position: -webkit-sticky;
                background-color: rgba(24,54,186,0.6);
                height: 45px;
                width: 100%;
                padding: 0px;
                position: fixed;
                z-index: 1;
                transition: 0.3s linear;
            }
            .tab ul {
                list-style: none;
                display: flex;
                justify-content: center;
                align-items: center;
                
            }
            .tab ul li {
                padding: 12px 30px;
                position: relative;
            }
            .tab ul li button {
                font-size: 18px;
                font-weight: bolder;
                text-decoration: none;
                transition: all 0.5s;
                border:none;
                color:white;
                background-color:inherit;
            }
            .tab ul li:hover {
                background-color:#1836ba; 
            }
            .tab ul li:hover .main{
                transform:scale(1.2);
            }
            .fas {
                float: right;
                margin-left: 10px;
                padding-top: 3px;
            }
            .ctab {
                transition: all 0.5s;
                display: none;
            }
            .tab ul li:hover .ctab {
                display: block;
                position: absolute;
                left: 0;
                top: 90%;
                transform:scale(1);
                margin-top:4.5px;
                background-color: rgba(24,54,186,0.5);
                z-index: 1;
            }
            .tab ul li:hover .ctab ul {
                display: block;
                margin:5px 10px;
                z-index: 1;
            }
            .tab ul li:hover .ctab ul li {
                padding: 0px;
                z-index: 1;
            }
            .tab ul li:hover .ctab ul li button{
                width: 150px;
                border:none;
                padding:15px;
                font-size:18px;
                font-weight:bolder;
                color: white;
                background-color: rgba(24,54,186,0.5);
                z-index: 1;
            }
            .tab ul li:hover .ctab ul li button:hover{
                color: black;
                z-index: 1;
            }
            .tabcontent { 
                display: none; 
                top:100px; 
                position: relative; 
                float: right; 
                padding: 10px 15px; 
                width: 100%; 
            }
            .tabcontent2 { 
                display: none; 
            }
            .tabcontent11 { 
                width: 70%; 
                padding:5px; 
                float: left; 
            }
            .tabcontent12 { 
                float: right; 
                position: relative;
                width: 30%;
                padding:5px; 
            }
            .center {
                margin-left:auto ; 
                margin-right:auto; 
            } 
            .dropbtn { 
                background-color: rgba(24,54,186,0.5); 
                color:white; 
                margin-right:5px;
                padding: 10px 10px; 
                min-width: 100px;
                height:40px;
                border-radius: 20px;
                font-size: 16px;  
                border: 3px solid rgb(24,54,165); 
                cursor: pointer; 
            }
            .dropbtn:hover { 
                background-color: rgb(24,54,220); 
            }
            .dropbtn:focus { 
                background-color: rgb(24,54,220);
            }
            .dropdown { 
                display: inline-block;
            }
            .dropdown-content { 
                display: none; 
                position: absolute; 
                right:3%;
                background-color: #7c8ef7;
                width: 180px; 
                overflow: auto; 
                z-index: 1; 
                border: 3px solid rgb(24,54,165); 
                border-bottom-left-radius:20px;
                border-bottom-right-radius:20px; 
                color:black;
            }
            .dropdown-content a { 
                background-color: #7c8ef7; 
                padding: 12px;
                text-align:center;
                text-decoration: none; 
                display: block; 
            }
            .dropdown-content button { 
                padding: 12px; 
                border:none; 
                background-color: #7c8ef7; 
                width:100%; 
                font-size:18px; 
                font-weight: bold; 
            }
            .dropdown a:hover,.dropdown-content button:hover {
                background-color: #3250fc;
            }
            .show {
                display: block;
            }
            .home { 
                background-color:#1838ba; 
                padding-top:7px; 
                border:none; 
                cursor:pointer; 
            }
            .header{ 
                width:100%; 
                background-color:#1836ba; 
                padding:2px 10px;
                font-family: timesnewroman; 
                color:white; 
                top:0px;
                display:flex;
                align-items: center;
                justify-content: center;
                position: fixed; 
                z-index: 1;
            }
            .head1{
                width:25%;
                font-size:20px;
            }
            .head2{
                width:40%;
                font-size:30px;
                text-align: center;
            }
            .tablecontent{ 
                background-color:white; 
                border-radius:20px;
                border:10px solid rgba(24,54,186,0.5); 
                margin-bottom: 40px;
            }
            .greenbutton input,.greenbutton1 input{ 
                color:white; 
                padding:10px; 
                background-color:green;
                border:none; 
                width:80%;
            }
            .greenbutton1 input{ 
                width:50%;
            }
            .gb{ 
                color:white; 
                padding:5px; 
                background-color:green; 
                border:none;
                text-decoration: none;
            }
            .rb{ 
                color:white; 
                padding:5px; 
                background-color:red; 
                border:none;
                text-decoration: none;
            }
            .bluebutton{ 
                color:white; 
                padding:4px; 
                background-color:blue;
                border:none; 
                width:50px;
            }
            .submitstyle{
                width:70px;
            }
            .buttonstyle{ 
                font-size:20px; 
                width:200px;
                padding: 13px 30px; 
                font-weight:bold;
            }
            .greenbutton input:hover,.greenbutton1 input:hover{ 
                background-color:lightgreen; 
            }
            .redbutton input{ 
                color:white;
                padding:10px; 
                background-color:red; 
                border:none; 
                width:100px;
            }
            .redbutton input:hover{ 
                background-color:#ff8080; 
            }
            .bsnl_input{ 
                width:70%;
                height:10%;
                font-size:14pt;
            }
            .tablecontent ul{
		list-style-type:none;
		padding:10px;
                font-size:20px;
            }
            .tablecontent ul li{	
		background-color:white; 
		padding:10px 10px;	
            }
            .tablecontent ul li button{
		padding:10px; 
                font-size:20px;
		background-color:blue; 
		color:white;
		width:180px; 
		border:none; 
		cursor:pointer;
            }
            .tablecontent ul li ul{
		list-style-type:disc;
		padding:10px;
		border:none;
                padding-left:150px;
            }	
            .tablecontent ul li ul li{
		color:blue;
                
            }
            .footer{
                position:fixed;
                bottom:0px;
                padding:5px;
                background-color: #1836ba;
                color:white;
                font-size: 10pt;
                text-align: center;
                width:100%;
                z-index: 1;
            }
            .img2{
                width:25px;
                height:25px;
            }
            .profile{
                float:none; 
                width:55%;
            }
            .title{
                color:#1836ba;
                font-size:42px;
                font-weight: bold;
                text-align: center;
            }
            .pcontent11{
                width:60%; 
                float:left; 
                padding:20px; 
                word-break: break-word; 
            }
            .pcontent12{
                width:40%; 
                float:right;
            }
            .pcontent13{
                float:left; 
                width:100%; 
            }
            .ptable{
                width:100%;
                border-collapse: collapse;
            }
            .ptable td,.ptable th{
                padding:10px 5px;
            }
            #pback{
                display:none;
            }
            #content112{
                display:none;
            }
            #imgedit{
                display:none;
            }
            .profile_img{
                width:80%;
                height:225px;
            }
            .gst,.signup,.add,.modify,.delete,.download,.display1{
                font-size:18px;
            }
            .gst input,.signup input,.add input,.add select,.modify select,.modify input,.delete select,.delete input,.download select,.download input,.display1 select,.display1 input{
                font-size:15px;
            }
            .btn{
                border:1px solid black;
                width:70%;
            }
            .homecontent{
                word-break: break-all; 
                width:55%; 
                float:none;
            }
            .display{
                width:100%;
            }
            @media (max-width: 1150px) {
                .homecontent{
                    width:65%;
                }
            }
            @media (max-width: 1000px) {
                .homecontent{
                    width:70%;
                }
                .tablecontent ul{
                    padding:10px;
                    font-size:16px;
                }
                .tablecontent ul li{	
                    padding:10px 10px;	
                }
                .tablecontent ul li button{
                    padding:10px; 
                    font-size:16px;
                    width:150px; 
                }
                .tablecontent ul li ul{
                    padding:10px;
                    padding-left:150px;
                }
                .header{ 
                    padding:5px;
                }
                .dropbtn { 
                    padding: 5px 10px; 
                    min-width: 90px;
                    height:35px;
                    border-radius: 20px;
                    font-size: 15px;   
                }
                .dropdown-content { 
                    width: 160px; 
                    right:4%;
                }
                .dropdown-content a { 
                    padding: 10px;
                }
                .dropdown-content button { 
                    padding: 10px; 
                    width:100%; 
                    font-size:16px; 
                }
                .imgstyle{
                    width:30px;
                    height:30px;
                }
                .home{
                    padding-top:0px;
                }
                .img2{
                    width:20px;
                    height:20px;
                }
                .head1{
                    width:25%; 
                    font-size:15px;
                }
                .head2{
                    width:40%; 
                    font-size:25px;
                }
                .profile{
                    float:none; 
                    width:75%;
                }
                .profile_img{
                    width:90%;
                    height:175px;
                }
                .pcontent11{
                    width:70%; 
                    float:left; 
                    padding:20px; 
                    word-break: break-word; 
                }
                .pcontent12{
                    width:30%; 
                    float:right;
                }
                .title{
                    font-size:36px;
                }
                .btn{
                    width:85%;
                }
                .gst,.signup,.add,.modify,.delete,.download,.display1 {
                    font-size:15px;
                }
                
                .gst input,.signup input,.add input,.add select,.modify select,.modify input,.delete select,.delete input,.download select,.download input,.display1 select,.display1 input{
                    font-size:13px;
                }
                .greenbutton input{
                     
                    width:90%;
                }
                .greenbutton1 input {
                    width:40%;
                }
                .tabcontent11, .tabcontent12 {
                    width: 100%;
                    margin-top: 0;
                }
                .tablescroll{
                    width:90vw;
                }
                .tab {
                    top:50px;
                }
                .tab ul li {
                    padding: 8px 25px;
                }
                .tab ul li button {
                    font-size: 15px;
                }
                .tab ul li:hover .ctab {
                    margin-top:4.5px;
                }
                .tab ul li:hover .ctab ul {
                    display: block;
                    margin:5px 10px;
                    z-index: 1;
                }
                .tab ul li:hover .ctab ul li button{
                    width: 120px;
                    padding:12px;
                    font-size:15px;
                }
                .tab ul li:hover .ctab ul li button:hover{
                    color: black;
                    z-index: 1;
                }
                
                .btnstyle{
                    width:40%;
                }
            }
            @media (max-width: 800px) {
                .homecontent{
                    width:80%;
                }
            }
            @media (max-width: 650px) {
                .tablecontent ul{
                    padding:10px;
                    font-size:14px;
                }
                .tablecontent ul li{	
                    padding:10px 10px;	
                }
                .tablecontent ul li button{
                    padding:10px; 
                    font-size:14px;
                    width:150px; 
                }
                .tablecontent ul li ul{
                    padding:10px;
                    padding-left:150px;
                }
                .header{ 
                    padding:5px;
                }
                .head1{
                    width:30%; 
                    font-size:12px;
                }
                .btnstyle{
                    width:40%;
                }
                .head2{
                    width:50%; 
                    font-size:17px;
                }
                .dropbtn { 
                    padding: 3px; 
                    min-width: 70px;
                    height:27px;
                    border-radius: 20px;
                    font-size: 12px;   
                }
                .dropbtn { 
                    padding: 5px 10px; 
                    min-width: 110px;
                    height:35px;
                    border-radius: 20px;
                    font-size: 15px;   
                }
                .tabcontent{
                    width:100%;
                    padding:10px 0px;
                }
                .dropdown-content { 
                    width: 130px; 
                    right:6%;
                }
                .dropdown-content a { 
                    padding: 8px;
                }
                
                .dropdown-content button { 
                    padding: 8px; 
                    width:100%; 
                    font-size:13px; 
                }
                .tabcontent11, .tabcontent12 {
                    width: 100%;
                    margin-top: 0;
                }
                .buttonstyle{ 
                    font-size:16px; 
                    width:140px;
                    padding: 13px 18px; 
                    font-weight:bold;
                }
                .profile{
                    float:none; 
                    width:100%;
                }
                .profile_img{
                    width:100%;
                    height:160px;
                }
                .btn{
                    width:100%;
                }
                .gst,.signup,.add,.modify,.delete,.download,.display1{
                    font-weight:bold;
                }
                .gst,.signup input,.add input,.add select,.modify input,.modify select,.delete select,.delete input,.download select,.download input,.display1 select,.display1 input{
                    font-size:12px;
                }
                .pcontent11{
                    width:75%; 
                    float:left; 
                    padding:20px; 
                    word-break: break-word; 
                }
                .pcontent12{
                    width:25%; 
                    float:right;
                }
                
                .tab {
                    top:8%;
                    height:37px;
                }
                .tab ul li {
                    padding:6px 20px;
                }
                .tab ul li button {
                    font-size: 13px;
                }
                .tab ul li:hover .ctab {
                    margin-top:4.5px;
                }
                .tab ul li:hover .ctab ul {
                    display: block;
                    margin:5px 10px;
                    z-index: 1;
                }
                .tab ul li:hover .ctab ul li button{
                    width: 100px;
                    padding:10px;
                    font-size:13px;
                }
                .tab ul li:hover .ctab ul li button:hover{
                    color: black;
                    z-index: 1;
                }
                .display td{
                    font-weight:lighter;
                }
            }
        </style>
    </head>
    <body>
    <%!
        public boolean convert(String date,HttpServletRequest request)
        {
            HttpSession session=request.getSession();  
            String fdate = "";
            try
            {
                Connection con = (Connection)session.getAttribute("connection");
                Statement stm = con.createStatement();
                ResultSet rs =null;
                rs = stm.executeQuery("select * from freeze");
                while(rs.next())
                {
                    fdate=rs.getString(1);
                }
            }
            catch(Exception e)
            {}
            if(Integer.parseInt(fdate)<10)
                fdate='0'+fdate;
            date+="-"+fdate;
            LocalDate date1 = LocalDate.parse(date);
            date1 = date1.plusMonths(1);
            LocalDate date2 = LocalDate.now();
            Period period = Period.between(date2,date1);
            if(period.getYears()<0 || period.getMonths()<0 || period.getDays()<0)
                return false;
            else
                return true;
        }
    %>
    <%!
        public String convert1(String date,int n)
        {
            LocalDate dates = LocalDate.parse(date+"-01");
            dates = dates.plusMonths(n);
            String date2 = dates.toString();
            String[] date1 = date2.split("-");
            return date1[0]+"-"+date1[1];
        }
        public String convert2(String date,int n)
        {
            LocalDate dates = LocalDate.parse(date+"-01");
            dates = dates.minusMonths(n);
            String date2 = dates.toString();
            String[] date1 = date2.split("-");
            if(Integer.parseInt(date1[0])>=2022)
                return date1[0]+"-"+date1[1];
            else
                return "null";
        }
        public String dateconvert(String date)
        {
            
            String month[] = {"Jan","Feb","Mar","Apr","May","Jun","Jul","Aug","Sep","Oct","Nov","Dec"};
            String[] date1 = date.split("-");
            return month[Integer.parseInt(date1[1])-1]+"\n"+date1[0]; 

        }
        public boolean checkAdmin(String[] admin,String username){
            for(int i=0;i<admin.length;i++)
            {
                if(admin[i].contains(username)) return true;
            }
            return false;
        }
    %>
    <%  
        Connection con ;
        Statement stm = null ,stm1 = null;
        ResultSet rs,rs1;
        double cgst = 0.0;
        double sgst = 0.0;
        String username="";
        String admin1 = "";
        String[] admin = new String[10];
        String uname = "";
        String menubar = "";
        String photourl = "";
        String[] name = new String[100];
        Calendar cal = Calendar.getInstance();
        username = session.getAttribute("uid").toString();
        admin1 = session.getAttribute("admin").toString();
        admin = session.getAttribute("admin").toString().split(",");
        Class.forName("com.mysql.cj.jdbc.Driver");
        con = (Connection)session.getAttribute("connection");
        stm = con.createStatement();
        stm1 = con.createStatement();
        rs =null;
        rs1 =null;
        
        rs = stm.executeQuery("select * from login");
        while(rs.next())
        {
            if(username.equals(rs.getString("username")))
            {
                uname=rs.getString("name");
                photourl=rs.getString("photo");
            }
        }
        for(int i=0;i<100;i++)
            name[i] = "amount"+Integer.toString(i);
        rs = stm.executeQuery("select * from gst");
        
        while(rs.next())
        {
            if(rs.getString("status").equals("ACTIVE"))
            {
                cgst = Double.parseDouble(rs.getString("cgst"))*0.01;
                sgst = Double.parseDouble(rs.getString("sgst"))*0.01;
            }
        }
        if(request.getParameter("menubar")==null)
            menubar="";
        else
            menubar=request.getParameter("menubar");
    %>
        <input type="hidden" id="menubar" value="<%=menubar%>"/>
        <div class="footer">
            <p>This Project is Done By Arvind M M (20BCE2633)</p>
        </div>
        <div class="tab">
            <ul>
                <li>
                    <button class="main tablinks" onclick="openMode(event, 'home')" id="default0"><i class="fa fa-home" aria-hidden="true"></i>&ensp;HOME</button>
                </li>    
                <%
                if(checkAdmin(admin,username))
                {
                %>
                <li><button class="main"><i class="fa fa-edit" aria-hidden="true"></i>&ensp;MASTER&ensp;<i class="fa fa-caret-down"></i></button>
                    <div class="ctab">
                        <ul>
                            <li><button class="tablinks" onclick="openMode(event, 'add')" id="default9">ADD NUMBER</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'modify')" id="default10">MODIFY NUMBER</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'delete')" id="default11">DELETE NUMBER</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'gst')" id="default14">GST</button></li>
                        </ul>
                    </div>
                </li>
                <%
                }
                %>
                <li><button class="main"><i class="fa fa-list-alt" aria-hidden="true"></i>&ensp;BILL&ensp;<i class="fa fa-caret-down"></i></button>
                    <div class="ctab">
                        <ul>
                            <li><button class="tablinks" onclick="openMode(event, 'airtel')" id="default1">AIRTEL 1</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'airtel_2')" id="default2">AIRTEL 2</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'jio')" id="default3">JIO</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'bsnl')" id="default4">BSNL</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'vodofone')" id="default5">VODOFONE</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'airtelvip')" id="default6">AIRTEL VIP</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'airtellandline')" id="default7">AIRTEL LANDLINE</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'bsnllandline')" id="default8">BSNL LANDLINE</button></li>
                        </ul>
                    </div>
                </li>
                <li><button class="main tablinks" onclick="openMode(event, 'display')" id="default12"><i class="fa fa-file-text" aria-hidden="true"></i>&ensp;REPORT</button></li>
                <%
                if(checkAdmin(admin,username))
                {
                %>
                <li><button class="main"><i class="fa fa-gear" aria-hidden="true"></i>&ensp;SETUP&ensp;<i class="fa fa-caret-down"></i></button>
                    <div class="ctab">
                        <ul>
                            <li><button class="tablinks" onclick="openMode(event, 'signup')" id="default15">ADD USER</button></li> 
                            <li><button class="tablinks" onclick="openMode(event, 'freeze')" id="default16">FREEZE DATE</button></li>
                        </ul>
                    </div>
                </li>
                <%
                }
                %>
            </ul>
        </div>
        <div class="header">
            <table style="width:100%;">
                <tr>
                    <td style="width:4%;">
                        <img class="imgstyle" src="images/VITLogoEmblem.png" width="40px" height="40px"/>
                    </td>
                    <td class="head1">
                        <span>VIT (VELLORE CAMPUS) </span>
                    </td>
                    <td class="head2"> PHONE BILL </td>
                    <td style='text-align: right;padding-right:20px;'>
                        <div class="dropdown">
                            <button onclick="dropdown_list()" class="dropbtn"><i class="fa fa-user-circle"></i>&ensp;<%=username%>&ensp;<i class="fa fa-caret-down"></i></button>
                            <div id="myDropdown" class="dropdown-content center">
                                HELLO,<br>
                                <center>
                                    <button  class="tablinks" onclick="openMode(event, 'profile')" id="default17"><%=uname%></button>
                                    <a href="logout.jsp">Sign Out</a>
                                </center>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div>
        <div id="home" class="tabcontent homecontent center" >
            <div class="tablecontent  center">                    
                <ul>    
                    <li><button>GST</button>
                        <ul>
                            <li>Current CGST : <%=cgst*100%>%.</li>
                            <li>Current SGST : <%=sgst*100%>%.</li>
                        </ul>
                    </li>    
                    <li><button>Last Bill Details</button>
                        <ul>
                        <%
                            String[] Operator1 = {"airtel","airtel_2","jio","bsnl","vodofone","airtelvip","airtellandline","bsnllandline"};
                            String[] Operator2 = {"Airtel 1","Airtel 2","Jio","Bsnl","Vodofone","Airtel Vip","Airtel Landline","Bsnl Landline"};
                            for(int i=0;i<8;i++)
                            {
                                 String curr = "";
                                if(cal.get(Calendar.MONTH) + 1>9)
                                {
                                    curr = cal.get(Calendar.YEAR) +"-"+( cal.get(Calendar.MONTH) + 1);
                                }   
                                else{
                                    curr = cal.get(Calendar.YEAR) +"-0"+( cal.get(Calendar.MONTH) + 1);
                                }
                                String date = "";
                                double sum1=0;
                                double cgst1=0;
                                double sgst1=0;
                                double one=0.0;
                                double fixed=0.0;
                                double usage=0.0;
                                double misc=0.0;
                                double late=0.0;
                                double discount=0.0;
                                double adj=0.0;
                                for(int j=0;date!="null";j++)
                                {
                                    int flag1=0;
                                    date = convert2(curr,j);
                                    rs=stm.executeQuery("select * from bills where operator='"+Operator1[i]+"' and date='"+date+"'");
                                    while(rs.next())
                                    {
                                        if(flag1==0 && rs.getString("operator")==null)
                                            break;
                                        else if(Operator1[i].equals("bsnl"))
                                        {
                                            one = Double.parseDouble(rs.getString("one"));
                                            fixed = Double.parseDouble(rs.getString("fixed"));
                                            usage = Double.parseDouble(rs.getString("usages"));
                                            misc = Double.parseDouble(rs.getString("misc"));
                                            late = Double.parseDouble(rs.getString("late"));
                                            discount = Double.parseDouble(rs.getString("discount"));
                                            adj = Double.parseDouble(rs.getString("adj"));
                                            sum1=one+fixed+usage+misc+late-discount-adj;
                                            flag1=1;
                                        }
                                        else
                                        {
                                            flag1=1;
                                            sum1+=Double.parseDouble(rs.getString("amount"));
                                        }
                                        cgst1 = Double.parseDouble(rs.getString("cgst"));
                                        sgst1 = Double.parseDouble(rs.getString("sgst"));
                                    }
                                    if(flag1==1)
                                    {
                                    %>
                                        <li><b><%=Operator2[i]%></b>: <%=date%> --- Rs <%=Math.round(((sum1*cgst1+sum1*sgst1)+sum1)*100.0)/100.0%><br></li>
                                        <%
                                        break;
                                    }
                                }
                            }
                        %>
                        </ul>
                    </li>
                </ul>
            </div>
        </div>
        <div id="profile" class="tabcontent profile center">
            <%
            if(request.getParameter("submit3")!=null)
            {
                %>
                <input type="hidden" id="status" value="error"/>
                    <%
            }
            else
            {
                %>
                    <input type="hidden" id="status" value="done"/>
                    <%    
            }
            %>
            <p class="title">PROFILE</p>
            <div class="tablecontent" style="float:left; width:100%;" > 
                <div class="pcontent1" id="content1">
                    <div class="pcontent11" id="content11">
                        <div class="pcontent111" id="content111">
                            <%
                            rs=stm.executeQuery("select * from login where username='"+username+"'");
                            while(rs.next())
                            {
                            %>
                            <form id="myform8" name="myform8" method="post" action="profile.jsp">
                            </form>
                            <table class='ptable'>
                                <tr>
                                    <th style='width:50%;text-align: left;'>Name</th>
                                    <td style='width:50%;'>
                                        <input form="myform8" type="text" style="width:100%;" value="<%=rs.getString("name")%>" name="p_name" readonly/>
                                    </td>
                                </tr>
                                <tr>
                                    <th style='text-align: left;'>STAFF ID</th>
                                    <td>
                                        <input form="myform8" type="text" style="width:100%;" value="<%=rs.getString("username")%>" name="p_staff" readonly/>
                                    </td>
                                </tr>
                                <tr>
                                    <th style='text-align: left;'>DESIGNATION</th>
                                    <td >
                                        <input form="myform8" type="text" style="width:100%;" value="<%=rs.getString("desi")%>" name="p_desi" readonly/>
                                    </td>
                                </tr>
                                <tr>
                                    <th style='text-align: left;'>EMAIL ID</th>
                                    <td >
                                        <input form="myform8" type="text" style="width:100%;" value="<%=rs.getString("email")%>" name="p_email" readonly/>                                        
                                    </td>
                                </tr>
                                <tr id='pedit'>
                                    <td></td>
                                    <td class='greenbutton' align="right">
                                        <input class="btn" onclick="edittab(true,'myform8','profile')" type="button" value="EDIT" name="submit2"/>
                                    </td>
                                </tr>
                                <tr id="pback">
                                    <td class='greenbutton' style='text-align: center;'>
                                        <input form="myform8" class="btn" type="submit" value="UPDATE" name="submit2"/>
                                    </td>
                                    <td class='redbutton' style='text-align: center;'>
                                        <input class="btn" type="button" value="BACK" name="submit2" onclick="edittab(false,'myform8','profile')"/>
                                    </td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <div style="width:40%; float:left;">Current admin:</div>
                                        <div style="width:30%; float:left;"><%=admin1%></div>
                                        <%
                                        if(checkAdmin(admin,username))
                                        {
                                        %>
                                        <div style="width:30%; float:left;">
                                            <input style="width:100%;" class="bluebutton" type="button" onclick="switchtab('content111','content112')" value="Change Admin" name="submit2"/>
                                        </div>
                                        <%
                                        }
                                        %>
                                    </td>
                                </tr>
                                <tr>
                                    <td>Change Security Question Answers: </td>
                                    <td class="greenbutton" align="right">
                                        <input type="button" onclick="switchtab('content1','content2')" value="Change Answers" name="submit2" class=""/>
                                    </td>
                                </tr>
                            </table>
                            <%
                            }
                            %>
                            <div style="width:59%; float:left;"></div>
                            <div style="width:39%; float:left;" class="greenbutton"></div>   
                        </div>
                        <div class="pcontent111" id="content112">
                            <form id="myform28" name="myform28" method="post" action="profile.jsp">
                            </form>
                            <table class="ptable">
                                <tr>
                                    <th style="width:50%; text-align: left;">User ID :</th>
                                    <td style="width:50%;">
                                        <select form="myform28" class="btn" name="p_user" required>
                                        <%
                                        rs1=stm1.executeQuery("select username from login");
                                        while(rs1.next())
                                        {
                                        %>
                                            <option value="<%=rs1.getString(1)%>"><%=rs1.getString(1)%></option>
                                        <%
                                        }
                                        %>    
                                        </select>
                                    </td>
                                </tr>
                                <tr>
                                    <th style="text-align: left;">Password :</th>
                                    <td>
                                        <input form="myform28" class="btn" type="password" name="p_pass" required/>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="greenbutton">
                                        <input form="myform28" class="btn" type="submit" value="CHANGE" name="submit2"/>
                                    </td>
                                    <td class="redbutton">
                                        <input class="btn" type="button" onclick="switchtab('content112','content111')" value="BACK" name="submit2"/>
                                    </td>
                                </tr>
                            </table>
                        </div>
                    </div>
                    <div class="pcontent12" id="content12" >
                        <form action="FileUploadServlet" method="post" enctype="multipart/form-data"> 
                            <center>
                                <img src="<%=photourl%>" alt="no image exist" class="profile_img">
                                <div id="imgedit">    
                                    <br>
                                    <input style="width:90%;" type="file" name="file" accept="image/png, image/gif, image/jpeg, image/jpg" />
                                    <input style="width:50%;" class="bluebutton" type="submit" value="CHANGE"/>   
                                </div>
                                <div id="imgback">
                                    <br>
                                    <input type="button" onclick="switchtab('imgback','imgedit')" value="Change Photo" class="bluebutton btn" name="submit2"/>
                                </div>
                            </center>
                            <br><br>
                        </form>
                    </div>
                </div>
                <div class="pcontent2" id="content2" style="display:none;">
                    <form id="myform18" name="myform18" method="post" action="profile.jsp">
                    </form>
                        <table style="width:100%; font-size:20px; " cellspacing="20">
                            <tr>
                                <td>Current Password</td>
                                <td><input form="myform18" style="width:100%; font-size:20px; height:25px;" type="password" name="p_pass" required/></td>
                            </tr>
                            <tr>
                                <td>1.What Is your favorite book?</td>
                                <td><input form="myform18" style="width:100%; font-size:20px; height:25px;" type="text" name="q1" required/></td>
                            </tr>
                            <tr>
                                <td>2.Where is your favorite place to vacation?</td>
                                <td><input form="myform18" style="width:100%; font-size:20px; height:25px;" type="text" name="q2" required/></td>
                            </tr>
                            <tr>
                                <td>3.What was the name of your elementary school?</td>
                                <td><input form="myform18" style="width:100%; font-size:20px; height:25px;" type="text" name="q3" required/></td>
                            </tr> 
                            <tr>
                                <td style="width:100px;" align="center" class="greenbutton">
                                    <input form="myform18" type="submit" value="SAVE" name="submit2"/>
                                </td>
                                <td style="width:100px;" align="center" class="redbutton">
                                    <input type="button" value="BACK" onclick="switchtab('content2','content1')"/>
                                </td>
                            </tr> 
                        </table>
                </div>
            </div>
        </div>
        <div id="airtel" class="tabcontent center" style="width:100%;">
            <center><p class="title">AIRTEL 1</p></center>
            <table class="tablecontent display1 center" style="width:100%;">
                <tr>
                <td>
                <div class="tab2">
                    <table class="center" cellspacing="30">
                        <tr>
                        <%
                            if(request.getParameter("button")!=null && request.getParameter("bill_operator").equals("airtel"))
                            {
                            if(request.getParameter("button").equals("new"))
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new1')" id="defaultOpen5">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old1')">OLD BILL</button></td>
                            <%
                            }
                            else if(request.getParameter("button").equals("old"))
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new1')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old1')" id="defaultOpen5">OLD BILL</button></td>
                            <%
                            }
                            else
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new1')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old1')">OLD BILL</button></td>
                            <%
                            }
                            }
                            else
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new1')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old1')">OLD BILL</button></td>
                            <%
                            }
                        %>
                        </tr>
                    </table>
                </div>
                <div id="new1" class="tabcontent2">
                <%
                    int month = cal.get(Calendar.MONTH) + 1 ;
                    int year = cal.get(Calendar.YEAR);
                    String currentdate = "";
                    if(month<10)
                    {
                        currentdate = year+"-"+"0"+month;
                    }
                    else
                    {
                        currentdate =  year+"-"+month;
                    }
                    int count1 = 0;
                    double sum1 = 0.0;
                    String bill_date = "";
                    String[] amt1 = new String[100];
                    if(request.getParameter("count")!=null && request.getParameter("button").equals("new") && request.getParameter("bill_operator").equals("airtel"))
                    {
                        count1=Integer.parseInt(request.getParameter("count"));
                        for(int i=0;i<count1;i++)
                            amt1[i]=request.getParameter(name[i]);
                        if(request.getParameter("sum")!=null)
                            sum1=Double.parseDouble(request.getParameter("sum"));
                        if(request.getParameter("bill_date")!=null)
                            bill_date = request.getParameter("bill_date");
                    }
                    else
                        count1=100;
                    for(int i=0;i<count1;i++)
                    {
                        if(amt1[i]==null)
                            amt1[i]="";
                    }
                %>   
                    <form name="form1" id="form1" method="post" action="bill_validation.jsp"> 
                    </form>
                    <form name="form11" id="form11" action="FileUploadServlet" method="post" enctype="multipart/form-data">
                    </form>
                        <div class="tabcontent12 center">
                            <br><br>
                            <table class="center" cellspacing="20">
                                <tr>
                                    <td>BILL MONTH</td>
                                    <td>
                                        <div class="input-group date datepicker">
                                            <input form="form1" style="width:90%;" type="text" onkeydown="return false" onchange="checkdate1(this)" value="<%=bill_date%>" name="bill_date" required>
                                            <span class="input-group-append"></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>	
                                    <td>Sub Total</td>
                                    <td><%=sum1%></td>
                                </tr>
                                <tr>
                                    <td>CGST</td>
                                    <td><%=Math.round(sum1*cgst*100.0)/100.0%></td>
                                </tr>
                                <tr>
                                    <td>SGST</td>
                                    <td><%=Math.round(sum1*sgst*100.0)/100.0%></td>
                                </tr>
                                <tr>
                                    <td>Grand Total</td>
                                    <td><%=Math.round(((sum1*cgst+sum1*sgst)+ sum1)*100.0)/100.0 %></td>
                                </tr>
                                <tr>
                                    <td class="greenbutton center"><input form="form1" type="submit" value="GET" name="submit1"></td>
                                    <%if(request.getParameter("bill_date")!=null){%>
                                    <td class="greenbutton center"><input form="form1" type="submit" value="STORE" name="submit1"></td>
                                    <%}else{%>
                                    <td><td>
                                    <%}%>
                                </tr>
                            </table>
                            <% 
                            if(!bill_date.isEmpty())
                            {
                            rs=stm.executeQuery("select * from receipt where operator='airtel' and date='"+bill_date+"'");
                            if(rs.next())
                            {
                            %>
                            <table class="center" style="width:100%;" cellspacing="15">    
                                <tr>
                                    <td><b>Receipt Filename :</b></td>
                                    <td style="word-break:break-all;"><%=rs.getString("filename")%></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <a class="gb" target="_blank" href="<%=rs.getString("filepath")%>">Download</a>
                                    </td>                                    
                                </tr>
                            </table>    
                            <%
                            }
                            else
                            {   
                            %>
                            
                                <table class="center" cellspacing="25">
                                    <tr>
                                        <td>Upload Receipt :<input form="form11" type="file" name="file"></td>
                                    </tr>
                                    <tr>
                                        <td class="greenbutton1">
                                            <input form="form11" type="submit" value="Submit" name="submit_receipt"/>
                                        </td>
                                    </tr>
                                </table>
                                <input form="form11" type="hidden" name="mobile2" value="airtel"/>
                                <input form="form11" type="hidden" name="bill_month" value="<%=bill_date%>"/>
                                <input form="form11" type="hidden" name="button" value="new"/>
                                <input form="form11" type="hidden" name="count" value="<%=count1%>"/>
                                <%
                                for(int i=0;i<count1;i++)
                                {%>
                                <input form="form11" type="hidden" value="<%=amt1[i]%>" name="<%=name[i]%>"/>
                                <%
                                }
                            }
                        }
                        %>
                        </div>
                        <div class="tabcontent11 center" >
                            <div class="tablescroll center" style="overflow-x:auto;">
                            <table id="example1" class="display" style="width:100%;" cellspacing="20">
                                <thead>    
                                    <tr>
                                        <td>S<font color="white">_</font>No</td>
                                        <td>Name</td>
                                        <td>Staff<font color="white">_</font>ID</td>
                                        <td>Designation</td>
                                        <td>Phone Number</td>
                                        <td>Amount</td>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                    int a1=0;
                                    rs=stm.executeQuery("select * from airtel");
                                    while(rs.next())
                                    {                
                                    %>
                                    <tr>
                                        <td><%=a1+1%></td>
                                        <td><%=rs.getString("name")%></td>
                                        <td><%=rs.getString("emp")%></td>
                                        <td><%=rs.getString("desi")%></td>
                                        <td><%=rs.getString("phone")%></td>
                                        <td><input form="form1" type="text" onchange="checknumber(this)" value="<%=amt1[a1]%>" name="<%=name[a1]%>" style="width:100px;" required></td>
                                    </tr>
                                    <%
                                        a1++;   
                                    }
                                %>  
                                </tbody>
                            </table>
                            </div>
                        </div>
                        <input form="form1" type="hidden" value="<%=a1%>" name="count"/>
                        <input form="form1" type="hidden" value="new" name="button"/>
                        <input form="form1" type="hidden" value="airtel" name="bill_operator"/>
                        
                </div>
                <div id="old1" class="tabcontent2">
                <%
                    String bill_date11="";
                    String filename="main.jsp";
                    double sum11=0;
                    if(request.getParameter("bill_operator")!=null && request.getParameter("bill_date")!=null && request.getParameter("button").equals("old") && request.getParameter("bill_operator").equals("airtel"))
                    {
                        bill_date11=request.getParameter("bill_date");
                        filename="bill_validation.jsp";
                    }  
                                int a11=0;
                                double cgst3=0.0;
                                double sgst3=0.0;
                                if(!bill_date11.equals(""))
                                {
                                    rs=stm.executeQuery("select * from bills where operator='airtel' and date='"+bill_date11+"'");
                                    if(rs.next())
                                    { 
                                    do
                                    {
                                        a11++;  
                                        if(rs.getString("amount")!=null)
                                            sum11+=Double.parseDouble(rs.getString("amount"));
                                        cgst3=Double.parseDouble(rs.getString("cgst"));
                                        sgst3=Double.parseDouble(rs.getString("sgst"));
                                    }while(rs.next());
                                    }
                                }
                %>
                    <div class="tabcontent12 center">
                        
                            <br><br>
                            <table class="center" cellspacing="20">
                                <tr>
                                    <td>BILL MONTH</td>
                                    <td>
                                        <%
                                        if(!bill_date11.equals(""))
                                        {
                                        %>
                                        <div class="input-group date">
                                            <input form="myform" style="width:90%;" type="text" onkeydown="return false" onchange="checkdate1(this)" value="<%=bill_date11%>" name="bill_date" readonly>
                                            <span class="input-group-append"></span>
                                        </div>
                                        <%
                                        }
                                        else{
                                        %>
                                        <div class="input-group date datepicker">
                                            <input form="myform" style="width:90%;" type="text" onkeydown="return false" onchange="checkdate1(this)" value="<%=bill_date11%>" name="bill_date" required>
                                            <span class="input-group-append"></span>
                                        </div>
                                        <%
                                        }
                                        %>    
                                    </td>
                                
                                </tr>
                                <tr>	
                                    <td>Sub Total</td>
                                    <td><%=sum11%></td>
                                </tr>
                                <tr>
                                    <td>CGST</td>
                                    <td><%=Math.round(sum11*cgst3*100.0)/100.0%></td>
                                </tr>
                                <tr>
                                    <td>SGST</td>
                                    <td><%=Math.round(sum11*sgst3*100.0)/100.0%></td>
                                </tr>
                                <tr>
                                    <td>Grand Total</td>
                                    <td><%=Math.round(((sum11*cgst3+sum11*sgst3) + sum11)*100.0)/100.0%></td>
                                </tr>
                                <%  
                                if(bill_date11.equals(""))
                                {
                                %>
                                <tr>
                                    <td colspan="2" class="greenbutton1 center"><input form="myform" type="submit" value="GET DETAILS" name="submit1"></td>
                                </tr>
                                <%
                                }
                                else
                                {
                                %>
                                <tr>
                                    <%if(convert(bill_date11,request)){%>
                                    <td class="greenbutton center"><input form="myform" type="submit" value="UPDATE" name="submit1"></td>
                                    <%}%>
                                    <td class="redbutton cventer"><input form="myform" type="submit" value="BACK" name="submit1"></td>
                                </tr>
                                <%
                                }
                                %>    
                            </table>
                            
                        <%
                        if(!bill_date11.equals(""))
                        {
                            rs=stm.executeQuery("select * from receipt where operator='airtel' and date='"+bill_date11+"'");
                            if(rs.next())
                            {
                            %>
                            <table class="center" cellspacing="15">    
                                <tr>
                                    <td><b>Receipt Filename :</b></td>
                                    <td style="word-break:break-all;"><%=rs.getString("filename")%></td>
                                </tr>
                                <%
                                if(checkAdmin(admin,username) && convert(bill_date11,request)) 
                                {
                                %>
                                <tr>
                                    <td>
                                        <a class="gb" target="_blank" href="<%=rs.getString("filepath")%>">Download</a>
                                    </td>
                                    <td>
                                        <a class="rb" target="_self" href="deletereceipt.jsp?operator=airtel&bill_month=<%=bill_date11%>&button=old">Delete</a>
                                    </td>
                                </tr>    
                                <%
                                }
                                else
                                {
                                %>
                                <tr>
                                    <td colspan="2">
                                        <a class="gb" target="_blank" href="<%=rs.getString("filepath")%>">Download</a>
                                    </td>
                                </tr>  
                                <%
                                }
                            %>
                            </table>    
                            <%
                            }
                            else
                            {   
                            %>
                            <form action="FileUploadServlet" method="post" enctype="multipart/form-data">
                                <table class="center" cellspacing="25">
                                    <tr>
                                        <td>Upload Receipt :<input type="file" name="file"></td>
                                    </tr>
                                    <tr>
                                        <td class="greenbutton1">
                                            <input class="btnstyle" type="submit" value="Submit" name="submit_receipt"/>
                                        </td>
                                    </tr>
                                </table> 
                                <input type="hidden" name="mobile2" value="airtel"/>
                                <input type="hidden" name="bill_month" value="<%=bill_date11%>"/>
                                <input type="hidden" name="button" value="old"/>
                                <input type="hidden" value="<%=a11%>" name="count"/>
                                
                            </form>
                            <%
                            }
                            rs=stm.executeQuery("select * from modifier where operator='airtel' and date='"+bill_date11+"'");
                            if(rs.next())
                            {
                            %>
                            <table class="center" cellspacing="25">
                                <tr>
                                    <td>Last Modified By : </td>
                                    <td><%=rs.getString("emp")%></td>
                                </tr>
                            </table>    
                            <%
                            }
                        }
                        %>
                    </div>
                    <div class="tabcontent11 center" >
                        <form name="myform" id="myform" method="post" action="<%=filename%>"> 
                        </form>
                        <div class="center tablescroll" style="overflow-x:auto;">
                        <table id="example11" class="display" style="width:100%;" cellspacing="20">
                            <thead>
                                <tr>
                                    <td>S<font color="white">_</font>No</td>
                                    <td>Name</td>
                                    <td>Staff<font color="white">_</font>ID</td>
                                    <td>Designation</td>
                                    <td>Phone Number</td>
                                    <td>Amount</td>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                a11=0;
                                if(!bill_date11.equals(""))
                                {
                                    rs=stm.executeQuery("select * from bills where operator='airtel' and date='"+bill_date11+"'");
                                    if(rs.next())
                                    { 
                                    do
                                    {
                                    %>
                                    <tr>
                                        <td><%=a11+1%></td>
                                        <td><%=rs.getString("name")%></td>
                                        <td><%=rs.getString("emp")%></td>
                                        <td><%=rs.getString("desi")%></td>
                                        <td><%=rs.getString("phone")%></td>
                                        <%if(convert(bill_date11,request)){%>
                                        <td><input form="myform" type="text" value="<%=rs.getString("amount")%>" name="<%=name[a11]%>" onchange="checknumber(this)" style="width:100px;" required></td>
                                        <%}else{%>
                                        <td><input form="myform" type="text" value="<%=rs.getString("amount")%>" name="<%=name[a11]%>" style="width:100px;" readonly></td>
                                        <%}%>
                                    </tr>
                                    <%
                                        a11++;  
                                    }while(rs.next());
                                    }
                                    else
                                    {
                                        bill_date11="";
                                        filename="main.jsp";
                                    }
                                }
                            %>  
                            </tbody>
                        </table>
                        </div>
                    </div>
                    
                            <input form="myform" type="hidden" value="airtel" name="bill_operator"/>
                            <input form="myform" type="hidden" value="airtel" name="menubar"/>
                            <input form="myform" type="hidden" value="old" name="button"/>
                            <input form="myform" type="hidden" value="<%=a11%>" name="count"/>
                </div>
                </td>
                </tr>
            </table>
        </div>
        <div id="airtel_2" class="tabcontent center" style="width:100%;">
            <center><p class="title">AIRTEL 2</p></center>
            <table class="tablecontent display1 center" style="width:100%;">
                <tr>
                <td>
                <div class="tab2">
                    <table class="center" cellspacing="30">
                        <tr>
                        <%
                            if(request.getParameter("button")!=null && request.getParameter("bill_operator").equals("airtel_2"))
                            {
                            if(request.getParameter("button").equals("new"))
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new12')" id="defaultOpen5">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old12')">OLD BILL</button></td>
                            <%
                            }
                            else if(request.getParameter("button").equals("old"))
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new12')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old12')" id="defaultOpen5">OLD BILL</button></td>
                            <%
                            }
                            else
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new12')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old12')">OLD BILL</button></td>
                            <%
                            }
                            }
                            else
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new12')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old12')">OLD BILL</button></td>
                            <%
                            }
                        %>
                        </tr>
                    </table>
                </div>
                <div id="new12" class="tabcontent2">
                <%
                    int count_2 = 0;
                    double sum_2 = 0.0;
                    String[] amt_2 = new String[100];
                    if(request.getParameter("count")!=null && request.getParameter("button").equals("new") && request.getParameter("bill_operator").equals("airtel_2"))
                    {
                        count_2=Integer.parseInt(request.getParameter("count"));
                        for(int i=0;i<count_2;i++)
                            amt_2[i]=request.getParameter(name[i]);
                        if(request.getParameter("sum")!=null)
                            sum_2=Double.parseDouble(request.getParameter("sum"));
                        if(request.getParameter("bill_date")!=null)
                            bill_date = request.getParameter("bill_date");
                    }
                    else
                        count_2=100;
                    for(int i=0;i<count_2;i++)
                    {
                        if(amt_2[i]==null)
                            amt_2[i]="";
                    }
                %>   
                    <form name="form_2" id="form_2" method="post" action="bill_validation.jsp"> 
                    </form>
                    <form name="form_11" id="form_11" action="FileUploadServlet" method="post" enctype="multipart/form-data">
                    </form>
                        <div class="tabcontent12 center">
                            <br><br>
                            <table class="center" cellspacing="20">
                                <tr>
                                    <td>BILL MONTH</td>
                                    <td>
                                        <div class="input-group date datepicker">
                                            <input form="form_2" style="width:90%;" type="text" onkeydown="return false" onchange="checkdate1(this)" value="<%=bill_date%>" name="bill_date" required>
                                            <span class="input-group-append"></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>	
                                    <td>Sub Total</td>
                                    <td><%=sum_2%></td>
                                </tr>
                                <tr>
                                    <td>CGST</td>
                                    <td><%=Math.round(sum_2*cgst*100.0)/100.0%></td>
                                </tr>
                                <tr>
                                    <td>SGST</td>
                                    <td><%=Math.round(sum_2*sgst*100.0)/100.0%></td>
                                </tr>
                                <tr>
                                    <td>Grand Total</td>
                                    <td><%=Math.round(((sum_2*cgst+sum_2*sgst)+ sum_2)*100.0)/100.0 %></td>
                                </tr>
                                <tr>
                                    <td class="greenbutton center"><input form="form_2" type="submit" value="GET" name="submit1"></td>
                                    <%if(request.getParameter("bill_date")!=null){%>
                                    <td class="greenbutton center"><input form="form_2" type="submit" value="STORE" name="submit1"></td>
                                    <%}else{%>
                                    <td><td>
                                    <%}%>
                                </tr>
                            </table>
                            <% 
                            if(!bill_date.isEmpty())
                            {
                            rs=stm.executeQuery("select * from receipt where operator='airtel_2' and date='"+bill_date+"'");
                            if(rs.next())
                            {
                            %>
                            <table class="center" style="width:100%;" cellspacing="15">    
                                <tr>
                                    <td><b>Receipt Filename :</b></td>
                                    <td style="word-break:break-all;"><%=rs.getString("filename")%></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <button class="gb"><a target="_blank" href="<%=rs.getString("filepath")%>">Download</a></button>
                                    </td>                                    
                                </tr>
                            </table>    
                            <%
                            }
                            else
                            {   
                            %>
                            
                                <table class="center" cellspacing="25">
                                    <tr>
                                        <td>Upload Receipt :<input form="form_11" type="file" name="file"></td>
                                    </tr>
                                    <tr>
                                        <td class="greenbutton1">
                                            <input form="form_11" type="submit" value="Submit" name="submit_receipt"/>
                                        </td>
                                    </tr>
                                </table>
                                <input form="form_11" type="hidden" name="mobile2" value="airtel_2"/>
                                <input form="form_11" type="hidden" name="bill_month" value="<%=bill_date%>"/>
                                <input form="form_11" type="hidden" name="button" value="new"/>
                                <input form="form_11" type="hidden" name="count" value="<%=count_2%>"/>
                                <%
                                for(int i=0;i<count_2;i++)
                                {%>
                                <input form="form_11" type="hidden" value="<%=amt_2[i]%>" name="<%=name[i]%>"/>
                                <%
                                }
                            }
                        }
                        %>
                        </div>
                        <div class="tabcontent11 center" >
                            <div class="tablescroll center" style="overflow-x:auto;">
                            <table id="example111" class="display" style="width:100%;" cellspacing="20">
                                <thead>    
                                    <tr>
                                        <td>S<font color="white">_</font>No</td>
                                        <td>Name</td>
                                        <td>Staff<font color="white">_</font>ID</td>
                                        <td>Designation</td>
                                        <td>Phone Number</td>
                                        <td>Amount</td>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                    int a_2=0;
                                    rs=stm.executeQuery("select * from airtel_2");
                                    while(rs.next())
                                    {                
                                    %>
                                    <tr>
                                        <td><%=a_2+1%></td>
                                        <td><%=rs.getString("name")%></td>
                                        <td><%=rs.getString("emp")%></td>
                                        <td><%=rs.getString("desi")%></td>
                                        <td><%=rs.getString("phone")%></td>
                                        <td><input form="form_2" type="text" onchange="checknumber(this)" value="<%=amt_2[a_2]%>" name="<%=name[a_2]%>" style="width:100px;" required></td>
                                    </tr>
                                    <%
                                        a_2++;   
                                    }
                                %>  
                                </tbody>
                            </table>
                            </div>
                        </div>
                        <input form="form_2" type="hidden" value="<%=a_2%>" name="count"/>
                        <input form="form_2" type="hidden" value="new" name="button"/>
                        <input form="form_2" type="hidden" value="airtel_2" name="bill_operator"/>
                        
                </div>
                <div id="old12" class="tabcontent2">
                <%
                    String bill_date_11="";
                    filename="main.jsp";
                    double sum_11=0;
                    if(request.getParameter("bill_operator")!=null && request.getParameter("bill_date")!=null && request.getParameter("button").equals("old") && request.getParameter("bill_operator").equals("airtel_2"))
                    {
                        bill_date_11=request.getParameter("bill_date");
                        filename="bill_validation.jsp";
                    }  
                                int a_11=0;
                                double cgst_3=0.0;
                                double sgst_3=0.0;
                                if(!bill_date_11.equals(""))
                                {
                                    rs=stm.executeQuery("select * from bills where operator='airtel_2' and date='"+bill_date_11+"'");
                                    if(rs.next())
                                    { 
                                    do
                                    {
                                        a_11++;  
                                        if(rs.getString("amount")!=null)
                                            sum_11+=Double.parseDouble(rs.getString("amount"));
                                        cgst_3=Double.parseDouble(rs.getString("cgst"));
                                        sgst_3=Double.parseDouble(rs.getString("sgst"));
                                    }while(rs.next());
                                    }
                                }
                %>
                    <div class="tabcontent12 center">
                        
                            <br><br>
                            <table class="center" cellspacing="20">
                                <tr>
                                    <td>BILL MONTH</td>
                                    <td>
                                        <%
                                        if(!bill_date_11.equals(""))
                                        {
                                        %>
                                        <div class="input-group date">
                                            <input form="myform_2" style="width:90%;" type="text" onkeydown="return false" onchange="checkdate1(this)" value="<%=bill_date_11%>" name="bill_date" readonly>
                                            <span class="input-group-append"></span>
                                        </div>
                                        <%
                                        }
                                        else{
                                        %>
                                        <div class="input-group date datepicker">
                                            <input form="myform_2" style="width:90%;" type="text" onkeydown="return false" onchange="checkdate1(this)" value="<%=bill_date_11%>" name="bill_date" required>
                                            <span class="input-group-append"></span>
                                        </div>
                                        <%
                                        }
                                        %>
                                    </td>
                                
                                </tr>
                                <tr>	
                                    <td>Sub Total</td>
                                    <td><%=sum_11%></td>
                                </tr>
                                <tr>
                                    <td>CGST</td>
                                    <td><%=Math.round(sum_11*cgst_3*100.0)/100.0%></td>
                                </tr>
                                <tr>
                                    <td>SGST</td>
                                    <td><%=Math.round(sum_11*sgst_3*100.0)/100.0%></td>
                                </tr>
                                <tr>
                                    <td>Grand Total</td>
                                    <td><%=Math.round(((sum_11*cgst_3+sum_11*sgst_3) + sum_11)*100.0)/100.0%></td>
                                </tr>
                                <%  
                                if(bill_date_11.equals(""))
                                {
                                %>
                                <tr>
                                    <td colspan="2" class="greenbutton1 center"><input form="myform_2" type="submit" value="GET DETAILS" name="submit1"></td>
                                </tr>
                                <%
                                }
                                else
                                {
                                %>
                                <tr>
                                    <%if(convert(bill_date_11,request)){%>
                                    <td class="greenbutton center"><input form="myform_2" type="submit" value="UPDATE" name="submit1"></td>
                                    <%}%>
                                    <td class="redbutton cventer"><input form="myform_2" type="submit" value="BACK" name="submit1"></td>
                                </tr>
                                <%
                                }
                                %>    
                            </table>
                            
                        <%
                        if(!bill_date_11.equals(""))
                        {
                            rs=stm.executeQuery("select * from receipt where operator='airtel_2' and date='"+bill_date_11+"'");
                            if(rs.next())
                            {
                            %>
                            <table class="center" cellspacing="15">    
                                <tr>
                                    <td><b>Receipt Filename :</b></td>
                                    <td style="word-break:break-all;"><%=rs.getString("filename")%></td>
                                </tr>
                                <%
                                if(checkAdmin(admin,username) && convert(bill_date_11,request)) 
                                {
                                %>
                                <tr>
                                    <td>
                                        <a class="gb" target="_blank" href="<%=rs.getString("filepath")%>">Download</a>
                                    </td>
                                    <td>
                                        <a class="rb" target="_self" href="deletereceipt.jsp?operator=airtel_2&bill_month=<%=bill_date_11%>&button=old">Delete</a>
                                    </td>
                                </tr>    
                                <%
                                }
                                else
                                {
                                %>
                                <tr>
                                    <td colspan="2">
                                        <a class="gb" target="_blank" href="<%=rs.getString("filepath")%>">Download</a>
                                    </td>
                                </tr>  
                                <%
                                }
                            %>
                            </table>    
                            <%
                            }
                            else
                            {   
                            %>
                            <form action="FileUploadServlet" method="post" enctype="multipart/form-data">
                                <table class="center" cellspacing="25">
                                    <tr>
                                        <td>Upload Receipt :<input type="file" name="file"></td>
                                    </tr>
                                    <tr>
                                        <td class="greenbutton1">
                                            <input class="btnstyle" type="submit" value="Submit" name="submit_receipt"/>
                                        </td>
                                    </tr>
                                </table> 
                                <input type="hidden" name="mobile2" value="airtel_2"/>
                                <input type="hidden" name="bill_month" value="<%=bill_date_11%>"/>
                                <input type="hidden" name="button" value="old"/>
                                <input type="hidden" value="<%=a_11%>" name="count"/>
                                
                            </form>
                            <%
                            }
                            rs=stm.executeQuery("select * from modifier where operator='airtel_2' and date='"+bill_date_11+"'");
                            if(rs.next())
                            {
                            %>
                            <table class="center" cellspacing="25">
                                <tr>
                                    <td>Last Modified By : </td>
                                    <td><%=rs.getString("emp")%></td>
                                </tr>
                            </table>    
                            <%
                            }
                        }
                        %>
                    </div>
                    <div class="tabcontent11 center" >
                        <form name="myform_2" id="myform_2" method="post" action="<%=filename%>"> 
                        </form>
                        <div class="center tablescroll" style="overflow-x:auto;">
                        <table id="example112" class="display" style="width:100%;" cellspacing="20">
                            <thead>
                                <tr>
                                    <td>S<font color="white">_</font>No</td>
                                    <td>Name</td>
                                    <td>Staff<font color="white">_</font>ID</td>
                                    <td>Designation</td>
                                    <td>Phone Number</td>
                                    <td>Amount</td>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                a_11=0;
                                if(!bill_date_11.equals(""))
                                {
                                    rs=stm.executeQuery("select * from bills where operator='airtel_2' and date='"+bill_date_11+"'");
                                    if(rs.next())
                                    { 
                                    do
                                    {
                                    %>
                                    <tr>
                                        <td><%=a_11+1%></td>
                                        <td><%=rs.getString("name")%></td>
                                        <td><%=rs.getString("emp")%></td>
                                        <td><%=rs.getString("desi")%></td>
                                        <td><%=rs.getString("phone")%></td>
                                        <%if(convert(bill_date_11,request)){%>
                                        <td><input form="myform_2" type="text" value="<%=rs.getString("amount")%>" name="<%=name[a_11]%>" onchange="checknumber(this)" style="width:100px;" required></td>
                                        <%}else{%>
                                        <td><input form="myform_2" type="text" value="<%=rs.getString("amount")%>" name="<%=name[a_11]%>" style="width:100px;" readonly></td>
                                        <%}%>
                                    </tr>
                                    <%
                                        a_11++;  
                                    }while(rs.next());
                                    }
                                    else
                                    {
                                        bill_date_11="";
                                        filename="main.jsp";
                                    }
                                }
                            %>  
                            </tbody>
                        </table>
                        </div>
                    </div>
                    
                            <input form="myform_2" type="hidden" value="airtel_2" name="bill_operator"/>
                            <input form="myform_2" type="hidden" value="airtel_2" name="menubar"/>
                            <input form="myform_2" type="hidden" value="old" name="button"/>
                            <input form="myform_2" type="hidden" value="<%=a_11%>" name="count"/>
                </div>
                </td>
                </tr>
            </table>
        </div>        
        <div id="jio" class="tabcontent center" style="width:100%;">
            <center><p class="title">JIO</p></center>
            <table class="tablecontent display1 center" style="width:100%;">
                <tr>
                <td>
                <div class="tab2">
                    <table class="center" cellspacing="30">
                        <tr>
                        <%
                            if(request.getParameter("button")!=null && request.getParameter("bill_operator").equals("jio"))
                            {
                            if(request.getParameter("button").equals("new"))
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new2')" id="defaultOpen5">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old2')">OLD BILL</button></td>
                            <%
                            }
                            else if(request.getParameter("button").equals("old"))
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new2')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old2')" id="defaultOpen5">OLD BILL</button></td>
                            <%
                            }
                            else
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new2')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old2')">OLD BILL</button></td>
                            <%
                            }
                            }
                            else
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new2')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old2')">OLD BILL</button></td>
                            <%
                            }
                        %>
                        </tr>
                    </table>
                </div>
                <div id="new2" class="tabcontent2">
                <%
                    int count2 = 0;
                    double sum2 = 0.0;
                    bill_date = "";
                    String[] amt2 = new String[100];
                    if(request.getParameter("count")!=null && request.getParameter("button").equals("new") && request.getParameter("bill_operator").equals("jio"))
                    {
                        count2=Integer.parseInt(request.getParameter("count"));
                        for(int i=0;i<count2;i++)
                            amt2[i]=request.getParameter(name[i]);
                        if(request.getParameter("sum")!=null)
                            sum2=Double.parseDouble(request.getParameter("sum"));
                        if(request.getParameter("bill_date")!=null)
                            bill_date = request.getParameter("bill_date");
                    }
                    else
                        count2=100;
                    for(int i=0;i<count2;i++)
                    {
                        if(amt2[i]==null)
                            amt2[i]="";
                    }
                %>   
                    
                <form id="form2" name="form2"  method="post" action="bill_validation.jsp">
                </form>
                        <div class="tabcontent12 center">
                            <br><br>
                            <table class="center" cellspacing="20">
                                <tr>
                                    <td>BILL MONTH</td>
                                    <td>
                                        <div class="input-group date datepicker">
                                            <input form="form2" style="width:90%;" type="text" form="form2" onkeydown="return false" onchange="checkdate1(this)" value="<%=bill_date%>" name="bill_date" required>
                                            <span class="input-group-append"></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>	
                                    <td>Total</td>
                                    <td><%=sum2%></td>
                                </tr>
                                <tr>
                                    <td class="greenbutton center"><input form="form2" type="submit" value="GET" name="submit1"></td>
                                    <%if(request.getParameter("bill_date")!=null){%>
                                    <td class="greenbutton center"><input form="form2" type="submit" value="STORE" name="submit1"></td>
                                    <%}else{%>
                                    <td><td>
                                    <%}%>
                                </tr>
                            </table>
                        </div> 
                    <div class="tabcontent11 center" >
                        <div class="center tablescroll" style="overflow-x:auto;">
                        <table id="example2" class="display" style="width:100%;" cellspacing="20">
                            <thead>    
                                <tr>
                                    <td>S<font color="white">_</font>No</td>
                                    <td>Name</td>
                                    <td>Staff<font color="white">_</font>ID</td>
                                    <td>Designation</td>
                                    <td>Phone Number</td>
                                    <td>Amount</td>
                                    <td>Receipt</td>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                int a2=0;
                                rs=stm.executeQuery("select * from jio");
                                while(rs.next())
                                {                
                                %>
                                    <tr>
                                        <td><%=a2+1%></td>
                                        <td><%=rs.getString("name")%></td>
                                        <td><%=rs.getString("emp")%></td>
                                        <td><%=rs.getString("desi")%></td>
                                        <td><%=rs.getString("phone")%></td>
                                        <td><input form="form2" type="text" value="<%=amt2[a2]%>" name="<%=name[a2]%>" onchange="checknumber(this)" style="width:100px;" required/></td>
                                        <%
                                        rs1 = stm1.executeQuery("select * from receipt where operator='jio' and date='"+bill_date+"' and phone='"+rs.getString("phone")+"'");
                                        if(rs1.next())
                                        {
                                        %>
                                        <td>
                                            <a class="gb" target="_blank" href="<%=rs1.getString("filepath")%>">Download</a>
                                            <i class="fa fa-file-text" title="<%=rs1.getString("filename")%>"></i>
                                        </td>
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <td>
                                            <form action="FileUploadServlet" method="post" enctype="multipart/form-data">
                                                
                                                <%if(!bill_date.isEmpty()){%>
                                                    <input type="file" name="file">
                                                    <input class="bluebutton submitstyle" type="submit" value="Submit" name="submit_receipt"/>
                                                <%}%>
                                                <input type="hidden" name="mobile2" value="jio"/>
                                                <input type="hidden" name="bill_month" value="<%=bill_date%>"/>
                                                <input type="hidden" name="button" value="new"/>
                                                <input type="hidden" name="phone" value="<%=rs.getString("phone")%>"/>
                                                <input type="hidden" name="count" value="<%=count2%>"/>
                                                <%
                                                for(int i=0;i<count2;i++)
                                                {
                                                %>
                                                <input type="hidden" value="<%=amt2[i]%>" name="<%=name[i]%>"/>
                                                <%
                                                }
                                                %>
                                            </form>
                                        </td>
                                        <%
                                        }
                                        %>
                                    </tr>
                                    <%
                                        a2++;   
                                }
                                %>  
                            </tbody>
                        </table>
                        </div>
                    </div>
                    <input form="form2" type="hidden" value="<%=a2%>" name="count"/>
                    <input form="form2" type="hidden" value="new" name="button"/>
                    <input form="form2" type="hidden" value="jio" name="bill_operator"/>        
                </div>
                <div id="old2" class="tabcontent2">
                <%
                    String bill_date22="";
                    filename="main.jsp";
                    double sum22=0;
                    if(request.getParameter("bill_operator")!=null && request.getParameter("bill_date")!=null && request.getParameter("button").equals("old") && request.getParameter("bill_operator").equals("jio"))
                    {
                        bill_date22=request.getParameter("bill_date");
                        filename="bill_validation.jsp";
                    }  
                    int a22=0;
                                if(!bill_date22.equals(""))
                                {
                                    rs=stm.executeQuery("select * from bills where operator='jio' and date='"+bill_date22+"'");
                                    if(rs.next())
                                    {
                                    do{
                                    a22++;  
                                        if(rs.getString("amount")!=null)
                                            sum22+=Double.parseDouble(rs.getString("amount"));
                                    }while(rs.next());
                                    }
                                    else
                                    {
                                        bill_date22="";
                                        filename="main.jsp";
                                    }
                }
                %>
                    <div class="tabcontent12 center">
                        <form id="myform2" name="myform2" method="post" action="<%=filename%>"></form> 
                            <br><br>
                            <table class="center" cellspacing="20">
                                <tr>
                                    <td>BILL MONTH</td>
                                    <td>
                                        <%
                                        if(!bill_date22.equals("")){
                                        %>
                                        <div class="input-group date">
                                            <input form="myform2" style="width:90%;" type="text" onkeydown="return false" value="<%=bill_date22%>" onchange="checkdate1(this)" name="bill_date" readonly>
                                            <span class="input-group-append"></span>
                                        </div>
                                        <% 
                                        }
                                        else{
                                        %>
                                        <div class="input-group date datepicker">
                                            <input form="myform2" style="width:90%;" type="text" onkeydown="return false" value="<%=bill_date22%>" onchange="checkdate1(this)" name="bill_date" required>
                                            <span class="input-group-append"></span>
                                        </div>
                                        <%
                                        }
                                        %>
                                    </td>
                                </tr>
                                <tr>	
                                    <td>Sub Total</td>
                                    <td><%=sum22%></td>
                                </tr>
                                <%  
                                if(bill_date22.equals(""))
                                {
                                %>
                                <tr>
                                    <td colspan="2" class="greenbutton1 center"><input form="myform2" type="submit" value="GET DETAILS" name="submit1"></td>
                                </tr>
                                <%
                                }
                                else
                                {
                                %>
                                <tr>
                                    <%if(convert(bill_date22,request)){%>
                                    <td class="greenbutton center"><input form="myform2" type="submit" value="UPDATE" name="submit1"></td>
                                    <%}%>
                                    <td class="redbutton cventer"><input form="myform2" type="submit" value="BACK" name="submit1"></td>
                                </tr>
                                <%
                                }
                                %>    
                            </table>
                            <%
                                rs=stm.executeQuery("select * from modifier where operator='jio' and date='"+bill_date22+"'");
                                if(rs.next())
                                {
                                %>
                                <table class="center" cellspacing="25">
                                    <tr>
                                        <td>Last Modified By : </td>
                                        <td><%=rs.getString("emp")%></td>
                                    </tr>
                                </table>    
                                <%
                                }
                            %>
                    </div>
                    <div class="tabcontent11 center" >
                        <div class="center tablescroll" style="overflow-x:auto;">
                        <table id="example22" class="display" style="width:100%;" cellspacing="20">
                            <thead>
                                <tr>
                                    <td>S<font color="white">_</font>No</td>
                                    <td>Name</td>
                                    <td>Staff<font color="white">_</font>ID</td>
                                    <td>Designation</td>
                                    <td>Phone Number</td>
                                    <td>Amount</td>
                                    <td>Receipt</td>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                a22=0;
                                if(!bill_date22.equals(""))
                                {
                                    rs=stm.executeQuery("select * from bills where operator='jio' and date='"+bill_date22+"'");
                                    while(rs.next()){
                                    %>
                                    <tr>
                                        <td><%=a22+1%></td>
                                        <td><%=rs.getString("name")%></td>
                                        <td><%=rs.getString("emp")%></td>
                                        <td><%=rs.getString("desi")%></td>
                                        <td><%=rs.getString("phone")%></td>
                                        <%if(convert(bill_date22,request)){%>
                                        <td><input form="myform2" type="text" value="<%=rs.getString("amount")%>" name="<%=name[a22]%>" onchange="checknumber(this)" style="width:100px;" required></td>
                                        <%}else{%>
                                        <td><input form="myform2" type="text" value="<%=rs.getString("amount")%>" name="<%=name[a22]%>" style="width:100px;" readonly></td>
                                        <%}%>
                                        <%
                                        rs1 = stm1.executeQuery("select * from receipt where operator='jio' and date='"+bill_date22+"' and phone='"+rs.getString("phone")+"'");
                                        if(rs1.next())
                                        {
                                        %>
                                        <td>
                                            <button class="gb"><a style="text-decoration:none;color:inherit;" target="_blank" href="<%=rs1.getString("filepath")%>">Download</a></button>
                                            <i class="fa fa-file-text" title="<%=rs1.getString("filename")%>"></i>                                            
                                            <%
                                            if(checkAdmin(admin,username) && convert(bill_date22,request)) 
                                            {
                                            %>
                                            <button class="rb"><a style="text-decoration:none;color:inherit;" target="_self" href="deletereceipt.jsp?operator=jio&bill_month=<%=bill_date22%>&phone=<%=rs.getString("phone")%>&button=old">Delete</a></button>
                                            <%
                                            }
                                            %>
                                        </td>
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <td>
                                            <form action="FileUploadServlet" method="post" enctype="multipart/form-data">
                                                <input type="file" name="file">
                                                <input class="bluebutton submitstyle" type="submit" value="Submit" name="submit_receipt"/>
                                                <input type="hidden" name="mobile2" value="jio"/>
                                                <input type="hidden" name="bill_month" value="<%=bill_date22%>"/>
                                                <input type="hidden" name="button" value="old"/>
                                                <input type="hidden" name="phone" value="<%=rs.getString("phone")%>"/>
                                                <input type="hidden" value="<%=a22%>" name="count"/>
                                            </form>
                                        </td>
                                        <%
                                        }
                                    %>
                                    </tr>
                                    <%
                                        a22++;  
                                        
                                    }
                                }
                            %>  
                            </tbody>
                        </table>
                    </div>
                    </div>
                    <input form="myform2" type="hidden" value="jio" name="bill_operator"/>
                    <input form="myform2" type="hidden" value="jio" name="menubar"/>
                    <input form="myform2" type="hidden" value="old" name="button"/>
                    <input form="myform2" type="hidden" value="<%=a22%>" name="count"/>
                </div>
                </td>
                </tr>
            </table>
        </div>       
        <div id="bsnl" class="tabcontent center" style="width:100%;">
            <center><p class="title">BSNL</p></center>
            <table class="tablecontent display1 center" style="width:100%;">
                <tr>
                <td>
                <div class="tab2">
                    <table class="center" cellspacing="30">
                        <tr>
                        <%
                            if(request.getParameter("button")!=null && request.getParameter("bill_operator").equals("bsnl"))
                            {
                            if(request.getParameter("button").equals("new"))
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new3')" id="defaultOpen5">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old3')">OLD BILL</button></td>
                            <%
                            }
                            else if(request.getParameter("button").equals("old"))
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new3')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old3')" id="defaultOpen5">OLD BILL</button></td>
                            <%
                            }
                            else
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new3')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old3')">OLD BILL</button></td>
                            <%
                            }
                            }
                            else
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new3')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old3')">OLD BILL</button></td>
                            <%
                            }
                        %>
                        </tr>
                    </table>
                </div>
                <div id="new3" class="tabcontent2">
                <%
                    int count3 = 0;
                    double sum3 = 0.0;
                    double one  = 0.0;
                    double fixed = 0.0;
                    double misc = 0.0;
                    double usage = 0.0;
                    double late = 0.0;
                    double discount = 0.0;
                    double adj = 0.0;
                    
                    bill_date = "";
                    String[] amt3 = new String[100];
                    if(request.getParameter("count")!=null && request.getParameter("button").equals("new") && request.getParameter("bill_operator").equals("bsnl"))
                    {
                        count3=Integer.parseInt(request.getParameter("count"));
                        for(int i=0;i<count3;i++)
                            amt3[i]=request.getParameter(name[i]);
                        if(request.getParameter("sum")!=null)
                            sum3=Double.parseDouble(request.getParameter("sum"));
                        if(request.getParameter("bill_date")!=null)
                            bill_date = request.getParameter("bill_date");
                            
                        one = Double.parseDouble(request.getParameter("one_charge"));
                        fixed = Double.parseDouble(request.getParameter("f_charge"));
                        misc = Double.parseDouble(request.getParameter("m_charge"));
                        usage = Double.parseDouble(request.getParameter("u_charge"));
                        late = Double.parseDouble(request.getParameter("l_charge"));
                        discount = Double.parseDouble(request.getParameter("discount"));
                        adj = Double.parseDouble(request.getParameter("adj"));
                    }
                    else
                        count3=100;
                    for(int i=0;i<count3;i++)
                    {
                        if(amt3[i]==null)
                            amt3[i]="399.00";
                    }
                %>   
                <form name="form3" id="form3" method="post" action="bill_validation.jsp"> </form>
                        <div class="tabcontent12 center">
                            <br><br>
                            <table class="center" cellspacing="20">
                                <tr>
                                    <td>BILL MONTH</td>
                                    <td>
                                        <div class="input-group date datepicker">
                                            <input form="form3" style="width:90%;" type="text" onkeydown="return false" value="<%=bill_date%>" onchange="checkdate1(this)" name="bill_date" required>
                                            <span class="input-group-append"></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td>One Time Charge</td>
                                    <td><input form="form3" class="bsnl_input" type="text" value="<%=one%>" name="one_charge" required/></td>
                                </tr>
                                <tr>
                                    <td>Fixed Monthly Charge</td>
                                    <td><input form="form3" class="bsnl_input" type="text" value="<%=fixed%>" name="f_charge" required/></td>
                                </tr>
                                <tr>
                                    <td>Usage Charge</td>
                                    <td><input form="form3" class="bsnl_input" type="text" value="<%=usage%>" name="u_charge" required/></td>
                                </tr>
                                <tr>
                                    <td>Miscellaneous Charge</td>
                                    <td><input form="form3" class="bsnl_input" type="text" value="<%=misc%>" name="m_charge" required/></td>
                                </tr>
                                <tr>
                                    <td>Late Charge</td>
                                    <td><input form="form3" class="bsnl_input" type="text" value="<%=late%>" name="l_charge" required/></td>
                                </tr>
                                <tr>	
                                    <td>Sub Total</td>
                                    <td style="font-size:14pt;"><%=sum3%></td>
                                </tr>
                                <%sum3-=discount;%>
                                <tr>
                                    <td>Discount</td>
                                    <td><input form="form3" class="bsnl_input" type="text" value="<%=discount%>" name="discount" required/></td>
                                </tr>
                                <%sum3-=adj;%>
                                <tr>
                                    <td>Adjustments</td>
                                    <td><input form="form3" class="bsnl_input" type="text" value="<%=adj%>" name="adj" required/></td>
                                </tr>
                                <tr>
                                    <td>Total Charge</td>
                                    <td style="font-size:14pt;"><%=Math.round(sum3*100.0)/100.0%></td>
                                </tr>
                                <tr>
                                    <td>CGST</td>
                                    <td style="font-size:14pt;"><%=Math.round(sum3*cgst*100.0)/100.0%></td>
                                </tr>
                                <tr>
                                    <td>SGST</td>
                                    <td style="font-size:14pt;"><%=Math.round(sum3*sgst*100.0)/100.0%></td>
                                </tr>
                                <tr>
                                    <td>Grand Total</td>
                                    <td style="font-size:14pt;"><%=Math.round(((sum3*cgst+sum3*sgst)+sum3)*100.0)/100.0%></td>
                                </tr>
                                <tr>
                                    <td class="greenbutton center"><input form="form3" type="submit" value="GET" name="submit1"></td>
                                    <%if(request.getParameter("bill_date")!=null){%>
                                    <td class="greenbutton center"><input form="form3" type="submit" value="STORE" name="submit1"></td>
                                    <%}else{%>
                                    <td><td>
                                    <%}%>
                                </tr>
                            </table>
                        
                    
                    <%
                    if(!bill_date.isEmpty())
                    {
                        rs=stm.executeQuery("select * from receipt where operator='bsnl' and date='"+bill_date+"'");
                        if(rs.next())
                        {
                            %>
                            <table class="center" cellspacing="15">    
                                <tr>
                                    <td><b>Receipt Filename :</b></td>
                                    <td style="word-break:break-all;"><%=rs.getString("filename")%></td>
                                </tr>
                                <tr>
                                    <td colspan="2">
                                        <a class="gb" target="_blank" href="<%=rs.getString("filepath")%>">Download</a>
                                    </td>
                                </tr>  
                            </table>    
                            <%
                        }
                        else
                        {   
                            %>
                            <form action="FileUploadServlet" method="post" enctype="multipart/form-data">
                                <table class="center" cellspacing="25">
                                    <tr>
                                        <td>Upload Receipt :<input type="file" name="file"></td>
                                    </tr>
                                    <tr>
                                        <td class="greenbutton1">
                                            <input type="submit" value="Submit" name="submit_receipt"/>
                                        </td>
                                    </tr>
                                </table>
                                <input type="hidden" name="mobile2" value="bsnl"/>
                                <input type="hidden" name="bill_month" value="<%=bill_date%>"/>
                                <input type="hidden" name="button" value="new"/>
                                <input type="hidden" name="count" value="<%=count3%>"/>
                                <%
                                for(int i=0;i<count3;i++)
                                {%>
                                <input type="hidden" value="<%=amt3[i]%>" name="<%=name[i]%>"/>
                                <%
                                }
                                %>
                            </form>
                            <%
                        }
                    }    
                    %>
                    </div>    
                    <div class="tabcontent11 center" >
                        <div class="tablescroll center" style="overflow-x:auto;">
                            <table id="example3" class="display" style="width:100%;" cellspacing="20">
                                <thead>    
                                    <tr>
                                        <td>S<font color="white">_</font>No</td>
                                        <td>Name</td>
                                        <td>Staff<font color="white">_</font>ID</td>
                                        <td>Designation</td>
                                        <td>Phone Number</td>
                                        <td>Amount</td>
                                    </tr>
                                </thead>
                                <tbody>
                                <%
                                    int a3=0;
                                    rs=stm.executeQuery("select * from bsnl");
                                    while(rs.next())
                                    {                
                                    %>
                                    <tr>
                                        <td><%=a3+1%></td>
                                        <td><%=rs.getString("name")%></td>
                                        <td><%=rs.getString("emp")%></td>
                                        <td><%=rs.getString("desi")%></td>
                                        <td><%=rs.getString("phone")%></td>
                                        <td><input form="form3" type="text" value="<%=amt3[a3]%>" name="<%=name[a3]%>" onchange="checknumber(this)" style="width:100px;" required></td>
                                    </tr>
                                    <%
                                        a3++;   
                                    }
                                %>  
                                </tbody>
                            </table>
                        </div>
                    </div>
                    <input form="form3" type="hidden" value="<%=a3%>" name="count"/>
                    <input form="form3" type="hidden" value="new" name="button"/>
                    <input form="form3" type="hidden" value="bsnl" name="bill_operator"/>
                </div>
                <div id="old3" class="tabcontent2">
                <%
                    String bill_date33="";
                    double one3 = 0.0;
                    double fixed3 = 0.0;
                    double misc3 = 0.0;
                    double usage3 = 0.0;
                    double late3 = 0.0;
                    double discount3 = 0.0;
                    double adj3 = 0.0;
                    filename="main.jsp";
                    double sum33=0;
                    int a33=0;
                    double cgst4=0.0;
                    double sgst4=0.0;
                    if(request.getParameter("bill_operator")!=null && request.getParameter("bill_date")!=null && request.getParameter("button").equals("old") && request.getParameter("bill_operator").equals("bsnl"))
                    {
                    
                        bill_date33=request.getParameter("bill_date");
                        filename="bill_validation.jsp";
                    }  
                    if(!bill_date33.equals(""))
                    {
                                    rs=stm.executeQuery("select * from bills where operator='bsnl' and date='"+bill_date33+"'");
                                    if(rs.next())
                                    { 
                                        do{
                                            a33++;  
                                            cgst4=Double.parseDouble(rs.getString("cgst"));
                                            sgst4=Double.parseDouble(rs.getString("sgst"));
                                            one3=Double.parseDouble(rs.getString("one"));
                                            fixed3=Double.parseDouble(rs.getString("fixed"));
                                            usage3=Double.parseDouble(rs.getString("usages"));
                                            misc3=Double.parseDouble(rs.getString("misc"));
                                            late3=Double.parseDouble(rs.getString("late"));
                                            discount3=Double.parseDouble(rs.getString("discount"));
                                            adj3=Double.parseDouble(rs.getString("adj"));

                                        }while(rs.next());
                                        sum33+=one3+fixed3+usage3+misc3+late3;
                                    }
                                    else
                                    {
                                        bill_date33="";
                                        filename="main.jsp";
                                    }
                                    
                                }
                %>
                    <div class="tabcontent12 center">
                        <form id="myform3" method="post" action="<%=filename%>"> </form>
                            <br><br>
                            <table class="center" cellspacing="10">
                                <tr>
                                    <td>BILL MONTH</td>
                                    <td>                                     
                                    <%
                                        if(!bill_date33.equals("")){
                                        %>
                                        <div class="input-group date">
                                            <input form="myform3" style="width:90%;" type="text" onkeydown="return false" value="<%=bill_date33%>" onchange="checkdate1(this)" name="bill_date" readonly>
                                            <span class="input-group-append"></span>
                                        </div>
                                        <% 
                                        }
                                        else{
                                        %>
                                        <div class="input-group date datepicker">
                                            <input form="myform3" style="width:90%;" type="text" onkeydown="return false" value="<%=bill_date33%>" onchange="checkdate1(this)" name="bill_date" required>
                                            <span class="input-group-append"></span>
                                        </div>
                                        <%
                                        }
                                        %>
                                        
                                    </td>
                                </tr>
                                <tr>
                                    <td>One Time Charge</td>
                                    <td><input form="myform3" class="bsnl_input" type="text" value="<%=one3%>" name="one_charge" required/></td>
                                </tr>
                                <tr>
                                    <td>Fixed Monthly Charge</td>
                                    <td><input form="myform3" class="bsnl_input" type="text" value="<%=fixed3%>" name="f_charge" required/></td>
                                </tr>
                                <tr>
                                    <td>Usage Charge</td>
                                    <td><input form="myform3" class="bsnl_input" type="text" value="<%=usage3%>" name="u_charge" required/></td>
                                </tr>
                                <tr>
                                    <td>Miscellaneous Charge</td>
                                    <td><input form="myform3" class="bsnl_input" type="text" value="<%=misc3%>" name="m_charge" required/></td>
                                </tr>
                                <tr>
                                    <td>Late Charge</td>
                                    <td><input form="myform3" class="bsnl_input" type="text" value="<%=late3%>" name="l_charge" required/></td>
                                </tr>
                                <tr>	
                                    <td>Sub Total</td>
                                    <td style="font-size:14pt;"><%=Math.round(sum33*100.0)/100.0%></td>
                                </tr>
                                <%sum33-=discount3;%>
                                <tr>
                                    <td>Discount</td>
                                    <td><input form="myform3" class="bsnl_input" type="text" value="<%=discount3%>" name="discount" required/></td>
                                </tr>
                                <%sum3-=adj3;%>
                                <tr>
                                    <td>Adjustments</td>
                                    <td><input form="myform3" class="bsnl_input" type="text" value="<%=adj3%>" name="adj" required/></td>
                                </tr>
                                <tr>
                                    <td>Total Charge</td>
                                    <td style="font-size:14pt;"><%=Math.round(sum33*100.0)/100.0%></td>
                                </tr>
                                <tr>
                                    <td>CGST</td>
                                    <td style="font-size:14pt;"><%=Math.round(sum33*cgst*100.0)/100.0%></td>
                                </tr>
                                <tr>
                                    <td>SGST</td>
                                    <td style="font-size:14pt;"><%=Math.round(sum33*sgst*100.0)/100.0%></td>
                                </tr>
                                <tr>
                                    <td>Grand Total</td>
                                    <td style="font-size:14pt;"><%=Math.round(((sum33*cgst+sum33*sgst)+sum33)*100.0)/100.0%></td>
                                </tr>
                                <%  
                                if(bill_date33.equals(""))
                                {
                                %>
                                <tr>
                                    <td colspan="2" class="greenbutton1 center"><input form="myform3" type="submit" value="GET DETAILS" name="submit1"></td>
                                </tr>
                                <%
                                }
                                else
                                {
                                %>
                                <tr>
                                    <%if(convert(bill_date33,request)){%>
                                    <td class="greenbutton center"><input form="myform3" type="submit" value="UPDATE" name="submit1"></td>
                                    <%}%>
                                    <td class="redbutton cventer"><input form="myform3" type="submit" value="BACK" name="submit1"></td>
                                </tr>
                                <%
                                }
                                %>    
                            </table>
                            <input form="myform3" type="hidden" value="bsnl" name="bill_operator"/>
                            <input form="myform3" type="hidden" value="bsnl" name="menubar"/>
                            <input form="myform3" type="hidden" value="old" name="button"/>
                            <input form="myform3" type="hidden" value="<%=a33%>" name="count"/>
                        <%
                        if(!bill_date33.equals(""))
                        {
                            rs=stm.executeQuery("select * from receipt where operator='bsnl' and date='"+bill_date33+"'");
                            if(rs.next())
                            {
                            %>
                            <table class="center" cellspacing="15">    
                                <tr>
                                    <td colspan="2"><b>Receipt Filename :</b></td>
                                </tr>
                                <tr>
                                    <td colspan="2" style="word-break: break-all;"><%=rs.getString("filename")%></td>
                                </tr>
                                <%
                                if(checkAdmin(admin,username) && convert(bill_date33,request)) 
                                {
                                %>
                                <tr>
                                    <td>
                                        <a class="gb" target="_blank" href="<%=rs.getString("filepath")%>">Download</a>
                                    </td>
                                    <td>
                                        <a class="rb" target="_self" href="deletereceipt.jsp?operator=bsnl&bill_month=<%=bill_date33%>&button=old">Delete</a>
                                    </td>
                                </tr>    
                                <%
                                }
                                else
                                {
                                %>
                                <tr>
                                    <td colspan="2">
                                        <a class="gb" target="_blank" href="<%=rs.getString("filepath")%>">Download</a>
                                    </td>
                                </tr>  
                                <%
                                }  
                                %>
                            </table>    
                            <%
                            }
                            else
                            {
                            %>
                            <form action="FileUploadServlet" method="post" enctype="multipart/form-data">
                                <table class="center" cellspacing="25">
                                    <tr>
                                        <td>UPLOAD RECEIPT :<input type="file" name="file"></td>
                                    </tr>
                                    <tr>
                                        <td class="greenbutton1">
                                            <input type="submit" value="upload" name="submit_receipt"/>
                                        </td>
                                    </tr>
                                </table> 
                                <input type="hidden" name="mobile2" value="bsnl"/>
                                <input type="hidden" value="<%=a33%>" name="count"/>
                                <input type="hidden" name="bill_month" value="<%=bill_date33%>"/>
                                <input type="hidden" name="button" value="old"/>
                            </form>
                            <%
                            }
                        }
                        rs=stm.executeQuery("select * from modifier where operator='bsnl' and date='"+bill_date33+"'");
                        if(rs.next())
                        {
                        %>
                            <table class="center" cellspacing="25">
                                <tr>
                                    <td>Last Modified By : </td>
                                    <td><%=rs.getString("emp")%></td>
                                </tr>
                            </table>    
                        <%
                        }
                        %>
                    </div>
                    <div class="tabcontent11 center">
                        <div class="tablescroll center" style="overflow-x:auto;">
                        <table id="example33" class="display" style="width:100%;" cellspacing="20">
                            <thead>
                                <tr>
                                    <td>S<font color="white">_</font>No</td>
                                    <td>Name</td>
                                    <td>Staff<font color="white">_</font>ID</td>
                                    <td>Designation</td>
                                    <td>Phone Number</td>
                                    <td>Amount</td>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                a33=0;
                                if(!bill_date33.equals(""))
                                {
                                    rs=stm.executeQuery("select * from bills where operator='bsnl' and date='"+bill_date33+"'");
                                    if(rs.next())
                                    { 
                                        do{
                                        %>
                                        <tr>
                                            <td><%=a33+1%></td>
                                            <td><%=rs.getString("name")%></td>
                                            <td><%=rs.getString("emp")%></td>
                                            <td><%=rs.getString("desi")%></td>
                                            <td><%=rs.getString("phone")%></td>
                                            <%if(convert(bill_date33,request)){%>
                                            <td><input form="myform3" type="text" value="<%=rs.getString("amount")%>" name="<%=name[a33]%>" onchange="checknumber(this)" style="width:100px;" required></td>
                                            <%}else{%>
                                            <td><input form="myform3" type="text" value="<%=rs.getString("amount")%>" name="<%=name[a33]%>" style="width:100px;" readonly></td>
                                            <%}%>
                                        </tr>
                                        <%
                                            a33++;  

                                        }while(rs.next());
                                    }
                                }
                            %>  
                            </tbody>
                        </table>
                    </div>
                    </div>
                    
                </div>
                </td>
                </tr>
            </table>
        </div>        
        <div id="vodofone" class="tabcontent center" style="width:100%;">
            <center><p class="title">VODOFONE</p></center>
            <table class="tablecontent display1 center" style="width:100%;">
                <tr>
                <td>
                <div class="tab2">
                    <table class="center" cellspacing="30">
                        <tr>
                        <%
                            if(request.getParameter("button")!=null && request.getParameter("bill_operator").equals("vodofone"))
                            {
                            if(request.getParameter("button").equals("new"))
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new4')" id="defaultOpen5">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old4')">OLD BILL</button></td>
                            <%
                            }
                            else if(request.getParameter("button").equals("old"))
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new4')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old4')" id="defaultOpen5">OLD BILL</button></td>
                            <%
                            }
                            else
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new4')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old4')">OLD BILL</button></td>
                            <%
                            }
                            }
                            else
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new4')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old4')">OLD BILL</button></td>
                            <%
                            }
                        %>
                        </tr>
                    </table>
                </div>
                <div id="new4" class="tabcontent2">
                <%
                    int count4 = 0;
                    double sum4 = 0.0;
                    bill_date = "";
                    String[] amt4 = new String[100];
                    if(request.getParameter("count")!=null && request.getParameter("button").equals("new") && request.getParameter("bill_operator").equals("vodofone"))
                    {
                        count4=Integer.parseInt(request.getParameter("count"));
                        for(int i=0;i<count4;i++)
                            amt4[i]=request.getParameter(name[i]);
                        if(request.getParameter("sum")!=null)
                            sum4=Double.parseDouble(request.getParameter("sum"));
                        if(request.getParameter("bill_date")!=null)
                            bill_date = request.getParameter("bill_date");
                    }
                    else
                        count4=100;
                    for(int i=0;i<count4;i++)
                    {
                        if(amt4[i]==null)
                            amt4[i]="";
                    }
                %>   
                <form id="form4" name="form4" method="post" action="bill_validation.jsp"> </form>
                        <div class="tabcontent12 center">
                            <br><br>
                            <table class="center" cellspacing="20">
                                <tr>
                                    <td>BILL MONTH</td>
                                    <td>
                                        <div class="input-group date datepicker">
                                            <input form="form4" style="width:90%;" type="text" onkeydown="return false" value="<%=bill_date%>" onchange="checkdate1(this)"  name="bill_date" required>
                                            <span class="input-group-append"></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>	
                                    <td>Total</td>
                                    <td><%=sum4%></td>
                                </tr>
                                <tr>
                                    <td class="greenbutton center"><input form="form4" type="submit" value="GET" name="submit1"></td>
                                    <%if(request.getParameter("bill_date")!=null){%>
                                    <td class="greenbutton center"><input form="form4" type="submit" value="STORE" name="submit1"></td>
                                    <%}else{%>
                                    <td><td>
                                    <%}%>
                                </tr>
                            </table>
                        </div>
                    <div class="tabcontent11 center" >
                        <div class="tablescroll center" style="overflow-x:auto;">
                        <table id="example4" class="display" style="width:100%;" cellspacing="20">
                            <thead>    
                                <tr>
                                    <td>S<font color="white">_</font>No</td>
                                    <td>Name</td>
                                    <td>Staff<font color="white">_</font>ID</td>
                                    <td>Designation</td>
                                    <td>Phone Number</td>
                                    <td>Amount</td>
                                    <td>Receipt</td>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                int a4=0;
                                rs=stm.executeQuery("select * from vodofone");
                                while(rs.next())
                                {                
                                %>
                                    <tr>
                                        <td><%=a4+1%></td>
                                        <td><%=rs.getString("name")%></td>
                                        <td><%=rs.getString("emp")%></td>
                                        <td><%=rs.getString("desi")%></td>
                                        <td><%=rs.getString("phone")%></td>
                                        <td><input form="form4" type="text" value="<%=amt4[a4]%>" name="<%=name[a4]%>" style="width:100px;" required/></td>
                                        <%
                                        rs1 = stm1.executeQuery("select * from receipt where operator='vodofone' and date='"+bill_date+"' and phone='"+rs.getString("phone")+"'");
                                        if(rs1.next())
                                        {
                                        %>
                                        <td>
                                            <a class="gb" target="_blank" href="<%=rs1.getString("filepath")%>">Download</a>
                                            <i class="fa fa-file-text" title="<%=rs1.getString("filename")%>"></i>
                                        </td>
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <td>
                                            <form action="FileUploadServlet" method="post" enctype="multipart/form-data">
                                                
                                                <%if(!bill_date.isEmpty()){%>   
                                                <input type="file" name="file">
                                                <input class="bluebutton submitstyle" type="submit" value="Submit" name="submit_receipt"/>
                                                <%}%>
                                                <input type="hidden" name="mobile2" value="vodofone"/>
                                                <input type="hidden" name="bill_month" value="<%=bill_date%>"/>
                                                <input type="hidden" name="button" value="new"/>
                                                <input type="hidden" name="phone" value="<%=rs.getString("phone")%>"/>
                                                <input type="hidden" name="count" value="<%=count4%>"/>
                                                <%
                                                for(int i=0;i<count4;i++)
                                                {
                                                %>
                                                <input type="hidden" value="<%=amt4[i]%>" name="<%=name[i]%>"/>
                                                <%
                                                }
                                                %>
                                            </form>
                                        </td>
                                        <%
                                        }
                                        %>
                                    </tr>
                                    <%
                                        a4++;   
                                }
                                %>  
                            </tbody>
                        </table>
                        </div>
                    </div>            
                    <input form="form4" type="hidden" value="<%=a4%>" name="count"/>
                    <input form="form4" type="hidden" value="new" name="button"/>
                    <input form="form4" type="hidden" value="vodofone" name="bill_operator"/>
                </div>
                <div id="old4" class="tabcontent2">
                <%
                    String bill_date44="";
                    filename="main.jsp";
                    double sum44=0;
                    if(request.getParameter("bill_operator")!=null && request.getParameter("bill_date")!=null && request.getParameter("button").equals("old") && request.getParameter("bill_operator").equals("vodofone"))
                    {
                        bill_date44=request.getParameter("bill_date");
                        filename="bill_validation.jsp";
                    }  
                    int a44=0;
                                if(!bill_date44.equals(""))
                                {
                                    rs=stm.executeQuery("select * from bills where operator='vodofone' and date='"+bill_date44+"'");
                                    if(rs.next())
                                    {
                                    do
                                    {
                                    a44++;  
                                        if(rs.getString("amount")!=null)
                                            sum44+=Double.parseDouble(rs.getString("amount"));
                                        }while(rs.next());
                                        }
                                    else
                                   {
                                        bill_date44="";
                                        filename="main.jsp";
                                   }   
                                    
                                }
                %>
                    
                    <div class="tabcontent12 center">
                        <form id="myform4" method="post" action="<%=filename%>"> 
                            <br><br>
                            <table class="center" cellspacing="20">
                                <tr>
                                    <td>BILL MONTH</td>
                                    <td>
                                    <%
                                        if(!bill_date44.equals("")){
                                        %>
                                        <div class="input-group date">
                                            <input style="width:90%;" type="text" onkeydown="return false" value="<%=bill_date44%>" onchange="checkdate1(this)" name="bill_date" readonly>
                                            <span class="input-group-append"></span>
                                        </div>
                                        <% 
                                        }
                                        else{
                                        %>
                                        <div class="input-group date datepicker">
                                            <input style="width:90%;" type="text" onkeydown="return false" value="<%=bill_date44%>" onchange="checkdate1(this)" name="bill_date" required>
                                            <span class="input-group-append"></span>
                                        </div>
                                        <%
                                        }
                                        %>
                                        
                                    </td>
                                </tr>
                                <tr>	
                                    <td>Sub Total</td>
                                    <td><%=sum44%></td>
                                </tr>
                                <%  
                                if(bill_date44.equals(""))
                                {
                                %>
                                <tr>
                                    <td colspan="2" class="greenbutton center"><input type="submit" value="GET DETAILS" name="submit1"></td>
                                </tr>
                                <%
                                }
                                else
                                {  
                                %>
                                <tr>
                                    <%if(convert(bill_date44,request)){%>
                                    <td class="greenbutton center"><input type="submit" value="UPDATE" name="submit1"></td>
                                    <%}%>
                                    <td class="redbutton cventer"><input type="submit" value="BACK" name="submit1"></td>
                                </tr>
                                <%
                                }
                                %>    
                            </table>
                            <%
                                rs=stm.executeQuery("select * from modifier where operator='vodofone' and date='"+bill_date44+"'");
                                if(rs.next())
                                {
                                %>
                                <table class="center" cellspacing="25">
                                    <tr>
                                        <td>Last Modified By : </td>
                                        <td><%=rs.getString("emp")%></td>
                                    </tr>
                                </table>    
                                <%
                                }
                            %>
                            <input type="hidden" value="vodofone" name="bill_operator"/>
                            <input type="hidden" value="vodofone" name="menubar"/>
                            <input type="hidden" value="old" name="button"/>
                            <input type="hidden" value="<%=a44%>" name="count"/>
                        </form>  
                    </div>
                        <div class="tabcontent11 center" >
                            <div class="tablescroll center" style="overflow-x:auto;">
                        <table id="example44" class="display" style="width:100%;" cellspacing="20">
                            <thead>
                                <tr>
                                    <td>S<font color="white">_</font>No</td>
                                    <td>Name</td>
                                    <td>Staff<font color="white">_</font>ID</td>
                                    <td>Designation</td>
                                    <td>Phone Number</td>
                                    <td>Amount</td>
                                    <td>Receipt</td>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                 a44=0;
                                if(!bill_date44.equals(""))
                                {
                                    rs=stm.executeQuery("select * from bills where operator='vodofone' and date='"+bill_date44+"'");
                                    if(rs.next())
                                    {
                                    do
                                    {
                                    %>
                                    <tr>
                                        <td><%=a44+1%></td>
                                        <td><%=rs.getString("name")%></td>
                                        <td><%=rs.getString("emp")%></td>
                                        <td><%=rs.getString("desi")%></td>
                                        <td><%=rs.getString("phone")%></td>
                                        <%if(convert(bill_date44,request)){%>
                                        <td><input form="myform4" type="text" value="<%=rs.getString("amount")%>" name="<%=name[a44]%>" onchange="checknumber(this)" style="width:100px;" required></td>
                                        <%}else{%>
                                        <td><input form="myform4" type="text" value="<%=rs.getString("amount")%>" name="<%=name[a44]%>" style="width:100px;" readonly></td>
                                        <%}%>
                                        <%
                                        rs1 = stm1.executeQuery("select * from receipt where operator='vodofone' and date='"+bill_date44+"' and phone='"+rs.getString("phone")+"'");
                                        if(rs1.next())
                                        {
                                        %>
                                        <td>
                                            <button class="gb"><a style="text-decoration:none;color:inherit;" target="_blank" href="<%=rs1.getString("filepath")%>">Download</a></button>
                                            <i class="fa fa-file-text" title="<%=rs1.getString("filename")%>"></i>
                                            <%
                                            if(checkAdmin(admin,username) && convert(bill_date44,request)) 
                                            {
                                            %>
                                            <button class="rb"><a style="text-decoration:none;color:inherit;" target="_self" href="deletereceipt.jsp?operator=vodofone&bill_month=<%=bill_date44%>&phone=<%=rs.getString("phone")%>&button=old">Delete</a></button>
                                            <%
                                            }
                                            %>
                                        </td>
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <td>
                                            <form action="FileUploadServlet" method="post" enctype="multipart/form-data">
                                                <input type="file" name="file">
                                                <input class="bluebutton submitstyle" type="submit" value="Submit" name="submit_receipt"/>
                                                <input type="hidden" name="mobile2" value="vodofone"/>
                                                <input type="hidden" value="<%=a44%>" name="count"/>
                                                <input type="hidden" name="bill_month" value="<%=bill_date44%>"/>
                                                <input type="hidden" name="button" value="old"/>
                                                <input type="hidden" name="phone" value="<%=rs.getString("phone")%>"/>
                                            </form>
                                        </td>
                                        <%
                                        }
                                        %>
                                    </tr>
                                    <%
                                        a44++;  
                                        }while(rs.next());
                                        }
                                    
                                }
                            %>  
                            </tbody>
                        </table>
                            </div>
                    </div>
                </div>
                        
                </td>
                </tr>
            </table>                        
        </div>
        <div id="airtelvip" class="tabcontent center">
            <center><p class="title">AIRTEL VIP</p></center>
            <table class="tablecontent display1 center" style="width:100%;">
                <tr>
                <td>
                <div class="tab2">
                    <table class="center" cellspacing="30">
                        <tr>
                        <%
                            if(request.getParameter("button")!=null && request.getParameter("bill_operator").equals("airtelvip"))
                            {
                            if(request.getParameter("button").equals("new"))
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new5')" id="defaultOpen5">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old5')">OLD BILL</button></td>
                            <%
                            }
                            else if(request.getParameter("button").equals("old"))
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new5')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old5')" id="defaultOpen5">OLD BILL</button></td>
                            <%
                            }
                            else
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new5')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old5')">OLD BILL</button></td>
                            <%
                            }
                            }
                            else
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new5')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old5')">OLD BILL</button></td>
                            <%
                            }
                        %>
                        </tr>
                    </table>
                </div>
                <div id="new5" class="tabcontent2">
                <%
                    int count5 = 0;
                    double sum5 = 0.0;
                    bill_date = "";
                    String[] amt5 = new String[100];
                    if(request.getParameter("count")!=null && request.getParameter("button").equals("new") && request.getParameter("bill_operator").equals("airtelvip"))
                    {
                        count5=Integer.parseInt(request.getParameter("count"));
                        for(int i=0;i<count5;i++)
                            amt5[i]=request.getParameter(name[i]);
                        if(request.getParameter("sum")!=null)
                            sum5=Double.parseDouble(request.getParameter("sum"));
                        if(request.getParameter("bill_date")!=null)
                            bill_date = request.getParameter("bill_date");
                    }
                    else
                        count5=100;
                    for(int i=0;i<count5;i++)
                    {
                        if(amt5[i]==null)
                            amt5[i]="";
                    }
                %>   
                    <form id="form5"  method="post" action="bill_validation.jsp"> 
                        <div class="tabcontent12 center">
                            <br><br>
                            <table class="center" cellspacing="20">
                                <tr>
                                    <td>BILL MONTH</td>
                                    <td>
                                       <div class="input-group date datepicker">
                                            <input style="width:90%;" type="text" onkeydown="return false" value="<%=bill_date%>" onchange="checkdate1(this)" name="bill_date" required>
                                            <span class="input-group-append"></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>	
                                    <td>Total</td>
                                    <td><%=sum5%></td>
                                </tr>
                                <tr>
                                    <td class="greenbutton center"><input type="submit" value="GET" name="submit1"></td>
                                    <%if(request.getParameter("bill_date")!=null){%>
                                    <td class="greenbutton center"><input type="submit" value="STORE" name="submit1"></td>
                                    <%}else{%>
                                    <td><td>
                                    <%}%>
                                </tr>
                            </table>
                        </div>
                    </form>
                    <div class="tabcontent11 center" >
                        <div class="tablescroll center" style="overflow-x:auto;">
                        <table id="example5" class="display" style="width:100%;" cellspacing="20">
                            <thead>    
                                <tr>
                                    <td>S<font color="white">_</font>No</td>
                                    <td>Name</td>
                                    <td>Staff<font color="white">_</font>ID</td>
                                    <td>Designation</td>
                                    <td>Phone Number</td>
                                    <td>Amount</td>
                                    <td>Receipt</td>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                int a5=0;
                                rs=stm.executeQuery("select * from airtelvip");
                                while(rs.next())
                                {                
                                %>
                                    <tr>
                                        <td><%=a5+1%></td>
                                        <td><%=rs.getString("name")%></td>
                                        <td><%=rs.getString("emp")%></td>
                                        <td><%=rs.getString("desi")%></td>
                                        <td><%=rs.getString("phone")%></td>
                                        <td><input form="form5" type="text" value="<%=amt5[a5]%>" name="<%=name[a5]%>" onchange="checknumber(this)" style="width:100px;" required/></td>
                                        <%
                                        rs1 = stm1.executeQuery("select * from receipt where operator='airtelvip' and date='"+bill_date+"' and phone='"+rs.getString("phone")+"'");
                                        if(rs1.next())
                                        {
                                        %>
                                        <td>
                                            <a class="gb" target="_blank" href="<%=rs1.getString("filepath")%>">Download</a>
                                            <i class="fa fa-file-text" title="<%=rs1.getString("filename")%>"></i>
                                        </td>
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <td>
                                            <form action="FileUploadServlet" method="post" enctype="multipart/form-data">
                                                <%if(!bill_date.isEmpty()){%>
                                                <input type="file" name="file">
                                                <input class="bluebutton submitstyle" type="submit" value="Submit" name="submit_receipt"/>
                                                <%}%>
                                                <input type="hidden" name="mobile2" value="airtelvip"/>
                                                <input type="hidden" name="bill_month" value="<%=bill_date%>"/>
                                                <input type="hidden" name="button" value="new"/>
                                                <input type="hidden" name="phone" value="<%=rs.getString("phone")%>"/>
                                                <input type="hidden" name="count" value="<%=count5%>"/>
                                                <%
                                                for(int i=0;i<count5;i++)
                                                {
                                                %>
                                                <input type="hidden" value="<%=amt5[i]%>" name="<%=name[i]%>"/>
                                                <%
                                                }
                                                %>
                                            </form>
                                        </td>
                                        <%
                                        }
                                        %>
                                    </tr>
                                    <%
                                        a5++;   
                                }
                                %>  
                            </tbody>                                            
                        </table>
                        </div>
                    </div>
                    <input form="form5" type="hidden" value="<%=a5%>" name="count"/>
                    <input form="form5" type="hidden" value="new" name="button"/>
                    <input form="form5" type="hidden" value="airtelvip" name="bill_operator"/>
                </div>
                <div id="old5" class="tabcontent2">
                <%
                    String bill_date55="";
                    filename="main.jsp";
                    double sum55=0;
                    if(request.getParameter("bill_operator")!=null && request.getParameter("bill_date")!=null && request.getParameter("button").equals("old") && request.getParameter("bill_operator").equals("airtelvip"))
                    {
                        bill_date55=request.getParameter("bill_date");
                        filename="bill_validation.jsp";
                    }  
                                int a55=0;
                                if(!bill_date55.equals(""))
                                {
                                rs=stm.executeQuery("select * from bills where operator='airtelvip' and date='"+bill_date55+"'");
                                    if(rs.next())
                                    { 
                                    do{
                                    a55++;  
                                        if(rs.getString("amount")!=null)
                                            sum55+=Double.parseDouble(rs.getString("amount"));
                                    }while(rs.next());
                                    }
                                    else
                                    {
                                        bill_date55="";
                                        filename="main.jsp";
                                    }
                                }
                
                %>
                    <div class="tabcontent12 center">
                        <form id="myform5" method="post" action="<%=filename%>"> 
                            <br><br>
                            <table class="center" cellspacing="20">
                                <tr>
                                    <td>BILL MONTH</td>
                                    <td>
                                    <%
                                        if(!bill_date55.equals("")){
                                        %>
                                        <div class="input-group date">
                                            <input style="width:90%;" type="text" onkeydown="return false" value="<%=bill_date55%>" onchange="checkdate1(this)" name="bill_date" readonly>
                                            <span class="input-group-append"></span>
                                        </div>
                                        <% 
                                        }
                                        else{
                                        %>
                                        <div class="input-group date datepicker">
                                            <input style="width:90%;" type="text" onkeydown="return false" value="<%=bill_date55%>" onchange="checkdate1(this)" name="bill_date" required>
                                            <span class="input-group-append"></span>
                                        </div>
                                        <%
                                        }
                                        %>
                                        
                                    </td>
                                </tr>
                                <tr>	
                                    <td>Total</td>
                                    <td><%=sum55%></td>
                                </tr>
                                <%  
                                if(bill_date55.equals(""))
                                {
                                %>
                                <tr>
                                    <td colspan="2" class="greenbutton1 center"><input type="submit" value="GET DETAILS" name="submit1"></td>
                                </tr>
                                <%
                                }
                                else
                                {
                                %>
                                <tr>
                                    <%if(convert(bill_date55,request)){%>
                                    <td class="greenbutton center"><input type="submit" value="UPDATE" name="submit1"></td>
                                    <%}%>
                                    <td class="redbutton cventer"><input type="submit" value="BACK" name="submit1"></td>
                                </tr>
                                <%
                                }
                                %>    
                            </table>
                            <%
                                rs=stm.executeQuery("select * from modifier where operator='airtelvip' and date='"+bill_date55+"'");
                                if(rs.next())
                                {
                                %>
                                <table class="center" cellspacing="25">
                                    <tr>
                                        <td>Last Modified By : </td>
                                        <td><%=rs.getString("emp")%></td>
                                    </tr>
                                </table>    
                                <%
                                }
                            %>
                            <input type="hidden" value="airtelvip" name="bill_operator"/>
                            <input type="hidden" value="airtelvip" name="menubar"/>
                            <input type="hidden" value="old" name="button"/>
                            <input type="hidden" value="<%=a55%>" name="count"/>
                        </form>  
                    </div>
                    <div class="tabcontent11 center" >
                        <div class="tablescroll center" style="overflow-x:auto;">
                        <table id="example55" class="display" style="width:100%;" cellspacing="20">
                            <thead>
                                <tr>
                                    <td>S<font color="white">_</font>No</td>
                                    <td>Name</td>
                                    <td>Staff<font color="white">_</font>ID</td>
                                    <td>Designation</td>
                                    <td>Phone Number</td>
                                    <td>Amount</td>
                                    <td>Receipt</td>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                a55=0;
                                if(!bill_date55.equals(""))
                                {
                                rs=stm.executeQuery("select * from bills where operator='airtelvip' and date='"+bill_date55+"'");
                                    if(rs.next())
                                    { 
                                    do{
                                    %>
                                    <tr>
                                        <td><%=a55+1%></td>
                                        <td><%=rs.getString("name")%></td>
                                        <td><%=rs.getString("emp")%></td>
                                        <td><%=rs.getString("desi")%></td>
                                        <td><%=rs.getString("phone")%></td>
                                        <%if(convert(bill_date55,request)){%>
                                        <td><input form="myform5" type="text" value="<%=rs.getString("amount")%>" name="<%=name[a55]%>" onchange="checknumber(this)" style="width:100px;" required></td>
                                        <%}else{%>
                                        <td><input form="myform5" type="text" value="<%=rs.getString("amount")%>" name="<%=name[a55]%>" style="width:100px;" readonly></td>
                                        <%}%>
                                        <%
                                        rs1 = stm1.executeQuery("select * from receipt where operator='airtelvip' and date='"+bill_date55+"' and phone='"+rs.getString("phone")+"'");
                                        if(rs1.next())
                                        {
                                        %>
                                        <td>
                                            <button class="gb" ><a style="text-decoration:none;color:inherit;" target="_blank" href="<%=rs1.getString("filepath")%>">Download</a></button>
                                            <i class="fa fa-file-text" title="<%=rs1.getString("filename")%>"></i>
                                            <%
                                            if(checkAdmin(admin,username) && convert(bill_date55,request)) 
                                            {
                                            %>
                                            <button class="rb" ><a style="text-decoration:none;color:inherit;" target="_self" href="deletereceipt.jsp?operator=airtelvip&bill_month=<%=bill_date55%>&phone=<%=rs.getString("phone")%>&button=old">Delete</a></button>
                                            <%
                                            }
                                            %>
                                        </td>
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <td>
                                            <form action="FileUploadServlet" method="post" enctype="multipart/form-data">
                                                <input type="file" name="file">
                                                <input class="bluebutton submitstyle" type="submit" value="Submit" name="submit_receipt"/>
                                                <input type="hidden" name="mobile2" value="airtelvip"/>
                                                <input type="hidden" value="<%=a55%>" name="count"/>
                                                <input type="hidden" name="bill_month" value="<%=bill_date55%>"/>
                                                <input type="hidden" name="button" value="old"/>
                                                <input type="hidden" name="phone" value="<%=rs.getString("phone")%>"/>
                                            </form>
                                        </td>
                                        <%
                                        }
                                        %>
                                    </tr>
                                    <%
                                        a55++;
                                    }while(rs.next());
                                    }
                                }
                            %>  
                            </tbody>
                        </table>
                        </div>
                    </div>    
                </div>
                </td>
                </tr>
            </table>
        </div>
        <div id="airtellandline" class="tabcontent center">
            <center><p class="title">AIRTEL LANDLINE</p></center>
            <table class="tablecontent display1 center" style="width:100%;">
                <tr>
                <td>    
                <div class="tab2">
                    <table class="center" cellspacing="30">
                        <tr>
                        <%
                            if(request.getParameter("button")!=null && request.getParameter("bill_operator").equals("airtellandline"))
                            {
                            if(request.getParameter("button").equals("new"))
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new6')" id="defaultOpen5">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old6')">OLD BILL</button></td>
                            <%
                            }
                            else if(request.getParameter("button").equals("old"))
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new6')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old6')" id="defaultOpen5">OLD BILL</button></td>
                            <%
                            }
                            else
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new6')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old6')">OLD BILL</button></td>
                            <%
                            }
                            }
                            else
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new6')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old6')">OLD BILL</button></td>
                            <%
                            }
                        %>
                        </tr>
                    </table>
                </div>
                <div id="new6" class="tabcontent2">
                <%
                    int count6 = 0;
                    double sum6 = 0.0;
                    bill_date = "";
                    String[] amt6 = new String[100];
                    if(request.getParameter("count")!=null && request.getParameter("button").equals("new") && request.getParameter("bill_operator").equals("airtellandline"))
                    {
                        count6=Integer.parseInt(request.getParameter("count"));
                        for(int i=0;i<count6;i++)
                            amt6[i]=request.getParameter(name[i]);
                        if(request.getParameter("sum")!=null)
                            sum6=Double.parseDouble(request.getParameter("sum"));
                        if(request.getParameter("bill_date")!=null)
                            bill_date = request.getParameter("bill_date");
                    }
                    else
                        count6=100;
                    for(int i=0;i<count6;i++)
                    {
                        if(amt6[i]==null)
                            amt6[i]="";
                    }
                %>   
                    <form id="form6"  method="post" action="bill_validation.jsp"> 
                        <div class="tabcontent12 center">
                            <br><br>
                            <table class="center" cellspacing="20">
                                <tr>
                                    <td>BILL MONTH</td>
                                    <td>
                                        <div class="input-group date datepicker">
                                            <input style="width:90%;" type="text" onkeydown="return false" value="<%=bill_date%>" onchange="checkdate1(this)" name="bill_date" required>
                                            <span class="input-group-append"></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>	
                                    <td>Total</td>
                                    <td><%=sum6%></td>
                                </tr>
                                <tr>
                                    <td class="greenbutton center"><input type="submit" value="GET" name="submit1"></td>
                                    <%if(request.getParameter("bill_date")!=null){%>
                                    <td class="greenbutton center"><input type="submit" value="STORE" name="submit1"></td>
                                    <%}else{%>
                                    <td><td>
                                    <%}%>
                                </tr>
                            </table>
                        </div>
                        
                    </form>
                    <div class="tabcontent11 center" >
                        <div class="tablescroll center" style="overflow-x:auto;">
                        <table id="example6" class="display" style="width:100%;" cellspacing="20">
                            <thead>    
                                <tr>
                                    <td>S<font color="white">_</font>No</td>
                                    <td>Name</td>
                                    <td>Staff<font color="white">_</font>ID</td>
                                    <td>Designation</td>
                                    <td>Phone Number</td>
                                    <td>Amount</td>
                                    <td>Receipt</td>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                int a6=0;
                                rs=stm.executeQuery("select * from airtellandline");
                                while(rs.next())
                                {                
                                %>
                                    <tr>
                                        <td><%=a6+1%></td>
                                        <td><%=rs.getString("name")%></td>
                                        <td><%=rs.getString("emp")%></td>
                                        <td><%=rs.getString("desi")%></td>
                                        <td><%=rs.getString("phone")%></td>
                                        <td><input form="form6" type="text" value="<%=amt6[a6]%>" name="<%=name[a6]%>" onchange="checknumber(this)" style="width:100px;" required/></td>
                                        <%
                                        rs1 = stm1.executeQuery("select * from receipt where operator='airtellandline' and date='"+bill_date+"' and phone='"+rs.getString("phone")+"'");
                                        if(rs1.next())
                                        {
                                        %>
                                        <td>
                                            <a  class="gb" target="_blank" href="<%=rs1.getString("filepath")%>">Download</a>
                                            <i class="fa fa-file-text" title="<%=rs1.getString("filename")%>"></i>
                                        </td>
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <td>
                                            <form action="FileUploadServlet" method="post" enctype="multipart/form-data">
                                                <%if(!bill_date.isEmpty()){%>
                                                <input type="file" name="file">
                                                <input class="bluebutton submitstyle" type="submit" value="Submit" name="submit_receipt"/>
                                                <%}%>
                                                <input type="hidden" name="mobile2" value="airtellandline"/>
                                                <input type="hidden" name="bill_month" value="<%=bill_date%>"/>
                                                <input type="hidden" name="button" value="new"/>
                                                <input type="hidden" name="phone" value="<%=rs.getString("phone")%>"/>
                                                <input type="hidden" name="count" value="<%=count6%>"/>
                                                <%
                                                for(int i=0;i<count6;i++)
                                                {
                                                %>
                                                <input type="hidden" value="<%=amt6[i]%>" name="<%=name[i]%>"/>
                                                <%
                                                }
                                                %>
                                            </form>
                                        </td>
                                        <%
                                        }
                                        %>
                                    </tr>
                                    <%
                                        a6++;   
                                }
                                %>  
                            </tbody>
                        </table>
                        </div>
                    </div>
                        <input form="form6" type="hidden" value="<%=a6%>" name="count"/>
                        <input form="form6" type="hidden" value="new" name="button"/>
                        <input form="form6" type="hidden" value="airtellandline" name="bill_operator"/>
                </div>
                <div id="old6" class="tabcontent2">
                <%
                    String bill_date66="";
                    filename="main.jsp";
                    double sum66=0;
                    if(request.getParameter("bill_operator")!=null && request.getParameter("bill_date")!=null && request.getParameter("button").equals("old") && request.getParameter("bill_operator").equals("airtellandline"))
                    {
                        bill_date66=request.getParameter("bill_date");
                        filename="bill_validation.jsp";
                    }  
                                int a66=0;
                                if(!bill_date66.equals(""))
                                {
                                    rs=stm.executeQuery("select * from bills where operator='airtellandline' and date='"+bill_date66+"'");
                                    if(rs.next())
                                    { 
                                    do
                                    {    
                                        a66++;  
                                        if(rs.getString("amount")!=null)
                                            sum66+=Double.parseDouble(rs.getString("amount"));
                                    }while(rs.next());
                                    }
                                    else
                                    {
                                        bill_date66="";
                                        filename="main.jsp";
                                    }
                                }
                %>
                    <div class="tabcontent12 center">
                        <form id="myform6" method="post" action="<%=filename%>"> 
                            <br><br>
                            <table class="center" cellspacing="20">
                                <tr>
                                    <td>BILL MONTH</td>
                                    <td>
                                    <%
                                        if(!bill_date66.equals("")){
                                        %>
                                        <div class="input-group date">
                                            <input style="width:90%;" type="text" onkeydown="return false" value="<%=bill_date66%>" onchange="checkdate1(this)" name="bill_date" readonly>
                                            <span class="input-group-append"></span>
                                        </div>
                                        <% 
                                        }
                                        else{
                                        %>
                                        <div class="input-group date datepicker">
                                            <input style="width:90%;" type="text" onkeydown="return false" value="<%=bill_date66%>" onchange="checkdate1(this)" name="bill_date" required>
                                            <span class="input-group-append"></span>
                                        </div>
                                        <%
                                        }
                                        %>
                                        
                                    </td>
                                </tr>
                                <tr>	
                                    <td>Total</td>
                                    <td><%=sum66%></td>
                                </tr>
                                <%  
                                if(bill_date66.equals(""))
                                {
                                %>
                                <tr>
                                    <td colspan="2" class="greenbutton1 center"><input type="submit" value="GET DETAILS" name="submit1"></td>
                                </tr>
                                <%
                                }
                                else
                                {
                                %>
                                <tr>
                                    <%if(convert(bill_date66,request)){%>
                                    <td class="greenbutton center"><input type="submit" value="UPDATE" name="submit1"></td>
                                    <%}%>
                                    <td class="redbutton cventer"><input type="submit" value="BACK" name="submit1"></td>
                                </tr>
                                <%
                                }
                                %>    
                            </table>
                            <%
                                rs=stm.executeQuery("select * from modifier where operator='airtellandline' and date='"+bill_date66+"'");
                                if(rs.next())
                                {
                                %>
                                <table class="center" cellspacing="25">
                                    <tr>
                                        <td>Last Modified By : </td>
                                        <td><%=rs.getString("emp")%></td>
                                    </tr>
                                </table>    
                                <%
                                }
                            %>
                            <input type="hidden" value="airtellandline" name="bill_operator"/>
                            <input type="hidden" value="airtellandline" name="menubar"/>
                            <input type="hidden" value="old" name="button"/>
                            <input type="hidden" value="<%=a66%>" name="count"/>
                        </form>  
                    </div>
                        <div class="tabcontent11 center" >
                        <div class="tablescroll center" style="overflow-x:auto;">
                        <table id="example66" class="display" style="width:100%;" cellspacing="20">
                            <thead>
                                <tr>
                                    <td>S<font color="white">_</font>No</td>
                                    <td>Name</td>
                                    <td>Staff<font color="white">_</font>ID</td>
                                    <td>Designation</td>
                                    <td>Phone Number</td>
                                    <td>Amount</td>
                                    <td>Receipt</td>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                a66=0;
                                if(!bill_date66.equals(""))
                                {
                                    rs=stm.executeQuery("select * from bills where operator='airtellandline' and date='"+bill_date66+"'");
                                    if(rs.next())
                                    { 
                                    do
                                    {
                                    %>
                                    <tr>
                                        <td><%=a66+1%></td>
                                        <td><%=rs.getString("name")%></td>
                                        <td><%=rs.getString("emp")%></td>
                                        <td><%=rs.getString("desi")%></td>
                                        <td><%=rs.getString("phone")%></td>
                                        <%if(convert(bill_date66,request)){%>
                                        <td><input form="myform6" type="text" value="<%=rs.getString("amount")%>" name="<%=name[a66]%>" onchange="checknumber(this)" style="width:100px;" required></td>
                                        <%}else{%>
                                        <td><input form="myform6" type="text" value="<%=rs.getString("amount")%>" name="<%=name[a66]%>" style="width:100px;" readonly></td>
                                        <%}%>
                                        <%
                                        rs1 = stm1.executeQuery("select * from receipt where operator='airtellandline' and date='"+bill_date66+"' and phone='"+rs.getString("phone")+"'");
                                        if(rs1.next())
                                        {
                                        %>
                                        <td>
                                            <button class="gb" ><a style="text-decoration:none;color:inherit;" target="_blank" href="<%=rs1.getString("filepath")%>">Download</a></button>
                                            <i class="fa fa-file-text" title="<%=rs1.getString("filename")%>"></i>
                                            <%
                                            if(checkAdmin(admin,username) && convert(bill_date66,request)) 
                                            {
                                            %>
                                            <button class="rb" ><a style="text-decoration:none;color:inherit;" target="_self" href="deletereceipt.jsp?operator=airtellandline&bill_month=<%=bill_date66%>&phone=<%=rs.getString("phone")%>&button=old">Delete</a></button>
                                            <%
                                            }
                                            %>
                                        </td>
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <td>
                                            <form action="FileUploadServlet" method="post" enctype="multipart/form-data">
                                                <input type="file" name="file"><input class="bluebutton submitstyle" type="submit" value="Submit" name="submit_receipt"/>
                                                <input type="hidden" name="mobile2" value="airtellandline"/>
                                                <input type="hidden" name="bill_month" value="<%=bill_date66%>"/>
                                                <input type="hidden" name="button" value="old"/>
                                                <input type="hidden" value="<%=a66%>" name="count"/>
                                                <input type="hidden" name="phone" value="<%=rs.getString("phone")%>"/>
                                            </form>
                                        </td>
                                        <%
                                        }
                                        %>
                                    </tr>
                                    <%
                                        a66++;  
                                    }while(rs.next());
                                    }
                                }
                            %>  
                            </tbody>
                        </table>
                            </div>
                    </div>
                </div>
                </td>
                </tr>
            </table>
        </div>             
        <div id="bsnllandline" class="tabcontent center">
            <center><p class="title">BSNL LANDLINE</p></center>
            <table class="tablecontent display1 center" style="width:100%;">
                <tr>
                <td>
                <div class="tab2">
                    <table class="center" cellspacing="30">
                        <tr>
                        <%
                            if(request.getParameter("button")!=null && request.getParameter("bill_operator").equals("bsnllandline"))
                            {
                            if(request.getParameter("button").equals("new"))
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new7')" id="defaultOpen5">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old7')">OLD BILL</button></td>
                            <%
                            }
                            else if(request.getParameter("button").equals("old"))
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new7')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old7')" id="defaultOpen5">OLD BILL</button></td>
                            <%
                            }
                            else
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new7')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old7')">OLD BILL</button></td>
                            <%
                            }
                            }
                            else
                            {
                            %>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'new7')">NEW BILL</button></td>
                            <td><button class="tablinks2 bluebutton buttonstyle" onclick="openMode2(event, 'old7')">OLD BILL</button></td>
                            <%
                            }
                        %>
                        </tr>
                    </table>
                </div>
                <div id="new7" class="tabcontent2">
                <%
                    int count7 = 0;
                    double sum7 = 0.0;
                    bill_date = "";
                    String[] amt7 = new String[100];
                    if(request.getParameter("count")!=null && request.getParameter("button").equals("new") && request.getParameter("bill_operator").equals("bsnllandline"))
                    {
                        count7=Integer.parseInt(request.getParameter("count"));
                        for(int i=0;i<count7;i++)
                            amt7[i]=request.getParameter(name[i]);
                        if(request.getParameter("sum")!=null)
                            sum7=Double.parseDouble(request.getParameter("sum"));
                        if(request.getParameter("bill_date")!=null)
                            bill_date = request.getParameter("bill_date");
                    }
                    else
                        count7=100;
                    for(int i=0;i<count7;i++)
                    {
                        if(amt7[i]==null)
                            amt7[i]="";
                    }
                %>   
                    <form id="form7"  method="post" action="bill_validation.jsp"> 
                        <div class="tabcontent12 center">
                            <br><br>
                            <table class="center" cellspacing="20">
                                <tr>
                                    <td>BILL MONTH</td>
                                    <td>
                                        <div class="input-group date datepicker">
                                            <input style="width:90%;" type="text" onkeydown="return false" value="<%=bill_date%>" onchange="checkdate1(this)" name="bill_date" required>
                                            <span class="input-group-append"></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>	
                                    <td>Total</td>
                                    <td><%=sum7%></td>
                                </tr>
                                <tr>
                                    <td class="greenbutton center"><input type="submit" value="GET" name="submit1"></td>
                                    <%if(request.getParameter("bill_date")!=null){%>
                                    <td class="greenbutton center"><input type="submit" value="STORE" name="submit1"></td>
                                    <%}else{%>
                                    <td><td>
                                    <%}%>
                                </tr>
                            </table>
                        </div>
                        
                    </form>
                    <div class="tabcontent11 center" >
                        <div class="tablescroll center" style="overflow-x:auto;">
                        <table id="example7" class="display" style="width:100%;" cellspacing="20">
                            <thead>    
                                <tr>
                                    <td>S<font color="white">_</font>No</td>
                                    <td>Name</td>
                                    <td>Staff<font color="white">_</font>ID</td>
                                    <td>Designation</td>
                                    <td>Phone Number</td>
                                    <td>Amount</td>
                                    <td>Receipt</td>

                                </tr>
                            </thead>
                            <tbody>
                            <%
                                int a7=0;
                                rs=stm.executeQuery("select * from bsnllandline");
                                while(rs.next())
                                {                
                                %>
                                    <tr>
                                        <td><%=a7+1%></td>
                                        <td><%=rs.getString("name")%></td>
                                        <td><%=rs.getString("emp")%></td>
                                        <td><%=rs.getString("desi")%></td>
                                        <td><%=rs.getString("phone")%></td>
                                        <td><input form="form7" type="text" value="<%=amt7[a7]%>" name="<%=name[a7]%>" onchange="checknumber(this)" style="width:100px;" required/></td>
                                        <%
                                        rs1 = stm1.executeQuery("select * from receipt where operator='bsnllandline' and date='"+bill_date+"' and phone='"+rs.getString("phone")+"'");
                                        if(rs1.next())
                                        {
                                        %>
                                        <td>
                                            <a class="gb" target="_blank" href="<%=rs1.getString("filepath")%>">Download</a>
                                            <i class="fa fa-file-text" title="<%=rs1.getString("filename")%>"></i>
                                        </td>
                                        <%
                                        }
                                        else
                                        {
                                        %>
                                        <td>
                                            <form action="FileUploadServlet" method="post" enctype="multipart/form-data">
                                                <%if(!bill_date.isEmpty()){%>
                                                <input type="file" name="file">
                                                <input class="bluebutton submitstyle" type="submit" value="Submit" name="submit_receipt"/>
                                                <%}%>
                                                <input type="hidden" name="mobile2" value="bsnllandline"/>
                                                <input type="hidden" name="bill_month" value="<%=bill_date%>"/>
                                                <input type="hidden" name="button" value="new"/>
                                                <input type="hidden" name="phone" value="<%=rs.getString("phone")%>"/>
                                                <input type="hidden" name="count" value="<%=count7%>"/>
                                                <%
                                                for(int i=0;i<count7;i++)
                                                {
                                                %>
                                                <input type="hidden" value="<%=amt7[i]%>" name="<%=name[i]%>"/>
                                                <%
                                                }
                                                %>
                                            </form>
                                        </td>
                                        <%
                                        }
                                        %>
                                    </tr>
                                    <%
                                        a7++;   
                                }
                                %>  
                            </tbody>
                        </table>
                        </div>
                    </div>
                        <input form="form7" type="hidden" value="<%=a7%>" name="count"/>
                        <input form="form7" type="hidden" value="new" name="button"/>
                        <input form="form7" type="hidden" value="bsnllandline" name="bill_operator"/>
                </div>
                <div id="old7" class="tabcontent2">
                <%
                    String bill_date77="";
                    filename="main.jsp";
                    double sum77=0;
                    if(request.getParameter("bill_operator")!=null && request.getParameter("bill_date")!=null && request.getParameter("button").equals("old") && request.getParameter("bill_operator").equals("bsnllandline"))
                    {
                        bill_date77=request.getParameter("bill_date");
                        filename="bill_validation.jsp";
                    }  
                                int a77=0;
                                if(!bill_date77.equals(""))
                                {
                                    rs=stm.executeQuery("select * from bills where operator='bsnllandline' and date='"+bill_date77+"'");
                                    if(rs.next())
                                    {  
                                    do
                                    {
                                        a77++;  
                                        if(rs.getString("amount")!=null)
                                            sum77+=Double.parseDouble(rs.getString("amount"));
                                    }while(rs.next());
                                    }    
                                    else
                                    {
                                        bill_date77="";
                                        filename="main.jsp";
                                    }
                                }
                %>
                    <div class="tabcontent12 center">
                        <form id="myform7" method="post" action="<%=filename%>"> 
                            <br><br>
                            <table class="center" cellspacing="20">
                                <tr>
                                    <td>BILL MONTH</td>                         
                                    <td>
                                        <%
                                        if(!bill_date77.equals("")){
                                        %>
                                        <div class="input-group date">
                                            <input style="width:90%;" type="text" onkeydown="return false" value="<%=bill_date77%>" onchange="checkdate1(this)" name="bill_date" readonly>
                                            <span class="input-group-append"></span>
                                        </div>
                                        <% 
                                        }
                                        else{
                                        %>
                                        <div class="input-group date datepicker">
                                            <input style="width:90%;" type="text" onkeydown="return false" value="<%=bill_date77%>" onchange="checkdate1(this)" name="bill_date" required>
                                            <span class="input-group-append"></span>
                                        </div>
                                        <%
                                        }
                                        %>
                                        
                                    </td>
                                </tr>
                                <tr>	
                                    <td>Total</td>
                                    <td><%=sum77%></td>
                                </tr>
                                <%  
                                if(bill_date77.equals(""))
                                {
                                %>
                                <tr>
                                    <td colspan="2" class="greenbutton1 center"><input type="submit" value="GET DETAILS" name="submit1"></td>
                                </tr>
                                <%
                                }
                                else
                                {
                                %>
                                <tr>
                                    <%if(convert(bill_date77,request)){%>
                                    <td class="greenbutton center"><input type="submit" value="UPDATE" name="submit1"></td>
                                    <%}%>
                                    <td class="redbutton cventer"><input type="submit" value="BACK" name="submit1"></td>
                                </tr>
                                <%
                                }
                                %>    
                            </table>
                            <%
                                rs=stm.executeQuery("select * from modifier where operator='bsnllandline' and date='"+bill_date77+"'");
                                if(rs.next())
                                {
                                %>
                                <table class="center" cellspacing="25">
                                    <tr>
                                        <td>Last Modified By : </td>
                                        <td><%=rs.getString("emp")%></td>
                                    </tr>
                                </table>    
                                <%
                                }
                            %>
                            <input type="hidden" value="bsnllandline" name="bill_operator"/>
                            <input type="hidden" value="bsnllandline" name="menubar"/>
                            <input type="hidden" value="old" name="button"/>
                            <input type="hidden" value="<%=a77%>" name="count"/>
                        </form>  
                    </div>
                    <div class="tabcontent11 center" >
                        <div class="tablescroll center" style="overflow-x:auto;">
                        <table id="example77" class="display" style="width:100%;" cellspacing="20">
                            <thead>
                                <tr>
                                    <td>S<font color="white">_</font>No</td>
                                    <td>Name</td>
                                    <td>Staff<font color="white">_</font>ID</td>
                                    <td>Designation</td>
                                    <td>Phone Number</td>
                                    <td>Amount</td>
                                    <td>Receipt</td>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                                a77=0;
                                if(!bill_date77.equals(""))
                                {
                                    rs=stm.executeQuery("select * from bills where operator='bsnllandline' and date='"+bill_date77+"'");
                                    if(rs.next())
                                    {  
                                    do
                                    {
                                    %>
                                    <tr>
                                        <td><%=a77+1%></td>
                                        <td><%=rs.getString("name")%></td>
                                        <td><%=rs.getString("emp")%></td>
                                        <td><%=rs.getString("desi")%></td>
                                        <td><%=rs.getString("phone")%></td>
                                        <%if(convert(bill_date77,request)){%>
                                        <td><input form="myform7" type="text" value="<%=rs.getString("amount")%>" name="<%=name[a77]%>" onchange="checknumber(this)" style="width:100px;" required></td>
                                        <%}else{%>
                                        <td><input form="myform7" type="text" value="<%=rs.getString("amount")%>" name="<%=name[a77]%>" style="width:100px;" readonly></td>
                                        <%}%>
                                        <%
                                        rs1 = stm1.executeQuery("select * from receipt where operator='bsnllandline' and date='"+bill_date77+"' and phone='"+rs.getString("phone")+"'");
                                        if(rs1.next())
                                        {
                                        %>
                                        <td>
                                            <button class="gb" ><a style="text-decoration:none;color:inherit;" target="_blank" href="<%=rs1.getString("filepath")%>">Download</a></button>
                                            <i class="fa fa-file-text" title="<%=rs1.getString("filename")%>"></i>
                                            <%
                                            if(checkAdmin(admin,username) && convert(bill_date77,request)) 
                                            {
                                            %>
                                            <button class="rb" ><a style="text-decoration:none;color:inherit;" target="_self" href="deletereceipt.jsp?operator=bsnllandline&bill_month=<%=bill_date77%>&phone=<%=rs.getString("phone")%>&button=old">Delete</a></button>
                                            <%
                                            }
                                            %>
                                        </td>
                                        <%
                                        }
                                        else
                                        {  
                                        %>
                                        <td>
                                            <form action="FileUploadServlet" method="post" enctype="multipart/form-data">
                                                <input type="file" name="file"><input class="bluebutton submitstylee" type="submit" value="Submit" name="submit_receipt"/>
                                                <input type="hidden" name="mobile2" value="bsnllandline"/>
                                                <input type="hidden" name="bill_month" value="<%=bill_date77%>"/>
                                                <input type="hidden" name="button" value="old"/>
                                                <input type="hidden" value="<%=a77%>" name="count"/>
                                                <input type="hidden" name="phone" value="<%=rs.getString("phone")%>"/>
                                            </form>
                                        </td>
                                        <%
                                        }
                                    %>
                                    </tr>
                                    <%
                                        a77++;  
                                        if(rs.getString("amount")!=null)
                                            sum77+=Double.parseDouble(rs.getString("amount"));
                                    }while(rs.next());
                                    }
                                }
                            %>  
                            </tbody>
                        </table>
                        </div>
                    </div>
                </div>
                </td>
                </tr>
            </table>
        </div> 
            <div id="add" class="tabcontent">
                <center><p class="title">ADD NUMBER</p></center>
                <form name="myform13" id="myform13" method="post" action="add_validation.jsp">
                </form>
                    <input type="hidden" id="operator1" value="<%=request.getParameter("operator1")%>"/>
                    <table class="tablecontent add center" cellspacing="15">
                        <tr>
                            <td>Mobile Operator</td>
                            <%
                                String name1="";
                                String desi1="";
                                String emp1="";
                                String phone1="";
                                if(request.getParameter("operator1")!=null)
                                {
                                    name1=request.getParameter("name1");
                                    desi1=request.getParameter("desi1");
                                    emp1=request.getParameter("emp1");
                                    phone1=request.getParameter("phone1");
                                }
                                %>
                            <td>
                                <select form="myform13" name="operator1" required>
                                    <option></option>
                                    <option id="airtel1" value="airtel">Airtel 1</option>
                                    <option id="airtel_21" value="airtel_2">Airtel 2</option>
                                    <option id="jio1" value="jio">Jio</option>
                                    <option id="bsnl1" value="bsnl">Bsnl</option>
                                    <option id="vodofone1" value="vodofone">Vodofone</option>
                                    <option id="airtellandline1" value="airtellandline">Airtel Landline</option>
                                    <option id="airtelvip1" value="airtelvip">Airtel Vip</option>
                                    <option id="bsnllandline1" value="bsnllandline">Bsnl Landline</option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td>NAME</td>
                            <td><input form="myform13" type="text" value="<%=name1%>" name="name1" required/></td>
                        </tr>
                        <tr>
                            <td>STAFF ID</td>
                            <td><input form="myform13" type="text" value="<%=emp1%>" name="emp1" pattern="[0-9]{5}" title="It must contain 5 digits only"/></td>
                        </tr>
                        <tr>
                            <td>DESIGNATION</td>
                            <td><input form="myform13" type="text" value="<%=desi1%>" name="desi1" required/></td>
                        </tr>
                        <tr>
                            <td>PHONE NUMBER</td>
                            <td><input form="myform13" type="text" value="<%=phone1%>" name="phone1" pattern="[0-9]{10}" title="Phone Number must contain 10 digits only" required/></td>
                        </tr>
                        <tr>
                            <td class="greenbutton center"><input form="myform13" type="submit" value="ADD"/></td>
                            <td class="redbutton center"><input form="myform13" type="reset" value="CLEAR"/></td>
                        </tr>                        
                    </table>
                </form>
            </div>
            <div id="modify" class="tabcontent center">
                <center><p class="title">MODIFY NUMBER</p></center>
                <form method="post" id="myform14" name="myform14" action="modify_validation.jsp">
                </form>
                <input type="hidden" id="operator2" value="<%=request.getParameter("operator2")%>"/>
                    <table class="tablecontent modify center" cellspacing="15">
                        <tr>
                            <td>MOBILE OPERATOR</td>
                            <%
                                String ph2 = "";
                                if(request.getParameter("phone2")!=null) ph2=request.getParameter("phone2");
                                if(request.getParameter("butt")!=null && request.getParameter("butt").equals("GET"))
                                {
                                %>
                                <td>
                                    <input form="myform14" type="text" value="<%=request.getParameter("operator2")%>" name="operator2" readonly/>
                                </td>
                                <%
                                }
                                else{
                                %>    
                                <td>
                                    <select form="myform14" name="operator2" required>
                                        <option></option>
                                        <option id="airtel2" value="airtel">Airtel 1</option>
                                        <option id="airtel_22" value="airtel_2">Airtel 2</option>
                                        <option id="jio2" value="jio">Jio</option>
                                        <option id="bsnl2" value="bsnl">Bsnl</option>
                                        <option id="vodofone2" value="vodofone">Vodofone</option>
                                        <option id="airtellandline2" value="airtellandline">Airtel Landline</option>
                                        <option id="airtelvip2" value="airtelvip">Airtel Vip</option>
                                        <option id="bsnllandline2" value="bsnllandline">Bsnl Landline</option>
                                    </select>
                                </td>
                                <%}%>
                            </tr>
                            <%
                            if(request.getParameter("butt")!=null && request.getParameter("butt").equals("GET"))
                            {
                            %>    
                            <tr>
                                <td>PHONE NUMBER</td>
                                <td><input form="myform14" type="text" value="<%=request.getParameter("phone2")%>" name="phone2" readonly/></td>
                            </tr>
                            <tr>
                                <td>NAME</td>
                                <td><input form="myform14" type="text" name="name2" value="<%=request.getParameter("name2")%>" required/></td>
                            </tr>
                            <tr>
                                <td>STAFF ID</td>
                                <td><input form="myform14" type="text" name="emp2" value="<%=request.getParameter("emp2")%>" pattern="[0-9]{5}||{0}" title="It must contain 5 digits only"/></td>
                            </tr>
                            <tr>
                                <td>DESIGNATION</td>
                                <td><input form="myform14" type="text" name="desi2" value="<%=request.getParameter("desi2")%>" required/></td>
                            </tr>    
                            <tr>
                                <td class="greenbutton center"><input form="myform14" type="submit" value="SAVE" name="button"/></td>
                                <td class="redbutton center"><input form="myform14" type="submit" value="BACK" name="button"/></td>
                            </tr>
                            <%
                            }
                            else
                            {
                            %>
                            <tr>
                                <td>PHONE NUMBER</td>
                                <td><input form="myform14" type="text" value="<%=ph2%>" name="phone2" pattern="[0-9]{10}" title="Phone Number must contain 10 digits only" required/></td>
                            </tr>
                            <tr>
                                <td>NAME</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>STAFF ID</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>DESIGNATION</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td class="greenbutton center"><input form="myform14" type="submit" value="GET" name="button"/></td>
                                <td class="redbutton center"><input form="myform14" type="reset" value="CLEAR"/></td>
                            </tr>
                            <%
                            }
                        %>
                    </table>
                </form>
            </div>
            <div id="delete" class="tabcontent center">
                <center><p class="title">DELETE NUMBER</p></center>
                <form id="myform15" name="myform15" method="post" action="delete_validation.jsp">
                </form>
                <input type="hidden" id="operator3" value="<%=request.getParameter("operator3")%>"/>
                    <table class="tablecontent delete center" cellspacing="20">
                        <tr>
                            <td>MOBILE OPERATOR</td>
                            <%
                                String ph3 = "";
                                if(request.getParameter("phone3")!=null) ph3=request.getParameter("phone3");
                                if(request.getParameter("delete")!=null && request.getParameter("delete").equals("DELETE"))
                                {
                                %>
                                <td><input form="myform15" type="text" name="operator3" value="<%=request.getParameter("operator3")%>" readonly/></td>
                                <%
                                }
                                else
                                {
                                %>    
                                <td>
                                    <select form="myform15" name="operator3" required>
                                        <option></option>
                                        <option id="airtel3" value="airtel">Airtel 1</option>
                                        <option id="airtel_23" value="airtel_2">Airtel 2</option>
                                        <option id="jio3" value="jio">Jio</option>
                                        <option id="bsnl3" value="bsnl">Bsnl</option>
                                        <option id="vodofone3" value="vodofone">Vodofone</option>
                                        <option id="airtellandline3" value="airtellandline">Airtel Landline</option>
                                        <option id="airtelvip3" value="airtelvip">Airtel Vip</option>
                                        <option id="bsnllandline3" value="bsnllandline">Bsnl Landline</option>
                                    </select>
                                </td>
                                <%
                                }
                            %>
                            </tr>
                            <%
                            if(request.getParameter("delete")!=null && request.getParameter("delete").equals("DELETE"))
                            {
                            %>
                            <tr>
                                <td>PHONE NUMBER</td>
                                <td><input form="myform15" type="text" value="<%=request.getParameter("phone3")%>" name="phone3" readonly/></td>
                            </tr>
                            <tr>
                                <td>NAME</td>
                                <td><%=request.getParameter("name3")%></td>
                            </tr>
                            <tr>
                                <td>STAFF ID</td>
                                <td><%=request.getParameter("emp3")%></td>
                            </tr>
                            <tr>
                                <td>DESIGNATION</td>
                                <td><%=request.getParameter("desi3")%></td>
                            </tr>
                            <tr>
                                <td class="greenbutton center"><input form="myform15" type="submit" value="CONFIRM" name="delete"/></td>
                                <td class="redbutton center"><input form="myform15" type="submit" value="BACK" name="delete"/></td>
                            </tr>
                            <%
                            }
                            else
                            {
                            %>
                            <tr>
                                <td>PHONE NUMBER</td>
                                <td colspan="2"><input form="myform15" value="<%=ph3%>" type="text" name="phone3" pattern="[0-9]{10}" title="Phone Number must contain 10 digits only" /></td>
                            </tr>
                            <tr>
                                <td>NAME</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>STAFF ID</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td>DESIGNATION</td>
                                <td></td>
                            </tr>
                            <tr>
                                <td class="greenbutton center"><input form="myform15" type="submit" value="DELETE" name="delete"/></td>
                                <td class="redbutton center"><input form="myform15" type="reset" value="CLEAR"/></td>
                            </tr>
                            <%
                            }
                        %>
                    </table>
                </form>
            </div>
                    
                    
                    
            <div id="display" class="tabcontent center">
            <center><p class="title">REPORT</p></center>
            
            <%
                int count8 = 0 ; 
                if(request.getParameter("count8")==null || Integer.parseInt(request.getParameter("count8"))==0 || Integer.parseInt(request.getParameter("count8"))==1)
                {
                %><input type="hidden" id="displayTab" value="singlemonth" /><%
                }
                else
                {
                    count8 = Integer.parseInt(request.getParameter("count8"));
                    %><input type="hidden" id="displayTab" value="multiplemonth" /><%
                }
                String dbmonth1="";
                String dbmonth2="";
                if(request.getParameter("dbmonth1")!=null)
                    dbmonth1=request.getParameter("dbmonth1");
                if(request.getParameter("dbmonth2")!=null)
                    dbmonth2=request.getParameter("dbmonth2");
            %>
            <form id="myform16" name="myform16" method="post" action="<%=request.getContextPath()%>/download2.jsp" onsubmit="return submitForm()">
                <input type="hidden" id="operator4" value="<%=request.getParameter("mobile1")%>"/>
                <input type="hidden" id="download1" value="<%=request.getContextPath()%>/download1.jsp"/>
                <input type="hidden" id="download2" value="<%=request.getContextPath()%>/download2.jsp"/>
                <input type="hidden" name="mobile5" value="<%=request.getParameter("mobile1")%>"/>
                <input type="hidden" name="dmonth1" value="<%=request.getParameter("dbmonth1")%>"/>
                <input type="hidden" name="dmonth2" value="<%=request.getParameter("dbmonth2")%>"/>
            </form> 
            <table class="tablecontent display1 center" style="width:100%;">
                <tr>
                    <td>
                        <form id="myform17" name="myform17" method="post" action="main.jsp" onsubmit="return submitForm1()">
                            <input type="hidden" id="operator5" value="<%=request.getParameter("mobile1")%>" />
                        </form>
                            <table cellspacing="20" class=" center">
                                <tr>
                                    <td>Mobile operator*</td>
                                            <td>
                                                <select form="myform17" name="mobile1" required>
                                                    <option></option>
                                                    <option value="airtel" id="airtel5">Airtel 1</option>
                                                    <option id="airtel_25" value="airtel_2">Airtel 2</option>
                                                    <option value="jio" id="jio5">Jio</option>
                                                    <option value="bsnl" id="bsnl5">Bsnl</option>
                                                    <option value="vodofone" id="vodofone5">Vodofone</option>
                                                    <option value="airtellandline" id="airtellandline5">Airtel Landline</option>
                                                    <option value="airtelvip" id="airtelvip5">Airtel Vip</option>
                                                    <option value="bsnllandline" id="bsnllandline5">Bsnl Landline</option>
                                                </select>
                                            </td>
                                </tr>
                                <tr>
                                    <td>From
                                        <div class="input-group date datepicker">
                                            <input form="myform17" id="from2" style="width:90%;" type="text" onkeydown="return false" onchange='checkdate("from","from2","to2")' value="<%=dbmonth1%>" name="dbmonth1" required>
                                            <span class="input-group-append"></span>
                                        </div>
                                    </td>
                                    <td>To
                                        <div class="input-group date datepicker">
                                            <input form="myform17" id="to2" style="width:90%;" type="text" onkeydown="return false" onchange='checkdate("to","from2","to2")' value="<%=dbmonth2%>" name="dbmonth2" required>
                                            <span class="input-group-append"></span>
                                        </div>
                                    </td>
                                </tr>
                                <tr>
                                    <td class="greenbutton center"> <input form="myform17" type="submit" value="Search"/>
                                    <% if(dbmonth1!="" && dbmonth2!="") { %>
                                    <td class="greenbutton center"> <input form="myform16" type="submit" value="Download"/>
                                    <% } else { %>
                                    <td></td>
                                    <% } %>
                                </tr> 
                            </table>
                            <input form="myform17" type="hidden" value="display" name="menubar" /> 
                            <input form="myform17" type="hidden" value="<%=count8%>" name="count8"/>
                        </form>    
                    <div id="singlemonth" style="display:none;">
                        <div class="center" style="overflow-x:auto;width:90vw;">
                            
                        <table id="example" class="display" style="width:100%">
                            <thead>
                                <tr>
                                    <th>S<font color="white">_</font>No</th>
                                    <th>Name</th>
                                    <th>Staff<font color="white">_</font>ID</th>
                                    <th>Designation</th>
                                    <th>Phone No</th>
                                    <th>Amount</th>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                            double sum8=0;
                            double sum88=0;
                            double cgst8=0;
                            double sgst8=0;
                            double one8 = 0.0;
                            double fixed8 = 0.0;
                            double misc8 = 0.0;
                            double usage8 = 0.0;
                            double late8 = 0.0;
                            double discount8 = 0.0;
                            double adj8 = 0.0;
                            if(request.getParameter("mobile1")!=null)
                            {
                                String mobile1 = request.getParameter("mobile1");
                                rs = stm.executeQuery("select * from bills where operator='"+mobile1+"' and date = '"+dbmonth1+"'");
                                int a8=0;
                                while(rs.next())
                                {
                                %>
                                
                                <tr>
                                    <td align="center"><%=a8+1%></td>
                                    <td align="left"><%=rs.getString("name")%></td>
                                    <td align="center"><%=rs.getString("emp")%></td>
                                    <td align="left"><%=rs.getString("desi")%></td>
                                    <td align="center"><%=rs.getString("phone")%></td>
                                    <td align="right"><%=rs.getString("amount")%></td>
                                </tr>
                                <%
                                    a8++;
                                    if(request.getParameter("mobile1")!=null && request.getParameter("mobile1").equals("bsnl"))
                                    {
                                        cgst8=Double.parseDouble(rs.getString("cgst"));
                                        sgst8=Double.parseDouble(rs.getString("sgst"));
                                        one8 = Double.parseDouble(rs.getString("one"));
                                        fixed8 = Double.parseDouble(rs.getString("fixed"));
                                        usage8 = Double.parseDouble(rs.getString("usages"));
                                        misc8 = Double.parseDouble(rs.getString("misc"));
                                        late8 = Double.parseDouble(rs.getString("late"));
                                        discount8 = Double.parseDouble(rs.getString("discount"));
                                        adj8 = Double.parseDouble(rs.getString("adj"));
                                    }
                                    else
                                    {
                                        cgst8=Double.parseDouble(rs.getString("cgst"));
                                        sgst8=Double.parseDouble(rs.getString("sgst"));
                                        sum8+=Double.parseDouble(rs.getString("amount"));
                                    }
                                }
                                %>
                                    </tbody>
                                    <tfoot>
                                <%
                                if(request.getParameter("mobile1")!=null && request.getParameter("mobile1").equals("bsnl"))
                                {
                                    sum8+=one8+fixed8+usage8+misc8+late8;
                                    sum88+=sum8-discount8-adj8;
                                    cgst8*=sum88;
                                    sgst8*=sum88;
                                    %>
                                    <tr>
                                    <th colspan="5" align="right">One Time Charge</th>
                                    <td align="right"><%=Math.round(one8*100.0)/100.0%></td>
                                    </tr>
                                    <tr>
                                    <th colspan="5" align="right">Fixed Monthly Charge</th>
                                    <td align="right"><%=Math.round(fixed8*100.0)/100.0%></td>
                                    </tr>
                                    <tr>
                                    <th colspan="5" align="right">Usage Charge</th>
                                    <td align="right"><%=Math.round(usage8*100.0)/100.0%></td>
                                    </tr>
                                    <tr>
                                    <th colspan="5" align="right">Miscellaneous Charge</th>
                                    <td align="right"><%=Math.round(misc8*100.0)/100.0%></td>
                                    </tr>
                                    <tr>
                                    <th colspan="5" align="right">Late Charge</th>
                                    <td align="right"><%=Math.round(late8*100.0)/100.0%></td>
                                    </tr>
                                    <tr>
                                    <th colspan="5" align="right">Sub Total</th>
                                    <td align="right"><%=Math.round(sum8*100.0)/100.0%></td>
                                    </tr>
                                    <tr>
                                    <th colspan="5" align="right">Discount</th>
                                    <td align="right"><%=Math.round(discount8*100.0)/100.0%></td>
                                    </tr>
                                    <tr>
                                    <th colspan="5" align="right">Adjustments</th>
                                    <td align="right"><%=Math.round(adj8*100.0)/100.0%></td>
                                    </tr>
                                    <tr>
                                    <th colspan="5" align="right">Total Charge</th>
                                    <td align="right"><%=Math.round(sum88*100.0)/100.0%></td>
                                    </tr>
                                    <tr>
                                    <th colspan="5" align="right">CGST</th>
                                    <td align="right"><%=Math.round(cgst8*100.0)/100.0%></td>
                                    </tr>
                                    <tr>
                                    <th colspan="5" align="right">SGST</th>
                                    <td align="right"><%=Math.round(sgst8*100.0)/100.0%></td>
                                    </tr>
                                    <tr>
                                    <th colspan="5" align="right">Grand Total</th>
                                    <td align="right"><%=Math.round((sgst8+cgst8+sum88)*100.0)/100.0%></td>
                                    </tr>
                                    <%
                                }
                                else{
                                    cgst8*=sum8;
                                    sgst8*=sum8;
                                    %>
                                    <tr>
                                    <th colspan="5" align="right">Sub Total</th>
                                    <td align="right"><%=Math.round(sum8*100.0)/100.0%></td>
                                    </tr>
                                    <tr>
                                    <th colspan="5" align="right">CGST</th>
                                    <td align="right"><%=Math.round(cgst8*100.0)/100.0%></td>
                                    </tr>
                                    <tr>
                                    <th colspan="5" align="right">SGST</th>
                                    <td align="right"><%=Math.round(sgst8*100.0)/100.0%></td>
                                    </tr>
                                    <tr>
                                    <th colspan="5" align="right">Grand Total</th>
                                    <td align="right"><%=Math.round((sgst8+cgst8+sum8)*100.0)/100.0%></td>
                                    </tr>
                                    <%
                                }
                            }
                            %>   
                            </tfoot>
                        </table>
                    </div>
                    </div>
                        <div id="multiplemonth" style="display:none;">
                            <%
                            if(request.getParameter("mobile1")!=null)
                            {
                            String mobile1 = request.getParameter("mobile1");
                            %>
                            <div class="center" style="overflow-x:auto;width:90vw;">
                            <table id="example8" class="display" style="width:100%">
                            <thead>
                                <tr>
                                    <th>Sno</th>
                                    <th>Name</th>
                                    <th>Staff<font color="white">_</font>ID</th>
                                    <th>Designation</th>
                                    <th>Phone No</th>
                                    <%
                                    for(int i=0;i<count8;i++)
                                    {
                                        %><th><%=dateconvert(convert1(dbmonth1,i))%></th><%
                                    }
                                    %>
                                    <th>Total</th>
                                </tr>
                            </thead>
                            <tbody>
                            <%
                            
                                rs=stm.executeQuery("select * from "+mobile1);  
                                int z=0;
                                while(rs.next())
                                {
                                    z++;
                                    double rowsum = 0;
                                    %>
                                    <tr>
                                        <td><%=z%></td>
                                        <td><%=rs.getString("name")%></td>
                                        <td><%=rs.getString("emp")%></td>
                                        <td><%=rs.getString("desi")%></td>
                                        <td><%=rs.getString("phone")%></td>
                                    <%
                                    
                                        for(int i=0;i<count8;i++)
                                        {
                                            rs1 = stm1.executeQuery("select * from bills where operator='"+mobile1+"' and phone='"+rs.getString("phone")+"' and date='"+convert1(dbmonth1,i)+"'");
                                            if(rs1.next())
                                            {
                                            
                                                %>
                                                <td align="center"><%=rs1.getString("amount")%></td>
                                                <%                    
                                                rowsum+=Double.parseDouble(rs1.getString("amount"));
                                            }  
                                            else{
                                                %>
                                                <td align="center">0</td>
                                                <%  
                                            }
                                        }
                                    
                                    %>
                                        <td><%=rowsum%></td>
                                    </tr>
                                    <%
                                }
                            }
                            %>   
                            </tbody>
                            </table>
                            </div>
                    </div>
                        
                    </td>
                </tr>
            </table>
        </div>
                
            <div id="gst" class="tabcontent">
                <center><P class="title">GST</p></center>
                <form name="myform10" id="myform10" method="post" action="gst_validation.jsp">
                </form>
                <%
                    rs = stm.executeQuery("select * from gst");
                    double cgst2 = 0;
                    double sgst2 = 0;
                    while(rs.next())
                    {
                        if(rs.getString("status").equals("ACTIVE"))
                        {
                            cgst2=Double.parseDouble(rs.getString("cgst"));
                            sgst2=Double.parseDouble(rs.getString("sgst"));
                        }
                    }
                    %>
                    <table cellspacing="20" class="tablecontent gst center">
                        <tr>
                            <td>Current CGST</td>
                            <td><input form="myform10" type="text" value="<%=cgst2%>" name="cgst2" readonly/></td>
                        </tr>
                        <tr>
                            <td>Current SGST</td>
                            <td><input form="myform10" type="text" value="<%=sgst2%>" name="sgst2" readonly/></td>
                        </tr>
                        <tr id="gedit">
                            <td class="greenbutton center"><input type="button" onclick="edittab(true,'myform10','gst')" value="EDIT" name="setting"/></td>
                            <td></td>
                        </tr>
                        <tr id="gback" style="display:none;">
                            <td class="redbutton"><input type="button" value="BACK" name="setting" onclick="edittab(false,'myform10','gst')"/></td>
                            <td class="greenbutton center">
                                <input form="myform10" style="width:50%;" type="submit" value="SAVE" name="setting"/>
                            </td>
                        </tr>
                    </table>
                </form>
            </div>
            <div id="signup" class="tabcontent">
                <center><p class="title">ADD USER</p></center>
                <form name="myform12" id="myform12" method="post" action="signup_validation.jsp">
                </form>
                    <table cellspacing="20" class="tablecontent signup center">
                    <%
                        String name5="";
                        String emp5="";
                        String desi5="";
                        String email5="";
                        if(request.getParameter("name5")!=null)
                        {
                        name5=request.getParameter("name5");
                        email5=request.getParameter("email5");
                        desi5=request.getParameter("desi5");
                        emp5=request.getParameter("emp5");
                        }
                    %>
                        <tr>
                            <td>Name</td>
                            <td><input form="myform12" type="text" value="<%=name5%>" name="name5" required/></td>
                        </tr>
                        <tr>
                            <td>Staff ID</td>
                            <td><input form="myform12" type="text" value="<%=emp5%>" name="emp5" pattern="[0-9]{5}" title="It must contain 5 digits only" required/>  </td>
                        </tr>
                        <tr>
                            <td>Designation</td>
                            <td><input form="myform12" type="text" value="<%=desi5%>" name="desi5" required/>  </td>
                        </tr>
                        <tr>
                            <td>Email ID</td>
                            <td><input form="myform12" type="email" value="<%=email5%>" name="email5" required/>  </td>
                        </tr>
                        <tr>
                            <td>Password</td>
                            <td><input form="myform12" type="password" name="pass5" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}" required/>  </td>
                        </tr>
                        <tr>
                            <td>Confirm Password</td>
                            <td><input form="myform12" type="password" name="cpass5" required/>  </td>
                        </tr>
                        <tr>
                            <td class="greenbutton center"><input form="myform12" type="submit" value="SAVE"/></td>
                            <td class="redbutton center"><input form="myform12" type="reset" value="CLEAR"/></td>
                        </tr>
                    </table>
            </div>
            <div id="freeze" class="tabcontent">
                <center><p class="title">FREEZE DATE</p></center>
                <form name="myform11" id="myform11" method="post" action="freeze.jsp">
                </form>
                    <%
                    int fdate = 0;
                    rs = stm.executeQuery("select * from freeze");
                    while(rs.next())
                        fdate = Integer.parseInt(rs.getString(1));
                    %>
                    <table cellspacing="20" class="tablecontent center">
                        <tr>
                            <td>Freezing Date<br>(for every month)</td>
                            <td style="width:50%;">
                                <select form="myform11" style="width:100%;" name="fdate" required readonly>
                                    <%
                                        for(int i=1;i<29;i++)
                                        {
                                            if(fdate==i){
                                            %>
                                            <option value="<%=i%>" selected><%=i%></option>
                                            <%}else{
                                            %><option value="<%=i%>"><%=i%></option><%
                                            }
                                        }
                                    %>
                                </select> 
                            </td>
                        </tr>
                        <tr id="fedit">
                            <td colspan="2" class="greenbutton">
                                <input onclick="editselect(true,'myform11')" style="width:50%;" type="submit" value="Change" name="fsubmit"/>
                            </td>
                        </tr>
                        <tr id="fback">
                            <td form="myform11" class="greenbutton"><input form="myform11" type="submit" value="Save" name="fsubmit"/></td>
                            <td class="redbutton"><input type="button" onclick="editselect(false,'myform11')" value="Back" name="fsubmit"/></td>
                        </tr>
                    </table>
            </div>
        <%
        %>
        <script>
            document.getElementById(document.getElementById('displayTab').value).style.display="block";
            editselect(false,'myform11');
            document.getElementById('default0').click();
            var c_menubar = ["home","airtel","airtel_2","jio","bsnl","vodofone","airtelvip","airtellandline","bsnllandline","add","modify","delete","display","download","gst","signup","freeze","profile"];
            var e_menubar = document.getElementById('menubar').value;
            for(let i=0;i<c_menubar.length;i++)
            {
                if(e_menubar===c_menubar[i])
                {
                    document.getElementById('default'+i).click();
                    if(e_menubar==="add")
                    {
                        let operator = document.getElementById('operator1').value;
                        for(let j=1;j<=8;j++)
                        {
                            if(operator===c_menubar[j])
                            {
                                document.getElementById(c_menubar[j]+'1').setAttribute("selected","");
                            }
                        }
                    }
                    if(e_menubar==="modify")
                    {
                        let operator= document.getElementById('operator2').value;
                        for(let j=1;j<=8;j++)
                        {
                            if(operator===c_menubar[j])
                            {
                                document.getElementById(c_menubar[j]+'2').setAttribute("selected","");
                            }
                        }
                    }
                    if(e_menubar==="delete")
                    {
                        let operator= document.getElementById('operator3').value;
                        for(let j=1;j<=8;j++)
                        {
                            if(operator===c_menubar[j])
                            {
                                document.getElementById(c_menubar[j]+'3').setAttribute("selected","");
                            }
                        }
                    }
                    if(e_menubar==="display")
                    {
                        let operator= document.getElementById('operator5').value;
                        for(let j=1;j<=8;j++)
                        {
                            if(operator===c_menubar[j])
                            {
                                document.getElementById(c_menubar[j]+'5').setAttribute("selected","");
                            }
                        }
                    }
                }
            }
            if(document.getElementById('status').value==="done"){
                switchtab('content2','content1');
            }
            else{
                switchtab('content1','content2');
            }
            function submitForm1()
            {
                var from = new Date(document.getElementById("from2").value);
                var to = new Date(document.getElementById("to2").value);
                var month = (to.getFullYear() - from.getFullYear())*12 + to.getMonth() - from.getMonth() + 1;
                document.myform17.count8.value=month;
                return true;
            }
            function submitForm()
            {
                if(document.myform16.dmonth1.value===document.myform16.dmonth2.value){
                    document.myform16.action=document.getElementById('download1').value;
                }
                else{
                    document.myform16.action=document.getElementById('download2').value;
                }
                return true;
            }
            function checkdate1(bill_date)
            {
                var curr = new Date();
                var date = new Date(bill_date.value);
                if(curr.getTime()-date.getTime()<0)
                {
                    bill_date.value="";
                    alert("Invalid date");
                }
            }
            function checkdate(check,date1,date2)
            {
                var curr = new Date();
                var from = new Date(document.getElementById(date1).value);
                var to = new Date(document.getElementById(date2).value);

                if(check==="from" && curr.getTime()-from.getTime()<0)
                {
                    document.getElementById(date1).value="";
                    alert("Incorrect From Date");
                }
                if(check==="to" && curr.getTime()-to.getTime()<0)
                {
                    document.getElementById(date2).value="";
                    alert("Incorrect To Date");
                }
                if(document.getElementById(date1).value.length>0 && document.getElementById(date2).value.length>0){
                    if(from.getTime()-to.getTime()>0)
                    {
                        if(check==="to") document.getElementById(date2).value="";
                        if(check==="from") document.getElementById(date1).value="";
                        alert("Invalid Date");
                    }
                }
            }
            function edittab(status,form,type){
                var element = document.querySelectorAll("input[form='"+form+"'][type='text']");
                if(status)
                {
                    for(let i=0;i<element.length;i++)
                    {
                        element[i].removeAttribute("readonly");
                    }
                    if(type==="profile")
                    {tswitchtab('pedit','pback');}
                    else if(type==="freeze")
                    {tswitchtab('fedit','fback');}
                    else
                    {tswitchtab('gedit','gback');}
                }
                else{
                    for(let i=0;i<element.length;i++)
                    {
                        element[i].setAttribute("readonly", "");
                    }
                    if(type==="profile")
                    {tswitchtab('pback','pedit');}
                    else if(type==="freeze")
                    {tswitchtab('fback','fedit');}
                    else
                    {
                        tswitchtab('gback','gedit');
                    }
                }
            }
            function editselect(status,form){
                var element = document.querySelectorAll("select[form='"+form+"']");
                if(status)
                {
                    for(let i=0;i<element.length;i++)
                    {
                        element[i].removeAttribute("disabled");
                    }
                    tswitchtab('fedit','fback');
                }
                else{
                    for(let i=0;i<element.length;i++)
                    {
                        element[i].setAttribute("disabled", "true");
                    }
                    tswitchtab('fback','fedit');
                }
            }
            function tswitchtab(id1,id2)
            {
                document.getElementById(id1).style.display="none";
                document.getElementById(id2).style.display="table-row";
            }
            function switchtab(id1,id2)
            {
                document.getElementById(id1).style.display="none";
                document.getElementById(id2).style.display="block";
            }
            function checknumber(va)
            {
                if(isNaN(va.value))
                {
                    alert("Amount should be in numbers only");
                    va.focus();
                    va.value="";
                }
            }
            function dropdown_list() {
                document.getElementById("myDropdown").classList.toggle("show");
            }
            window.onclick = function(event) {
                if (!event.target.matches('.dropbtn')) {
                    var dropdowns = document.getElementsByClassName("dropdown-content");
                    var i;
                    for (i = 0; i < dropdowns.length; i++) {
                        var openDropdown = dropdowns[i];
                        if (openDropdown.classList.contains('show')) {
                            openDropdown.classList.remove('show');
                        }
                    }
                }
            };
            if(document.getElementById("defaultOpen5"))
                document.getElementById("defaultOpen5").click();
            if(document.getElementById("defaultOpen6"))
                document.getElementById("defaultOpen6").click();
            if(document.getElementById("defaultOpen1"))
                document.getElementById("defaultOpen1").click();
            if(document.getElementById("defaultOpen2"))
                document.getElementById("defaultOpen2").click();
            if(document.getElementById("defaultOpen3"))
                document.getElementById("defaultOpen3").click();
            if(document.getElementById("defaultOpen4"))
                document.getElementById("defaultOpen4").click();
            function openMode1(evt,operator) 
            {
                var i, tabcontent, tablinks;
                tabcontent = document.getElementsByClassName("tabcontent1");
                for (i = 0; i < tabcontent.length; i++) {
                    tabcontent[i].style.display = "none";
                }
                tablinks = document.getElementsByClassName("tablinks1");
                for (i = 0; i < tablinks.length; i++) {
                    tablinks[i].className = tablinks[i].className.replace("active", "");
                }
                document.getElementById(operator).style.display = "block";
                evt.currentTarget.className += " active";
            }
            function openMode(evt, operator) 
            {
                var i, tabcontent, tablinks;
                tabcontent = document.getElementsByClassName("tabcontent");
                for (i = 0; i < tabcontent.length; i++) {
                    tabcontent[i].style.display = "none";
                }
                tablinks = document.getElementsByClassName("tablinks");
                for (i = 0; i < tablinks.length; i++) {
                    tablinks[i].className = tablinks[i].className.replace("active", "");
                }
                document.getElementById(operator).style.display = "block";
                evt.currentTarget.className += " active";
            }
            function openMode2(evt, operator) 
            {
                var i, tabcontent, tablinks;
                tabcontent = document.getElementsByClassName("tabcontent2");
                for (i = 0; i < tabcontent.length; i++) {
                    tabcontent[i].style.display = "none";
                }
                tablinks = document.getElementsByClassName("tablinks2");
                for (i = 0; i < tablinks.length; i++) {
                    tablinks[i].className = tablinks[i].className.replace(" active", "");
                }
                document.getElementById(operator).style.display = "block";
                evt.currentTarget.className += " active";
            }
        </script>
        <script>
            $(function() {
                $('.datepicker').datepicker(
                {
                    startView: 1,
                    minViewMode: 1,
                    format: 'yyyy-mm',
                    clearBtn: true,
                    autoclose:true
                });
            });
            $(document).ready(function () {
                $('.display').DataTable({"bPaginate": false,"paging": false});
                
            });
        </script>
    </body>
</html>