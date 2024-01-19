<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
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
				<h4 class="fw-semibold mb-8">가맹점주 관리</h4>
				<nav aria-label="breadcrumb">
					<ol class="breadcrumb">
						<li class="breadcrumb-item">
							<a class="text-muted text-decoration-none" href="/admin/main">Main</a>
						</li>
						<li class="breadcrumb-item">
			              <a class="text-muted text-decoration-none" href="/admin/FranChiseOwner/list">가맹점 관리</a>
			            </li>
						<li class="breadcrumb-item" aria-current="page">가맹점주 관리</li>
					</ol>
				</nav>
			</div>
			 <div class="col-3">
		          <div class="text-center mb-n5">
		              <img src="/resources/image/배너(누끼)_가맹점.png" alt=""
		                   class="img-fluid mb-n1" style="width: 50%; margin-top: -40px;">
		          </div>
		      </div>
		</div>
	</div>
</div>
<div class="card">
	<div class="card-body">
		<div class="table-responsive">
			<table id="adminOwnrList" class="table border table-bordered text-nowrap">
				<thead>
				<tr>
					<th class="fw-semibold mb-0 text-center">순번</th>
					<th class="fw-semibold mb-0 text-center">이름</th>
					<th class="fw-semibold mb-0 text-center">연락처</th>
					<th class="fw-semibold mb-0 text-center">이메일</th>
					<th class="fw-semibold mb-0 text-center">가입일</th>
					<th class="fw-semibold mb-0 text-center">활성여부</th>
				</tr>
				</thead>
				<tbody>
				<!-- start row -->
				<c:choose>
					<c:when test="${fn:length(dataList) > 0}">
						<c:forEach items="${dataList}" var="ownrVO" varStatus="stat">
							<tr onclick="location.href='/admin/FranChiseOwner/detail?frcsOwnrNo=${ownrVO.frcsOwnrNo}'">
								<td class="mb-0 text-center">${stat.count}</td>
								<td class="mb-0 text-center">${ownrVO.frcsOwnrNm}</td>
								<td class="mb-0 text-center">${ownrVO.frcsOwnrTel}</td>
								<td class="mb-0 text-center">${ownrVO.frcsOwnrEmail}</td>
								<td class="mb-0 text-center">${ownrVO.frcsOwnrJoinDt}</td>
								<td class="mb-0 text-center">
									<c:choose>
										<c:when test="${ownrVO.enabled == 1}">
											운영중
										</c:when>
										<c:otherwise>
											비활성
										</c:otherwise>
									</c:choose>
								</td>
							</tr>
						</c:forEach>
					</c:when>
					<c:otherwise>
						<tr>
							<td colspan="6">
								<p>등록된 가맹점주가 없습니다.</p>
							</td>
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
	$("#adminOwnrList").DataTable({
		bLengthChange: false,
		info: false,
		order: []
	});
</script>
