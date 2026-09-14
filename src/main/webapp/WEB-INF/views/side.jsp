<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지</title>
    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Bootstrap Icons -->
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    
    <style>
        /* 화면 좌측에 고정되는 날개(토글) 버튼 스타일 */
        .sidebar-toggle-btn {
            position: fixed;
            top: 50%;
            left: 0;
            transform: translateY(-50%);
            z-index: 1045;
            border-radius: 0 8px 8px 0;
            padding: 12px 8px;
            box-shadow: 2px 0 8px rgba(0,0,0,0.15);
        }
    </style>
</head>
<body>


    <button class="btn btn-primary sidebar-toggle-btn" type="button" data-bs-toggle="offcanvas" data-bs-target="#myPageSidebar" aria-controls="myPageSidebar">
        <i class="bi bi-chevron-double-right fs-5"></i>
    </button>

    <!-- 2. 접었다 폈다 하는 슬라이드 오프캔버스 사이드바 -->
    <div class="offcanvas offcanvas-start" tabindex="-1" id="myPageSidebar" aria-labelledby="myPageSidebarLabel" style="width: 280px;">
        <div class="offcanvas-header border-bottom">
            <h5 class="offcanvas-title fw-bold" id="myPageSidebarLabel">
                <i class="bi bi-person-circle me-2 text-primary"></i>마이페이지
            </h5>
            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
        </div>
        
        <div class="offcanvas-body p-3">
            <ul class="nav nav-pills flex-column gap-1">
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/myPage.do" class="nav-link active">
                        <i class="bi bi-person-gear me-2"></i> 내 정보 수정
                    </a>
                </li>
 
                <li class="nav-item">
                    <a href="${pageContext.request.contextPath}/withdraw.do" class="nav-link text-danger">
                        <i class="bi bi-box-arrow-right me-2"></i> 회원 탈퇴
                    </a>
                </li>
            </ul>
        </div>
    </div>

    <!-- Bootstrap 5 JS (오프캔버스 작동을 위해 필수) -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>