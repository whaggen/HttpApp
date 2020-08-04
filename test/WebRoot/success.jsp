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
    
    <title>�H����ƭ���</title>
    
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
                <a href="login.jsp" class="a1">�n�X</a>
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
                <th><input type="checkbox" name="all" onclick="check_all(this,'id')">����</th>
                <th>ID</th>
                <th>�m�W</th>
                <th>�︹</th>
                <th>�~��</th>
                <th>�ʧO</th>
                <th>�ͤ�</th>
                <th>�Ƶ�</th>
                <th>�����إ߮ɶ�</th>
                <th>�ާ@</th>
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
                         <a href="operatePerson.jsp?action=del&&id=<%= id %>" onclick="return confirm('�T�w�R���Ӭ���?')" class="a1">�R��</a>   
                                            
                         <a href="operatePerson.jsp?action=edit&&id=<%= id %>" class="a2">�ק�</a>
                     </td>
                     
                 </tr>
                 
                
             <%
              }
             %>
        </table>
        <div align="center">
            <input type="button" value="�s�W�H�����" onclick="document.location='addPerson.jsp'" class="button"style="width: 300px; height: 40px"/>
        </div>
        
         </div>   
    </form>    
    
    <%
       }catch(SQLException e){
           out.println("�ҥ~�o��"+ e.getMessage());
       }finally{
           //����
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
