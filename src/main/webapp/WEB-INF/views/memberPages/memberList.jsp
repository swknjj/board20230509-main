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
</head>
<body>
<%@include file="../component/header.jsp" %>
<%@include file="../component/nav.jsp" %>
<div id="section">
    <h2>회원 리스트</h2>
    <c:choose>
        <c:when test="${memberList eq []}">
            <h3>회원이 없습니다</h3>
        </c:when>
        <c:otherwise>
            <div class="container" id="list">
                <table class="table table-striped table-hover text-center">
                    <tr>
                        <th>id</th>
                        <th>이메일</th>
                        <th>비밀번호</th>
                        <th>이름</th>
                        <th>전화번호</th>
                        <th>프로필사진</th>
                        <th>삭제</th>
                    </tr>

                    <c:forEach items="${memberList}" var="member">
                        <c:if test="${sessionScope.loginEmail eq 'admin'}">
                            <c:if test="${member.memberEmail != 'admin'}">
                            <tr>
                                <td>${member.id}</td>
                                <td>
                                    <a href="/member/memberList/?id=${member.id}&page=${paging.page}&q=${q}&type=${type}&memberId=${memberId}">${member.memberEmail}</a>
                                </td>
                                <td>${member.memberPassword}</td>
                                <td>${member.memberName}</td>
                                <td>${member.memberMobile}</td>
                                <td>${member.fileAttached}</td>
                                <td><a href="/member/delete?id=${member.id}">삭제</a></td>
                            </tr>
                            </c:if>
                        </c:if>
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
                                   href="/member/memberList?page=${paging.page-1}&q=${q}&type=${type}&memberId=${memberId}">[이전]</a>
                            </li>
                        </c:otherwise>
                    </c:choose>

                    <c:forEach begin="${paging.startPage}" end="${paging.endPage}" var="i" step="1">
                        <c:choose>
                            <c:when test="${i eq paging.page}">
                                <li class="page-item active">
                                    <a class="page-link">${i}</a>
                                </li>
                            </c:when>
                            <c:otherwise>
                                <li class="page-item">
                                    <a class="page-link" href="/member/memberList?page=${i}&q=${q}&type=${type}&memberId=${memberId}">${i}</a>
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
                                   href="/member/memberList?page=${paging.page+1}&q=${q}&type=${type}&memberId=${memberId}">[다음]</a>
                            </li>
                        </c:otherwise>
                    </c:choose>
                </ul>
            </div>
        </c:otherwise>
    </c:choose>
    <div class="container" id="search-area">
        <form action="/member/memberList" method="get">
            <select name="type" id="typeSelect">
                <option value="" selected disabled hidden>선택해주세요</option>
                <option value="id">id</option>
                <option value="memberEmail">이메일</option>
                <option value="memberName">이름</option>
                <option value="memberMobile">전화번호</option>
            </select>
            <input type="text" name="q" id="searchInput" placeholder="검색어를 입력하세요" disabled="disabled">
            <input type="submit" value="검색">
        </form>
    </div>
</div>
<%@include file="../component/footer.jsp" %>
</body>
<script>
    const typeSelect = document.getElementById("typeSelect");
    const searchInput = document.getElementById("searchInput");

    typeSelect.addEventListener("change", function () {
        if (typeSelect.value === "") {
            searchInput.disabled = true;
        } else {
            searchInput.disabled = false;
        }
    });
</script>
</html>