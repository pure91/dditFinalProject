<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
	.table-responsive {
		cursor: default;
		overflow-x: clip;
	}
	.dataTables_paginate{
		margin-top: 20px !important;
	}
	tbody > tr {
		cursor: pointer;
	}

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



<div class="card bg-info-subtle shadow-none position-relative overflow-hidden mb-4" id="bgInfoSubtle">
	<div class="card-body px-4 py-3">
		<div class="row align-items-center" id="subTitlePosition">
			<div class="col-9">
				<h4 class="fw-semibold mb-8">가맹점 조회</h4>
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item">
							<a class="text-muted text-decoration-none" href="/admin">Home</a>
						</li>
						<li class="breadcrumb-item">
			              <a class="text-muted text-decoration-none" href="/admin/FranChiseOwner/list">가맹점 관리</a>
			            </li>
						<li class="breadcrumb-item" aria-current="page">가맹점 조회</li>
					</ol>
				</nav>
			</div>
			 <div class="col-3">
		          <div class="text-center mb-n5">
		              <img src="/resources/image/배너(누끼)_커피머신.png" alt=""
		                   class="img-fluid mb-n1" style="width: 50%; margin-top: -50px;">
		          </div>
		      </div>
		</div>
	</div>
</div>
<div class="card">
	<div class="card-body">
		<div class="table-responsive">
			<table id="adminFrcsList" class="table border table-bordered text-nowrap">
				<thead>
				<tr>
					<th class="fw-semibold mb-0 text-center">순번</th>
					<th class="fw-semibold mb-0 text-center">가맹점 이름</th>
					<th class="fw-semibold mb-0 text-center">가맹점 등록 일자</th>
					<th class="fw-semibold mb-0 text-center">가맹점 지역</th>
					<th class="fw-semibold mb-0 text-center">운영상태</th>
				</tr>
				</thead>
				<tbody>
				<!-- start row -->
				<c:choose>
					<c:when test="${fn:length(dataList) > 0}">
						<c:forEach items="${dataList}" var="frcsVO" varStatus="stat">
							<tr onclick="location.href='/admin/frcs/detail?frcsNo=${frcsVO.frcsNo}'">
								<td class="mb-0 text-center">${stat.count}</td>
								<td class="mb-0 text-center">${frcsVO.frcsNm}</td>
								<td class="mb-0 text-center">
									<fmt:formatDate value="${frcsVO.frcsRgstDt}" dateStyle="medium"/>
								</td>
								<td class="mb-0 text-center">
									<c:choose>
										<c:when test="${frcsVO.frcsRegionCd == '11000'}">서울특별시</c:when>
										<c:when test="${frcsVO.frcsRegionCd == '26000'}">부산광역시</c:when>
										<c:when test="${frcsVO.frcsRegionCd == '27000'}">대구광역시</c:when>
										<c:when test="${frcsVO.frcsRegionCd == '28000'}">인천광역시</c:when>
										<c:when test="${frcsVO.frcsRegionCd == '29000'}">광주광역시</c:when>
										<c:when test="${frcsVO.frcsRegionCd == '30000'}">대전광역시</c:when>
										<c:when test="${frcsVO.frcsRegionCd == '31000'}">울산광역시</c:when>
										<c:when test="${frcsVO.frcsRegionCd == '41000'}">경기도</c:when>
										<c:when test="${frcsVO.frcsRegionCd == '42000'}">강원도</c:when>
										<c:when test="${frcsVO.frcsRegionCd == '43000'}">충청북도</c:when>
										<c:when test="${frcsVO.frcsRegionCd == '44000'}">충청남도</c:when>
										<c:when test="${frcsVO.frcsRegionCd == '45000'}">전라북도</c:when>
										<c:when test="${frcsVO.frcsRegionCd == '46000'}">전라남도</c:when>
										<c:when test="${frcsVO.frcsRegionCd == '47000'}">경상북도</c:when>
										<c:when test="${frcsVO.frcsRegionCd == '48000'}">경상남도</c:when>
										<c:when test="${frcsVO.frcsRegionCd == '50000'}">폐업</c:when>
										<c:when test="${frcsVO.frcsRegionCd == '77777'}">폐업</c:when>
									</c:choose>
								</td>
								<td class="mb-0 text-center">
									<c:choose>
										<c:when test="${frcsVO.frcsStsCd == 'FRST01'}">오픈준비</c:when>
										<c:when test="${frcsVO.frcsStsCd == 'FRST02'}">운영중</c:when>
										<c:when test="${frcsVO.frcsStsCd == 'FRST03'}">휴업</c:when>
										<c:when test="${frcsVO.frcsStsCd == 'FRST04'}">폐업</c:when>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="6">
								<p>등록된 가맹점이 없습니다.</p>
							</td>
							<td style="display: none;"></td>
							<td style="display: none;"></td>
							<td style="display: none;"></td>
							<td style="display: none;"></td>
							<td style="display: none;"></td>
						</tr>
					</c:otherwise>
				</c:choose>
				<!-- end row -->
				</tbody>
			</table>
		</div>
	</div>
</div>

<script src="/resources/bootstrap/src/assets/libs/datatables.net/js/jquery.dataTables.min.js"></script>
<script>
	$("#adminFrcsList").DataTable({
		bLengthChange: false,
		info: false,
		order: []
	});
</script>