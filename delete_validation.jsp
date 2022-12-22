<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="icon" href="VITLogoEmblem.png">
        <title>E_BILL</title>
    </head>
    <script>
        function submit1()
        {
            var str = document.getElementById('check');
            if( str.value === "error")
            {
                alert("Phone number doesn't exist in this Mobile Operator");
            }
            if( str.value === "yes")
            {
                document.getElementById("form1").submit();
            }
            if( str.value === "done")
            {
                alert("Deleted Successfully!");
            }
            document.getElementById("form1").submit();
        }
    </script>
    <body onload="submit1()">
    <% 
        String username="";
        
        username = session.getAttribute("uid").toString();
        %>
        <form method="post" action="main.jsp" id="form1" onload>
            <%
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = (Connection)session.getAttribute("connection");
            Statement stm = con.createStatement();
            ResultSet rs = null;
            int flag=0;
            String phone = request.getParameter("phone3");
            String operator = request.getParameter("operator3");
            if(request.getParameter("delete").equals("DELETE"))
            {
                String sql = "select * from "+operator;
                rs = stm.executeQuery(sql);
                while(rs.next())
                {
                    if(rs.getString("phone").equals(phone))
                    {
                    %>
                    <input type="hidden" value="<%=rs.getString("phone")%>" name="phone3"/>
                    <input type="hidden" value="<%=operator%>" name="operator3"/>
                    <input type="hidden" value="<%=rs.getString("name")%>" name="name3"/>
                    <input type="hidden" value="<%=rs.getString("desi")%>" name="desi3"/>
                    <input type="hidden" value="<%=rs.getString("emp")%>" name="emp3"/>
                    <input type="hidden" value="<%=request.getParameter("delete")%>" name="delete"/>
                    <input type="hidden" value="delete" name="menubar"/>
                    <input type="hidden" value="yes" id="check"/>
                    <%
                    flag=1;
                    break;
                    }
                }
                if(flag==0)
                {
                %>
                <input type="hidden" value="<%=phone%>" name="phone3"/>
                <input type="hidden" value="<%=operator%>" name="operator3"/>
                <input type="hidden" value="error" id="check"/>
                <input type="hidden" value="delete" name="menubar"/>
                <%
                }
            }
            else if(request.getParameter("delete").equals("CONFIRM"))
            {
                String sql = "delete from "+operator+" where phone = ?";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setString(1,phone);
                ps.executeUpdate();
                %>
                <input type="hidden" value="done" id="check"/>
                <%
            }
            else
            {
                %>
                <input type="hidden" value="yes" id="check"/>
                <input type="hidden" value="delete" name="menubar"/>
                <%
            }
        %>
        </form>
        <%    
        %>
    </body>
</html>
