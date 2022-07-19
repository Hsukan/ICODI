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
        .item {
        	list-style: none;
        	width: 111px;
        	height: 111px;
        	border: 1px solid black;
        	float : left;
        	margin: 13px;
        	position : relative;
        }
        .productPrice{
        	position: absolute;
        	bottom: -20px;
        }

        #canvas {
        	background-image: url(<%=request.getContextPath()%>/upload/codibook/마네킹.png);
        	background-size: 100% 100%;
            background-repeat: no-repeat;
        	border: 1px solid black;
			text-align: center;
            width: 390px;
            display: flex;
            flex-wrap: wrap;
            margin-left: 20px;
            justify-content: space-evenly;
        }
        
        #canvas div{
        	/* border: 1px solid black; */
        	width: 170px;
        }
        
        .canvasDiv{
            height: 130px;
            padding: 10px;
            position : relative;
        }
        #topReset{
        	z-index: 999;
        	text-align: center;
        	border: 1px solid black;
        	width: 10px;
        	height: 18px; 
        	position: absolute;
        	right:300px;
        	top: 75px;
        }
        #bottomReset{
        	z-index: 999;
        	text-align: center;
        	border: 1px solid black;
        	width: 10px;
        	height: 18px; 
        	position: absolute;
        	right:300px;
        	top: 225px;
        }
        #shoesReset{
        	z-index: 999;
        	text-align: center;
        	border: 1px solid black;
        	width: 10px;
        	height: 18px; 
        	position: absolute;
        	right:300px;
        	top: 375px;
        }
        #accReset{
        	z-index: 999;
        	text-align: center;
        	border: 1px solid black;
        	width: 10px;
        	height: 18px; 
        	position: absolute;
        	right:100px;
        	top: 75px;
        }
        .div{
            border: 1px solid black;
        }

        #container_img {
            width: 500px;
            height: 450px;
            float: left;
            padding:5px;
            margin: 5px 5px 5px 5px;
        }

        #container_img img {
            display: block;
            float: left;
        }

        .target {
           border: 1px solid red;
        }

        .img {
            width: 125px;
            height: 125px;
        }

        .codiProductArea-wrap {
            height: 50px;
            position: relative;
            right: 30px;
        }

        #category {
            list-style: none;

        }

        #category li {
            float: left;
            margin: 0 20px 0 0;
            padding: 5px 15px;
            border: 1px solid black;
        }
        

        article {
        	margin : 0 auto;
            width: 1000px;
            border: 1px solid black;
            height: 600px;
            position: relative;
            padding-left: 50px;
            
        }
#modal.modal-overlay {
            width: 100%;
            height: 100%;
            position: absolute;
            left: 0;
            top: 0;
            display: none;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background: rgba(255, 255, 255, 0.25);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            backdrop-filter: brightness(0.5);
            /* border: 1px solid rgba(255, 255, 255, 0.18); */
        }
        #modal.modal-overlay1 {
            width: 100%;
            height: 100%;
            position: absolute;
            left: 0;
            top: 0;
            display: none;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            background: rgba(255, 255, 255, 0.25);
            box-shadow: 0 8px 32px 0 rgba(31, 38, 135, 0.37);
            backdrop-filter: brightness(0.5);
            /* border: 1px solid rgba(255, 255, 255, 0.18); */
        }
        #modal .modal-window {
            background: rgba( 255, 255, 255 );
            border-radius: 4px;
            /* border: 1px solid rgba( 255, 255, 255, 0.18 ); */
            width: 400px;
            height: 400px;
            position: relative;
            top: 0px;
            padding: 10px;   
        }
        #modal .modal-window1 {
            background: rgba( 255, 255, 255 );
            /* backdrop-filter: blur( 13.5px );
            -webkit-backdrop-filter: blur( 13.5px ); */
            border-radius: 4px;
            /* border: 1px solid rgba( 255, 255, 255, 0.18 ); */
            width: 200px;
            height: 200px;
            position: relative;
            top: 356px;
            padding: 10px;
        }
        #modal .title {
            padding-top: 10px;
            padding-left: 10px;
            display: inline;
            color: gray;
            
        }
        #modal .title h4 {
            display: inline;
        }
        #modal .close-area {
            display: inline;
            float: right;
            padding-right: 10px;
            cursor: pointer;
            /* text-shadow: 1px 1px 2px gray; */
            color: #000;
        }
        
        #modal .content {
            margin-top: 20px;
            padding: 0px 10px;
            text-shadow: 1px 1px 2px gray;
            color: white;
        }
        #btnModal{
        	display: none;
        }
        
        .divReset{
        	position: absolute;
        	right: 5px;
        	top:5px;
        }

</style>
<main>
	</header>
        <article>
            <div class="codiProductArea-wrap">
				<ul id="category">
					<li value="<%= CategoryNo.stringOf("TOP") %>" id="top">TOP</li>
					<li value="<%= CategoryNo.stringOf("BOTTOM") %>" id="bottom">BOTTOM</li>
					<li value="<%= CategoryNo.stringOf("SHOES") %>" id="shoes">SHOES</li>
					<li value="<%= CategoryNo.stringOf("ACC") %>" id="acc">ACC</li>
				</ul>
				<input type="button" value="저장" id="btnSave" />
				<button type="button" id="btnModal" ></button>
                <input type="button" id="btn_reset" value="Reset" onclick="reset();"></button>
			</div>
		<div id="container_img" class="div">
			<ul>

			</ul>
		</div>
			<span id="topReset" class="divReset">x</span>
			<span id="accReset" class="divReset">x</span>
			<span id="bottomReset" class="divReset">x</span>
			<span id="shoesReset" class="divReset">x</span>
			<div id="canvas">
				<div id="div1" class="canvasDiv" ondragover="allowDrop(event)">
				</div>
				<div id="div4" class="canvasDiv" ondragover="allowDrop(event)">
				</div>
				<div id="div2" class="canvasDiv" ondragover="allowDrop(event)">
				</div>
				<div id="div4" class="canvasDiv" ondragover="allowDrop(event)">
				</div>
				<div id="div3" class="canvasDiv" ondragover="allowDrop(event)">
				</div>
				<div id="div4" class="canvasDiv" ondragover="allowDrop(event)">
				</div>
			</div>
		</article>
	</section>
	<script>
	const arr = [];
	
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
                }
                else {
                    div.classList.remove("target");
                    div.setAttribute('ondrop', " ");
                }
            });
            console.log(arr);

        }
    
    //드랍존 안에 드랍했을 때
    function drop(ev) {
        ev.preventDefault();
        var data = ev.dataTransfer.getData("text");
        const divNumber = ev.target.id.charAt(ev.target.id.length - 1);

        const imgNum = ev.target.id.charAt(ev.target.id.length - 1);
        // console.log(imgNum);
        const div = document.getElementsByClassName("canvasDiv");
        [...div].forEach((div) => {
            const divNum = div.id.charAt(div.id.length - 1);
            if(imgNum == divNum){
                const imgData = ev.target.appendChild(document.getElementById(data));
                const imgId = imgData.id;
                console.log("imgId : ",imgId);
    
                if(arr.indexOf(imgId) == -1){
                    arr.push(imgId);
                }
                console.log(arr);
            }
            else{

            }
        });
		if([...document.querySelectorAll("#canvas img")].length > 0){
        	document.getElementById("canvas").style.background = "url()";
			
		}
		if([...document.querySelectorAll("#canvas img")].length == 0){
		document.getElementById("canvas").style.background = "url(<%=request.getContextPath()%>/upload/codibook/마네킹.png)";
			
		}

        
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
            //ev.target.innerHTML = " ";
            console.log(arr);
            
            //document.querySelector()
        }
    };
    
    btnSave.onclick = (e) => {
    	partShot();
    	document.querySelector("#btnModal").click();
    };
    
    function partShot() {
       //특정부분 스크린샷
      
        html2canvas(document.getElementById("canvas")).then(function (canvas) {
        //이미지 저장
        	var myImg = canvas.toDataURL('image/jpeg', 1);
 			myImg = myImg.replace("data:image/jpeg;base64,", "");
 			document.querySelector("[name=imgSrc]").value = myImg;
        }).catch(function (err) {
       		console.log(err);
        }); 
        const codiArr = new Set(arr);
		const useProductArr = [...codiArr].join(", ");		
		const memberId = "<%= loginMember.getMemberId() %>";

		document.querySelector("[name=memberId]").value = memberId;
		document.querySelector("[name=useProductArr]").value = useProductArr;
    };

    const reset = () => {

    	[...document.querySelectorAll("#canvas img")].forEach((img) => {
    		const categoryNum = img.dataset.categoryCode;
    		
    		 img.remove();
 			productLoad(categoryNum);
 			arr = [];
             return;
    	});
    	
};
	//상의 리셋
	const topReset = document.querySelector("#topReset");
	topReset.addEventListener('click', () => {
		if(document.querySelector("#div1 img") == null) return;
		document.querySelector("#div1 img").remove();
		arr.pop();
		productLoad(1);
    }); 
	
	//하의 리셋
	const bottomReset = document.querySelector("#bottomReset");
	bottomReset.addEventListener('click', () => {
		document.querySelector("#div2 img").remove();
		arr.pop();
		productLoad(2);
    }); 
	
	//신발 리셋
	const shoesReset = document.querySelector("#shoesReset");
	shoesReset.addEventListener('click', () => {
		document.querySelector("#div3 img").remove();
		arr.pop();
		productLoad(3);
    }); 
	
	//악세 리셋
	const accReset = document.querySelector("#accReset");
		accReset.addEventListener('click', () => {
		document.querySelector("#div4 img").remove();
		arr.pop();
		productLoad(4);
    }); 
	</script>
</main>
<script>
	const productLoad = (target) => {
		$.ajax({
			url : '<%= request.getContextPath()%>/codibook/create',
			method : 'POST',
			dataType : 'json',
			data : {categoryNo : target},
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
										data-category-code="\${target}"/>
								<div class="productPrice">\${productPrice}원</div>
							</li>			
							`;
						ul.insertAdjacentHTML('afterbegin', li);
					});
				})
			},
			error : console.log
		});
		
	}

	document.querySelector("#category").addEventListener('click', (e) => {
		const target = e.target.value;
		console.log(target);
		productLoad(target);
	});
	
	</script>
<form action="<%= request.getContextPath() %>/canvas" 
	name="codiBoardInsert"
	method="POST">
  <div id="modal" class="modal-overlay">
      <div class="modal-window">
          <div class="title">
              <h4>코디 저장하기</h4>
          </div>
          <div class="close-area">X</div>
          <div class="content">
          	<textarea id="content" cols="60" rows="10" name="content" placeholder="생성한 코디에 대한 간단한 설명을 적어주세요."></textarea>
 			<input type="submit" value="저장" />
          	<input type="checkbox" name="isOpen" id="isOpen" value="N"/>
          	<label for="isOpen">비공개 저장</label>
          	<input type="hidden" name="imgSrc" />
          	<input type="hidden" name="memberId" />
          	<input type="hidden" name="useProductArr" />
          </div>
      </div>
  </div>
	</form>
	<script>
    
	const modal = document.getElementById("modal")
    function modalOn() {
        modal.style.display = "flex";
    }
    function isModalOn() {
        return modal.style.display === "flex"
    }
    function modalOff() {
        modal.style.display = "none"
    }
    const btnModal = document.getElementById("btnModal")
    btnModal.addEventListener("click", e => {
      modalOn()
      const momodal = document.getElementById("momodal")
    })
    const closeBtn = modal.querySelector(".close-area")
    closeBtn.addEventListener("click", e => {
        modalOff()
    })
    modal.addEventListener("click", e => {
        const evTarget = e.target
        if(evTarget.classList.contains("modal-overlay")) {
            modalOff()
        }
    })
    window.addEventListener("keyup", e => {
        if(isModalOn() && e.key === "Escape") {
            modalOff()
        }
    })
</script>
</body>
</html>
