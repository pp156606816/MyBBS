<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>

<%
int pageSize = 1;

String strPageNo = request.getParameter("pageNo");
int pageNo ;
if(strPageNo == null || strPageNo.equals("")){
	pageNo = 1;
}else{
	pageNo = Integer.parseInt(strPageNo.trim());
}

int start = (pageNo - 1)*pageSize; 



Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost:3306/bbs?user=root&password=banny0914";
Connection conn = DriverManager.getConnection(url);

Statement stmtCount = conn.createStatement();
ResultSet rsCount = stmtCount.executeQuery("Select count(*) from article where pid =0");
rsCount.next();
int totalRecord = rsCount.getInt(1);

Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery("Select * from article where pid = 0 order by pdate desc limit"+ start+ ","+pageSize);



 %>
 

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
  
    
    <title>My JSP 'ShowArticleTree.jsp' starting page</title>
    <meta http-equiv="content-type" content="text/html; charset=gb2312" />
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
  
  <a href = "Post.jsp">发表新帖  </a>
  
  <table border = "1">
  
  <%
  	while(rs.next()){
  		
  		 	
   %>
   
   <tr>
   		<td>
   		<%=rs.getString("cont") %>
   		</td>
   </tr>
  
  <%
  }
   %>
  
	<% rs.close();
	stmt.close();
	conn.close();
	%>
  </table>
 
  </body>
</html>
