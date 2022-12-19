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
                top:9.5%;
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
                top:120px; 
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
                background-color: #7c8ef7;
                min-width: 160px; 
                overflow: auto; 
                z-index: 1; 
                border: 3px solid rgb(24,54,165); 
                border-bottom-left-radius:20px;
                border-bottom-right-radius:20px; 
                color:black;
            }
            .dropdown-content a { 
                background-color: #7c8ef7; 
                padding: 12px 16px; 
                text-align:center;
                text-decoration: none; 
                display: block; 
            }
            .dropdown-content button { 
                padding: 12px 40px; 
                border:none; 
                font-size:25px;
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
                
            }
            .head2{
                
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
                width:100px;
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
                float:left; 
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
            @media (max-width: 1000px) {
                .header{ 
                    padding:5px;
                }
                .imgstyle{
                    width:30px;
                    height:30px;
                }
                .home{
                    padding-top:0px;
                }
                img2{
                    width:15px;
                    height:15px;
                }
                .head1{
                    width:40%; 
                    font-size:15px;
                }
                .head2{
                    width:40%; 
                    font-size:25px;
                }
                .tabcontent11, .tabcontent12 {
                    width: 100%;
                    margin-top: 0;
                }
                .tab {
                    height: 40px;
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
                    width:40%; 
                    font-size:15px;
                }
                .head2{
                    width:40%; 
                    font-size:20px;
                }
                .tabcontent11, .tabcontent12 {
                    width: 100%;
                    margin-top: 0;
                }
                .tab {
                    height: 35px;
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
        <div class="footer">
            <p>This Project is Done By Arvind M M (20BCE2633) , For any more Queries contact arvind.mm2020@vitstudent.ac.in</p>
        </div>
        <div class="tab">
        <%
            if(menubar!=null)
            {
                if(menubar.equals("airtel"))
                {
                %>
                <ul>
                    <li><button>BILL <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'airtel')" id="defaultOpen1">AIRTEL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'jio')">JIO</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnl')">BSNL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'vodofone')">VODOFONE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtelvip')">AIRTEL VIP</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtellandline')">AIRTEL LANDLINE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnllandline')">BSNL LANDLINE</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'add')">ADD</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'modify')">MODIFY</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'delete')">DELETE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                    <li><button class="tablinks" onclick="openMode(event, 'display')">DISPLAY</button></li>
                    <li><button>DOWNLOAD <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'single')">Month Report</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'multiple')">Monthwise Report</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'gst')">GST</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'signup')">SIGNUP</button></li> 
                                <li><button class="tablinks" onclick="openMode(event, 'freeze')">FREEZE DATE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                </ul>
                <%
                }
                else if(menubar.equals("jio"))
                {
                %>
                <ul>
                    <li><button>BILL <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'airtel')">AIRTEL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'jio')" id="defaultOpen1">JIO</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnl')">BSNL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'vodofone')">VODOFONE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtelvip')">AIRTEL VIP</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtellandline')">AIRTEL LANDLINE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnllandline')">BSNL LANDLINE</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'add')">ADD</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'modify')">MODIFY</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'delete')">DELETE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                    <li><button class="tablinks" onclick="openMode(event, 'display')">DISPLAY</button></li>
                    <li><button>DOWNLOAD <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'single')">Month Report</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'multiple')">Monthwise Report</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'gst')">GST</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'signup')">SIGNUP</button></li> 
                                <li><button class="tablinks" onclick="openMode(event, 'freeze')">FREEZE DATE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                </ul>
                <%
                }
                else if(menubar.equals("bsnl"))
                {
                %>
                <ul>
                    <li><button>BILL <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'airtel')">AIRTEL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'jio')">JIO</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnl')" id="defaultOpen1">BSNL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'vodofone')">VODOFONE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtelvip')">AIRTEL VIP</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtellandline')">AIRTEL LANDLINE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnllandline')">BSNL LANDLINE</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'add')">ADD</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'modify')">MODIFY</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'delete')">DELETE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                    <li><button class="tablinks" onclick="openMode(event, 'display')">DISPLAY</button></li>
                    <li><button>DOWNLOAD <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'single')">Month Report</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'multiple')">Monthwise Report</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'gst')">GST</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'signup')">SIGNUP</button></li> 
                                <li><button class="tablinks" onclick="openMode(event, 'freeze')">FREEZE DATE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                </ul>
                <%
                }
                else if(menubar.equals("vodofone"))
                {
                %>
                <ul>
                    <li><button>BILL <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'airtel')">AIRTEL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'jio')">JIO</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnl')">BSNL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'vodofone')" id="defaultOpen1">VODOFONE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtelvip')">AIRTEL VIP</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtellandline')">AIRTEL LANDLINE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnllandline')">BSNL LANDLINE</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'add')">ADD</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'modify')">MODIFY</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'delete')">DELETE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                    <li><button class="tablinks" onclick="openMode(event, 'display')">DISPLAY</button></li>
                    <li><button>DOWNLOAD <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'single')">Month Report</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'multiple')">Monthwise Report</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'gst')">GST</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'signup')">SIGNUP</button></li> 
                                <li><button class="tablinks" onclick="openMode(event, 'freeze')">FREEZE DATE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                </ul>
                <%
                }
                else if(menubar.equals("airtelvip"))
                {
                %>
                <ul>
                    <li><button>BILL <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'airtel')">AIRTEL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'jio')">JIO</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnl')">BSNL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'vodofone')">VODOFONE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtelvip')" id="defaultOpen1">AIRTEL VIP</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtellandline')">AIRTEL LANDLINE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnllandline')">BSNL LANDLINE</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'add')">ADD</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'modify')">MODIFY</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'delete')">DELETE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                    <li><button class="tablinks" onclick="openMode(event, 'display')">DISPLAY</button></li>
                    <li><button>DOWNLOAD <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'single')">Month Report</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'multiple')">Monthwise Report</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'gst')">GST</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'signup')">SIGNUP</button></li> 
                                <li><button class="tablinks" onclick="openMode(event, 'freeze')">FREEZE DATE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                </ul>
                <%
                }
                else if(menubar.equals("airtellandline"))
                {
                %>
                <ul>
                    <li><button>BILL <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'airtel')">AIRTEL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'jio')">JIO</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnl')">BSNL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'vodofone')">VODOFONE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtelvip')">AIRTEL VIP</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtellandline')" id="defaultOpen1">AIRTEL LANDLINE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnllandline')">BSNL LANDLINE</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'add')">ADD</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'modify')">MODIFY</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'delete')">DELETE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                    <li><button class="tablinks" onclick="openMode(event, 'display')">DISPLAY</button></li>
                    <li><button>DOWNLOAD <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'single')">Month Report</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'multiple')">Monthwise Report</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'gst')">GST</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'signup')">SIGNUP</button></li> 
                                <li><button class="tablinks" onclick="openMode(event, 'freeze')">FREEZE DATE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                </ul>
                <%
                }
                else if(menubar.equals("bsnllandline"))
                {
                %>
                <ul>
                    <li><button>BILL <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'airtel')">AIRTEL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'jio')">JIO</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnl')">BSNL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'vodofone')">VODOFONE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtelvip')">AIRTEL VIP</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtellandline')">AIRTEL LANDLINE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnllandline')" id="defaultOpen1">BSNL LANDLINE</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'add')">ADD</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'modify')">MODIFY</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'delete')">DELETE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                    <li><button class="tablinks" onclick="openMode(event, 'display')">DISPLAY</button></li>
                    <li><button>DOWNLOAD <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'single')">Month Report</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'multiple')">Monthwise Report</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'gst')">GST</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'signup')">SIGNUP</button></li> 
                                <li><button class="tablinks" onclick="openMode(event, 'freeze')">FREEZE DATE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                </ul>
                <%
                }
                else if(menubar.equals("add"))
                {
                %>
                <ul>
                    <li><button>BILL <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'airtel')">AIRTEL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'jio')">JIO</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnl')">BSNL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'vodofone')">VODOFONE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtelvip')">AIRTEL VIP</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtellandline')">AIRTEL LANDLINE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnllandline')">BSNL LANDLINE</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'add')"  id="defaultOpen1">ADD</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'modify')">MODIFY</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'delete')">DELETE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                    <li><button class="tablinks" onclick="openMode(event, 'display')">DISPLAY</button></li>
                    <li><button>DOWNLOAD <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'single')">Month Report</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'multiple')">Monthwise Report</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'gst')">GST</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'signup')">SIGNUP</button></li> 
                                <li><button class="tablinks" onclick="openMode(event, 'freeze')">FREEZE DATE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                </ul>
                <%
                }
                else if(menubar.equals("modify"))
                {
                %>
                <ul>
                    <li><button>BILL <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'airtel')">AIRTEL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'jio')">JIO</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnl')">BSNL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'vodofone')">VODOFONE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtelvip')">AIRTEL VIP</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtellandline')">AIRTEL LANDLINE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnllandline')">BSNL LANDLINE</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'add')">ADD</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'modify')" id="defaultOpen1">MODIFY</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'delete')">DELETE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                    <li><button class="tablinks" onclick="openMode(event, 'display')">DISPLAY</button></li>
                    <li><button>DOWNLOAD <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'single')">Month Report</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'multiple')">Monthwise Report</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'gst')">GST</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'signup')">SIGNUP</button></li> 
                                <li><button class="tablinks" onclick="openMode(event, 'freeze')">FREEZE DATE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                </ul>
                <%
                }
                else if(menubar.equals("delete"))
                {
                %>
                <ul>
                    <li><button>BILL <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'airtel')">AIRTEL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'jio')">JIO</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnl')">BSNL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'vodofone')">VODOFONE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtelvip')">AIRTEL VIP</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtellandline')">AIRTEL LANDLINE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnllandline')">BSNL LANDLINE</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'add')">ADD</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'modify')">MODIFY</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'delete')" id="defaultOpen1">DELETE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                    <li><button class="tablinks" onclick="openMode(event, 'display')">DISPLAY</button></li>
                    <li><button>DOWNLOAD <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'single')">Month Report</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'multiple')">Monthwise Report</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'gst')">GST</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'signup')">SIGNUP</button></li> 
                                <li><button class="tablinks" onclick="openMode(event, 'freeze')">FREEZE DATE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                </ul>
                <%
                }
                else if(menubar.equals("display"))
                {
                %>
                <ul>
                    <li><button>BILL <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'airtel')">AIRTEL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'jio')">JIO</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnl')">BSNL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'vodofone')">VODOFONE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtelvip')">AIRTEL VIP</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtellandline')">AIRTEL LANDLINE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnllandline')">BSNL LANDLINE</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'add')">ADD</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'modify')">MODIFY</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'delete')">DELETE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                    <li><button class="tablinks" onclick="openMode(event, 'display')" id="defaultOpen1">DISPLAY</button></li>
                    <li><button>DOWNLOAD <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'single')">Month Report</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'multiple')">Monthwise Report</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'gst')">GST</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'signup')">SIGNUP</button></li> 
                                <li><button class="tablinks" onclick="openMode(event, 'freeze')">FREEZE DATE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                </ul>
                <%
                }
                else if(menubar.equals("single"))
                {
                %>
                <ul>
                    <li><button>BILL <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'airtel')">AIRTEL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'jio')">JIO</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnl')">BSNL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'vodofone')">VODOFONE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtelvip')">AIRTEL VIP</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtellandline')">AIRTEL LANDLINE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnllandline')">BSNL LANDLINE</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'add')">ADD</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'modify')">MODIFY</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'delete')">DELETE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                    <li><button class="tablinks" onclick="openMode(event, 'display')">DISPLAY</button></li>
                    <li><button>DOWNLOAD <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'single')" id="defaultOpen1">Month Report</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'multiple')">Monthwise Report</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'gst')">GST</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'signup')">SIGNUP</button></li> 
                                <li><button class="tablinks" onclick="openMode(event, 'freeze')">FREEZE DATE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                </ul>
                <%
                }
                else if(menubar.equals("multiple"))
                {
                %>
                <ul>
                    <li><button>BILL <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'airtel')">AIRTEL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'jio')">JIO</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnl')">BSNL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'vodofone')">VODOFONE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtelvip')">AIRTEL VIP</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtellandline')">AIRTEL LANDLINE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnllandline')">BSNL LANDLINE</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'add')">ADD</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'modify')">MODIFY</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'delete')">DELETE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                    <li><button class="tablinks" onclick="openMode(event, 'display')">DISPLAY</button></li>
                    <li><button>DOWNLOAD <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'single')">Month Report</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'multiple')" id="defaultOpen1">Monthwise Report</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'gst')">GST</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'signup')">SIGNUP</button></li> 
                                <li><button class="tablinks" onclick="openMode(event, 'freeze')">FREEZE DATE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                </ul>
                <%
                }
                else if(menubar.equals("gst"))
                {
                %>
                <ul>
                    <li><button>BILL <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'airtel')">AIRTEL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'jio')">JIO</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnl')">BSNL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'vodofone')">VODOFONE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtelvip')">AIRTEL VIP</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtellandline')">AIRTEL LANDLINE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnllandline')">BSNL LANDLINE</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'add')">ADD</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'modify')">MODIFY</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'delete')">DELETE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                    <li><button class="tablinks" onclick="openMode(event, 'display')">DISPLAY</button></li>
                    <li><button>DOWNLOAD <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'single')">Month Report</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'multiple')">Monthwise Report</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'gst')" id="defaultOpen1">GST</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'signup')">SIGNUP</button></li> 
                                <li><button class="tablinks" onclick="openMode(event, 'freeze')">FREEZE DATE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                </ul>
                <%
                }
                else if(menubar.equals("signup"))
                {
                %>
                <ul>
                    <li><button>BILL <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'airtel')">AIRTEL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'jio')">JIO</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnl')">BSNL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'vodofone')">VODOFONE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtelvip')">AIRTEL VIP</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtellandline')">AIRTEL LANDLINE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnllandline')">BSNL LANDLINE</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'add')">ADD</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'modify')">MODIFY</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'delete')">DELETE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                    <li><button class="tablinks" onclick="openMode(event, 'display')">DISPLAY</button></li>
                    <li><button>DOWNLOAD <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'single')">Month Report</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'multiple')">Monthwise Report</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'gst')">GST</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'signup')" id="defaultOpen1">SIGNUP</button></li> 
                                <li><button class="tablinks" onclick="openMode(event, 'freeze')">FREEZE DATE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                </ul>
                <%
                }
                else if(menubar.equals("freeze"))
                {
                %>
                <ul>
                    <li><button>BILL <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'airtel')">AIRTEL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'jio')">JIO</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnl')">BSNL</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'vodofone')">VODOFONE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtelvip')">AIRTEL VIP</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'airtellandline')">AIRTEL LANDLINE</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'bsnllandline')">BSNL LANDLINE</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'add')">ADD</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'modify')">MODIFY</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'delete')">DELETE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                    <li><button class="tablinks" onclick="openMode(event, 'display')">DISPLAY</button></li>
                    <li><button>DOWNLOAD <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'single')">Month Report</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'multiple')">Monthwise Report</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'gst')">GST</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'signup')">SIGNUP</button></li> 
                                <li><button class="tablinks" onclick="openMode(event, 'freeze')" id="defaultOpen1">FREEZE DATE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                </ul>
                <%
                }
                else
                {
                %>
                <ul>
                <li><button>BILL <i class="fas fa-caret-down"></i></button>
                    <div class="ctab">
                        <ul>
                            <li><button class="tablinks" onclick="openMode(event, 'airtel')">AIRTEL</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'jio')">JIO</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'bsnl')">BSNL</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'vodofone')">VODOFONE</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'airtelvip')">AIRTEL VIP</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'airtellandline')">AIRTEL LANDLINE</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'bsnllandline')">BSNL LANDLINE</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'add')">ADD</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'modify')">MODIFY</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'delete')">DELETE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                    <li><button class="tablinks" onclick="openMode(event, 'display')">DISPLAY</button></li>
                    <li><button>DOWNLOAD <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'single')">Month Report</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'multiple')">Monthwise Report</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'gst')">GST</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'signup')">SIGNUP</button></li> 
                                <li><button class="tablinks" onclick="openMode(event, 'freeze')">FREEZE DATE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                </ul>
                <%
                }
            }
            else
            {
            %>
            <ul>
                <li><button>BILL <i class="fas fa-caret-down"></i></button>
                    <div class="ctab">
                        <ul>
                            <li><button class="tablinks" onclick="openMode(event, 'airtel')">AIRTEL</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'jio')">JIO</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'bsnl')">BSNL</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'vodofone')">VODOFONE</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'airtelvip')">AIRTEL VIP</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'airtellandline')">AIRTEL LANDLINE</button></li>
                            <li><button class="tablinks" onclick="openMode(event, 'bsnllandline')">BSNL LANDLINE</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'add')">ADD</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'modify')">MODIFY</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'delete')">DELETE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
                    <li><button class="tablinks" onclick="openMode(event, 'display')">DISPLAY</button></li>
                    <li><button>DOWNLOAD <i class="fas fa-caret-down"></i></button>
                        <div class="ctab">
                            <ul>
                                <li><button class="tablinks" onclick="openMode(event, 'single')">Single Month Report</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'multiple')">Month wise Report</button></li>
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
                                <li><button class="tablinks" onclick="openMode(event, 'gst')">GST</button></li>
                                <li><button class="tablinks" onclick="openMode(event, 'signup')">SIGNUP</button></li> 
                                <li><button class="tablinks" onclick="openMode(event, 'freeze')">FREEZE DATE</button></li>
                            </ul>
                        </div>
                    </li>
                    <%
                    }
                    %>
            </ul>
            <%
            }
        %>
        </div>
        <div class="header">
            <table style="width:100%;border-collapse: collapse" border="1">
                <tr>
                    <td style="width:4%;">
                        <img class="imgstyle" src="images/VITLogoEmblem.png" width="40px" height="40px"/>
                    </td>
                    <td style='width:25%;font-size:20px;'>
                        <span>VIT (VELLORE CAMPUS) </span>
                    </td>
                    <td style='width:3%;'>
                        <%
                        if(request.getParameter("menubar")==null || menubar.equals("home"))
                        {
                        %>
                        <button class="home tablinks" onclick="openMode(event, 'home')" id="defaultOpen">
                            <img class="img2" src="images/home icon.png" width="25px" height="25px"></img>
                        </button>
                        <%
                        }
                        else
                        {
                        %>
                        <button class="home tablinks" onclick="openMode(event, 'home')">
                            <img class="img2" src="images/home icon.png" width="25px" height="25px"></img>
                        </button>
                        <%
                        }
                        %>
                    </td>
                    <td style='width:40%;font-size:30px;text-align: center;'> TELEPHONE E-BILL </td>
                    <td style='text-align: right;padding-right:20px;'>
                        <div class="dropdown">
                            <button onclick="dropdown_list()" class="dropbtn"><%=username%></button>
                            <div id="myDropdown" class="dropdown-content center">
                                HELLO,<br>
                                <center>
                                <%
                                if(menubar.equals("profile"))
                                {
                                    %>
                                    <button style="" class="tablinks" onclick="openMode(event, 'profile')" id="defaultOpen"><%=uname%></button>
                                    <a href="logout.jsp">Sign Out</a>
                                    <%
                                    }
                                    else
                                    {
                                    %>
                                    <button style="" class="tablinks" onclick="openMode(event, 'profile')"><%=uname%></button>
                                    <a href="logout.jsp">Sign Out</a>
                                    <%
                                    }
                                %>    
                                </center>
                            </div>
                        </div>
                    </td>
                </tr>
            </table>
        </div> 
        <script>
            alert(window.innerWidth);
            </script>
    </body>
</html>