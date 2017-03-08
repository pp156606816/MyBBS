<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import = "java.sql.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
String action = request.getParameter("action");
if(action != null && action.equals("post")){

	request.setCharacterEncoding("utf-8");
	String title = request.getParameter("title");
	String cont= request.getParameter("cont");
	
	cont.replaceAll("\n", "<br>");
	
	Class.forName("com.mysql.jdbc.Driver");
	String url = "jdbc:mysql://localhost:3306/bbs?user=root&password=banny0914";
	Connection conn = DriverManager.getConnection(url);
	
	conn.setAutoCommit(false);
	
	String sql = "insert into article values(null,0,?,?,?,now(),0)";
	PreparedStatement pstmt = conn.prepareStatement(sql,Statement.RETURN_GENERATED_KEYS);
	Statement stmt = conn.createStatement();
	
	pstmt.setInt(1,-1);
	pstmt.setString(2,title);
	pstmt.setString(3,cont);
	pstmt.executeUpdate();
	
	ResultSet rsKey = pstmt.getGeneratedKeys();
	rsKey.next();
	int key =rsKey.getInt(1);
	rsKey.close();
	stmt.execute("update article set rootid = " + key + "where id =" + key);
	//select max from id;拿到新生成的值方法一
	
	//stmt.executeUpdate("update article set isleaf = 1 where id = "+id);
	
	conn.commit();
	conn.setAutoCommit(true);
	
	stmt.close();
	pstmt.close();
	conn.close();
	
	response.sendRedirect("ShowArticleTree.jsp");

}

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
    <form action = "Post.jsp" method = "post">
   		<input type ="hidden" name ="action" value="post">
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
