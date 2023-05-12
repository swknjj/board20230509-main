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
    <script src="https://code.jquery.com/jquery-3.6.1.min.js"></script>
</head>
<body>
<%@include file="../component/header.jsp" %>
<%@include file="../component/nav.jsp" %>
<div id="section" style="text-align: center">
    <h2>회원가입 정보</h2>
    <form action="/member/save" method="post" enctype="multipart/form-data" onsubmit="return check()">
        <label for="member-email">이메일 입력</label><br>
        <input type="text" id="member-email" name="memberEmail" onblur="emailCheck()" placeholder="필수입력 , 중복불가"><br>
        <h5 id="member-email-bottom"></h5><br>

        <label for="member-password">비밀번호 입력</label><br>
        <input type="text" id="member-password" name="memberPassword" placeholder="영문소문자 필수 5~10글자"><br>

        <label for="member-password-check">비밀번호 확인</label><br>
        <input type="text" id="member-password-check" placeholder="비밀번호와 같아야 합니다"><br>

        <label for="member-name">이름 입력</label><br>
        <input type="text" id="member-name" name="memberName"><br>

        <label for="member-mobile">전화번호 입력</label><br>
        <input type="text" id="member-mobile" name="memberMobile" placeholder="형식 - 빼고 입력"><br>

        <label for="member-profile">프로필 사진</label><br>
        <input type="file" accept="image/*" name="memberProfile" id="member-profile"
               multiple style="display: none"
               onchange="javascript:document.getElementById('fileName').innerHTML =
                                (this.value.replace(/c:\\fakepath\\/i,''))">
        <img style="width: 100px;height: 100px;border: 1px solid black" id="preview-image"><br>

        <input type="submit" id="submit-button" disabled="disabled" value="회원가입">
        <button onclick="back()">취소</button>
    </form>
</div>
<%@include file="../component/footer.jsp" %>
</body>
<script>
    // 뒤로가기 버튼 함수
    const back = () => {
        location.href = "../../..";
    }
    // 이메일 중복 체크
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

    // 빈곳 없는지 체크후 submit
    const check = () => {
        const email = document.getElementById("member-email");
        const password = document.getElementById("member-password");
        const passwordCheck = document.getElementById("member-password-check");
        const name = document.getElementById("member-name");
        const mobile = document.getElementById("member-mobile");
        const exp = /^(?=.*[a-z])(?=.*\d)[a-z\d]{5,10}$/;
        const mobileExp = /^(?=.*[\d])[\d]{10,11}$/;
        if (email.value.length == 0) {
            alert("이메일을 입력해주세요");
            email.focus();
            return false;
        } else if (password.value.length == 0) {
            alert("비밀번호를 입력해주세요");
            password.focus();
            return false;
        } else if (!(password.value.match(exp))) {
            alert("비밀번호는 영문소문자 필수 , 5~10글자 이내로 완성해주세요");
            password.focus();
            return false;
        } else if (!(mobile.value.match(mobileExp))) {
            alert("전화번호 형식에 맞게 -빼고 입력해주세요");
            mobile.focus();
            return false;
        } else if (passwordCheck.value.length == 0) {
            alert("비밀번호 확인을 입력해주세요");
            passwordCheck.focus();
            return false;
        } else if (name.value.length == 0) {
            alert("이름을 입력해주세요");
            name.focus();
            return false;
        } else if (mobile.value.length == 0) {
            alert("전화번호를 입력해주세요");
            mobile.focus();
            return false;
        } else if (password.value != passwordCheck.value) {
            alert("비밀번호와 비밀번호 확인이 다릅니다");
            return false;
        } else {
            alert("회원가입 완료");
            return true;
        }
    }

    // 프로필 사진이 입력받았을때
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

    const memberProfile = document.getElementById("member-profile")
    memberProfile.addEventListener("change", e => {
        readImage(e.target)
    })
</script>
</html>
