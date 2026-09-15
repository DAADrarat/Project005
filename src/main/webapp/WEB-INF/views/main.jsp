<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>메인 화면</title>
 <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/project.css" type="text/css" />
</head>
<body>
	<jsp:include page="/WEB-INF/views/header.jsp" />

    <!-- 최상단 타이틀[cite: 4] -->
    <div class="sub-title-wrap">
        <div>청년지원 종합정보</div>
    </div>

    <!-- 1200px 넓이를 맞춰주는 달력과 동일한 컨테이너[cite: 4] -->
    <div class="inner">
        
        <!-- 4분할 사선 버튼 영역 -->
        <div class="slant-container">
            
            
            <a href="${pageContext.request.contextPath}/calendarAll.do" class="slant-box">
                <div class="slant-inner">
                    <div class="bg-img" style="background-image: url('https://images.unsplash.com/photo-1506784983877-45594efa4cbe?q=80&w=800');"></div>
                    <span class="slant-text">전체일정</span>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/calendarPolicy.do" class="slant-box">
                <div class="slant-inner">
                    <div class="bg-img" style="background-image: url('https://images.unsplash.com/photo-1434030216411-0b793f4b4173?q=80&w=800');"></div>
                    <div class="slant-text">정부사업일정</div>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/calendarCertification.do" class="slant-box">
                <div class="slant-inner">
                    <div class="bg-img" style="background-image: url('https://images.unsplash.com/photo-1454165804606-c3d57bc86b40?q=80&w=800');"></div>
                    <div class="slant-text">자격증시험일정</div>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/calendarJob.do" class="slant-box">
                <div class="slant-inner">
                    <div class="bg-img" style="background-image: url('https://images.unsplash.com/photo-1522071820081-009f0129c71c?q=80&w=800');"></div>
                    <div class="slant-text">채용공고일정</div>
                </div>
            </a>

        </div>

        <!-- 하단 마이페이지 버튼 -->
        <a href="${pageContext.request.contextPath}/myPage.do" class="mypage-container">
            <div class="mypage-bg" style="background-image: url('https://images.unsplash.com/photo-1507537297725-24a1c029d3ca?q=80&w=1200');"></div>
            <div class="slant-text">마이페이지로 이동</div>
        </a>

    </div>

</body>
</html>