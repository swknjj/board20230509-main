<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
<div id="nav">
    <ul>
        <li id="li_1">
            <a href="/member/Save">회원가입</a>
        </li>
        <li id="li_2">
            <a href="/member/Login">로그인</a>
        </li>
        <li id="li_3">
            <a href="/board/boardList">글 목록</a>
        </li>
        <li class="login-name" id="login-area">
        </li>
    </ul>
</div>
<script>
    const loginArea = document.getElementById("login-area");
    const loginEmail = '${sessionScope.loginEmail}';
    const li_1 = document.getElementById("li_1");
    const li_2 = document.getElementById("li_2");
    const li_3 = document.getElementById("li_3");

    if (loginEmail.length != 0) {
        loginArea.innerHTML = "<a href='/member/mypage' style='color: black;'>" + loginEmail + "님 환영합니다</a>" + "<a href='/logout'>logout</a>";
        li_1.innerHTML = "<a href='/board/Save'>글 작성</a>"
        li_2.innerHTML = "<a href='/board/boardList'>글 목록</a>"
        li_3.innerHTML ="<c:if test="${sessionScope.loginEmail eq 'admin'}">"+
            "<td><a href='/member/memberList'>관리자 화면</a></td>"+
        "</c:if>"
    } else {
        loginArea.innerHTML = "<a href='/member/Login'>login</a>"
    }
</script>