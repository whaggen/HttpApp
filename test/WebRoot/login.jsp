<%@page import="test.loginBean"%>
<%@ page language="java" import="java.util.*" pageEncoding="BIG5"%>
<%@ taglib uri="/struts-tags" prefix="struts" %>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
 
  
  response.setCharacterEncoding("UTF-8");
  
  loginBean persons[] ={
        new loginBean("demo", "demo12345"),
        
  };
  
  String message="";
  
  if(request.getMethod().equals("POST")){
    
    for(loginBean person:persons){
      
      if(person.getUsername().equalsIgnoreCase(request.getParameter("username"))
           && person.getPassword().equalsIgnoreCase(request.getParameter("password"))){
          
          session.setAttribute("person", person);
          
          
          response.sendRedirect(request.getContextPath()+"/success.jsp");
          return;
      }      
    }
    message="�ϥΪ̱b���K�X�����T,�n�J����";
  }
     
%>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title>�n�J����</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<link rel="stylesheet" type="text/css" href="css/test.css">

    <script src="http://code.jquery.com/jquery-latest.js"></script>          
    
  </head>
  
  <body>
    <br>
    <div align="center" style="margin:10px">
       <fieldset style="width:75%">
         <legend>�n�J</legend>
         <form action="login.jsp" method="post">
           <table>
             <% if(! message.equals("")){  %>           
           
             <tr>
               <td></td>
               <td>
                 <span><img src="images/errorrstate.gif"></span>
                 <span style="color:red;"><%= message %></span>
               </td>
             </tr>
             
             <%} %>
             
             <tr>
               <td>�b��</td>
               <td><input type="text" name="username"  style="width: 300px;height: 40px "></td>
             </tr>
             <tr>
               <td>�K�X</td>
               <td><input type="password"  name="password" style="width: 300px; height: 40px"></td>
             </tr>
             <tr>
               <td></td>
               <td>
                 <input type="submit" value="�n�J"  class="button" style="width: 300px; height: 40px">
               </td>
             </tr>
           </table>
         </form>
       </fieldset>
     </div>  �b��:demo �K�X:demo12345 
      
  </body>
</html>
