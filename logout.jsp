<%
    try
    {
    session.removeAttribute("uid");
    session.setAttribute("msg","Successfully Logged Out");
    session.setAttribute("status","success");
    response.sendRedirect("index.jsp");
    }
    catch(Exception e)
    {
        
    }
%>