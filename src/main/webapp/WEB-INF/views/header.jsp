<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- [추가] 부트스트랩 CSS & JS (어느 페이지에서 불러와도 스타일이 안 깨지도록 지정) -->
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>

<nav class="navbar navbar-expand-lg navbar-light bg-light border-bottom">
  <div class="container-fluid">
    <!-- 1. 제일 왼쪽: 로고 위치 -->
    <a class="navbar-brand fw-bold" href="${pageContext.request.contextPath}/main.do">
      <span class="text-primary">LOGO</span>
    </a>

    <!-- 모바일 반응형 토글 버튼 -->
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>

    <div class="collapse navbar-collapse" id="navbarSupportedContent">
      <!-- 오른쪽 메뉴 영역 (ms-auto 적용) -->
      <ul class="navbar-nav ms-auto mb-2 mb-lg-0 align-items-center gap-2">
      
        <!-- 4. 정보 (드롭다운: 정책, 시험, 채용) -->
        <li class="nav-item dropdown">
          <a class="nav-link dropdown-toggle" href="#" id="infoDropdown" role="button" data-bs-toggle="dropdown" aria-expanded="false">
            정보
          </a>
          <ul class="dropdown-menu dropdown-menu-end" aria-labelledby="infoDropdown">
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/calendarPolicy.do">정책</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/calendarCertification.do">시험</a></li>
            <li><a class="dropdown-item" href="${pageContext.request.contextPath}/calendarJob.do">채용</a></li>
          </ul>
        </li>
        
        <!-- 3. 마이페이지 -->
        <li class="nav-item">
          <a class="nav-link" href="${pageContext.request.contextPath}/myPage.do">마이페이지</a>
        </li>

        <!-- 2. 로그인 버튼 -->
        <c:if test="${not empty sessionScope.userId}">
        	<a href="logout.do" class="header-link">로그아웃</a>
        </c:if>
        
        <c:if test="${empty sessionScope.userId}">
  			<a href="login.do" class="header-link">로그인</a>
		</c:if>
        

      </ul>
    </div>
  </div>
</nav>