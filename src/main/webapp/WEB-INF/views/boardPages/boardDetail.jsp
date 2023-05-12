<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 2023-05-09
  Time: 오후 1:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/resources/css/main.css">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.10.5/font/bootstrap-icons.css">
    <link rel="stylesheet" href="/resources/css/bootstrap.min.css">
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
    <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/moment.js/2.24.0/moment.min.js"></script>
</head>
<body>
<%@include file="../component/header.jsp" %>
<%@include file="../component/nav.jsp" %>
<div id="section">
    <h2>글 상세보기</h2>
        작성자 = ${BoardDTO.boardWriter}<br>
        조회수 = ${BoardDTO.boardHits}<br>
        작성시간 = <fmt:formatDate value="${BoardDTO.boardCreatedDate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate><br>
        <label for="board-title">글 제목</label><br>
        <textarea name="boardTitle" id="board-title" style="width: 50%; height: 10%" readonly>${BoardDTO.boardTitle}</textarea><br>

        <label for="board-contents">글 내용</label><br>
        <textarea name="boardContents" id="board-contents" placeholder="내용 입력" style="width: 50%; height: 30%" readonly>${BoardDTO.boardContents}</textarea><br>
        <c:if test="${BoardDTO.fileAttached == 1}">
            <div id="member-profile">
                <c:forEach items="${boardFileDTO}" var="boardFile">
                    <img src="${pageContext.request.contextPath}/upload/${boardFile.storedFileName}"
                         alt="" width="100" height="100">
                </c:forEach>
            </div>
        </c:if>

        <button onclick="board_list()">목록</button>
        <c:if test="${sessionScope.loginEmail != null}">
        <div id="comment-write-area">
            <input type="text" id="comment-writer" value="${sessionScope.loginEmail}" readonly>
            <input type="text" id="comment-contents" placeholder="댓글 내용">
            <button onclick="comment_write()">댓글작성</button>
        </div>
        </c:if>
        <div id="comment-list">
            <c:choose>
                <c:when test="${commentList.size() eq 0}">
                    <h2>작성된 댓글이 없습니다.</h2>
                </c:when>
                <c:otherwise>
                    <table>
                        <tr>
                            <th>id</th>
                            <th>작성자</th>
                            <th>내용</th>
                            <th>작성시간</th>
                            <th>삭제</th>
                        </tr>
                        <c:forEach items="${commentList}" var="comment">
                            <tr>
                                <td>${comment.id}</td>
                                <td>${comment.commentWriter}</td>
                                <td>${comment.commentContents}</td>
                                <td>
                                    <fmt:formatDate value="${comment.commentCreatedDate}" pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                                </td>
                            </tr>
                        </c:forEach>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>
</div>
<%@include file="../component/footer.jsp" %>
</body>
<script>
    const comment_write = () => {
        const commentWriter = document.getElementById("comment-writer").value;
        const commentContents = document.getElementById("comment-contents").value;
        const boardId = '${BoardDTO.id}';
        const result = document.getElementById("comment-list");
        $.ajax({
            type: "post",
            url: "/comment/save",
            data: {
                "commentWriter": commentWriter,
                "commentContents": commentContents,
                "boardId": boardId,
            },
            success: function (res) {
                console.log(res);
                let output = "<table>";
                output += "<tr>";
                output += "<th>id</th>";
                output += "<th>작성자</th>";
                output += "<th>내용</th>";
                output += "<th>작성시간</th>";
                output += "</tr>";
                for(let i in res) {
                    output += "<tr>";
                    output += "<td>" + res[i].id + "</td>";
                    output += "<td>" + res[i].commentWriter + "</td>";
                    output += "<td>" + res[i].commentContents + "</td>";
                    output += "<td>" + moment(res[i].commentCreatedDate).format("YYYY-MM-DD HH:mm:ss") + "</td>";
                    output += "</tr>";
                }
                output += "</table>";
                result.innerHTML = output;
                document.getElementById("comment-writer").value = "${sessionScope.loginEmail}";
                document.getElementById("comment-contents").value = "";
            },
            error: function () {
                console.log("실패");
            }
        });
    }
    const board_list = () => {
        const type = '${type}';
        const q = '${q}';
        const page = '${page}';
        location.href = "/board/boardList?page=" + page + "&type=" + type + "&q=" + q;
    }
</script>
</html>