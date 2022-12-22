
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="VITLogoEmblem.png">
        <title>E_BILL</title>
        <script>
            function submit1()
            {
                var x = document.getElementById("check");
                if(x.value === "done2")
                {
                    alert("Successfully Modified");
                    document.getElementById("myForm").submit();
                }
                else if(x.value === "done1")
                {
                    document.getElementById("myForm").submit();
                }
                else if(x.value === "error")
                {
                    alert("Entered phone number doesn't exist in the entered mobile operator");
                    document.getElementById("myForm").submit();
                }
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
            <input type="hidden" value="<%=username%>" name="username"/>
            <%    
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = (Connection)session.getAttribute("connection");
            Statement stm = con.createStatement();
            ResultSet rs = null;
            String button=request.getParameter("button");
            String ph = request.getParameter("phone2");
            String operator = request.getParameter("operator2");
            String name = "";
            String desi = "";
            String emp = "";
            int flag=1;
            if(button.equals("GET"))
            {
                String sql="select * from "+operator;
                rs=stm.executeQuery(sql);
                while(rs.next())
                {
                    if(rs.getString("phone").equals(ph))
                    {
                        name=rs.getString("name");
                        desi=rs.getString("desi");
                        emp=rs.getString("emp");
                        flag=0;
                        break;
                    }
                }
                if(flag==0)
                {
                %>
                <input type="hidden" name="menubar" value="modify"/>
                <input type="hidden" id="check" value="done1"/>
                <input type="hidden" name="phone2" value="<%=ph%>">
                <input type="hidden" name="name2" value="<%=name%>"/>
                <input type="hidden" name="emp2" value="<%=emp%>"/>
                <input type="hidden" name="desi2" value="<%=desi%>"/>
                <input type="hidden" name="operator2" value="<%=operator%>"/>
                <input type="hidden" value="<%=button%>" name="butt"/>
                <%
                }
                else
                {
                %>
                <input type="hidden" value="error" id="check"/>
                
                <input type="hidden" name="phone2" value="<%=ph%>">
                <input type="hidden" name="operator2" value="<%=operator%>"/>
                <input type="hidden" name="menubar" value="modify"/>
                <%
                }
            }
            else if(button.equals("SAVE"))
            {
                operator=request.getParameter("operator2");
                ph=request.getParameter("phone2");
                name=request.getParameter("name2");
                desi=request.getParameter("desi2");
                emp=request.getParameter("emp2");
                String sql = "update "+operator+" set name=? , desi=? , emp=? where phone=?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1,name);
                ps.setString(2,desi);
                ps.setString(3,emp);
                ps.setString(4,ph);
                ps.executeUpdate();
                %>
                <input type="hidden" id="check" value="done2"/>
                <%
            }
            else
            {
                %>
                <input type="hidden" id="check" value="done1"/>
                <input type="hidden" name="menubar" value="modify"/>
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
