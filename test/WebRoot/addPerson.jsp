<%@ page language="java" import="java.util.*" pageEncoding="BIG5"%>
<%
String path = request.getContextPath();
String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>

<%
   String action=(String)request.getAttribute("action");
   String name=(String)request.getAttribute("name");
   String nickname=(String)request.getAttribute("nickname");
   String id=(String)request.getAttribute("id");
   String sex=(String)request.getAttribute("sex");
   String age=(String)request.getAttribute("age");
   String birthday=(String)request.getAttribute("birthday");
   String description=(String)request.getAttribute("description");
   
   boolean isEdit= "edit".equals(action);
   
 %>

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN">
<html>
  <head>
    <base href="<%=basePath%>">
    
    <title><%= isEdit ? "�ק�H�����" : "�s�W�H�����" %></title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	
	<link rel="stylesheet" type="text/css" href="css/test.css">

  </head>
  
  <body>
    <form action="operatePerson.jsp" method="post">
      <input type="hidden" name="action" value="<%= isEdit ? "save":"add"%>">
      <input type="hidden" name="id" value="<%= isEdit ? id :""%>">
    
    <div align="center"><br>
        <fieldset style="width:75%">
            <legend><%= isEdit ? "�ק�H�����" : "�s�W�H�����" %></legend>
            <table align="center">
                <tr>
                  <td>�m�W</td>
                  <td><input type="text" name="name" value="<%= isEdit ? name: "" %>"></td>
                </tr>
                
                <tr>
                  <td>�ʺ�</td>
                  <td><input type="text" name="nickname" value="<%= isEdit ? nickname: "" %>"></td>
                </tr>
                
                <tr>
                  <td>�~��</td>
                  <td><input type="text" name="age" value="<%= isEdit ? age: "" %>"></td>
                </tr>
                
                <tr>
                  <td>�ʧO</td>
                  <td>
                      <input type="radio" name="sex" value="male" id="sex_male" <%= isEdit && "male".equals(sex) ? "checked": "" %>>
                      <label for="sex_male">�k &nbsp;</label>
                      <input type="radio" name="sex" value="female" id="sex_female" <%= isEdit && "female".equals(sex) ? "checked": "" %>>
                      <label for="sex_female">�k &nbsp;</label>
                  </td>
                </tr>
                
                <tr>
                  <td>�ͤ�</td>
                  <td>
                      <input type="text" name="birthday" value="<%= isEdit ? birthday: "" %>">
                      yyyy-MM-dd
                  </td>
                  
                </tr>
                
                <tr>
                  <td>�y�z</td>
                  <td><textarea name="description" rows="5"><%= isEdit ? description : "" %></textarea></td>
                </tr>
                
                <tr>
                  <td></td>
                  <td>
                      <input type="submit" value="<%= isEdit ? "�x�s" : "�W�[�H�����" %>" class="button"/>
                      <input type="button" value="�^�W�@��" onclick=" history.go(-1); " class="button">
                  </td>
                </tr>
            </table>
        </fieldset>
    </div>
    </form>
  </body>
</html>
