<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원 정보 수정</title>
    <!-- 부트스트랩 CSS 포함 -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    
</head>
<body class="d-flex flex-column min-vh-100">

    <jsp:include page="/WEB-INF/views/header.jsp" />

    <div class="container flex-grow-1 my-5">
        <form action="${pageContext.request.contextPath}/edit.do" method="post">
            <table class="table table-bordered text-center align-middle w-100 mx-auto mt-4" style="max-width: 600px;">
                
                <tr>
                    <td class="bg-light text-center fw-bold fs-5 py-3" colspan="2">회원 정보 수정</td>
                </tr>
                
               
                <tr>
                    <td class="bg-light fw-bold" style="width: 30%;">이름</td>
                    <td style="width: 70%;">
                        <input type="text" name="name" value="${member.name}" class="form-control" required>
                    </td>
                </tr>
                
                
                <tr>
                    <td class="bg-light fw-bold">ID</td>
                    <td>
                        
                        <input type="text" name="userId" value="${member.userId}" class="form-control" readonly>
                    </td>
                </tr>
                

                <tr>
                    <td class="bg-light fw-bold">PW</td>
                    <td>
                        <input type="password" name="password" value="${member.password}" class="form-control" required>
                    </td>
                </tr>
                
               
                <tr>
                    <td class="bg-light fw-bold">나이</td>
                    <td>
                        <!-- [수정] userAddress -> userAge name 수정 -->
                        <input type="number" name="userAge" value="${member.userAge}" class="form-control">
                    </td>
                </tr>
                
                 <tr>
                    <td class="bg-light fw-bold">학력</td>
                    <td>
                        <input type="text" name="educationLevel" value="${member.educationLevel}" class="form-control">
                    </td>
                </tr>

                <tr>
                    <td class="bg-light fw-bold">전공</td>
                    <td>
                       
                        <input type="text" name="major" value="${member.major}" class="form-control">
                    </td>
                </tr>
                
               
                <tr>
                    <td class="bg-light fw-bold">취업상태</td>
                    <td class="text-start ps-3">
                        <div class="d-flex gap-4">
                            <label class="form-check-label">
                                <input type="radio" name="empStatus" value="Y" class="form-check-input" ${member.empStatus eq 'Y' ? 'checked' : ''}> 재직
                            </label>
                            <label class="form-check-label">
                                <input type="radio" name="empStatus" value="N" class="form-check-input" ${member.empStatus eq 'N' || empty member.empStatus ? 'checked' : ''}> 구직
                            </label>
                        </div>
                    </td>
                </tr>

               
                <tr>
                    <td colspan="2" class="p-3">
                        <button type="submit" class="btn btn-primary w-100 fw-bold py-2">수정</button>
                    </td>
                </tr>
            </table>
        </form>
    </div>

    <!-- 공통 푸터 -->
    <jsp:include page="/WEB-INF/views/footer.jsp" />

  
</body>
</html>