<%@ page language="java" import="java.util.*" pageEncoding="utf-8"%>
<%@ page import = "java.sql.*" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%!
private void del(Connection conn,int id){
	Statement stmt = null;
	ResultSet rs = null;
	
	try{
		stmt = conn.createStatement();
		String sql = "select * from article where pid ="+ id;
		rs = stmt.executeQuery(sql);
		
		while(rs.next()){
			del(conn,rs.getInt("id"));
			}
		stmt.executeUpdate("delete from article where id ="+id);
		
		
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

int id =Integer.parseInt(request.getParameter("id"));
int pid = Integer.parseInt(request.getParameter("pid"));

Class.forName("com.mysql.jdbc.Driver");
String url = "jdbc:mysql://localhost:3306/bbs?user=root&password=banny0914";
Connection conn = DriverManager.getConnection(url);

conn.setAutoCommit(false);

del(conn,id);

Statement stmt = conn.createStatement();
ResultSet rs = stmt.executeQuery("select count(*) from article where pid="+pid);
rs.next();
int count = rs.getInt(1);
rs.close();
stmt.close();

if(count <= 0 ){
	Statement stmtUpdate=conn.createStatement();
	stmtUpdate.executeQuery("update article set isleaf = 0 where id ="+pid);
	stmtUpdate.close();
}

conn.commit();
conn.setAutoCommit(true);

conn.close();
response.sendRedirect("ShowArticleTree.jsp");
 %>

