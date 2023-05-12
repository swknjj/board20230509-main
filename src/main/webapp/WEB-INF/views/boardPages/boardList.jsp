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
</head>
<body>
<%@include file="../component/header.jsp" %>
<%@include file="../component/nav.jsp" %>
<div id="section">
    <h2>게시글 리스트</h2>
    <c:choose>
        <c:when test="${boardList eq []}">
            <h3>작성된 글이 없습니다</h3>
        </c:when>
        <c:otherwise>
    <div class="container" id="list">
        <table class="table table-striped table-hover text-center">
            <tr>
                <th>id</th>
                <th>글 제목</th>
                <th>글 작성자</th>
                <th>조회수</th>
                <th>작성 시간</th>
                <th>파일 여부</th>
                <th>수정</th>
                <th>삭제</th>
            </tr>
            <c:forEach items="${boardList}" var="board">
                <tr>
                    <td>${board.id}</td>
                    <td>
                        <a href="/board/detail?id=${board.id}&page=${paging.page}&q=${q}&type=${type}">${board.boardTitle}</a>
                    </td>
                    <td>${board.boardWriter}</td>
                    <td>${board.boardHits}</td>
                    <td>
                        <fmt:formatDate value="${board.boardCreatedDate}"
                                        pattern="yyyy-MM-dd HH:mm:ss"></fmt:formatDate>
                    </td>
                    <td>${board.fileAttached}</td>
                    <c:if test="${board.memberId eq memberId}">

                        <th><a href="/board/update?id=${board.id}">수정</a></th>
                        <th><a href="/board/delete?id=${board.id}">삭제</a></th>
                    </c:if>
                </tr>
            </c:forEach>
        </table>
    </div>
    <div class="container">
        <ul class="pagination justify-content-center">
            <c:choose>
                <%-- 현재 페이지가 1페이지면 이전 글자만 보여줌 --%>
                <c:when test="${paging.page<=1}">
                    <li class="page-item disabled">
                        <a class="page-link">[이전]</a>
                    </li>
                </c:when>
                <%-- 1페이지가 아닌 경우에는 [이전]을 클릭하면 현재 페이지보다 1 작은 페이지 요청 --%>
                <c:otherwise>
                    <li class="page-item">
                        <a class="page-link"
                           href="/board/boardList?page=${paging.page-1}&q=${q}&type=${type}&memberId=${memberId}">[이전]</a>
                    </li>
                </c:otherwise>
            </c:choose>

            <%--  for(int i=startPage; i<=endPage; i++)      --%>
            <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
                <c:choose>
                    <%-- 요청한 페이지에 있는 경우 현재 페이지 번호는 텍스트만 보이게 --%>
                    <c:when test="${i eq paging.page}">
                        <li class="page-item active">
                            <a class="page-link">${i}</a>
                        </li>
                    </c:when>

                    <c:otherwise>
                        <li class="page-item">
                            <a class="page-link"
                               href="/board/boardList?page=${i}&q=${q}&type=${type}&memberId=${memberId}">${i}</a>
                        </li>
                    </c:otherwise>
                </c:choose>
            </c:forEach>

            <c:choose>
                <c:when test="${paging.page>=paging.maxPage}">
                    <li class="page-item disabled">
                        <a class="page-link">[다음]</a>
                    </li>
                </c:when>
                <c:otherwise>
                    <li class="page-item">
                        <a class="page-link"
                           href="/board/boardList?page=${paging.page+1}&q=${q}&type=${type}&memberId=${memberId}">[다음]</a>
                    </li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
        </c:otherwise>
    </c:choose>
    <div class="container" id="search-area">
        <form action="/board/boardList" method="get">
            <select name="type" id="typeSelect">
                <option value="" selected disabled hidden>선택해주세요</option>
                <option value="boardTitle">제목</option>
                <option value="boardWriter">작성자</option>
                <option value="boardContents">내용</option>
            </select>
            <input type="text" name="q" id="searchInput" placeholder="검색어를 입력하세요" disabled="disabled">
            <input type="submit" value="검색">
        </form>
    </div>
    <div id="paging-change">
        <label for="paging-changemode">페이지당 볼 글 갯수</label>
        <input type="text" id="paging-changemode" name="pagingChange">
        <button onclick="paging_change()">입력</button>
    </div>
</div>
<%@include file="../component/footer.jsp" %>
</body>
<script>
    const typeSelect = document.getElementById("typeSelect");
    const searchInput = document.getElementById("searchInput");

    typeSelect.addEventListener("change", function() {
        if (typeSelect.value === "") {
            searchInput.disabled = true;
        } else {
            searchInput.disabled = false;
        }
    });
    const paging_change = () => {

    }
</script>
</html>