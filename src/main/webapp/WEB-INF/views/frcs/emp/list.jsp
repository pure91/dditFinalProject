<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>

<!-- 로그인 정보 긁어오기 -->
<sec:authorize access="isAuthenticated()">
    <sec:authentication property="principal.ownerVO" var="franchiseOwnerVO"/>
</sec:authorize>

<%-- <p>${data}</p> --%>
<%-- <p>${comDetCodeInfoVOList2}</p> --%>
<%-- <p>${franchiseOwnerVO}</p> --%>
<style>
#leave{
	margin-left:7px;
}
/* 서브타이틀S  */
#subTitleBg {
    background: linear-gradient(45deg, #eae1f4, #e5e3ff)!important;
    height: 125px;
}
#subTitlePosition{
	height: 100%; /* 기존 이미지가 사라지면서 틀어지는 부분 */
}

#subTitleTxt{
	color :#5a6a85bf;
}
/* 서브타이틀E  */
</style>

<!-- 서브타이틀  -->
<div class="card bg-info-subtle shadow-none position-relative overflow-hidden mb-4" id="subTitleBg">
  <div class="card-body px-4 py-3">
    <div class="row align-items-center" id="subTitlePosition">
      <div class="col-9">
        <h4 class="fw-semibold mb-8">직원관리</h4>
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb">
            <li class="breadcrumb-item">
              <a class="text-muted text-decoration-none" href="/frcs/main">Main</a>
            </li>
            <li class="breadcrumb-item" aria-current="page">
            	<a class="text-muted text-decoration-none">조직관리</a>
            </li>
<!--             <li class="breadcrumb-item" aria-current="page"> -->
<!--                <a class="text-muted text-decoration-none" href="/frcs/publicdues/main">공과금 등록</a> -->
<!--             </li> -->
          </ol>
        </nav>
      </div>
      <div class="col-3">
        <div class="text-center mb-n5">
<!--           <img src="../../../resources/bootstrap/src/assets/images/breadcrumb/ChatBc.png" alt="" class="img-fluid mb-n4"> -->
        </div>
      </div>
    </div>
  </div>
</div>
	
	<div class="emp-card-body">
              <div class="emp-row">
              <!-- 포이치 진행시켜!@!!!!!!!!!!!!!  -->
              <c:forEach var="franchiseEmployeeVO" items="${data}">
                <div class="emp-col-md-4">
                  <div class="emp-card">
                    <img src="/resources/upload/frcsEmp/${franchiseEmployeeVO.atchFileVOList[0].streFileNm}" width="400px" height="400px" class="emp-card-img-top" alt="...">
                    <div class="card-body">
                      <h5 class="card-title">${franchiseEmployeeVO.frcsEmpNm}</h5>
                      
                      <p class="card-text">${franchiseEmployeeVO.frcsEmpBrdt}</p>
                      <p class="card-text">${franchiseEmployeeVO.frcsEmpTel}</p>
                      <br/>
                      
                      <c:set var="frcsEmpTypeCd">
							<c:choose>
								<c:when test="${franchiseEmployeeVO.frcsEmpTypeCd eq 'WKTP01'}">주간</c:when>
								<c:when test="${franchiseEmployeeVO.frcsEmpTypeCd eq 'WKTP02'}">야간</c:when>
								<c:when test="${franchiseEmployeeVO.frcsEmpTypeCd eq 'WKTP03'}">주말</c:when>
								<c:otherwise>매니저</c:otherwise>
							</c:choose>
					  </c:set>
                      
                      <p class="card-text">${frcsEmpTypeCd}</p>
                    
                      <button type="button" class="btn btn-primary"><a href="/frcs/emp/detail?frcsEmpNo=${franchiseEmployeeVO.frcsEmpNo}">상세 정보</a></button>
					  <button type="button" class="btn btn-primary"><a href="/frcs/emp/calendar?frcsEmpNo=${franchiseEmployeeVO.frcsEmpNo}">근무 일정</a></button>
                    </div>
                  </div>
              </div>
              <!-- 🚪 포이치 닫아 🚪 -->   </c:forEach>
            </div>
<!--             /resources/bootstrap/src/assets/images/frcs/2023/12/07/b901601c-7fab-45c8-a8ba-5283b4901942_kimgoeun.jpg -->
            
     </div>
     			<div class="emp-btn-group">
				<button type="button" class="btn mb-1 waves-effect waves-light btn-outline-primary"><a href="/frcs/emp/create">직원 등록</a>
                </button>
<!-- 				<button type="button" class="btn mb-1 waves-effect waves-light btn-outline-danger" id="leave">퇴사 -->
<!--                 </button> -->
                </div>
	
<ul class="pagination" style="display:flex; justify-content:center;">
    <c:if test="${pagingHandler.currentPage gt 1}">
        <li class="page-item">
            <a class="page-link" href="<c:url value='/frcs/emp/list'><c:param name='currentPage' value='${pagingHandler.currentPage - 1}'/></c:url>" aria-label="Previous">
                <span aria-hidden="true">&laquo;</span>
            </a>
        </li>
    </c:if>

    <c:forEach var="i" begin="1" end="${pagingHandler.totalPage}">
        <li class="page-item <c:if test='${currentPage eq i}'>active</c:if>">
            <a class="page-link" href="<c:url value='/frcs/emp/list'><c:param name='currentPage' value='${i}'/></c:url>"><c:out value='${i}'/></a>
        </li>
    </c:forEach>

    <c:if test="${pagingHandler.currentPage lt pagingHandler.totalPage}">
        <li class="page-item">
            <a class="page-link" href="<c:url value='/frcs/emp/list'><c:param name='currentPage' value='${pagingHandler.currentPage + 1}'/></c:url>" aria-label="Next">
                <span aria-hidden="true"> &raquo;</span>
            </a>
        </li>
    </c:if>
</ul>
	

