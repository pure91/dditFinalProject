<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/chart.js"></script>


<style>
.page-wrapper .body-wrapper > .container-fluid {
	padding-bottom: 24px;
}
.card {
	min-width: 600px !important;
}
.date-btns {
    border: 0 none;
    margin-left: 30px;
    margin-right: 30px;
    background-color: transparent;
}

#frm {
    font-size: 14pt;
    display: flex;
    justify-content: center;
    flex-wrap: wrap;
    align-content: center;
    align-items: center;
    height: 100%;
    margin-bottom: 0;
    padding-bottom: 16px;
/*     border-bottom: 1px solid #000; */
}

.chart-container {
    border: 1px solid #ddd;
    padding: 16px;
    border-radius: 8px;
/*     margin: 30px; */
    margin-top: 0;
}

.card-wrap {
	display: flex;
	gap: 16px;
	width: fit-content;
}

.legend-box {
	display: flex;
	gap: 30px;
	width: 100%;
}

.container-fluid {
	width: 100%;
}

/* 서브타이틀S  */
.bg-info-subtle {
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
/* 기간선택 카드 */
#cardDate {
    margin-bottom: 0;
    padding: 16px 30px;
    padding-bottom: 30px;
}

.text-center {
	text-align: left !important;
	font-weight: bold;
}
/* 바차트와 청구서 부분 */
.chartBillCon {
    display: flex;
    gap: 0px 30px;
}
/* 청구서*/
.boxBill {
    width: 40%;
    border: 1px solid #ddd;
    padding: 16px;
    border-radius: 8px;
    height: 100%;
    padding-bottom: 24px;
}
.billTable {
	padding: 0px;
}
/* 차트 그룹 */
.chart-group {
	display: flex;
    gap: 0px 30px;
    margin-top : 30px;
    height: 100%;
}
/* 카드 제목 부분 */
.title-part-padding {
    margin-bottom: 24px;
}
</style>


<!-- 서브타이틀  -->
<div class="card bg-info-subtle shadow-none position-relative overflow-hidden mb-4">
  <div class="card-body px-4 py-3">
    <div class="row align-items-center" id="subTitlePosition">
      <div class="col-9">
        <h4 class="fw-semibold mb-8">매출 총이익 분석</h4>
        <nav aria-label="breadcrumb">
          <ol class="breadcrumb">
            <li class="breadcrumb-item">
              <a class="text-muted text-decoration-none" href="/frcs/main">Main</a>
            </li>
            <li class="breadcrumb-item" aria-current="page" id="subTitleTxt">
            	매입/매출 분석
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


<!-- 기간선택 카드 -->
<div class="card" id="cardDate">
	<form id="frm" class="text-center">
		<button class="date-btns" type="submit" name="viewDate"
			value="${previousMonth}">
			<i class='bx bxs-left-arrow'></i>
		</button>
		<strong>${viewDate}월</strong>
		<button class="date-btns" type="submit" name="viewDate"
			value="${nextMonth}"
			<c:if test="${nextMonth gt crrDate}">disabled</c:if>>
			<i class='bx bxs-right-arrow'></i>
		</button>
	</form>
	
	<!--                         차트들 시작                                                                      -->
	<div class="chartBillCon">
	<!-- 바 차트 시작  -->
	<div class="chart-container" style="clear:both; width:60%; height:100%; padding-bottom: 24px;">
		<div class="border-bottom title-part-padding" style="padding:15px 0px; margin-bottom: 32px;">
			<h4 class="text-center"><span style="margin-right:10px; color:#763ebd;">${viewDate}</span>월 별 매입 / 매출</h4><!-- ${viewDate}월 차트 -->
		</div>
		<div style="clear:both;width:100%;height:300px;">
			<canvas id="bar-chart"></canvas>
		</div>
	</div>
	<!-- 매출 청구서 -->
	<div class="boxBill" style="height: 438px;">
	<div class="border-bottom title-part-padding" style="padding:15px 0px;">
		<h4 class="text-center"><span style="margin-right:10px; color:#763ebd;">${viewDate}</span>청구서</h4><!-- ${viewDate}월청구서 -->
	</div>
	<div class="card-body billTable">
		<table
			class="tablesaw table-striped table-hover table-bordered table no-wrap tablesaw-columntoggle"
			data-tablesaw-mode="columntoggle" id="tablesaw-1233" style="margin-bottom:0px;">
			<thead>
				<tr class="text-center">
					<th scope="col" data-tablesaw-sortable-col=""
						data-tablesaw-priority="persist" class="border">항목</th>
					<th scope="col" data-tablesaw-sortable-col=""
						data-tablesaw-priority="4" class="border tablesaw-priority-4">
						금액(원)</th>
				</tr>
			</thead>
			<c:set var="total"
				value="${monthPaymentVO.paymentTotal-monthFrcsOrderVO.total}" />

			<tbody>
				<!-- 이걸 뽑아다가 갖다놓긴 했는데 parameter값 월별로 쿼리에 때려 넣는걸 어떻게 해야할까? -->
				<tr>
					<td class="title">매출액</td>
					<td class="tablesaw-priority-3 text-end"><fmt:formatNumber
							type="number" maxFractionDigits="3"
							value="${monthPaymentVO.paymentTotal}" /></td>
				</tr>
				<tr>
					<td class="title">매입가</td>
					<td class="tablesaw-priority-3 text-end">- <fmt:formatNumber
							type="number" maxFractionDigits="3"
							value="${monthFrcsOrderVO.total}" /></td>
				</tr>
				<tr>
					<td class="title"></td>
					<td class="tablesaw-priority-3"></td>
				</tr>
				<tr>
					<td class="title">매출 총 이익</td>
					<td class="tablesaw-priority-3 text-end"><fmt:formatNumber
							type="number" maxFractionDigits="3" value="${total}" /></td>
				</tr>
				<c:set var="totalRate" value="${total/monthPaymentVO.paymentTotal}" />
				<tr>
					<td class="title">매출 총 이익률</td>
					<td class="tablesaw-priority-3 text-end"><fmt:formatNumber
							value="${totalRate * 100}" type="number" maxFractionDigits="0" />%
					
				</tr>
			</tbody>
		</table>
	</div>
	</div>
	</div>
	<div class="chart-group">
	<!-- 파이 차트 시작 -->
	<div class="chart-container" style="width: 40%;">
		<div class="border-bottom title-part-padding text-center" style="padding:15px 0px;">
				<h4 class="text-center"><span style="margin-right:10px; color:#763ebd;">${viewDate}</span>판매 순위 / 수량</h4><!-- ${viewDate}월판매 수량 -->
		</div>
		<div style="height: min-content;">
		<canvas id="pie-chart"></canvas>
		</div>
	</div>
	<!-- 매출 순위표 -->
	<div class="chart-container" style="width: 60%;">
		<div class="border-bottom title-part-padding text-center" style="padding:15px 0px;">
			<h4 class="text-center"><span style="margin-right:10px; color:#763ebd;">${viewDate}</span>판매 순위 / 수량</h4><!-- ${viewDate}월판매 수량 -->
		</div>
		<div class="tablesaw-bar tablesaw-mode-stack"></div>
		<table
				class="tablesaw no-wrap table-bordered table-hover table tablesaw-stack"
				data-tablesaw-mode="stack" id="tablesaw-2564">
				<thead class="table-thead">
					<tr class="text-center">
						<th scope="col" data-tablesaw-priority="persist" class="border"
							style="background-color: #eeddff; color: #495057;">판매 순위</th>
						<th scope="col" data-tablesaw-priority="persist" class="border"
							style="background-color: #eeddff; color: #495057;">메뉴명</th>
						<th scope="col" data-tablesaw-sortable-default-col=""
							data-tablesaw-priority="3" class="border"
							style="background-color: #eeddff; color: #495057;">판매 수량</th>
					</tr>
				</thead>

				<!-- start row -->
				<tbody class="table-tbody">
					<c:choose>
						<c:when test="${fn:length(paymentTopList)>0}">
							<c:forEach items="${paymentTopList}" var="paymentVO"
								varStatus="status">
								<c:forEach items="${paymentVO.paymentDetailVOList}"
									var="paymentDetailVO">
									<tr>
										<td class="text-center">${status.count}위</td>
										<td>${paymentDetailVO.menu}</td>
										<td class="text-end">${paymentDetailVO.totalCnt}잔</td>
									</tr>
								</c:forEach>
							</c:forEach>
						</c:when>
					</c:choose>
				</tbody>
				<!-- end row -->

			</table>
		</div>
	</div>
</div><!-- 여까지 카드 -->

<script>

const token = $("meta[name='_csrf']").attr("content");
const header = $("meta[name='_csrf_header']").attr("content");

const veiwDate = $("#viewDate").val();
const thisPageDateJson = {"viewDate": veiwDate}
const detTbody = $("#det-info-area");

</script>


<script type="text/javascript">

$(function(){
   
	console.log("${viewDate}@@@" + '${viewDate}');
	console.log("${previousMonth}@@@" + '${previousMonth}');
	
   let data={
		   "frcsNo" : ${paymentVO.frcsNo},
		   "viewDate" : '${viewDate}'
   };
   
   
   $.ajax({
      url:"/frcs/salespurchase/grossProfit",
      contentType:"application/json;charset=utf-8",
      type:"post",
      data:JSON.stringify(data),
      dataType:"json",
      async:false,
      beforeSend:function(xhr){
         xhr.setRequestHeader("${_csrf.headerName}", "${_csrf.token}");
      },
      success:function(result){
         //이거로 타고가//
         console.log("매출이이이잉 : ", result);
         
         console.log("매출바왔니? : " + result.salesBar);
         console.log("매입바왔니? : " + result.purchaseBar);
         
         console.log("@@@@@파이왔니? : " + result.pie); //왜 이새끼 값이 안들어오지?
        		 
//          console.log("딸기 : "+result.pie[0].paymentDetailVOList[0].menu);
//          console.log("50개 : "+result.pie[0].paymentDetailVOList[0].totalCnt);
//          console.log("딸기 : "+result.pie[1].paymentDetailVOList[0].menu);
//          console.log("50개 : "+result.pie[1].paymentDetailVOList[0].totalCnt);
//          console.log("딸기 : "+result.pie[2].paymentDetailVOList[0].menu);
//          console.log("50개 : "+result.pie[2].paymentDetailVOList[0].totalCnt);
//          console.log("딸기 : "+result.pie[3].paymentDetailVOList[0].menu);
//          console.log("50개 : "+result.pie[3].paymentDetailVOList[0].totalCnt);
         
//          console.log("파이딸기 : " + result.pie[0].paymentDetailVOList[0].menuNm);
//          console.log("카푸치노 : " + result.pie[0].paymentDetailVOList[1].menuNm);
//          console.log("이건뭔디 : " + result.pie[0].paymentDetailVOList[2].menuNm);
//          console.log("이건뭔디1 : " + result.pie[0].paymentDetailVOList[3].menuNm);
//          console.log("이건뭔디2 : " + result.pie[0].paymentDetailVOList[4].menuNm);
         
//          console.log("몇잔1 : " + result.pie[0].paymentDetailVOList[0].pynmCnt);
//          console.log("몇잔2 : " + result.pie[0].paymentDetailVOList[1].pynmCnt);
//          console.log("몇잔3 : " + result.pie[0].paymentDetailVOList[2].pynmCnt);
//          console.log("몇잔4 : " + result.pie[0].paymentDetailVOList[3].pynmCnt);
//          console.log("몇잔5 : " + result.pie[0].paymentDetailVOList[4].pynmCnt);
         
         
//          console.log("매입 : "+result.purchaseBar[0].total);
//          console.log("매입2 : "+result.purchaseBar[1].total);
//          console.log("매출 : "+result.salesBar[0].paymentTotal);
//          console.log("매출11 : "+result.salesBar[11].paymentTotal);
         
//          console.log("길이길이 : " + result.pie[0].paymentDetailVOList.length);
         
         //파이차트, 바차트 선언 
         var mypie = $('#pie-chart');
         var mybar = $('#bar-chart');
         
         /////////////////////////파이차트 시작///////////////////////////
         //pie 데이터를 배열에 저장
         var pieLabels = [];
         var pieData = [];
         
//          for(var i = 0; i < result.pie[0].paymentDetailVOList.length; i++){
//             pieLabels.push(result.pie[0].paymentDetailVOList[i].menuNm);
//             pieData.push(result.pie[0].paymentDetailVOList[i].pynmCnt);
//          }

         for(var i = 0; i < result.pie.length; i++){
            pieLabels.push(result.pie[i].paymentDetailVOList[0].menu);
            pieData.push(result.pie[i].paymentDetailVOList[0].totalCnt);
         }
         
//          console.log("씨바왜안돼 : "+pieLabels);
         
         /* 파이 차트 data */
         var piepie={
               label : ['판매 수량'],
               data : pieData,
               backgroundColor : ["#763ebd",
                  "#936cf4", "#dbb8f9", "#f1e9ff", '#eeeeee','#fdffde','#c2f2f2','#b5dbf7','#fde1ff','#f1a1ff',]/* 색깔 한...열개 정도 정해두기 */
         }
         
         /* 파이차트 생성 */
         var myPieChart = new Chart(mypie, {
            type : 'pie',
            data : {
               
               labels : pieLabels,
               datasets : [piepie]
            },
            
            options:{
               maintainAspectRatio : false,
               plugins:{
                  title:{
                     display:true,
//                      text:'12월 판매 비율(?)'
                  },
                  legend:{
                     position:'right'
                  }
               }
            }
         })
         /////////////////////////파이차트 끝///////////////////////////
         
         var purchaseData =[];
         var salesData = [];
         
         for(var i = 0; i < result.purchaseBar.length; i++){
             purchaseData.push(result.purchaseBar[i].total);
          }
          
          for(var i = 0; i < result.salesBar.length; i++){
              salesData.push(result.salesBar[i].paymentTotal);
           }
         
         console.log("찍바찍바 :" + purchaseData);
         console.log("찍바찍바 :" + salesData);
         
         //월별 매출액 data
         var salesBar ={
               type :'bar',
               label : '월 별 매출액(원)',
               data : salesData,
               backgroundColor : '#936cf4',
//                borderColor : '#763ebd',
//                borderWidth : 1,
               fill : false
         }
         
         //월별 매입액 data
         var purchaseBar ={
               type :'bar',
               label : '월 별 매입액(원)',
               data : purchaseData,
               backgroundColor : '#ff896e',
//                borderColor : '#f2605c',
//                borderWidth : 1,
               fill : false
         }
         
         var myBarChart = new Chart(mybar,
               {
                  type : 'bar',
                  data : {
                     labels : [ '1월', '2월', '3월', '4월',
                        '5월', '6월', '7월', '8월', '9월',
                        '10월', '11월', '12월', '1월' ],
                     datasets : [salesBar, purchaseBar]
                  },
                  options: {
                      maintainAspectRatio: false,
                      scales: {
                          y: {
                              beginAtZero: true
                          }
                      }
                  }
               })
         
      }
   })
})

</script>
