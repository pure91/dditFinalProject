<%@ page import="java.util.Date" %>
<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<style>
	
	table {
		text-align: center;
	}
	
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
        <h4 class="fw-semibold mb-8">메뉴 관리</h4>
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb">
            <li class="breadcrumb-item">
              <a class="text-muted text-decoration-none" href="/frcs/main">Main</a>
            </li>
            <li class="breadcrumb-item" aria-current="page" id="subTitleTxt">
            	매장 관리
            </li>
<!--             <li class="breadcrumb-item" aria-current="page"> -->
<!--                <a class="text-muted text-decoration-none" href="/frcs/publicdues/main" id="subTitleTxt">매입/매출 분석</a> -->
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

<div class="card">
    <div class="card-body">
        <div id="up-table-group" class="row">
            <div class="col-sm-3">
                <form id="frm">
                    <div class="input-group">
                        <input type="text" class="form-control" placeholder="메뉴명" name="keyword" aria-label="" aria-describedby="basic-addon1">
                        <button class="btn bg-info-subtle text-info font-medium" type="submit"><i class='bx bx-search-alt-2'></i>검색</button>
                    </div>
                </form>
            </div>
        </div>
        <table class="table border text-nowrap customize-table mb-0 align-middle">
            <thead class="text-dark fs-4">
            <tr>
                <th>
                    <h6 class="fs-4 fw-semibold mb-0"></h6>
                </th>
                <th>
                    <h6 class="fs-4 fw-semibold mb-0 text-center">번호</h6>
                </th>
                <th>
                    <h6 class="fs-4 fw-semibold mb-0 text-center">메뉴명</h6>
                </th>
                <th>
                    <h6 class="fs-4 fw-semibold mb-0 text-center">카테고리</h6>
                </th>
                <th>
                    <h6 class="fs-4 fw-semibold mb-0 text-center">가격</h6>
                </th>
                <th>
                    <h6 class="fs-4 fw-semibold mb-0 text-center">출시일</h6>
                </th>
                <th>
                    <h6 class="fs-4 fw-semibold mb-0 text-center">판매상태</h6>
                </th>
                <th>
                    <h6 class="fs-4 fw-semibold mb-0"></h6>
                </th>
            </tr>
            </thead>
            <tbody>
            <c:forEach items="${menuList.content}" var="menu">
                <tr>
                    <td>
                        <div class="d-flex align-items-center">
                            <img src="/resources/upload/menu/${menu.atchFileVO.streFileNm}"
                                 class="rounded-circle" width="40" height="40">
                        </div>
                    </td>
                    <td>
                        <div class="d-flex align-items-center">
                            <p>${menu.menuNo}</p>
                        </div>
                    </td>
                    <td>
                        <div class="d-flex align-items-center">
							<a href="/frcs/menu/detail?menuNo=${menu.menuNo}">${menu.menuNm}</a>
                        </div>
                    </td>
                    <td>
                        <div class="d-flex align-items-center">
                            ${menu.ctgryDetailVO.ctgryDetailNm}
                        </div>
                    </td>
                    <td>
                        <div class="d-flex align-items-baseline justify-content-end">
                            ${menu.menuPrice} 원
                        </div>
                    </td>
                    <td>
                        <div class="d-flex align-items-center">
                            <fmt:formatDate value="${menu.menuStrtDt}" dateStyle="medium"/>
                        </div>
                    </td>
                    <td>
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
                </tr>
            </c:forEach>
            </tbody>
        </table>
        <div id="list-paging-area">
            ${menuList.getPagingArea()}
        </div>
    </div>
</div>

