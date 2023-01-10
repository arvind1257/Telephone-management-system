<%@page import="java.security.MessageDigest"%>
<%@page import="java.math.BigInteger"%>
<%@page import="java.security.NoSuchAlgorithmException"%>
<%@page import="java.sql.*"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<body>
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
    Class.forName("com.mysql.cj.jdbc.Driver");
    //String url="jdbc:mysql://localhost:3306/phone_bill?zeroDateTimeBehavior=CONVERT_TO_NULL";
    //Connection con = DriverManager.getConnection(url,"root","123456");
    String url="jdbc:mysql://localhost:3306/tele_bills?zeroDateTimeBehavior=CONVERT_TO_NULL";
    Connection con = DriverManager.getConnection(url,"telebills_admin","NcWuAqxEyEY5C622@");
    String user = request.getParameter("username");
    String pass = request.getParameter("password");
    String sql="select * from login where username='"+user+"' and password='"+getMd5(pass)+"'";
    Statement stm = con.createStatement();
    ResultSet rs =null;
    rs=stm.executeQuery(sql);
    if(rs.next())
    {
        session.setAttribute("connection",con);
        session.setAttribute("uid",user);
        session.setAttribute("uname",rs.getString("name"));
        response.sendRedirect("main.jsp");
    }
    else
    {
        session.setAttribute("msg","Invalid Credentials");
        session.setAttribute("status","failed");
        response.sendRedirect("index.jsp");
    }
    rs=stm.executeQuery("select * from login where status='admin'");
    while(rs.next())
    {
        session.setAttribute("admin",rs.getString("username"));
    }
%>
</body>
</html>



