<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-09
  Time: 오후 1:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/main.css">
</head>
<body>
<%@include file="../component/header.jsp" %>
<%@include file="../component/nav.jsp" %>
<div id="section">
    <form action="/member/login" method="post" onsubmit="return check()">
        <label for="member-email">로그인 할 이메일 입력</label><br>
        <input type="text" id="member-email" name="memberEmail"><br>

        <label for="member-password">로그인 할 비밀번호 입력</label><br>
        <input type="text" id="member-password" name="memberPassword"><br>

        <input type="submit" id="submit-button" value="로그인">
        <button id="cansel" onclick="back()">처음으로 가기</button>
    </form>

</div>
<%@include file="../component/footer.jsp" %>
</body>
<script>
    // 뒤로가기 버튼 함수
    const back = () => {
        location.href = "../../..";
    }
    const check = () => {
        email = document.getElementById("member-email");
        password = document.getElementById("member-password");
        if (email.value.length == 0) {
            alert("이메일 입력")
            email.focus();
            return false;
        } else if (password.value.length == 0) {
            alert("비밀번호 입력")
            password.focus();
            return false;
        } else {
            return true;
        }
    }
</script>
</html>