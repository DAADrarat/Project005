<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지 - 자격증시험일정</title>

    <!-- 1. FullCalendar v6 라이브러리 불러오기 -->
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>

    <style>
        /* 기본 전체 여백 및 폰트 설정 */
        body { margin: 0; font-family: 'Malgun Gothic', '맑은 고딕', sans-serif; color: #333; padding-bottom: 100px; }
        a { text-decoration: none; color: inherit; }
        ul { list-style: none; padding: 0; margin: 0; }
        p { margin: 0; }

        /* 최상단 타이틀 */
        .sub-title-wrap { padding: 5rem 2rem; font-size: 2.5rem; font-weight: bold; text-align: center; border-bottom: 1px solid #eee; }
        
        /* 콘텐츠 중앙 정렬 및 넓이 제한 */
        .inner { max-width: 1200px; width: 100%; margin: 0 auto; padding: 2rem 20px; box-sizing: border-box; }

        /* 탭 버튼 */
        .pc-tab { margin-bottom: 40px; }
        .tab-ul01 { display: flex; border: 1px solid #ddd; border-radius: 4px; overflow: hidden; }
        .tab-ul01 li { flex: 1; text-align: center; border-right: 1px solid #ddd; }
        .tab-ul01 li:last-child { border-right: none; }
        .tab-ul01 li a { display: block; padding: 16px 0; font-size: 1.1rem; font-weight: 500; background: #fff; }
        .tab-ul01 li.active a { background: #213c7a; color: white; font-weight: bold; } 

        /* 캘린더 상단 메뉴 */
        .board-calendar-tab { display: flex; justify-content: flex-end; margin-bottom: 15px; }
        .b-cal-cate-box ul { display: flex; gap: 15px; }
        .b-cal-cate-box li { display: flex; align-items: center; font-size: 14px; font-weight: bold; }
        
        #b-bachelor-1::before {
            content: ''; 
            display: inline-block; 
            width: 14px; 
            height: 14px;
            margin-right: 6px; 
            background-color: #ffc107; 
            border: 1px solid #e0a800;
        }

        /* FullCalendar 전용 커스텀 스타일 */
        #calendar { margin-bottom: 50px; }
        .fc-toolbar-title { font-size: 2rem !important; font-weight: 500 !important; letter-spacing: 2px; }
        .fc-col-header-cell-cushion { padding: 15px 0 !important; font-size: 16px; }
        
        .fc-day-sun .fc-col-header-cell-cushion, .fc-day-sun .fc-daygrid-day-number { color: #e63946 !important; text-decoration: none;} 
        .fc-day-sat .fc-col-header-cell-cushion, .fc-day-sat .fc-daygrid-day-number { color: #3a86ff !important; text-decoration: none;} 
        .fc-daygrid-day-number { font-size: 15px; font-weight: 500; padding: 8px !important; text-decoration: none; color: #333;}
        
        .fc-h-event { border: none; border-radius: 3px; padding: 2px 4px; font-weight: 600; font-size: 13px; margin-bottom: 3px; cursor: pointer; }

        /* 정책 영역 디자인 */
        .policy-section { display: flex; gap: 30px; margin-top: 40px; padding-top: 40px; border-top: 2px solid #333; }
        .policy-left, .policy-right { flex: 1; border: 1px solid #ddd; border-radius: 8px; padding: 30px; background-color: #fcfcfc; display: flex; flex-direction: column; justify-content: space-between; }
        
        .policy-header-flex { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; border-bottom: 2px solid #213c7a; padding-bottom: 10px; }
        .policy-section h3 { margin: 0; font-size: 1.3rem; color: #213c7a; }
        
        /* 검색바 디자인 */
        .search-box-crappy { display: flex; gap: 5px; }
        .search-box-crappy input { padding: 4px 8px; border: 1px solid #999; font-size: 0.9rem; outline: none; }
        .search-box-crappy button { padding: 4px 10px; background: #e0e0e0; border: 1px solid #777; cursor: pointer; font-size: 0.9rem; font-weight: bold; }
        .search-box-crappy button:active { background: #ccc; }

        .policy-list li { display: flex; justify-content: space-between; align-items: center; padding: 15px 0; border-bottom: 1px dashed #ccc; font-size: 1.1rem; }
        .policy-list li:last-child { border-bottom: none; }
        .policy-list a { text-decoration: underline; text-underline-offset: 4px; }
        .policy-list a:hover { color: #e0a800; font-weight: bold; }
        .policy-list input[type="checkbox"] { width: 20px; height: 20px; cursor: pointer; }
        
        #selected-policies { flex-grow: 1; margin-bottom: 20px; }
        #selected-policies li { padding: 12px 15px; margin-bottom: 10px; background-color: #213c7a; color: white; border-radius: 4px; font-weight: bold; font-size: 1.1rem; box-shadow: 2px 2px 5px rgba(0,0,0,0.1); }
        #selected-policies .empty-msg { background-color: transparent; color: #999; box-shadow: none; font-weight: normal; padding: 0; }

        /* 장바구니 확정(구매) 버튼 느낌의 하단 파란색 액션 버튼 */
        .checkout-btn {
            width: 100%;
            padding: 15px;
            background-color: #213c7a;
            color: #fff;
            border: none;
            border-radius: 4px;
            font-size: 1.1rem;
            font-weight: bold;
            cursor: pointer;
            box-shadow: 0 4px 6px rgba(0,0,0,0.15);
            text-align: center;
            transition: background 0.2s;
        }
        .checkout-btn:hover { background-color: #162a56; }
    </style>
</head>
<body>
	<jsp:include page="/WEB-INF/views/header.jsp" />
	
    <div class="sub-title-wrap">
        <div>자격증시험일정</div>
    </div>

    <div class="inner">
        <!-- 상단 탭 -->
        <div class="pc-tab">
            <ul class="tab-ul01">
                <li><a href="${pageContext.request.contextPath}/calendarAll.do"><span>전체일정</span></a></li>
                <li><a href="${pageContext.request.contextPath}/calendarPolicy.do"><span>정부사업일정</span></a></li>
                <li class="active"><a href="${pageContext.request.contextPath}/calendarCertification.do"><span>자격증시험일정</span></a></li>
                <li><a href="${pageContext.request.contextPath}/calendarJob.do"><span>채용공고일정</span></a></li>
            </ul>
        </div>

        <!-- 달력 범례 -->
        <div class="board-calendar-tab">
            <div class="b-cal-cate-box">
                <ul>
                    <li class="b-bachelor" id="b-bachelor-1"><span>자격증일정</span></li>                    
                </ul>
            </div>
        </div>

        <div id="calendar"></div>

        <!-- 자격증 리스트 영역 -->
        <div class="policy-section">
            <div class="policy-left">
                <div>
                    <div class="policy-header-flex">
                        <h3>관심 자격증 선택</h3>
                        <div class="search-box-crappy">
                            <input type="text" placeholder="자격증 검색...">
                            <button type="button">조회</button>
                        </div>
                    </div>
                    <ul class="policy-list">
                        <li>
                            <a href="https://www.example.com/cert1" target="_blank">[Q-Net] 정기 기사 3회 실기</a>
                            <input type="checkbox" value="[Q-Net] 정기 기사 3회 실기">
                        </li>
                        <li>
                            <a href="https://www.example.com/cert2" target="_blank">제80회 한국사능력검정시험</a>
                            <input type="checkbox" value="제80회 한국사능력검정시험">
                        </li>
                        <li>
                            <a href="https://www.example.com/cert3" target="_blank">제512회 TOEIC 정기시험</a>
                            <input type="checkbox" value="제512회 TOEIC 정기시험">
                        </li>
                    </ul>
                </div>
            </div>

            <div class="policy-right">
                <div>
                    <div class="policy-header-flex">
                        <h3>내가 선택한 자격증</h3>
                    </div>
                    <ul id="selected-policies">
                        <li class="empty-msg">선택된 자격증이 없습니다. 왼쪽에서 체크해주세요.</li>
                    </ul>
                </div>
                <button type="button" class="checkout-btn">선택한 자격증 접수하기</button>
            </div>
        </div>

    </div>

    <script>
        document.addEventListener('DOMContentLoaded', function() {
            const calendarEl = document.getElementById('calendar');

            const calendar = new FullCalendar.Calendar(calendarEl, {
                initialView: 'dayGridMonth',
                initialDate: '2026-09-01',
                locale: 'ko',
                
                headerToolbar: {
                    left: 'prev',
                    center: 'title',
                    right: 'next'
                },

                eventBackgroundColor: '#ffe4e8', 
                eventTextColor: '#d63353',       
                displayEventTime: false, 

                events: [
                    { title: '[Q-Net] 2026년 정기 기사 3회 실기 원서접수', start: '2026-09-02', end: '2026-09-06', color: '#ffc107', textColor: '#000' },
                    { title: '제80회 한국사능력검정시험일', start: '2026-09-19', color: '#ffc107', textColor: '#000' },
                    { title: '제512회 TOEIC 정기시험', start: '2026-09-27', color: '#ffc107', textColor: '#000' }
                ]
            });

            calendar.render();
        });

        const checkboxes = document.querySelectorAll('.policy-list input[type="checkbox"]');
        const selectedList = document.getElementById('selected-policies');

        function updateSelectedPolicies() {
            selectedList.innerHTML = '';
            let isChecked = false; 

            checkboxes.forEach(function(box) {
                if (box.checked) {
                    isChecked = true;
                    const li = document.createElement('li');
                    li.textContent = box.value;
                    selectedList.appendChild(li);
                }
            });

            if (!isChecked) {
                selectedList.innerHTML = '<li class="empty-msg">선택된 자격증이 없습니다. 왼쪽에서 체크해주세요.</li>';
            }
        }

        checkboxes.forEach(function(box) {
            box.addEventListener('change', updateSelectedPolicies);
        });
    </script>

</body>
</html>