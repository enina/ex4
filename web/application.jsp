<%-- 
    Document   : customers
    Created on : Jan 11, 2012, 10:56:59 AM
    Author     : ninaro
--%>
<%@  page import = "java.util.Vector" %>
<%@ page session="true" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<% if (session.getAttribute("username") == null) response.sendRedirect("index.jsp"); %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Application Page</title>
    </head>
    <body>
        <h1>Welcome <%= session.getAttribute("username") %>!</h1>
        
      <%  
        Vector ul = (Vector) application.getAttribute("userlist");
        if (ul == null) { 
                out.println ("something is wrong!"); 
           } else { out.println(ul); }
        
        %>
        <div>
            <a href="logout.jsp">Logout</a>
        </div>
        
    </body>
</html>
