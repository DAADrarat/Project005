<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>로그인 - Team5 Project</title>
<style>
    /* 전체 레이아웃 구획 설정 */
    body {
        margin: 0;
        padding: 0;
        font-family: 'Noto Sans KR', sans-serif;
        background-color: #ffffff;
        color: #333;
    }
    
    .login-wrapper {
        min-height: 65vh;
        display: flex;
        flex-direction: column;
        justify-content: center;
        align-items: center;
        padding: 40px 20px;
    }
    
    .login-title {
        font-size: 32px;
        font-weight: 700;
        color: #1a2b4c; /* 마이페이지 상단 탭의 남색 톤 */
        margin-bottom: 30px;
        letter-spacing: -1px;
    }

    .login-card {
        width: 100%;
        max-width: 400px;
        padding: 40px;
        border: 1px solid #e2e8f0;
        border-radius: 8px;
        box-shadow: 0 4px 12px rgba(0, 0, 0, 0.05);
        background-color: #ffffff;
        box-sizing: border-box;
    }

    .input-group {
        margin-bottom: 20px;
    }

    .input-group label {
        display: block;
        font-size: 14px;
        font-weight: 600;
        color: #4a5568;
        margin-bottom: 8px;
    }

    .input-group input {
        width: 100%;
        height: 46px;
        padding: 0 14px;
        font-size: 15px;
        border: 1px solid #cbd5e0;
        border-radius: 4px;
        box-sizing: border-box;
        outline: none;
        transition: border-color 0.2s;
    }

    .input-group input:focus {
        border-color: #1e3a8a; /* 포커스 시 네이비 포인트 */
    }

    /* 로그인 버튼 (마이페이지 선택된 탭 컬러) */
    .btn-login {
        width: 100%;
        height: 48px;
        background-color: #1e3a8a;
        color: #ffffff;
        font-size: 16px;
        font-weight: 600;
        border: none;
        border-radius: 4px;
        cursor: pointer;
        margin-top: 10px;
        transition: background-color 0.2s;
    }

    .btn-login:hover {
        background-color: #172554;
    }

    /* 구분선 및 회원가입 영역 */
    .divider {
        margin: 25px 0;
        border: 0;
        height: 1px;
        background-color: #e2e8f0;
    }

    .signup-area {
        text-align: center;
    }

    .signup-text {
        font-size: 14px;
        color: #718096;
        margin-bottom: 12px;
    }

    /* 회원가입 버튼 (아웃라인 스타일) */
    .btn-signup {
        display: inline-block;
        width: 100%;
        height: 46px;
        line-height: 44px;
        text-align: center;
        background-color: #ffffff;
        color: #1e3a8a;
        font-size: 15px;
        font-weight: 600;
        border: 1px solid #1e3a8a;
        border-radius: 4px;
        text-decoration: none;
        box-sizing: border-box;
        transition: all 0.2s;
    }

    .btn-signup:hover {
        background-color: #f1f5f9;
    }
    
    .error-msg {
        color: #e53e3e;
        font-size: 13px;
        margin-bottom: 15px;
        text-align: center;
    }
</style>
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

            <form action="${pageContext.request.contextPath}/loginCheck.do" method="post">
                <div class="input-group">
                    <label for="userId">아이디</label>
                    <input type="text" id="userId" name="userId" placeholder="아이디를 입력하세요" required autocomplete="off">
                </div>

                <div class="input-group">
                    <label for="userPw">비밀번호</label>
                    <input type="password" id="userPw" name="userPw" placeholder="비밀번호를 입력하세요" required>
                </div>

                <button type="submit" class="btn-login">로그인</button>
            </form>

            <hr class="divider">

            <!-- 로그인 하단 회원가입 버튼 영역 -->
            <div class="signup-area">
                <div class="signup-text">아직 회원이 아니신가요?</div>
                <a href="${pageContext.request.contextPath}/join.do" class="btn-signup">회원가입</a>
            </div>
        </div>
    </div>

    <!-- 3. 공통 푸터 -->
    <!-- <jsp:include page="/WEB-INF/views/footer.jsp" /> -->

</body>
</html>