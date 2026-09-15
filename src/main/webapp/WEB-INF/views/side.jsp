<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!-- 사이드바 열기 버튼 -->
<button class="btn btn-primary sidebar-toggle-btn" type="button" data-bs-toggle="offcanvas" data-bs-target="#myPageSidebar" aria-controls="myPageSidebar">
    <i class="bi bi-chevron-double-right fs-5"></i>
</button>

<!-- 마이페이지 Offcanvas 사이드바 -->
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
                <a href="${pageContext.request.contextPath}/edit.do" class="nav-link active">
                    <i class="bi bi-person-gear me-2"></i> 내 정보 수정
                </a>
            </li>
            
            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/badge.do" class="nav-link text-dark">
                    <i class="bi bi-award me-2"></i> 자격증 수집
                </a>
            </li>

            <li class="nav-item">
                <a href="${pageContext.request.contextPath}/remove.do" class="nav-link text-danger">
                    <i class="bi bi-box-arrow-right me-2"></i> 회원 탈퇴
                </a>
            </li>
        </ul>
    </div>
</div>