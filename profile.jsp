<%@page import="java.security.MessageDigest"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.NoSuchAlgorithmException"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="VITLogoEmblem.png">
        <title>E-BILL</title>
        <script>
            function submit1()
            {
                if(document.getElementById("check").value === "done2")
                {
                    alert("Successfully Updated");
                    document.getElementById("myForm").submit();
                }
                else if(document.getElementById("check").value === "done3")
                {
                    alert("Successfully changed the admin");
                    document.getElementById("myForm").submit();
                }
                else if(document.getElementById("check").value === "done4")
                {
                    alert("Successfully Answers have been Modified\n");
                    document.getElementById("myForm").submit();
                }
                else if(document.getElementById("check").value === "error1")
                {
                    alert("Password doesn't match");
                    document.getElementById("myForm").submit();
                }
            }
        </script>
    </head>
    <body onload="submit1()">
        <%!
            public static String getMd5(String input)
            {
                try 
                {
                    MessageDigest md = MessageDigest.getInstance("MD5");
                    byte[] messageDigest = md.digest(input.getBytes());
                    BigInteger no = new BigInteger(1, messageDigest);
                    String hashtext = no.toString(16);
                    while (hashtext.length() < 32) 
                    {
                        hashtext = "0" + hashtext;
                    }
                    return hashtext;
                }catch (NoSuchAlgorithmException e) {
                     throw new RuntimeException(e);
                }
            } 
        %>  
        <form id="myForm" method="post" action="main.jsp">
        <%
        
        String username="";
        try
        {
        username = session.getAttribute("uid").toString();
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection con = (Connection)session.getAttribute("connection");
        Statement stm = con.createStatement();
        PreparedStatement ps;
        ResultSet rs =null;
        String name=request.getParameter("p_name");
        String emp=request.getParameter("p_staff");
        String desi=request.getParameter("p_desi");
        String email=request.getParameter("p_email");
        String pass=request.getParameter("p_pass");
        String user=request.getParameter("p_user");
        String q1 = "";
        String q2 = "";
        String q3 = "";
        if(request.getParameter("q1")!=null && request.getParameter("q2")!=null && request.getParameter("q3")!=null)
        {
            q1=getMd5(request.getParameter("q1"));
            q2=getMd5(request.getParameter("q2"));
            q3=getMd5(request.getParameter("q3"));
        }
        String button = request.getParameter("submit2");
        if(button.equals("UPDATE"))
        {
            String sql = "update login set name=? , desi=? , email=? where username=?";
            ps = con.prepareStatement(sql);
            ps.setString(1,name);
            ps.setString(2,desi);
            ps.setString(3,email);
            ps.setString(4,emp);
            ps.executeUpdate();
            %>
            <input type="hidden" id="check" value="done2"/>
            <%
        }
        else if(button.equals("SAVE"))
        {
            rs = stm.executeQuery("select * from login where username='"+username+"' and password='"+getMd5(pass)+"'");
            if(rs.next())
            {
            String sql = "update login set Q1=? , Q2=? , Q3=? where username=?";
            ps = con.prepareStatement(sql);
            ps.setString(1,q1);
            ps.setString(2,q2);
            ps.setString(3,q3);
            ps.setString(4,username);
            ps.executeUpdate();
            %>
            <input type="hidden" id="q1" value="<%=q1%>"/>
            <input type="hidden" id="q2" value="<%=q2%>"/>
            <input type="hidden" id="q3" value="<%=q3%>"/>
            <input type="hidden" id="check" value="done4"/>
            <%
            }
            else
            {
            %>
            <input type="hidden" id="check" value="error1"/>
            <input type="hidden" name="submit3" value="error"/>
                
            <%
            }
        }      
        else if(button.equals("CHANGE"))
        {
            rs=stm.executeQuery("select * from login where username='"+username+"' and password='"+getMd5(pass)+"'");
            if(rs.next())
            {
                ps = con.prepareStatement("update login set status='normal' where status='admin'");
                ps.executeUpdate();

                PreparedStatement ps1 = con.prepareStatement("update login set status='admin' where username=?");
                ps1.setString(1,user);
                ps1.executeUpdate();
                
                session.setAttribute("admin",user);
                %>
                <input type="hidden" id="check" value="done3"/>
                <%
            }
            else
            {
                %>
                <input type="hidden" id="check" value="error1"/>
                <%
            }
        }
        }
        catch(Exception e)
        {
            session.setAttribute("msg","Please Login First");
            session.setAttribute("status","failed");
            response.sendRedirect("index.jsp");
        }
        %>
            <input type="hidden" name="menubar" value="profile"/>
        </form>
    </body>
</html>
