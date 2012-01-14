<%@  page import = "java.util.Vector" %>
<jsp:useBean id="users" scope="application" class="ex4.users.UserDetails" /> 
<%
   String errorMsg = "";
   boolean status = true;
   
   if (request.getParameter("userSubmit")!=null) {
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        status = users.login(username, password);

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
            errorMsg="Invalid username or password.Please try again.";
    }
   
    //go to application.jsp when we already logged in or just logged in successfully
    String myname = (String) session.getAttribute("username");
    if (myname != null)
        request.getServletContext().getRequestDispatcher("/application.jsp").forward(request, response);

%>

<HTML>
    <HEAD>
        <TITLE>Login using jsp</TITLE>
    </HEAD>

    <BODY bgcolor="#FFFFFF">
    <CENTER>
        <div style="color:red"><%=errorMsg%></div>
        <H1> <font size=4>Sign in</font></H1>
        
        <form action="loginPage.jsp" method="post" >
            <input name="userSubmit" type="hidden" value="1"/>
            <table>
                <tr>
                    <td> Username  : </td><td> <input name="username" size=15 type="text" /> </td> 
                </tr>
                <tr>
                    <td> Password  : </td><td> <input name="password" size=15 type="password" /> </td> 
                </tr>
            </table>
             <P>
            <input type="submit" value="login" />
        </form>
        <H2> <font size=4><a href="registrationPage.jsp"> New to this site?Create an account</a>  </font></H2>
    </center>
</BODY>
</HTML>



