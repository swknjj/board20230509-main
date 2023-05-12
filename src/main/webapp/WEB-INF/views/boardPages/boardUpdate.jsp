
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
  <h2>글 수정</h2><br>
  <form action="/board/update" method="post" enctype="multipart/form-data" onsubmit="return check()">
    <input type="text" id="board-Id" name="id" value="${boardDTO.id}" style="display:none;"><br>
    <label for="board-writer">글 작성자</label><br>
    <input type="text" id="board-writer" name="boardWriter" readonly value="${sessionScope.loginEmail}"><br>
    <textarea id="board-title" name="boardTitle" placeholder="수정할 제목 입력" style="width: 50%; height: 10%"></textarea><br>
    <textarea id="board-contents" name="boardContents" placeholder="수정할 내용 입력" style="width: 50%; height: 30%"></textarea><br>
    <label for="board-profile">사진 변경</label><br>
    <input type="file" accept="image/*" name="boardProfile" id="board-profile"
           multiple style="display: none"
           onchange="javascript:document.getElementById('fileName').innerHTML =
                                (this.value.replace(/c:\\fakepath\\/i,''))">
    <img style="width: 100px;height: 100px;border: 1px solid black" id="preview-image"><br>
    <c:if test="${boardDTO.fileAttached == 1}">
      <div id="board-profile">
        <label for="board-profile">등록된 사진</label><br>
        <c:forEach items="${boardFileDTO}" var="boardFile">
          <img src="${pageContext.request.contextPath}/upload/${boardFile.storedFileName}"
               alt="" width="100" height="100">
        </c:forEach>
      </div>
    </c:if>
    <input type="submit" value="수정하기">
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
  const check = () => {
    const title = document.getElementById("board-title");
    const contents= document.getElementById("board-contents");
    if(title.value.length==0){
      alert("제목을 작성해주세요")
      title.focus();
      return false;
    }else if(contents.value.length==0){
      alert("내용을 작성해주세요")
      contents.focus();
      return false;
    }else {
      alert("수정 완료")
      return true;
    }
  }
  function readImage(input) {
    if (input.files && input.files[0]) {
      const reader = new FileReader()
      reader.onload = e => {
        const previewImage = document.getElementById("preview-image")
        previewImage.src = e.target.result
      }
      reader.readAsDataURL(input.files[0])
    }
  }

  const boardProfile = document.getElementById("board-profile")
  boardProfile.addEventListener("change", e => {
    readImage(e.target)
  })
</script>
</html>