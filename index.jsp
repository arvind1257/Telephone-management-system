<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.15.4/css/all.css" integrity="sha384-DyZ88mC6Up2uqS4h/KRgHuoeGwBcD4Ng9SiP4dIRy0EXTlnuz47vAwmeGwVChigm" crossorigin="anonymous"> 
        <link rel="icon" href="VITLogoEmblem.png">
        <title>E-BILL</title>
        <style>
            *{
                margin:0px;
                box-sizing: border-box;
            }
            .center { 
                margin-left: auto; 
                margin-right: auto;
            }
            .header{ 
                z-index:1; 
                width:100%; 
                color:white; 
                position:fixed; 
                padding:10px 10px;
                background-color: #1836ba; 
                font-family: timesnewroman; 
                top:0%;}
            body { 
                overflow:hidden;
                font-family: Arial; 
                background-color:#e8e8e8; 
            }
            .content{
                top:14%;
                width:100%;
                height:90vh;
                overflow-y:auto;
                position:absolute;
                
            }
            .maincontent{ 
                width:35%; 
                padding:20px;
                color:#1b6bf5; 
                margin-top:3%; 
                background-color: white; 
                border-top: 7px solid #0f5adb; 
                box-shadow: 0px 0px 10px 5px grey;
            }
            .form_header{ 
                font-size:40px; 
                text-align:center;
                word-wrap:break-word;
                font-family:timesnewroman; 
            }
            .login__field { 
                margin:15px;
                position: relative; 
            }
            .login__icon { 
                top: 15px;
                width:45px; 
                height:35px; 
                color:#1b6bf5; 
                font-size: 20px;
                padding:0px 5px; 
                position: absolute; 
            }  
            .login__input { 
                padding: 10px; 
                padding-left: 40px; 
                width: 90%; 
                font-size:18pt; 
                height: 50px; 
            }  
            .button{ 
                width:80%;  
                color:white; 
                font-size:35px; 
                cursor: pointer; 
                padding:5px 20px; 
                background-color:#1836ba;
            }
            .button:hover { 
                background-color:rgba(15, 90, 219,0.8); 
            }
            .status{
                width:100%;
                float:left;
                text-align:center;
            }
            .forgot{
                float:left; 
                font-size:12pt;
                margin:15px 10%;
                word-wrap:break-word;
            }
            .head1{
                width:32%; 
                font-size:20px;
            }
            .head2{
                width:73%; 
                font-size:35px;
                font-weight: bolder;
            }
            @media (max-width:1000px)
            {
                .head1{
                    width:28%;
                }
                .head2{
                    font-size:30px;
                }
                .maincontent{
                    width:45%;
                }
            }
            @media (max-width:600px)
            {
                .head1{
                    width:25%;
                    font-size:15px;
                }
                .head2{
                    font-size:25px;
                }
                .maincontent{
                    width:65%;
                }
            }
            @media (max-width:410px)
            {
                .head1{
                    width:25%;
                    font-size:10px;
                }
                .head2{
                    font-size:20px;
                }
                .maincontent{
                    width:85%;
                }
                .imgstyle{
                    width:30px;
                    height:30px;
                }
                .form_header{ 
                    font-size:30px; 
                }
                .login__icon { 
                    top:12px;
                    font-size: 17px;
                }  
                .login__input { 
                    width: 100%;  
                    height: 40px; 
                    font-size:15pt;
                }  
                .button{ 
                    padding:2px 20px; 
                    font-size:25px; 
                }
            }
        </style>
        <script>
            window.history.forward();
        </script>
    </head>
    <body> 
        <div class="header">
            <table style="width:100%;">
                <tr>
                    <td style="width:5%;"; align="center"><img class="imgstyle" src="images/VITLogoEmblem.png" width="40px" height="40px"/></td>
                    <td class="head1"> VIT (VELLORE CAMPUS) </td>
                    <td class="head2"> TELEPHONE E-BILL </td>
                </tr>
            </table>
        </div>
        <br>
        <div class="content">
            <div class="maincontent center">
                <h1 class="form_header">LOGIN</h1>
                <br>
                <form action="login_validation.jsp" method="post">  
                    <center>
                        <div class="login__field">
                            <i class = "login__icon fas fa-user"> </i> 
                            <input class="login__input" type="text" name="username" placeholder="EMP ID" pattern="[0-9]{5}" title="Username must contain 5 digit only" required/>
                        </div>
                        <div class="login__field">
                            <i class = "login__icon fas fa-lock"> </i> 
                            <input class="login__input" type="password" name="password" placeholder="Password" pattern="(?=.*\d)(?=.*[a-z])(?=.*[A-Z]).{8,}"  title="Must contain at least one number and one uppercase and lowercase letter, and at least 8 or more characters" required/>
                        </div>
                        <div class="status center">
                            <%
                            if(session.getAttribute("status")!=null && session.getAttribute("msg")!=null)
                            {
                                if(session.getAttribute("status").toString().equals("success"))
                                {
                                %>
                                <p style="color:green;"><%=session.getAttribute("msg").toString()%></p>
                                <%
                                }
                                else
                                {
                                %>
                                <p style="color:red;"><%=session.getAttribute("msg").toString()%></p>
                                <%
                                }
                                session.setAttribute("msg","");
                                session.setAttribute("status","");
                            }
                            %>
                        </div>  
                        <div class="forgot">    
                            <a href="forgotPassword.jsp">Forgot Password?</a>
                        </div>
                        <br><br><br><br><br>
                        <input class="button" type="submit" value="Login"/>
                    </center>    
                </form>         
            </div>
            <br><br>
        </div>
    </body>
</html>
