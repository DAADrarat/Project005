<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>마이페이지 - 정부사업일정</title>

    <!-- 1. FullCalendar v6 라이브러리 불러오기 -->
    <script src='https://cdn.jsdelivr.net/npm/fullcalendar@6.1.11/index.global.min.js'></script>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/project.css" type="text/css" />


</head>
<body>
	<jsp:include page="/WEB-INF/views/header.jsp" />
	
    <div class="sub-title-wrap">
        <div>정부사업일정</div>
    </div>

    <div class="inner">
        <!-- 상단 탭 -->
        <div class="pc-tab">
            <ul class="tab-ul01">
                <li><a href="${pageContext.request.contextPath}/calendarAll.do"><span>전체일정</span></a></li>
                <li class="active"><a href="${pageContext.request.contextPath}/calendarPolicy.do"><span>정부사업일정</span></a></li>
                <li><a href="${pageContext.request.contextPath}/calendarCertification.do"><span>자격증시험일정</span></a></li>
                <li><a href="${pageContext.request.contextPath}/calendarJob.do"><span>채용공고일정</span></a></li>
            </ul>
        </div>

        <!-- 달력 범례 -->
        <div class="board-calendar-tab">
            <div class="b-cal-cate-box">
                <ul>
                    <li class="b-bachelor"><span>정부사업일정</span></li>
                </ul>
            </div>
        </div>

        <div id="calendar"></div>

        <!-- 정책 리스트 영역 -->
        <form method="post" action="${pageContext.request.contextPath}/applyPolicy.do">
        <div class="policy-section">
            <div class="policy-left">
                <div>
                    <div class="policy-header-flex">
                        <h3>관심 정책 선택</h3>
                        <div class="search-box-crappy">
                            <input type="text" placeholder="정책 검색...">
                            <button type="button">조회</button>
                        </div>
                    </div>
                    <ul class="policy-list">
                        <c:forEach var="p" items="${policyList}">
                            <li>
                                <a href="#" title="${p.govProjectInfo}">${p.govProjectName}</a>
                                <input type="checkbox"
                                       name="govProjectCode"
                                       value="${p.govProjectCode}"
                                       data-label="${p.govProjectName}">
                            </li>
                        </c:forEach>
                        <c:if test="${empty policyList}">
                            <li class="empty-msg">등록된 정부사업 일정이 없습니다.</li>
                        </c:if>
                    </ul>
                </div>
            </div>

            <div class="policy-right">
                <div>
                    <div class="policy-header-flex">
                        <h3>내가 선택한 정책</h3>
                    </div>
                    <ul id="selected-policies">
                        <li class="empty-msg">선택된 정책이 없습니다. 왼쪽에서 체크해주세요.</li>
                    </ul>
                </div>
                <button type="submit" class="checkout-btn">선택한 정책 신청하기</button>
            </div>
        </div>
        </form>

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

                // DB에서 조회한 정부사업 일정 (컨트롤러의 model "events")
                events: [
                    <c:forEach var="e" items="${events}" varStatus="st">
                    {
                        title: '${e.title}',
                        start: '${e.startDate}'
                        <c:if test="${not empty e.endDate}">, end: '${e.endDate}'</c:if>
                    }<c:if test="${!st.last}">,</c:if>
                    </c:forEach>
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
                    li.textContent = box.dataset.label || box.value;
                    selectedList.appendChild(li);
                }
            });

            if (!isChecked) {
                selectedList.innerHTML = '<li class="empty-msg">선택된 정책이 없습니다. 왼쪽에서 체크해주세요.</li>';
            }
        }

        checkboxes.forEach(function(box) {
            box.addEventListener('change', updateSelectedPolicies);
        });
    </script>

</body>
</html>