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
            if(document.getElementById("check").value === "error1")
            {
                alert("Enter amount for all the phone numbers");
                document.getElementById("myForm").submit();
            }
            else if(document.getElementById("check").value === "error2")
            {
                alert("Already the bill amounts are added!");
                    document.getElementById("myForm").submit();
            }    
            else if(document.getElementById("check").value === "error3")
            {
                alert("Bill Month can't be empty");
                document.getElementById("myForm").submit();
            }
            else if(document.getElementById("check").value === "error4")
            {
                alert("Amount should not be empty");
                document.getElementById("myForm").submit();
            }
            else if(document.getElementById("check").value === "error5")
            {
                alert("Amount should be in numbers only");
                document.getElementById("myForm").submit();
            }
            else if(document.getElementById("check").value === "done")            
                document.getElementById("myForm").submit();
            else if(document.getElementById("check").value === "done1")            
            {
                alert("Stored Successfully!");
                document.getElementById("myForm").submit();
            }
            else if(document.getElementById("check").value === "done2")            
            {
                alert("Updated Successfully!");
                document.getElementById("myForm").submit();
            }
        }
    </script>
    <body onload="submit1()">
    <%
        String bill_operator = request.getParameter("bill_operator");
        String date="";
        int count=0;
        String username="";
        try
        {
            username = session.getAttribute("uid").toString();
        %>
        <form method="post" action="main.jsp" id="myForm" name="myForm" onload/>
            <input type="hidden" value="<%=bill_operator%>" name="bill_operator"/>
            <%  
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection con = (Connection)session.getAttribute("connection");
                Statement stm = con.createStatement();
                ResultSet rs =null;
                String gst1 = "select * from gst";
                rs = stm.executeQuery(gst1);
                double sgst = 0.0;
                double cgst = 0.0;
                while(rs.next())
                {
                    if(rs.getString("status").equals("ACTIVE") && (bill_operator.equals("airtel") || bill_operator.equals("bsnl")))
                    {
                        cgst = Double.parseDouble(rs.getString("cgst"))*0.01;
                        sgst = Double.parseDouble(rs.getString("sgst"))*0.01;
                    }
                }
                date=request.getParameter("bill_date");
                
                
                String[] name = new String[100];
                String[] amt = new String[100];
                count = Integer.parseInt(request.getParameter("count"));
                double one = 0.00;
                    double fixed = 0.00;
                    double misc = 0.00;
                    double usage = 0.00;
                    double late = 0.00;
                    double discount = 0.00;
                    double adj = 0.00;
                if(bill_operator.equals("bsnl"))
                {
                    try{
                        one = Double.parseDouble(request.getParameter("one_charge"));
                        fixed = Double.parseDouble(request.getParameter("f_charge"));
                        usage = Double.parseDouble(request.getParameter("u_charge"));
                        misc = Double.parseDouble(request.getParameter("m_charge"));
                        late = Double.parseDouble(request.getParameter("l_charge"));
                        discount = Double.parseDouble(request.getParameter("discount"));
                        adj = Double.parseDouble(request.getParameter("adj"));
                    }
                    catch(Exception e)
                    {
                    }
                }
                for(int i=0;i<count;i++)
                    name[i] = "amount"+Integer.toString(i);
                for(int i=0;i<count;i++)
                {
                amt[i]=request.getParameter(name[i]);
                try{
                    double s = Double.parseDouble(amt[i]);
                    %>
                    <input type="hidden" value="<%=amt[i]%>" name="<%=name[i]%>"/>
                    <%
                }
                catch(NumberFormatException e)
                {
                    %>
                    <input type="hidden" value="" name="<%=name[i]%>"/>
                    <%
                }
                }
                if(date.isEmpty()||date.equals(""))
                {
                %>
                <input type="hidden" value="error3" id="check"/>
                <input type="hidden" value="<%=one%>" name="one_charge"/>
                <input type="hidden" value="<%=fixed%>" name="f_charge"/>
                <input type="hidden" value="<%=misc%>" name="m_charge"/>
                <input type="hidden" value="<%=usage%>" name="u_charge"/>
                <input type="hidden" value="<%=late%>" name="l_charge"/>
                <input type="hidden" value="<%=discount%>" name="discount"/>
                <input type="hidden" value="<%=adj%>" name="adj"/>
                <input type="hidden" value="<%=bill_operator%>" name="bill_operator"/>
                <input type="hidden" value="<%=bill_operator%>" name="menubar"/>
                <input type="hidden" value="new" name="button"/>
                <%
                }
                else{
                if(request.getParameter("submit1").equals("GET"))
                {
                    String check = "select date,operator from bills";
                    rs = stm.executeQuery(check);
                    int flag=0;
                    while(rs.next())
                    {
                        if(rs.getString("date")!=null)
                        {
                        if(rs.getString("date").equals(date) && rs.getString("operator").equals(bill_operator))
                        {
                        %>
                        <input type="hidden" value="error2" id="check"/>
                        <input type="hidden" value="<%=one%>" name="one_charge"/>
                        <input type="hidden" value="<%=fixed%>" name="f_charge"/>
                        <input type="hidden" value="<%=misc%>" name="m_charge"/>
                        <input type="hidden" value="<%=usage%>" name="u_charge"/>
                        <input type="hidden" value="<%=late%>" name="l_charge"/>
                        <input type="hidden" value="<%=discount%>" name="discount"/>
                        <input type="hidden" value="<%=adj%>" name="adj"/>
                        <input type="hidden" value="<%=bill_operator%>" name="bill_operator"/>
                        <input type="hidden" value="<%=bill_operator%>" name="menubar"/>
                        <input type="hidden" value="<%=count%>" name="count"/>
                        <input type="hidden" value="new" name="button"/>
                        <%
                        flag=1;
                        break;
                        }
                        }
                    } 
                    if(flag!=1)
                    {
                        double sum = 0.0;
                        if(bill_operator.equals("bsnl"))
                        {                    
                        sum+=one+fixed+misc+usage+late;
                        sum=Math.round(sum*100.0)/100.0;
                        }
                        else
                        {
                        for(int i=0;i<count;i++)
                            sum+=Double.parseDouble(amt[i]);
                        }
                        %>
                        <input type="hidden" value="<%=one%>" name="one_charge"/>
                        <input type="hidden" value="<%=fixed%>" name="f_charge"/>
                        <input type="hidden" value="<%=misc%>" name="m_charge"/>
                        <input type="hidden" value="<%=usage%>" name="u_charge"/>
                        <input type="hidden" value="<%=late%>" name="l_charge"/>
                        <input type="hidden" value="<%=discount%>" name="discount"/>
                        <input type="hidden" value="<%=adj%>" name="adj"/>
                        <input type="hidden" value="<%=sum%>" name="sum"/> 
                        <input type="hidden" value="<%=count%>" name="count"/>
                        <input type="hidden" value="<%=date%>" name="bill_date"/>
                        <input type="hidden" value="<%=bill_operator%>" name="bill_operator"/>
                        <input type="hidden" value="done" id="check"/>
                        <input type="hidden" value="new" name="button"/>
                        <input type="hidden" value="<%=bill_operator%>" name="menubar"/>
                        <%
                    }        
                }
                else if(request.getParameter("submit1").equals("STORE"))
                {
                    String check = "select date,operator from bills";
                    rs = stm.executeQuery(check);
                    int flag=0;
                    while(rs.next())
                    {
                        if(rs.getString("date")!=null)
                        {
                        if(rs.getString("date").equals(date) && rs.getString("operator").equals(bill_operator))
                        {
                        %>
                        <input type="hidden" value="error2" id="check"/>
                        <input type="hidden" value="<%=bill_operator%>" name="bill_operator"/>
                        <input type="hidden" value="<%=bill_operator%>" name="menubar"/>
                        <input type="hidden" value="new" name="button"/>
                        <input type="hidden" value="<%=count%>" name="count"/>
                        <input type="hidden" value="<%=date%>" name="bill_date"/>
                        <%
                        flag=1;
                        break;
                        }
                        }
                    }    
                    if(flag==0)
                    {
                        String sql= "select * from "+bill_operator;
                        rs = stm.executeQuery(sql);
                        int i=0;
                        while(rs.next())
                        {
                            Double.parseDouble(amt[i]);
                            String sql1 = "insert into bills(name,desi,emp,phone,amount,operator,date,cgst,sgst,one,fixed,usages,misc,late,discount,adj) values(?,?,?,?,?,?,?,?,?,?,?,?,?,?,?,?)";
                            PreparedStatement ps = con.prepareStatement(sql1);
                            ps.setString(1,rs.getString("name"));
                            ps.setString(2,rs.getString("desi"));
                            ps.setString(3,rs.getString("emp"));
                            ps.setString(4,rs.getString("phone"));
                            ps.setString(5,amt[i]);
                            ps.setString(6,bill_operator);
                            ps.setString(7,date);
                            ps.setString(8,Double.toString(cgst));
                            ps.setString(9,Double.toString(sgst));
                            ps.setString(10,Double.toString(one));
                            ps.setString(11,Double.toString(fixed));
                            ps.setString(12,Double.toString(usage));
                            ps.setString(13,Double.toString(misc));
                            ps.setString(14,Double.toString(late));
                            ps.setString(15,Double.toString(discount));
                            ps.setString(16,Double.toString(adj));
                            ps.executeUpdate();
                            i++;
                        }
                        PreparedStatement ps = con.prepareStatement("insert into modifier(emp,operator,date) values(?,?,?)");
                        ps.setString(1,username);
                        ps.setString(2,bill_operator);
                        ps.setString(3,date);
                        ps.executeUpdate();
                        %>
                        <input type="hidden" value="done1" id="check"/>
                        <%
                    }
                }
                else if(request.getParameter("submit1").equals("UPDATE"))
                {
                    String sql= "select * from bills where operator='"+bill_operator+"' and date='"+date+"'";
                    rs = stm.executeQuery(sql);
                    int i=0;
                    while(rs.next())
                    {   
                        Double.parseDouble(amt[i]);
                        if(amt[i]==null)
                        {
                        %>
                        <input type="hidden" value="error4" id="check"/>
                        <input type="hidden" value="<%=bill_operator%>" name="bill_operator"/>
                        <input type="hidden" value="<%=bill_operator%>" name="menubar"/>
                        <input type="hidden" value="old" name="button"/>
                        <input type="hidden" value="<%=date%>" name="bill_date" id="bill_date"/>
                        <%
                        }
                        else if(rs.getString("amount").equals(amt[i]))
                        {
                            i++;
                            continue;
                        }
                        else
                        {
                            String sql1 = "update bills set amount=? where operator=? and phone=? and date=?";
                            PreparedStatement ps = con.prepareStatement(sql1);
                            ps.setString(1,amt[i]);
                            ps.setString(2,bill_operator);
                            ps.setString(3,rs.getString("phone"));
                            ps.setString(4,date);
                            ps.executeUpdate();
                            ps = con.prepareStatement("update modifier set emp=? where operator=? and date=?");
                            ps.setString(1,username);
                            ps.setString(2,bill_operator);
                            ps.setString(3,date);
                            ps.executeUpdate();
                            i++;
                        }
                        
                    }
                    %>
                    <input type="hidden" value="done2" id="check"/>
                    <input type="hidden" value="<%=bill_operator%>" name="bill_operator"/>
                    <input type="hidden" value="<%=bill_operator%>" name="menubar"/>
                    <input type="hidden" value="old" name="button"/>
                    <input type="hidden" value="<%=date%>" name="bill_date" id="bill_date"/>
                    <%
                    String sql1 = "update bills set one=? , fixed=? , usages=? , misc=? , late=? , discount=? , adj=?  where operator=? and date=?";
                    PreparedStatement ps = con.prepareStatement(sql1);
                    
                    ps.setString(1,Double.toString(one));
                    ps.setString(2,Double.toString(fixed));
                    ps.setString(3,Double.toString(usage));
                    ps.setString(4,Double.toString(misc));
                    ps.setString(5,Double.toString(late));
                    ps.setString(6,Double.toString(discount));
                    ps.setString(7,Double.toString(adj));
                    ps.setString(8,bill_operator);
                    ps.setString(9,date);
                    ps.executeUpdate();
                }
                else
                {
                %>    
                <input type="hidden" value="done" id="check"/>
                <input type="hidden" value="<%=bill_operator%>" name="bill_operator"/>
                <input type="hidden" value="<%=bill_operator%>" name="menubar"/>
                <input type="hidden" value="old" name="button"/>
                <%    
                }
            }
        }
        catch(NullPointerException e)
        {
            session.setAttribute("msg","Please Login First");
            session.setAttribute("status","failed");
            response.sendRedirect("index.jsp");
        }
        catch(NumberFormatException e)
        {
            %>
            <input type="hidden" value="<%=date%>" name="bill_date"/>
            <input type="hidden" value="<%=bill_operator%>" name="bill_operator"/>
            <input type="hidden" value="<%=count%>" name="count"/>
            <input type="hidden" value="error5" id="check"/>
            <%
                if(request.getParameter("submit1").equals("UPDATE")) 
                {
                %>
                    <input type="hidden" value="old" name="button"/>
                <% 
                }
                else if(request.getParameter("submit1").equals("STORE")) {
                %>
                    <input type="hidden" value="new" name="button"/>
                <% 
                }
                else if(request.getParameter("submit1").equals("GET")) {
                %>
                    <input type="hidden" value="new" name="button"/>
                <%
                }
                %>
                <input type="hidden" value="<%=bill_operator%>" name="menubar"/>
            <%
        }
        %> 
        </form>
    </body>
</html>
