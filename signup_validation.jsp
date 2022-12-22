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
                if(document.getElementById('check').value === "error")
                {
                    alert("The Username is already exist");
                    document.getElementById("myForm").submit();
                }
                else if(document.getElementById('check').value === "error1")
                {
                    alert("The password and Confirm Password doesn't match");
                    document.getElementById("myForm").submit();
                }
                else if(document.getElementById('check').value === "done")
                {
                    alert("Successfully Added");
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
    <% 
        String username="";
        try
        {
            username = session.getAttribute("uid").toString();
        %>
        <form method="post" action="main.jsp" id="myForm" onload>
            <input type="hidden" value="<%=username%>" name="username"/>
            <%
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = (Connection)session.getAttribute("connection");
            Statement stm = con.createStatement();
            ResultSet rs = null;
            String name = request.getParameter("name5");
            String emp = request.getParameter("emp5");
            String desi = request.getParameter("desi5");
            String email = request.getParameter("email5");
            String pass = request.getParameter("pass5");
            String cpass = request.getParameter("cpass5");
            int flag=0;
            if(pass.equals(cpass))
            {
                String sql = "select username from login";
                rs = stm.executeQuery(sql);
                while(rs.next())
                {
                    if(rs.getString(1).equals(emp))
                    {
                        flag=1;
                        %>
                        <input type="hidden" value="error" id="check" name="check"/>
                        <input type="hidden" value="<%=name%>" name="name5"/>
                        <input type="hidden" value="<%=emp%>" name="emp5"/>
                        <input type="hidden" value="<%=desi%>" name="desi5"/>
                        <input type="hidden" value="<%=email%>" name="email5"/>
                        <input type="hidden" value="signup" name="menubar"/>
                        <%
                        break;
                    }
                }
                if(flag==0)
                {   
                    String sql1 = "insert into login(name,username,password,email,desi) values(?,?,?,?,?)";
                    PreparedStatement ps = con.prepareStatement(sql1);
                    ps.setString(1,name);
                    ps.setString(2,emp);
                    ps.setString(3,getMd5(pass));
                    ps.setString(4,email);
                    ps.setString(5,desi);
                    ps.executeUpdate();
                    %>
                    <input type="hidden" value="done" id="check"/>
                    <%
                }
            }
            else
            {   
                %>
                <input type="hidden" value="error1" id="check"/>
                <input type="hidden" value="<%=name%>" name="name5"/>
                <input type="hidden" value="<%=emp%>" name="emp5"/>
                <input type="hidden" value="<%=desi%>" name="desi5"/>
                <input type="hidden" value="<%=email%>" name="email5"/>
                <input type="hidden" value="signup" name="menubar"/>
                <%
            }
            
        %>
        </form>
        <%
        }
        catch(Exception e)
        {
            session.setAttribute("msg","Please Login First");
            session.setAttribute("status","failed");
            response.sendRedirect("index.jsp");

        }
        %>
    </body>
</html>
