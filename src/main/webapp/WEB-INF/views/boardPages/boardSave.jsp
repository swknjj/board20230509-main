
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
<%@include file="../component/header.jsp"%>
<%@include file="../component/nav.jsp"%>
<div id="section" style="text-align: center">
    <h2>글 작성/등록</h2><br>
    <form action="/board/Save" method="post" enctype="multipart/form-data">
        <input type="text" id="board-memberId" name="memberId" value="${member.id}" style="display:none;"><br>
        <label for="board-writer">글 작성자</label><br>
        <input type="text" id="board-writer" name="boardWriter" readonly value="${sessionScope.loginEmail}"><br>
        <textarea name="boardTitle" placeholder="제목 입력" style="width: 50%; height: 10%"></textarea><br>
        <textarea name="boardContents" placeholder="내용 입력" style="width: 50%; height: 30%"></textarea><br>
        <input type="file" accept="image/*" name="boardProfile" multiple> <br>
        <input type="submit" value="작성">
        <button onclick="back()">취소</button>
    </form>
</div>
<%@include file="../component/footer.jsp"%>
</body>
<script>
    // 뒤로가기 버튼 함수
    const back = () => {
        location.href = "../../..";
    }
</script>
</html>