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
    <h2>My Page</h2>
    <form action="/member/update" method="post" enctype="multipart/form-data" onsubmit="return check()">
        <div id="password-check">

        </div>
        <label for="member-password">비밀번호</label><br>
        <input type="text" id="member-password" name="memberPassword" value="${LoginDTO.memberPassword}"
               disabled="disabled"><br>

        <label for="member-id">아이디</label><br>
        <input type="text" id="member-id" name="id" value="${LoginDTO.id}" readonly><br>

        <label for="member-email">이메일</label><br>
        <input type="text" id="member-email" name="memberEmail" onblur="emailCheck()" value="${LoginDTO.memberEmail}" disabled="disabled"><br>
        <h5 id="member-email-bottom"></h5><br>


        <label for="member-name">이름</label><br>
        <input type="text" id="member-name" name="memberName" value="${LoginDTO.memberName}" disabled="disabled"><br>

        <label for="member-mobile">전화번호</label><br>
        <input type="text" id="member-mobile" name="memberMobile" value="${LoginDTO.memberMobile}"
               disabled="disabled"><br>
        <div id="update-priview" style="display:none;">
            <label for="member-file">사진 변경</label><br>
            <input type="file" accept="image/*" name="memberProfile" id="member-file"
                   multiple style="display: none"
                   onchange="javascript:document.getElementById('fileName').innerHTML =
                                (this.value.replace(/c:\\fakepath\\/i,''))">
            <img style="width: 100px;height: 100px;border: 1px solid black" id="preview-image"><br>
        </div>
        <div id="submit">

        </div>
    </form>
    <div id="priview">
    <c:if test="${LoginDTO.fileAttached == 1}">
        <label for="member-profile">프로필 사진</label><br>
        <div id="member-profile">
            <c:forEach items="${memberprofileDTO}" var="memberFile">
                <img src="${pageContext.request.contextPath}/upload/${memberFile.storedFileName}"
                     alt="" width="100" height="100">
            </c:forEach>
        </div>
    </c:if>
    </div>


    <button onclick="update()">수정</button>
    <button onclick="outing()">회원탈퇴</button>
    <button onclick="back()">뒤로</button>
</div>
<%@include file="../component/footer.jsp" %>
</body>
<script>
    const back = () => {
        location.href = "/";
    }
    const update = () => {
        const passwordCheck = document.getElementById("password-check");
        const submit = document.getElementById("submit");
        const priview = document.getElementById("priview");
        const memberfile = document.getElementById("update-priview");
        passwordCheck.innerHTML = "<label for='member-password-check'>비밀번호</label><br>"
            + "<input type='text' id='member-password-check' onblur=updateCheck()><br>"
        submit.innerHTML = "<input type='submit' id='submit-button' disabled='disabled' value='정보수정'>"
        priview.innerHTML="";
        memberfile.style.display="block";
    }
    const updateCheck = () => {
        const typingPassword = document.getElementById("member-password-check");
        const password = document.getElementById("member-password");
        const email = document.getElementById("member-email");
        const name = document.getElementById("member-name");
        const mobile = document.getElementById("member-mobile");
        if (typingPassword.value == "${LoginDTO.memberPassword}") {
            password.disabled = false;
            email.disabled = false;
            name.disabled = false;
            mobile.disabled = false;
        } else {
            alert("비밀번호가 다릅니다")
        }
    }
    const check = () => {
        const password = document.getElementById("member-password");
        const email = document.getElementById("member-email");
        const name = document.getElementById("member-name");
        const mobile = document.getElementById("member-mobile");
        const exp = /^(?=.*[a-z])(?=.*\d)[a-z\d]{5,10}$/;
        const mobileExp = /^(?=.*[\d])[\d]{10,11}$/;
        if (password.value.length == 0) {
            alert("수정할 비밀번호 입력")
            password.focus();
            return false;
        } else if (email.value.length == 0) {
            alert("수정할 이메일 입력")
            email.focus();
            return false;
        } else if (name.value.length == 0) {
            alert("수정할 이름 입력")
            name.focus();
            return false;
        } else if (mobile.value.length == 0) {
            alert("수정할 이메일 입력")
            mobile.focus();
            return false;
        } else if (!(password.value.match(exp))) {
            alert("비밀번호는 영문소문자 필수 , 5~10글자 이내로 완성해주세요");
            password.focus();
            return false;
        } else if (!(mobile.value.match(mobileExp))) {
            alert("전화번호 형식에 맞게 -빼고 입력해주세요");
            mobile.focus();
            return false;
        } else {
            alert("정보 수정 완료")
            return true;
        }
    }
    const outing = () => {
        if (confirm("탈퇴하시겠습니까?")) {
            alert("삭제완료")
            location.href = "/member/outing?id=${LoginDTO.id}"
        }
    }
    const emailCheck = () => {
        let typingEmail = document.getElementById("member-email").value;
        const submitButton = document.getElementById("submit-button");
        const memberEmailButtom = document.getElementById("member-email-bottom");
        $.ajax({
            type: "post",
            url: "/email-check",
            data: {
                "email_check": typingEmail
            },
            success: function () {
                if (typingEmail.length == 0) {
                    memberEmailButtom.innerText = "필수입력";
                    memberEmailButtom.style.color = "red";
                    submitButton.disabled = true;
                } else {
                    memberEmailButtom.innerText = "사용가능";
                    memberEmailButtom.style.color = "green";
                    submitButton.disabled = false;
                }
            },
            error: function () {
                memberEmailButtom.innerText = "이미 사용중인 이메일입니다";
                memberEmailButtom.style.color = "red";
                submitButton.disabled = true;
            }
        })
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

    const memberProfile = document.getElementById("member-file")
    memberProfile.addEventListener("change", e => {
        readImage(e.target)
    })
</script>
</html>