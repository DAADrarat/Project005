<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 - Team5 Project</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/loginSide.css" type="text/css" />

</head>
<body>

      <jsp:include page="/WEB-INF/views/header.jsp" />

    <!-- 2. 로그인 본문 영역 -->
    <div class="login-wrapper">
        <h1 class="login-title">로그인</h1>

        <div class="login-card">
            <!-- 실패 메시지 출력 (필요 시 사용) -->
            <c:if test="${not empty msg}">
                <div class="error-msg">${msg}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login.do" method="post">
                <div class="input-group">
                    <label for="userId">아이디</label>
                    <input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요" required autocomplete="off">
                </div>

                <div class="input-group">
                    <label for="userPw">비밀번호</label>
                    <input type="password" id="password" name="password" placeholder="비밀번호를 입력하세요" required>
                </div>

                <button type="submit" class="btn-login">로그인</button>
            </form>

            <hr class="divider">

            <!-- 로그인 하단 회원가입 버튼 영역 -->
            <div class="signup-area">
                <div class="signup-text">아직 회원이 아니신가요?</div>
                <a href="${pageContext.request.contextPath}/signUp.do" class="btn-signup">회원가입</a>
            </div>
        </div>
    </div>

    <!-- 3. 공통 푸터 -->
     <jsp:include page="/WEB-INF/views/footer.jsp" /> 

</body>
</html>