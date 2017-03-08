<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import = "java.sql.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
request.setCharacterEncoding("utf-8");
int id =Integer.parseInt(request.getParameter("id"));
int rootid = Integer.parseInt(request.getParameter("rootid"));
String title = request.getParameter("title");
String cont= request.getParameter("cont");

cont.replaceAll("\n", "<br>");

Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost:3306/bbs?user=root&password=banny0914";
Connection conn = DriverManager.getConnection(url);

conn.setAutoCommit(false);

String sql = "insert into article values(null,?,?,?,?,now(),0)";
PreparedStatement pstmt = conn.prepareStatement(sql);
Statement stmt = conn.createStatement();

pstmt.setInt(1,id);
pstmt.setInt(2,rootid);
pstmt.setString(3,title);
pstmt.setString(4,cont);
pstmt.executeUpdate();

stmt.executeUpdate("update article set isleaf = 1 where id = "+id);

conn.commit();
conn.setAutoCommit(true);

stmt.close();
pstmt.close();
conn.close();

response.sendRedirect("ShowArticleTree.jsp");
 %>
<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'ReplyOk.jsp' starting page</title>
    
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
    <font color = "red" size = "7">
    	OK!
    </font>
  </body>
</html>
