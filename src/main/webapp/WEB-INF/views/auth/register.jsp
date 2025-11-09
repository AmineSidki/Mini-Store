<%@ page contentType="text/html;charset=UTF-8" language="java" session="false" %>
<html>
<head>
    <title>Register</title>
    <style>
        input{
            font-family: system-ui, -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, 'Open Sans', 'Helvetica Neue', sans-serif;
            font-size: 25px;
            background-color: rgba(128, 128, 128, 0.165);
            border: 1px rgba(0, 0, 0, 0) solid;
            border-radius: 25px;
            padding-left: 20px;
            padding-right: 20px;
            padding-top: 10px;
            padding-bottom: 10px;
            margin-bottom: 10px;
        }
        #title{
            font-size: 55px;
            font-family: 'Courier New', Courier, monospace;
        }
        #subtitle{
            font-size: 25px;
            font-family: 'Courier New', Courier, monospace;
            margin-bottom: 50px;
        }
        #submit
        {
            background-color:  rgb(0, 128, 255);
        }
        #submit:hover{
            background-color: rgb(89, 172, 255);
        }
    </style>
</head>
<body>
<div style="text-align: center;">
    <div id="title">
        Mini-Store
    </div>
    <div id="subtitle">
        Register
    </div>
    <form id="register_form" action="register" method="post">
        <input required name="username" type="text" placeholder="Username">
        <input required name="email" type="email" placeholder="Email"><br>
        <input required name="password" type="password" placeholder="Password">
        <input required name="confirmedPassword" type="password" placeholder="Confirm password"><br>
        <input id="submit" style="color: rgb(255,255,255); font-weight: bold; border:none" type="submit" value="Sign up">
    </form>
    <% if(request.getAttribute("isInvalid").equals("true")){ %>
    <div id="error_block">
        Error : ${requestScope.Reason}
    </div>
    <%}%>
</div>
</body>
</html>
