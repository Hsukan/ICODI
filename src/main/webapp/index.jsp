

<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!-- src/main/webapp 부터 시작! -->
<%@include file="/WEB-INF/views/common/header.jsp"%>
<br />
<br />
<link rel="stylesheet" type="text/css"
	href="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.css" />
<script type="text/javascript"
	src="//cdn.jsdelivr.net/npm/slick-carousel@1.8.1/slick/slick.min.js"></script>
<style>
#newItem img {
	width: 130px;
	height: 140px;
	margin: 0 15px 40px 0;
}

#newItem {
	width: 470px;
	position: absolute;
	right: 0px;
	top: 25px;
}

section {
	width: 1024px;
	margin: 0 auto;
}

#sliderContainer {
	margin: 0 auto;
	position: relative;
}

#slider {
	width: 550px;
	height: 400px;
	position: absolute; left : -210px; border : 10px solid transparent;
	padding : 0px; z-index : 100; overflow : hidden; white-space : nowrap;
	box-sizing : border-box; margin-left : 200px;
	position: relative;
	left: -210px;
	border: 10px solid transparent;
	padding: 0px;
	z-index: 100;
	overflow: hidden;
	white-space: nowrap;
	box-sizing: border-box;
	margin-left: 200px;
}

#slider>li {
	width: 99.5%;
	height: 100%;
	border: 1px solid black;
	display: inline-block;
	overflow: hidden;
	font-size: 15px;
	font-size: initial;
	line-height: normal;
	transition: all 0.5s cubic-bezier(0.4, 1.3, 0.65, 1);
	/* Slide css animation */
	background-size: cover;
	vertical-align: top;
	box-sizing: border-box;
	white-space: normal;
}

#slider img {
	width: 100%;
	height: 100%;
}
</style>
<section>
	<div id="sliderContainer">
		<ul id="slider">
			<li><a
				href="<%= request.getContextPath()%>/csCenter/csCenterView?no=3">
					<img src="<%= request.getContextPath()%>/upload/main/delay.png"
					alt="">
			</a></li>
			<li><a href="<%= request.getContextPath()%>/codibook/create">
					<img
					src="<%= request.getContextPath()%>/upload/main/toCodiMake.png"
					alt="">
			</a></li>
			<li><a href="<%= request.getContextPath()%>/codi/hotCodiList">
					<img
					src="<%= request.getContextPath()%>/upload/main/toCodiBoard.png"
					alt="">
			</a></li>
		</ul>
		<div id="newItem">
		<p style="text-align:right; margin:0 35px 20px 0">신상품</p>
		</div>
	</div>
</section>
<br />
<br />
<br />
<br />
<script>
		const newProduct = () => {
			$.ajax({
				url : '<%=request.getContextPath()%>/product/newProdcut',
				dataType: 'json',
				success(response){
					console.log("response@index = " + response);
					const div = document.querySelector("#newItem");
					
					response.forEach((product) => {
						const {productRenamedFilename} = product.attachmentList[0];
						const {productCode, productName, productPrice} = product;
						
						const img = `
							<a href="<%= request.getContextPath()%>/product/detail?product_name=\${productName}">					
							<img src="<%= request.getContextPath()%>/upload/admin/\${productRenamedFilename}" alt="" /></a>
						`;
						div.insertAdjacentHTML('beforeend', img);
					})
				},
				error: console.log
			});
		};
		newProduct();
		
		 // Slide every slideDelay seconds
        const slideDelay = 3000;
  
        const dynamicSlider = document.getElementById("slider");
  
        var curSlide = 0;
        window.setInterval(()=>{
          curSlide++;
          if (curSlide === dynamicSlider.childElementCount) {
            curSlide = 0;
          }
  
          // Actual slide
          dynamicSlider.firstElementChild.style.setProperty("margin-left", "-" + curSlide + "00%");
        }, slideDelay);
  
	</script>