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
                document.getElementById('form1').submit();
                alert("Successfully Updated");
            }
        </script>
    </head>
    <body onload="submit1()">
    <%
    String username = "";
    String fsubmit = ""; 
    String date = "";
    try
    {
    username = session.getAttribute("uid").toString();
    %>             
        <form id="form1" method="post" action="main.jsp">
        <%
            date = request.getParameter("fdate");
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = (Connection)session.getAttribute("connection");
            Statement stm = con.createStatement();
            ResultSet rs =null;
            
                PreparedStatement ps = con.prepareStatement("update freeze set date=?");
                ps.setString(1,date);
                ps.executeUpdate();
            %>
            <input type="hidden" name="menubar" value="freeze"/>
        </form>
    <%
    }catch(Exception e)
    {
        session.setAttribute("msg","Please Login First");
        session.setAttribute("status","failed");
        response.sendRedirect("index.jsp");
    }
    %>
    </body>
</html>
