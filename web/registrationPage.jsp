<%-- 
    Document   : BGColor
    Created on : Jan 4, 2012, 9:22:06 AM
    Author     : solange
--%>
<%@ page import="java.sql.*" %> 
<%@ page import="java.io.*" %> 
<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import = "java.util.Vector" %>
<jsp:useBean id="users" scope="application" class="ex4.users.UserDetails" /> 
<%
   String errorMsg = "";
   boolean status = true;
   
   if (request.getParameter("userSubmit")!=null) {
        String username = request.getParameter("login");
        String password = request.getParameter("password");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");

        status = users.registerUser(firstName,lastName,username,password,email);

        if (status) {
            //save username is session
            session.setAttribute("username", username);
            synchronized(application) {
                Vector ul = (Vector) application.getAttribute("userlist");
                if (ul == null) {
                    ul = new Vector();
                    application.setAttribute("userlist",ul);
                }
                ul.addElement(username);
            }
        }else
            errorMsg="User already registered.Please choose different parameters";
    }
   
    //go to application.jsp when we already logged in or just logged in successfully
    String myname = (String) session.getAttribute("username");
    if (myname != null)
        request.getServletContext().getRequestDispatcher("/application.jsp").forward(request, response);

%>

<html>
    <body bgcolor="#FFFFFF">
    <center>
       
        <div style="color:red"><%=errorMsg%></div>
        <form action="registrationPage.jsp" method=post>
            <input name="userSubmit" type="hidden" value="1"/>
            <table cellpadding=4 cellspacing=2 border=0 >
                <th bgcolor="#FFFFFF" colspan=2>
                    <font size=4>Registration</font>
                    <br><font size=1><sup></sup></font><hr>
                </th>
                
                <tr bgcolor="#FFFFFF"><td valign=top> 
                        <b>First Name</b>
                    </td>    
                    <td>
                        <input type="text" name="firstName" value="" size=15 maxlength=20>
                    </td> </tr>
                
                <tr bgcolor="#FFFFFF"><td valign=top>
                        <b>Last Name</b></td><td>
                        <input type="text" name="lastName" value="" size=15 maxlength=20>
                    </td></tr>
                
                <tr bgcolor="#FFFFFF"><td valign=top>
                        <b>User Name</b></td><td>
                        <input type="text" name="login" size=10 value="" maxlength=10>
                    </td></tr>
                
                <tr bgcolor="#FFFFFF"> <td valign=top>
                        <b>Password</b> </td><td>
                        <input type="password" name="password" size=10 value="" 
                                   maxlength=10></td></tr>
                        
                <tr bgcolor="#FFFFFF"> <td valign=top>
                        <b>E-Mail</b> 
                    </td><td><input type="text" name="email" value="" size=25 
                               maxlength=125>
                    </td></tr>
           
              
                <td align=center colspan=2>
                    <input type="submit" value="Submit"></td></tr></table></center>

    </form>
    </center>
</body>
</html>