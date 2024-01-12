<%@ page import="java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
    #list-paging-area{
        margin-top: 20px;
        display: flex;
        justify-content: center;
    }
    #list-paging-area > div{
        display: flex;
        justify-content: center;
    }
    #up-table-group{
        margin-bottom: 20px;
    }
    #insert-btn-area{
        display: flex;
        justify-content: end;
    }
    #frm{
        margin: 0;
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
/* .aaa { */
/* 	padding-right:10px; */
/* } */
</style>

<div class="card bg-info-subtle shadow-none position-relative overflow-hidden mb-4" id="bgInfoSubtle">
    <div class="card-body px-4 py-3">
        <div class="row align-items-center" id="subTitlePosition">
            <div class="col-9">
                <h4 class="fw-semibold mb-8">메뉴 관리</h4>
                <nav aria-label="breadcrumb">
                    <ol class="breadcrumb">
                        <li class="breadcrumb-item">
                            <a class="text-muted text-decoration-none" href="/admin/main">Main</a>
                        </li>
                        <li class="breadcrumb-item text-muted" aria-current="page">메뉴 관리</li>
                    </ol>
                </nav>
            </div>
            <div class="col-3">
			<div class="text-center mb-n5">
				<img style="width: 45%; margin-top:-25px;"
					src="/resources/image/배너(누끼)_원두.png"
					alt="" class="img-fluid mb-n3">
			</div>
		</div>
        </div>
    </div>
</div>

<div class="card">
    <div class="card-body">
        <div id="up-table-group" class="row">
            <div class="col-sm-3">
                <form id="frm">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="메뉴명" name="keyword" aria-label="" aria-describedby="basic-addon1">
                        <button class="btn bg-info-subtle text-info font-medium" type="submit"><i class='bx bx-search-alt-2'></i></button>
                    </div>
                </form>
            </div>
            <div class="col" id="insert-btn-area">
                <a type="button" class="btn btn-primary" href="/admin/menu/registration">메뉴등록</a>
            </div>
        </div>
        <table class="table border text-nowrap customize-table mb-0 align-middle">
            <thead class="text-dark fs-4">
            <tr class="col-12">
                <th class="col-1">
                    <h6 class="fs-4 fw-semibold mb-0 text-center">번호</h6>
                </th>
                <th class="col-1">
                    <h6 class="fs-4 fw-semibold mb-0 text-center">메뉴 사진</h6>
                </th>
                <th class="col-2">
                    <h6 class="fs-4 fw-semibold mb-0 text-start">메뉴명</h6>
                </th>
                <th class="col-1">
                    <h6 class="fs-4 fw-semibold mb-0 text-center">카테고리</h6>
                </th>
                <th class="col-1"> 
                    <h6 class="fs-4 fw-semibold mb-0 text-center">가격</h6>
                </th>
                <th class="col-1">
                    <h6 class="fs-4 fw-semibold mb-0 text-center">출시일</h6>
                </th>
                <th class="col-1">
                    <h6 class="fs-4 fw-semibold mb-0 text-center">판매상태</h6>
                </th>
                <th class="col-1">
                    <h6 class="fs-4 fw-semibold mb-0 text-center">비고</h6>
                </th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${menuList.content}" var="menu">
                <tr>
                    <td class="fs-4 mb-0 text-center" style="vertical-align: middle;">
                        <div>
                            ${menu.menuNo}
                        </div>
                    </td>
                    <td class="fs-4 mb-0 text-center" style="vertical-align: middle;">
                        <div>
                            <img src="/resources/upload/menu/${menu.atchFileVO.streFileNm}"
                                 class="rounded-circle" width="40" height="40">
                        </div>
                    </td>
                    <td class="fs-4 mb-0 text-start" style="vertical-align: middle;">
                        <div>
                                ${menu.menuNm}
                        </div>
                    </td>
                    <td class="fs-4 mb-0 text-center" style="vertical-align: middle;">
                        <div>
                            ${menu.ctgryDetailVO.ctgryDetailNm}
                        </div>
                    </td>
                    <td class="fs-4 mb-0 text-end">
                        <div style="margin-right:30px;">
                        	<fmt:formatNumber value="${menu.menuPrice}" pattern="#,###" />원
                        </div>
                    </td>
                    <td class="fs-4 mb-0 text-center">
                        <div>
                            <fmt:formatDate value="${menu.menuStrtDt}" dateStyle="medium"/>
                        </div>
                    </td>
                    <td class="fs-4 mb-0 text-center">
                        <c:set var="now" value="<%=new Date()%>"/>
                        <c:choose>
                            <c:when test="${menu.menuStrtDt > now}">
                                <span class="badge bg-Warning-subtle text-Warning fw-semibold fs-2">판매준비중</span>
                            </c:when>
                            <c:when test="${menu.menuStrtDt < now && (menu.menuEndDt > now || menu.menuEndDt == null)}">
                                <span class="badge bg-success-subtle text-success fw-semibold fs-2">판매중</span>
                            </c:when>
                            <c:otherwise>
                                <span class="badge bg-Dark-subtle fw-semibold fs-2">단종</span>
                            </c:otherwise>
                        </c:choose>
                    </td>
                    <td style="text-align : center;">
                        <a class="btn btn-primary" href="/admin/menu/detail?menuNo=${menu.menuNo}">상세보기</a>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div id="list-paging-area">
            ${menuList.getPagingArea()}
        </div>
    </div>
</div>