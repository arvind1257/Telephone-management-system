<%@page import="java.util.Calendar"%>
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
                document.getElementById("myForm").submit();
            }
        </script>
    </head>
    <body onload="submit1()">
        <form id="myForm" method="post" action="main.jsp" onload>
        <% 
            String username="";
            String date=request.getParameter("bill_month");
            String operator = request.getParameter("operator");
            String phone = request.getParameter("phone");
            String button = request.getParameter("button");
            try
            {
            username = session.getAttribute("uid").toString();
            if(phone==null)
                phone="-";
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection con = (Connection)session.getAttribute("connection");
            PreparedStatement pst = con.prepareStatement("delete from receipt where operator='"+operator+"' and date='"+date+"' and phone='"+phone+"'");
            pst.executeUpdate();
            }
            catch(Exception e)
            {
            session.setAttribute("msg","Please Login First");
            session.setAttribute("status","failed");
            response.sendRedirect("index.jsp");
            }
        %>
            <input type="hidden" value="<%=operator%>" name="bill_operator"/>
            <input type="hidden" value="<%=operator%>" name="menubar"/>
            <input type="hidden" value="<%=button%>" name="button"/>
            <input type="hidden" value="<%=date%>" name="bill_date"/>
        </form>    
    </body>
</html>
