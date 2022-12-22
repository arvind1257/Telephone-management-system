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
                if(document.getElementById('check').value.length <= 0)
                {
                    alert("The phone number is already exist in the list");
                }
                else
                {
                    alert("Successfully Added!");
                }
                document.getElementById("myForm").submit();
            }
        </script>
    </head>    
    <body onload="submit1()">
    <% 
        String username="";
        try
        {
            username = session.getAttribute("uid").toString();
        %>
        <form id="myForm" method="post" action="main.jsp" onload>
        <%
            String phone = request.getParameter("phone1");
            String name = request.getParameter("name1");
            String emp = request.getParameter("emp1");
            String desi = request.getParameter("desi1");
            String operator = request.getParameter("operator1");
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = (Connection)session.getAttribute("connection");
            Statement stm = con.createStatement();
            ResultSet rs =null;
        
            String sql = "select * from "+operator;
            int flag=0;
            rs = stm.executeQuery(sql);
            while(rs.next())
            {
                if(phone.equals(rs.getString("phone")))
                {   
                    flag=1;
                    %>
                    <input type="hidden" value="" id="check"/>
                    <input type="hidden" value="add" name="menubar"/>
                    <input type="hidden" value="<%=name%>" name="name1"/>
                    <input type="hidden" value="<%=emp%>" name="emp1"/>
                    <input type="hidden" value="<%=desi%>" name="desi1"/>
                    <input type="hidden" value="<%=operator%>" name="operator1"/>
                    <input type="hidden" value="<%=phone%>" name="phone1"/>
                    <%  
                    break;
                }
            }
            if(flag==0)
            {
                String sql1 = "insert into "+operator+"(name,phone,emp,desi) values(?,?,?,?)" ;
                PreparedStatement ps = con.prepareStatement(sql1);
                ps.setString(1,name);
                ps.setString(2,phone);
                ps.setString(3,emp);
                ps.setString(4,desi);
                ps.executeUpdate();
                %>
                <input type="hidden" value="done" id="check"/>
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
