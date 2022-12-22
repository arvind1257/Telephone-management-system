<%@page import="java.util.Calendar"%>
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
            if(document.getElementById("check").value === "done")
            {
                alert("successfully Modified");
                document.getElementById("myForm").submit();
            }
            else if(document.getElementById("check").value === "error")
            {
                alert("First edit the gst value");
                document.getElementById("myForm").submit();
            }
        }
    </script>
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
                String cgst = request.getParameter("cgst2");
                String sgst = request.getParameter("sgst2");
                    try
                    {
                    if(!sgst.isEmpty() && !cgst.isEmpty())
                    {
                        Calendar cal = Calendar.getInstance();
                        String date=cal.get(Calendar.DATE)+"/"+(cal.get(Calendar.MONTH) + 1)+"/"+cal.get(Calendar.YEAR);
                        String sql = "update gst set status='INACTIVE' where status='ACTIVE'";
                        PreparedStatement ps = con.prepareStatement(sql);
                        ps.executeUpdate();
                        String sql1 = "insert into gst(date,cgst,sgst,status) values(?,?,?,?)";
                        ps = con.prepareStatement(sql1);
                        ps.setString(1,date);
                        ps.setString(2,cgst);
                        ps.setString(3,sgst);
                        ps.setString(4,"ACTIVE");
                        ps.executeUpdate();
                        %>
                        <input type="hidden" value="done" id="check"/>
                        <%
                    }
                    }catch(Exception e)
                    {   
                    %>
                    <input type="hidden" value="error" id="check"/>
                    <input type="hidden" value="gst" name="menubar"/>
                    <%
                    }
                          
        }
        catch(Exception e)
        {
            session.setAttribute("msg","Please Login First");
            session.setAttribute("status","failed");
            response.sendRedirect("index.jsp");
        }
        %>
        </form>
    </body>
</html>
