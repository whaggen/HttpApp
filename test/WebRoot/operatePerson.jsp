<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@ page language="java" import="java.util.*" pageEncoding="BIG5"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%!
    public String forSQL(String sql){
        
        return sql.replace("'", "//'");
    }
 %>

<%
    request.setCharacterEncoding("UTF-8");
    
    String action=request.getParameter("action");
    String name=request.getParameter("name");
    String nickname=request.getParameter("nickname");    
    String sex=request.getParameter("sex");
    String age=request.getParameter("age");
    String birthday=request.getParameter("birthday");
    String description=request.getParameter("description");
    
    String DBusername="root";
    String DBpassword="Sc8560&36";
    
    if("add".equals(action)){
        
        String sql ="INSERT INTO tb_person" + 
        "( name, nickname, age, sex, birthday, description)values " +
        "( '" + forSQL(name) +"', '" + forSQL(nickname) + "', '"+ age +"', '"+
        sex +"', '"+ birthday + "', '"+ forSQL(description) + "')";
        
        Connection conn= null;
        Statement stmt= null;
        int result=0;
        
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn =DriverManager.getConnection("jdbc:mysql://localhost:3306/databaseeng?serverTimezone=UTC",DBusername,DBpassword);
            stmt =conn.createStatement();
              
            result= stmt.executeUpdate(sql);
             
        }catch(SQLException e){
           out.println("執行SQL\""+sql+"\"時發生例外:"+e.getMessage());
           return;
        }finally{
           if(stmt !=null)
              stmt.close();
           if(conn !=null)
              conn.close();
        }
        
        out.println("<html><style body{font-size:12px;}></style><body>");
        out.println(result+"條記錄增加到資料庫中。");
        out.println("<a href='success.jsp'>傳回人員列表</a>");
        out.println("<br><br>執行的SQL敘述為:</>"+sql);
        
        return;
        
    }else if("del".equals(action)){
       
       String[] id =request.getParameterValues("id");
       
       if(id==null && id.length == 0){
           out.println("沒有勾選任何選項");
           return;
       }
       String condition ="";
       
       for(int i=0;i<id.length;i++){
         if (i==0) condition=""+id[i];
         else condition=", "+id[i];
       }
       
       String sql ="DELETE FROM tb_person WHERE id IN ("+condition+")";
       
       Connection conn=null;
       Statement stmt=null;
       
       try{
          Class.forName("com.mysql.cj.jdbc.Driver");
          conn =DriverManager.getConnection("jdbc:mysql://localhost:3306/databaseeng?serverTimezone=UTC",DBusername,DBpassword);
          stmt =conn.createStatement();
              
          int result= stmt.executeUpdate(sql);
          
          out.println("<html><style body{font-size:12px;}></style><body>");
          out.println(result+"條記錄被刪除。");
          out.println("<a href='success.jsp'>傳回人員列表</a>");
          out.println("<br><br>執行的SQL敘述為:</>"+sql);
       }catch(SQLException e){
          out.println("執行SQL\"" +sql+"\"時發生例外:"+e.getMessage());
          e.printStackTrace();
       }finally{
          if(stmt !=null)
             stmt.close();
          if(conn !=null)
             conn.close();
       }
       
    }else if("edit".equals(action)) {
        
        String id=request.getParameter("id");
        String sql="SELECT * FROM tb_person WHERE id=" + id;
        
        Connection conn=null;
        Statement stmt=null;
        ResultSet rs=null;
        
        try{
           Class.forName("com.mysql.cj.jdbc.Driver");
           conn =DriverManager.getConnection("jdbc:mysql://localhost:3306/databaseeng?serverTimezone=UTC",DBusername,DBpassword);
           stmt =conn.createStatement(); 
           rs = stmt.executeQuery(sql);
           
           if(rs.next()){
               request.setAttribute("id",rs.getString("id"));
               request.setAttribute("name",rs.getString("name"));
               request.setAttribute("nickname",rs.getString("nickname"));
               request.setAttribute("age",rs.getString("age"));
               request.setAttribute("sex",rs.getString("sex"));
               request.setAttribute("birthday",rs.getString("birthday"));
               request.setAttribute("description",rs.getString("description"));
               
               request.setAttribute("action",action);
               
               request.getRequestDispatcher("/addPerson.jsp").forward(request, response);
           }else{
               out.println("沒有找到ID為" + id +"的紀錄。");
           }
        }catch(SQLException e){
          out.println("執行SQL\"" +sql+"\"時發生例外:"+e.getMessage());
          e.printStackTrace();
        }finally{
          if(stmt !=null)
             stmt.close();
          if(conn !=null)
             conn.close();
          if(rs !=null)
             rs.close();
        }
    }else if("save".equals(action)){
        
        String id = request.getParameter("id");
        
        String sql ="UPDATE tb_person SET" + 
                    " name = '" + forSQL(name) + "' ,"+
                    " nickname = '" + forSQL(nickname) + "' ,"+
                    " sex = '" + sex + "' ,"+
                    " age = '" + age + "' ,"+
                    " birthday = '" + birthday + "' ,"+
                    " description = '" + forSQL(description) + "' "+
                    "WHERE id="+id;
                    
        Connection conn= null;
        Statement stmt =null;
        
        try{
            Class.forName("com.mysql.cj.jdbc.Driver");
            conn =DriverManager.getConnection("jdbc:mysql://localhost:3306/databaseeng?serverTimezone=UTC",DBusername,DBpassword);
            stmt =conn.createStatement(); 
            int result=stmt.executeUpdate(sql);
            
            out.println("<html><style body{font-size:12px;}></style><body>");
            if(result ==0)  out.println("影響數目為 0,修改失敗.");
            else            out.println(result+"條記錄被修改。");
            out.println("<a href='success.jsp'>傳回人員列表</a>");
            out.println("<br><br>執行的SQL敘述為:</>"+sql);
            
            
        }catch(SQLException e){
            out.println("執行SQL\"" +sql+"\"時發生例外:"+e.getMessage());
            e.printStackTrace();
        }finally{
            if(stmt !=null)
              stmt.close();
            if(conn !=null)
              conn.close();
        }
    }
    
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>My JSP 'operatePerson.jsp' starting page</title>
    
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
    This is my JSP page. <br>
  </body>
</html>
