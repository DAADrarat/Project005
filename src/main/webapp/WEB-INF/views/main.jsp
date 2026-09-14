<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>메인 화면</title>
    <style>
        /* 1. 기본 전체 여백 및 폰트 설정 (달력과 동일)[cite: 4] */
        body { margin: 0; font-family: 'Malgun Gothic', '맑은 고딕', sans-serif; color: #333; padding-bottom: 100px; background-color: #fff; }
        a { text-decoration: none; color: inherit; }
        * { box-sizing: border-box; }

        /* 2. 최상단 타이틀 (달력과 동일)[cite: 4] */
        .sub-title-wrap {
            padding: 5rem 2rem; font-size: 2.5rem; font-weight: bold;
            text-align: center; border-bottom: 1px solid #eee;
        }

        /* 3. 콘텐츠 중앙 정렬 및 1200px 넓이 제한 (달력과 동일)[cite: 4] */
        .inner {
            max-width: 1200px;
            width: 100%;
            margin: 0 auto;
            padding: 2rem 20px;
        }

        /* 4. 중앙 4분할 사선 버튼 영역 */
        .slant-container {
            display: flex;
            width: 100%;
            height: 350px; /* 달력 크기에 맞춰 높이 살짝 조절 */
            gap: 15px; /* ★ 버튼 사이사이 간격 주기 */
            overflow: hidden; 
            margin-bottom: 25px; /* 하단 버튼과의 간격 */
            border-radius: 8px; /* 달력 정책 박스처럼 모서리 둥글게 */
        }

        .slant-box {
            flex: 1;
            position: relative;
            transform: skewX(-15deg); /* 사선으로 기울이기 */
            overflow: hidden; 
            cursor: pointer;
            border: 1px solid #ddd; /* 달력 테이블과 동일한 연한 테두리[cite: 4] */
            background-color: #fcfcfc;
        }
        /* 양 끝이 기울어지면서 생기는 빈 여백을 덮기 위해 밖으로 당김 */
        .slant-box:first-child { margin-left: -50px; padding-left: 50px; border-left: none; }
        .slant-box:last-child { margin-right: -50px; padding-right: 50px; border-right: none; }

        /* 사선 상자 내부 (사진 + 글자 묶음) */
        .slant-inner {
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            transform: skewX(15deg); /* 글자는 반듯하게 복구 */
            display: flex; align-items: center; justify-content: center;
        }

        /* 호버 시 확대될 배경 이미지 레이어 */
        .bg-img {
            position: absolute;
            top: -50px; left: -50px; right: -50px; bottom: -50px; /* 기울임 복구 틈새 방지 */
            background-size: cover;
            background-position: center;
            transition: transform 0.4s ease; 
            z-index: 1;
        }

        /* 글자 레이어 (달력 탭 디자인 색상 차용) */
        .slant-text {
            position: relative;
            z-index: 2;
            font-weight: bold;
            font-size: 1.3rem;
            color: #000000; /* 달력 탭 활성화 색상[cite: 4] */
            background: rgba(255,255,255,0.5); /* 글자 잘 보이게 흰색 반투명 */
            padding: 12px 25px;
            border-radius: 4px;
            pointer-events: none; 
            box-shadow: 2px 2px 5px rgba(0,0,0,0.1);        
        }

        .slant-box:hover .bg-img { transform: scale(1.15); }

        /* 5. 하단 마이페이지 버튼 */
        .mypage-container {
            width: 100%;
            height: 120px;
            position: relative;
            overflow: hidden;
            cursor: pointer;
            display: flex; align-items: center; justify-content: center;
            border: 1px solid #ddd;
            border-radius: 8px;
        }

        .mypage-bg {
            position: absolute;
            top: 0; left: 0; right: 0; bottom: 0;
            background-size: cover;
            background-position: center;
            transition: transform 0.4s ease;
            z-index: 1;
        }

        .mypage-text {
            position: relative;
            z-index: 2;
            font-weight: bold;
            font-size: 1.3rem;
            color: #000000;
            background: rgba(255, 255, 255, 0.5);
            padding: 15px 60px;
            border-radius: 4px;
            box-shadow: 2px 2px 5px rgba(0,0,0,0.2);
        }

        .mypage-container:hover .mypage-bg { transform: scale(1.15); }

    </style>
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