<%@ page language="java" import="java.util.*" pageEncoding="BIG5"%>

<%@page import="java.sql.Timestamp"%>
<%@page import="java.sql.SQLException"%>

<%@page import="java.sql.Date"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.mysql.cj.exceptions.RSAException"%>

<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>人員資料頁面</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<link rel="stylesheet" type="text/css" href="css/test.css">
	
	<script type="text/javascript">
     function check_all(obj,id)
      {
        var checkboxs = document.getElementsByName(id);        
       
             for(var i=0;i<checkboxs.length;i++){
                    
                checkboxs[i].checked = obj.checked;
             }       
                        
      }
    </script>

  </head>
  
  <body>
  <br>
    <table align="right" >
        <tr>
            <td>
                <a href="login.jsp" class="a1">登出</a>
            </td>
        </tr>
    </table> 
            
    <br>
    <br>
    <%
      String DBusername="root";
      String DBpassword="Sc8560&36";
      Connection conn=null;
      Statement stmt=null;
      ResultSet rs=null;
      
      try{
          Class.forName("com.mysql.cj.jdbc.Driver");
              conn =DriverManager.getConnection("jdbc:mysql://localhost:3306/databaseeng?serverTimezone=UTC",DBusername,DBpassword);
              stmt =conn.createStatement();
              if(conn!=null && !conn.isClosed()){
                System.out.println("Database Linked susseceful");
              }
              
              rs=stmt.executeQuery("select * from tb_person");
      
     %>
  
    <form >
    <div align="center">    
        
        <table id="person" >
            
            <tr >
                <th><input type="checkbox" name="all" onclick="check_all(this,'id')">全選</th>
                <th>ID</th>
                <th>姓名</th>
                <th>綽號</th>
                <th>年齡</th>
                <th>性別</th>
                <th>生日</th>
                <th>備註</th>
                <th>紀錄建立時間</th>
                <th>操作</th>
            </tr>
            <%
                while(rs.next()){
                    int id=rs.getInt("id");
                    int age=rs.getInt("age");
                    
                    String name=rs.getString("name");
                    String nickname=rs.getString("nickname");
                    String sex=rs.getString("sex");
                    String descriptiion=rs.getString("description");
                    
                    Date birthday=rs.getDate("birthday");
                    Timestamp createTime= rs.getTimestamp("create_Time");                 
                
             %>
                 <tr class="person-tr">
                     <td><input type="checkbox" name="id" value=<%= id%>></td>
                     <td><%= id %></td>
                     <td><%= name%></td>
                     <td><%= nickname %></td>
                     <td><%= age %></td>
                     <td><%= sex %></td>
                     <td><%= birthday %></td>
                     <td><%= descriptiion %></td>
                     <td><%= createTime %></td>
                     <td>  
                         <a href="operatePerson.jsp?action=del&&id=<%= id %>" onclick="return confirm('確定刪除該紀錄?')" class="a1">刪除</a>   
                                            
                         <a href="operatePerson.jsp?action=edit&&id=<%= id %>" class="a2">修改</a>
                     </td>
                     
                 </tr>
                 
                
             <%
              }
             %>
        </table>
        <div align="center">
            <input type="button" value="新增人員資料" onclick="document.location='addPerson.jsp'" class="button"style="width: 300px; height: 40px"/>
        </div>
        
         </div>   
    </form>    
    
    <%
       }catch(SQLException e){
           out.println("例外發生"+ e.getMessage());
       }finally{
           //關閉
           if(rs != null)
               rs.close();
           if(stmt !=null)
               stmt.close();
           if(conn !=null)
               conn.close();
       }
       
     %>
   
  </body>
  
</html>
