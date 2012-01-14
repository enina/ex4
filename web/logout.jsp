<%@ page import = "java.util.Vector" %>
<%

    String username=(String)session.getAttribute("username");
    if(username!=null)
    {
        out.println(username+" loged out,<div> <a href=\"index.jsp\">Back</a></div>");
        session.removeAttribute("username");
        synchronized(application) {
                Vector ul = (Vector) application.getAttribute("userlist");
                ul.remove(username);
        }        
    }
    else 
    {
         out.println("You are not logged in <a href=\"index.jsp\">Back</a>");
    }
%> 