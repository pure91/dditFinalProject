<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags"%>

<link rel="stylesheet" href="/resources/bootstrap/src/assets/libs/prismjs/themes/prism-okaidia.min.css">

<style>
/* 배너 위아래 크기 고정 */
#bgInfoSubtle{
	height : 125px;
	background: linear-gradient(45deg, #d5f3f2, #e0f6fb)!important;
}

/* 배너 안에 글씨 위치 고정 */
#subTitlePosition{
	height: 100%
}
</style>

<div class="body-wrapper">
 <div class="container-fluid" style="padding: unset;">
   <div class="card bg-info-subtle shadow-none position-relative overflow-hidden mb-4" id="bgInfoSubtle">
  <div class="card-body px-4 py-3">
    <div class="row align-items-center" id="subTitlePosition">
      <div class="col-9">
        <h4 class="fw-semibold mb-8">공문 발신함</h4>
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb">
            <li class="breadcrumb-item">
              <a class="text-muted text-decoration-none" href="/frcs/main">Main</a>
            </li>
            <li class="breadcrumb-item">
              <a class="text-muted text-decoration-none" href="/admin/offDoc/create">공문 관리</a>
            </li>
            <li class="breadcrumb-item" aria-current="page">공문 발신함</a>
            </li>
          </ol>
        </nav>
      </div>
	<div class="col-3">
		<div class="text-center mb-n5">
			<img style="width: 50%; margin-top:-20px;"
				src="/resources/image/배너(누끼)_레터.png"
				alt="" class="img-fluid mb-n4">
		</div>
	</div>
    </div>
  </div>
</div>

          <div class="product-list">
            <div class="card">
              <div class="card-body p-3">
				<div class="d-flex justify-content-between align-items-center mb-9">
					<form class="position-relative">
						<input type="text" class="form-control search-chat py-2 ps-5" 
							id="text-srh" placeholder="Search Product">
						<i class="ti ti-search position-absolute top-50 start-0 translate-middle-y fs-6 text-dark ms-3"></i>
					</form>
						<button type="button" id="btnAdd"
							class="btn btn-primary btn-rounded mb-1 createModal"
							data-bs-toggle="modal">
							<a href="/admin/offDoc/create" style="color:white">
								<i class="ti ti-plus" style="margin-right: 5px;"></i>공문 쓰기
							</a>
						</button>
				</div>
					<div class="table-responsive border rounded">
                  <table class="table align-middle text-nowrap mb-0">
                    <thead> <!-- 제목 부분 -->
                      <tr>
                        <th class="text-center" scope="col">번호</th>
                        <th class="text-start" scope="col">제목</th>
                        <th class="text-center" scope="col">작성일</th>
                        <th class="text-center" scope="col">작성자</th>
                        <th class="text-center" scope="col">수신 가맹점</th>
                        <th class="text-center" scope="col">확인여부</th>
                      </tr>
                    </thead>
                    
                    <tbody><!-- 리스트 부분 -->
                    <c:forEach var="offDocVO" items="${offDocVOList}" varStatus="status">    
                      <tr>
                        <td class="text-center">
                        	<p class="mb-0">${offDocVO.offDocNo}</p>
                        </td>
                        <td class="text-start">
                        	<p class="mb-0"><a href="/admin/offDoc/detail?offDocNo=${offDocVO.offDocNo}">${offDocVO.offDocTitle}</a></p>
                        </td>
                        <td class="text-center">
                        	<p class="mb-0"><fmt:formatDate value="${offDocVO.offDocFwdDt}" pattern="yyyy. MM. dd" /></p>
                        </td>
                        <td class="text-center">
                        	<p class="mb-0">${offDocVO.offDocFromNm}</p>
                        </td>
                        <td class="text-center">
                        	<p class="mb-0">${offDocVO.offDocToNm}</p>
                        </td>
                        <td class="text-center">
                          <h6 class="mb-0 fs-4">${offDocVO.offDocStatusYn eq 'Y' ? '<span class="badge text-bg-primary">확인</span>' : '-'}</h6>
                        </td>
                      </tr>
                      </c:forEach>

                    </tbody>
                  </table>
                  <!-- 페이지네이션 -->
                  <div class="d-flex align-items-center justify-content-end py-1">
                    <p class="mb-0 fs-2">Rows per page:</p>
                    <select class="form-select w-auto ms-0 ms-sm-2 me-8 me-sm-4 py-1 pe-7 ps-2 border-0" aria-label="Default select example">
                      <option selected="">5</option>
                      <option value="1">10</option>
                      <option value="2">25</option>
                    </select>
                    <p class="mb-0 fs-2">1–5 of 12</p>
                    <nav aria-label="...">
                      <ul class="pagination justify-content-center mb-0 ms-8 ms-sm-9">
                        <li class="page-item p-1">
                          <a class="page-link border-0 rounded-circle text-dark fs-6 round-32 d-flex align-items-center justify-content-center" href="#"><i class="ti ti-chevron-left"></i></a>
                        </li>
                        <li class="page-item p-1">
                          <a class="page-link border-0 rounded-circle text-dark fs-6 round-32 d-flex align-items-center justify-content-center" href="#"><i class="ti ti-chevron-right"></i></a>
                        </li>
                      </ul>
                    </nav>
                  </div>
                </div>

              </div>
            </div>
          </div>
        </div>
      </div>



<script src="/resources/bootstrap/src/assets/libs/prismjs/prism.js"></script>
<script src="/resources/bootstrap/src/assets/js/widget/ui-card-init.js"></script>
<script type="text/javascript">



</script>
