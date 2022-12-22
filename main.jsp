<%@page import="java.util.Calendar"%>
<%@page import="java.sql.*"%>
<%@page import="java.io.File"%>
<%@page import="java.time.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="VITLogoEmblem.png">
        <link rel="stylesheet" href="bootstrap.min.css">
        <link href="jquery.dataTables.min.css" rel="stylesheet" />
        <link rel="stylesheet" href="bootstrap-datepicker.min.css">
        <link href="https://code.jquery.com/ui/1.11.4/themes/smoothness/jquery-ui.css" rel="stylesheet" type="text/css" />
        <script src="jquery.dataTables.min.js"></script>
        <script src="bootstrap-datepicker.min.js"></script>
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>
        <title>E-BILL</title>
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
                top:8.5%;
                position: -webkit-sticky;
                background-color: rgba(24,54,186,0.6);
                height: 45px;
                width: 100%;
                padding: 0px;
                position: fixed;
                z-index: 1;
            }
            .tab ul {
                list-style: none;
                display: flex;
                
            }
            .tab ul li {
                padding: 10px 30px;
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
            .tab ul li:hover button {
                color: black;
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
                top: 100%;
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
                float: left; 
                width: 70%; 
                padding:5px; 
            }
            .tabcontent12 { 
                float: right; 
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
            .head3{
                
            }
            .tablecontent{ 
                background-color:white; 
                border-radius:20px;
                border:10px solid rgba(24,54,186,0.5); 
                margin-bottom: 40px;
            }
            .greenbutton input{ 
                color:white; 
                padding:10px; 
                background-color:green;
                border:none; 
                width:80%;
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
            .buttonstyle{ 
                font-size:20px; 
                width:200px;
                padding: 13px 30px; 
                font-weight:bold;
            }
            .greenbutton input:hover{ 
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
            .gst,.signup,.add,.modify,.delete{
                font-size:18px;
            }
            .gst input,.signup input,.add input,.add select,.modify select,.modify input,.delete select,.delete input{
                font-size:15px;
            }
            .btn{
                width:70%;
            }
            @media (max-width: 1000px) {
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
                .gst,.signup,.add,.modify,.delete {
                    font-size:15px;
                }
                
                .gst input,.signup input,.add input,.add select,.modify select,.modify input,.delete select,.delete input{
                    font-size:13px;
                }
                .greenbutton input{
                     
                    width:90%;
                }
                .tabcontent11, .tabcontent12 {
                    width: 100%;
                    margin-top: 0;
                }
                .tab {
                    top:8%;
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
            }
            @media (max-width: 650px) {
                .header{ 
                    padding:5px;
                }
                .head1{
                    width:30%; 
                    font-size:12px;
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
                    min-width: 90px;
                    height:35px;
                    border-radius: 20px;
                    font-size: 15px;   
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
                .gst,.signup,.add,.modify,.delete{
                    font-weight:bold;
                }
                .gst,.signup input,.add input,.add select,.modify input,.modify select,.delete select,.delete input{
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
            }
        </style>
    </head>
    <body>
    <%  
        Connection con ;
        Statement stm = null ,stm1 = null;
        ResultSet rs,rs1;
        String username="";
        String admin="";
        String uname = "";
        String menubar = "";
        String photourl = "";
        String[] name = new String[100];
        
            username = session.getAttribute("uid").toString();
            admin = session.getAttribute("admin").toString();
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
        double cgst = 0.0;
        double sgst = 0.0;
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
            <p>This Project is Done By Arvind M M (20BCE2633) , For any more Queries contact arvind.mm2020@vitstudent.ac.in</p>
        </div>
        <div class="tab">
            <ul>
                <li><button>BILL <i class="fas fa-caret-down"></i></button>
                    <div class="ctab">
                        <ul>
                            <li><button class="tablinks" onclick="openMode(event, 'airtel')" id="default1">AIRTEL</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'jio')" id="default2">JIO</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'bsnl')" id="default3">BSNL</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'vodofone')" id="default4">VODOFONE</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'airtelvip')" id="default5">AIRTEL VIP</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'airtellandline')" id="default6">AIRTEL LANDLINE</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'bsnllandline')" id="default7">BSNL LANDLINE</button></li>
                        </ul>
                    </div>
                </li>
                <%
                if(admin.equals(username))
                {
                %>
                <li><button>EDIT <i class="fas fa-caret-down"></i></button>
                    <div class="ctab">
                        <ul>
                            <li><button class="tablinks" onclick="openMode(event, 'add')" id="default8">ADD</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'modify')" id="default9">MODIFY</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'delete')" id="default10">DELETE</button></li>
                        </ul>
                    </div>
                </li>
                <%
                }
                %>
                <li><button class="tablinks" onclick="openMode(event, 'display')" id="default11">DISPLAY</button></li>
                <li><button>DOWNLOAD <i class="fas fa-caret-down"></i></button>
                    <div class="ctab">
                        <ul>
                            <li><button class="tablinks" onclick="openMode(event, 'single')" id="default12">Report</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'multiple')"  id="default13">MONTH WISE Report</button></li>
                        </ul>
                    </div>
                </li>    
                <%
                if(admin.equals(username))
                {
                %>
                <li><button>SETTING <i class="fas fa-caret-down"></i></button>
                    <div class="ctab">
                        <ul>
                            <li><button class="tablinks" onclick="openMode(event, 'gst')" id="default14">GST</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'signup')" id="default15">SIGNUP</button></li> 
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
                    <td style='width:3%;'>
                        <button class="home tablinks" onclick="openMode(event, 'home')" id="default0">
                            <img class="img2" src="images/home icon.png"></img>
                        </button>
                    </td>
                    <td class="head2"> TELEPHONE E-BILL </td>
                    <td style='text-align: right;padding-right:20px;'>
                        <div class="dropdown">
                            <button onclick="dropdown_list()" class="dropbtn"><%=username%></button>
                            <div id="myDropdown" class="dropdown-content center">
                                HELLO,<br>
                                <center>
                                    <button style="" class="tablinks" onclick="openMode(event, 'profile')" id="default17"><%=uname%></button>
                                    <a href="logout.jsp">Sign Out</a>
                                </center>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
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
                    <div class="pcontent11" id="content11" style="">
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
                                    <td style=''>
                                        <input form="myform8" type="text" style="width:100%;" value="<%=rs.getString("desi")%>" name="p_desi" readonly/>
                                    </td>
                                </tr>
                                <tr>
                                    <th style='text-align: left;'>EMAIL ID</th>
                                    <td style=''>
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
                                        <div style="width:25%; float:left;"><%=admin%></div>
                                        <%
                                        if(admin.equals(username))
                                        {
                                        %>
                                        <div style="width:35%; float:left;">
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
                    <div class="pcontent12" id="content12" style="">
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
                <div class="pcontent2" id="content2">
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
            <div id="add" class="tabcontent">
                <center><p class="title">ADD</p></center>
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
                                    <option id="airtel1" value="airtel">Airtel</option>
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
                <center><p class="title">MODIFY</p></center>
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
                                        <option id="airtel2" value="airtel">Airtel</option>
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
                                <td><input form="myform14" type="text" name="emp2" value="<%=request.getParameter("emp2")%>" pattern="[0-9]{5}" title="It must contain 5 digits only" required/></td>
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
                <center><p class="title">DELETE</p></center>
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
                                        <option id="airtel3" value="airtel">Airtel</option>
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
                <center><p class="title">SIGNUP</p></center>
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
        <script>
            editselect(false,'myform11');
            document.getElementById('default0').click();
            var c_menubar = ["home","airtel","jio","bsnl","vodofone","airtelvip","airtellandline","bsnllandline","add","modify","delete","display","single","multiple","gst","signup","freeze","profile"];
            var e_menubar = document.getElementById('menubar').value;
            for(let i=0;i<c_menubar.length;i++)
            {
                if(e_menubar===c_menubar[i])
                {
                    document.getElementById('default'+i).click();
                    if(e_menubar==="add")
                    {
                        let operator = document.getElementById('operator1').value;
                        for(let j=1;j<=7;j++)
                        {
                            if(operator===c_menubar[j])
                            {
                                alert(e_menubar+":"+operator);
                                document.getElementById(c_menubar[j]+'1').setAttribute("selected","");
                            }
                        }
                    }
                    if(e_menubar==="modify")
                    {
                        let operator= document.getElementById('operator2').value;
                        for(let j=1;j<=7;j++)
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
                        for(let j=1;j<=7;j++)
                        {
                            if(operator===c_menubar[j])
                            {
                                document.getElementById(c_menubar[j]+'3').setAttribute("selected","");
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
            alert(window.innerWidth);
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
    </body>
</html>