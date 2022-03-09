<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="USER.UserDAO" %>
<%@ page import="java.io.PrintWriter" %>
<% request.setCharacterEncoding("UTF-8");%>
<jsp:useBean id="USER" class="USER.User" scope="page" />
<jsp:setProperty name="user" property="userID" />
<jsp:setProperty name="user" property="userPassword" />
<jsp:setProperty name="user" property="userName" />
<jsp:setProperty name="user" property="userGender" />
<jsp:setProperty name="user" property="userEmail" />
<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>테스트버전</title>
</head>
<body>
	<%
		String userID = null;
		if (session.getAttribute("userID") != null){
			userID = (String)session.getAttribute("userID");
		}
		if(userID != null){ //한번 로그인 한 회원이 다시 로그인 하지 못하도록 방지함
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('이미 로그인 되어있습니다')");
			script.println("location.href='main.jsp'");
			script.println("</script>");
		}
		//입력안된 사항이 있을때 돌아갈수있는 함수
		if(USER.getUserID()==null || USER.getUserPassword()==null || USER.getUserName()==null || USER.getUserGender()==null || USER.getUserEmail()==null){
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('모든 항목을 입력해주세요')");
			script.println("history.back()");
			script.println("</script>"); 
		} else {
			UserDAO userDAO = new UserDAO();
			int result = userDAO.join(USER);
			if(result == -1){ //이미 db에 존재하는 아이디여서 -1값으로 반환되는 경우
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("alert('아이디가 이미 존재합니다')");
				script.println("history.back()");
				script.println("</script>");
			}
			else { //모두 입력하고 신규 가입자인 경우 0값으로 반환되어 main페이지로 넘어가게한다
				session.setAttribute("userID", USER.getUserID()); //세션 부여하여 메인페이지로 넘어가게한다
				PrintWriter script = response.getWriter();
				script.println("<script>");
				script.println("location.href = 'main.jsp'");
				script.println("</script>");
			}
		}
	%>
</body>
</html>