<%@page import="com.kh.icodi.admin.model.dto.CategoryNo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/interactjs/dist/interact.min.js"></script>
<script src="https://unpkg.com/html2canvas@1.4.1/dist/html2canvas.js"></script>
<style>
.item img {
	width: 110px;
	height: 110px;
}

#canvas {
	width: 360px;
	height: 500px;
}

.canvasDiv, .div {
	width: 350px;
	height: 135px;
	padding: 10px;
	border: 1px solid black;
}

#container_img {
	width: 400px;
	height: 400px;
}

.target {
	border: 1px solid red;
}

.img {
	width: 100px;
	height: 100px;
}
</style>
<main>
	<section>
		<article>
			<div class="codiArea-wrap">
				<div class="codiAreaMenu">
					<div id="saveBtn">저장</div>
				</div>
				<div class="canvas-wrap"></div>
			</div>
		</article>
		<article>
			<div class="codiProductArea-wrap">
				<ul id="category">
					<li value="<%= CategoryNo.stringOf("TOP") %>">TOP</li>
					<li value="<%= CategoryNo.stringOf("BOTTOM") %>">BOTTOM</li>
					<li value="<%= CategoryNo.stringOf("SHOES") %>">SHOES</li>
					<li value="<%= CategoryNo.stringOf("ACC") %>">ACC</li>
				</ul>
			</div>
		</article>
		<div id="canvas">
			<div id="div1" class="canvasDiv" ondragover="allowDrop(event)"></div>
			<div id="div2" class="canvasDiv" ondragover="allowDrop(event)"></div>
			<div id="div3" class="canvasDiv" ondragover="allowDrop(event)"></div>
		</div>
		<button onclick=partShot()>partShot</button>
		<input type="button" id="btn_reset" value="Reset" onclick="reset();">
		<div id="container_img" class="div" ondragover="allowDrop(event)">
			<ul>	
			
			</ul>
		</div>
		</button>

	</section>
	<script>
	const arr = [];

    //드랍존 안에 있을때 계속 실행
    function allowDrop(ev) {
        ev.preventDefault();
    }

    //클릭하고 이동시
    function drag(ev) {
        ev.dataTransfer.setData("text", ev.target.id);
        // console.log("id : " , ev.target.id);
        // console.log("categoryCode : ", ev.target.dataset.categoryCode);
        // const imgNum = ev.target.id.charAt(ev.target.id.length - 1);
        const imgCategory = ev.target.dataset.categoryCode;
        // console.log("이미지 번호 : ", imgCategory);
        const div = document.getElementsByClassName("canvasDiv");
        [...div].forEach((div) => {
            const divNum = div.id.charAt(div.id.length - 1);
            // console.log("div번호 : ", divNum);

            
            if (imgCategory === divNum) {
                div.setAttribute('ondrop', "drop(event)")
                div.classList.add("target");
                // console.log(document.querySelector(".div"));
            }
            else {
                div.classList.remove("target");
                div.setAttribute('ondrop', " ");
            }
        });
        const container_img= document.querySelector("#container_img");
        // console.log(container_img);
        container_img.setAttribute('ondrop', "drop(event)")

        arr.forEach((data) => {
            console.log("data :" ,data);
            console.log(" :", ev.target.dataset.productCode);
            if(data == ev.target.dataset.productCode){
                arr.pop(data);
            }
        });
        // console.log(arr);

    }

    //드랍존 안에 드랍했을 때
    function drop(ev) {
        ev.preventDefault();
        var data = ev.dataTransfer.getData("text");
        
        const imgNum = ev.target.id.charAt(ev.target.id.length - 1);
        // console.log(imgNum);
        const div = document.getElementsByClassName("canvasDiv");
        [...div].forEach((div) => {
            const divNum = div.id.charAt(div.id.length - 1);
            if(imgNum == divNum){
                const imgData = ev.target.appendChild(document.getElementById(data));
                const imgId = imgData.id;
                console.log("imgId : ",imgId);
    
                arr.push(imgId);
                // console.log(arr);
            }
            else{

            }
        });

        //드랍된 이미지 태그,data 다 가져옴

        [...div].forEach((div) => {
            div.classList.remove("target")
        })

        if(ev.target.id == "container_img"){
            new Set(arr);
            const deleteArr = ev.target.appendChild(document.getElementById(data)).dataset.productCode;
            for(let i = 0; i < arr.length; i++){
                if(arr[i] === deleteArr){
                    arr.splice(i, 1);
                }
            }
            console.log(arr);

        }

        

    }
    function partShot() {
       //특정부분 스크린샷
        html2canvas(document.getElementById("canvas"))
        //id container 부분만 스크린샷
        .then(function (canvas) {

        //이미지 저장
        saveAs(canvas.toDataURL(), 'file-name.jpg');
        	}).catch(function (err) {
       			 console.log(err);
        	});
        const codiArr = new Set(arr);
        console.log(codiArr);
    }


    function saveAs(uri, filename) {
        var link = document.createElement('a');
        if (typeof link.download === 'string') {
            link.href = uri;
            link.download = filename;
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);
        } else {
            window.open(uri);
        }
    }

    const reset = () => {
  location.reload();
};
	</script>

</main>
<script>
	document.querySelector("#category").addEventListener('click', (e) => {
		$.ajax({
			url : '<%= request.getContextPath()%>/codibook/create',
			method : 'POST',
			dataType : 'json',
			data : {categoryNo : e.target.value},
			success(products) {
				const ul = document.querySelector("#container_img ul");
				ul.innerHTML = '';
				
				products.forEach((product) => {
					if(product == '') return;
					
					const {productCode, productPrice, attachmentList} = product;
					attachmentList.forEach((attach) => {				
						const {codiRenamedFilename} = attach;
						if(codiRenamedFilename == undefined) {
							return;
						}
						const li =
							`
							<li class="item">
								<img src="<%= request.getContextPath() %>/upload/admin/\${codiRenamedFilename}"
								id="\${productCode}" class="img" draggable="true" ondragstart="drag(event)"
									data-product-code="\${productCode}" data-product-price="\${productPrice}"
										data-category-code="\${e.target.value}"/>
								<div class="productPrice">\${productPrice}원</div>
							</li>			
							`;
						ul.insertAdjacentHTML('afterbegin', li);
					});
				})
			},
			error : console.log
		});
	});
	
    
    
</script>
</body>
</html>