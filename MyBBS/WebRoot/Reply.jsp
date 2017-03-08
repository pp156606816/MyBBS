<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
int id =Integer.parseInt(request.getParameter("id"));
int rootid = Integer.parseInt(request.getParameter("rootid"));


 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'Reply.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->

  </head>
  
  <body>
    <form action = "ReplyOK.jsp" method = "post">
    <input type = "hidden" name = "id" value = "<%=id %>">
    <input type = "hidden" name = "rootid" value = "<%=rootid %>">
    	<table border ="1">
    		<tr>
    			<td>
    				<input type ="text" name = "title"  size = 80>
    			</td>
    		</tr>
    		<tr>
    			<td>
    				<textarea cols = "80" row = "12" name = "cont" ></textarea>
    			</td>
    		</tr>
    		<tr>
    			<td>
    				<input type ="submit" value = "提交">
    			</td>
    		</tr>
    	</table>
    </form>
  </body>
</html>
