<%@page import="com.kh.icodi.admin.model.dto.CategoryNo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/views/common/header.jsp"%>
<script src="<%=request.getContextPath()%>/js/jquery-3.6.0.js"></script>
<script
	src="https://cdn.jsdelivr.net/npm/interactjs/dist/interact.min.js"></script>
<script src="https://unpkg.com/html2canvas@1.4.1/dist/html2canvas.js"></script>
<link rel="stylesheet" href="<%=request.getContextPath()%>/css/codiBook.css" />
<article>
	<div id="category">
			<div class="label">
			<input type="radio" value="<%= CategoryNo.stringOf("TOP") %>" id="top" name="tabs" /> 
			<label for="top" class="cetegoryLabel">TOP</label>
			</div>
			<div class="label">
			<input type="radio" value="<%= CategoryNo.stringOf("BOTTOM") %>" id="bottom" name="tabs" id="bottom" /> 
			<label for="bottom" class="cetegoryLabel">BOTTOM</label> 
			</div>
			<div class="label">
			<input type="radio" value="<%= CategoryNo.stringOf("SHOES") %>" id="shoes" name="tabs" />
			<label for="shoes" class="cetegoryLabel">SHOES</label> 
			</div>
			<div class="label">
			<input type="radio" value="<%= CategoryNo.stringOf("ACC") %>" id="acc" name="tabs" />
			<label for="acc" class="cetegoryLabel">ACC</label>
			</div>
	</div>
<div id="container">
	<div id="container_img" class="div">
		<ul>
		</ul>
	</div>
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
			<input type="button" value="저장" id="btnSave" />
			<button type="button" id="btnModal" ></button>
            <input type="button" id="btn_reset" value="Reset" onclick="reset();"></button>
			
</article>
<script>
document.querySelector("#category").addEventListener('change', (e) => {
	const target = e.target.value;
	console.log(target);
	productLoad(target);
});
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
<%-- function partShot() {
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
 }; --%>

 const reset = () => {

 	[...document.querySelectorAll("#canvas img")].forEach((img) => {
 		const categoryNum = img.dataset.categoryCode;
 		
 		img.remove();
			productLoad(categoryNum);
	 		arr.pop();
 	});
 	return;
 	
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
          	<textarea id="content" cols="50" rows="10" name="content" placeholder="생성한 코디에 대한 간단한 설명을 적어주세요."></textarea>
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
