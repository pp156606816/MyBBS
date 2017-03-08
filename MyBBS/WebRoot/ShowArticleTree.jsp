<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import="java.sql.*" %>

<%!
String str = "";
private void tree(Connection conn,int id,int level){
	Statement stmt = null;
	ResultSet rs = null;
	String preStr = "";
	
	for(int i = 0;i<level;i++){
		preStr += "----";
	}
	try{
		stmt = conn.createStatement();
		String sql = "select * from article where pid = "+ id;
		rs = stmt.executeQuery(sql);
		
		while(rs.next()){
			str += "<tr><td>" + rs.getInt("id") + "</td><td>" + 
				preStr +"<a href = 'ShowArticleDetail.jsp?id="+ rs.getInt("id")+"'>"
				+ rs.getString("title") +"</a></td> "+
				"<td><a href = 'Delete.jsp?id="+rs.getInt("id")+"&pid="+rs.getInt("pid")+"'>删除</a>"
				+"</td> </tr>";
			if(rs.getInt("isleaf")!= 0){
				tree(conn,rs.getInt("id"),level+1);
			}
		}
	}catch(SQLException ex){
		ex.printStackTrace();
	}finally{
		try{
			if(rs != null){
				rs.close();
				rs = null;
			}
			if(stmt != null){
				stmt.close();
				stmt = null;
			}
					
			}catch(SQLException e){
				e.printStackTrace();
		}
	}
}
 %>

<%
Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost:3306/bbs?user=root&password=banny0914";
Connection conn = DriverManager.getConnection(url);

Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery("Select * from article where pid = 0");
while(rs.next()){
	str += "<tr><td>" + rs.getInt("id") + "</td><td>" 
	        + "<a href = 'ShowArticleDetail.jsp?id="+ rs.getInt("id")+"&pid="+rs.getInt("pid")+"'>"
	        +rs.getString("title") +"</a> </td>"	
	        +"<td><a href = 'Delete.jsp?id="+rs.getInt("id")+"'>删除</a>"
			+"</td> </tr>";
	if(rs.getInt("isleaf") != 0){
		tree(conn,rs.getInt("id"),1);
	}
}

rs.close();
stmt.close();
conn.close();
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
  	<%= str %>
  	<%= str = "" %>
  </table>
  
  </body>
</html>
