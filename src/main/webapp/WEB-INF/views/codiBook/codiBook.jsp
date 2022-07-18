
  1
  2
  3
  4
  5
  6
  7
  8
  9
 10
 11
 12
 13
 14
 15
 16
 17
 18
 19
 20
 21
 22
 23
 24
 25
 26
 27
 28
 29
 30
 31
 32
 33
 34
 35
 36
 37
 38
 39
 40
 41
 42
 43
 44
 45
 46
 47
 48
 49
 50
 51
 52
 53
 54
 55
 56
 57
 58
 59
 60
 61
 62
 63
 64
 65
 66
 67
 68
 69
 70
 71
 72
 73
 74
 75
 76
 77
 78
 79
 80
 81
 82
 83
 84
 85
 86
 87
 88
 89
 90
 91
 92
 93
 94
 95
 96
 97
 98
 99
100
101
102
103
104
105
106
107
108
109
110
111
112
113
114
115
116
117
118
119
120
121
122
123
124
125
126
127
128
129
130
131
132
133
134
135
136
137
138
139
140
141
142
143
144
145
146
147
148
149
150
151
152
153
154
155
156
157
158
159
160
161
162
163
164
165
166
167
168
169
170
171
172
173
174
175
176
177
178
179
180
181
182
183
184
185
186
187
188
189
190
191
192
193
194
195
196
197
198
199
200
201
202
203
204
205
206
207
208
209
210
211
212
213
214
215
216
217
218
219
220
221
222
223
224
225
226
227
228
229
230
231
232
233
234
235
236
237
238
239
240
241
242
243
244
245
246
247
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
		<form action="<%= request.getContextPath()%>/codi/myCodi">
		<input type="hidden" name="memberId" value="<%= loginMember.getMemberId() %>" />
		<button>내코디보기</button>
		</form>
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
			<input type="button" value="저장" id="btnSave"/>
		<div id="container_img" class="div" ondragover="allowDrop(event)" ondrop="drop(event)">
			<ul>

			</ul>
		</div>
		</button>

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
                    // console.log(document.querySelector(".div"));
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
            console.log(arr);

        }

        

    }
    btnSave.onclick = (e) => {
    	partShot();
    };
    
    function partShot() {
       //특정부분 스크린샷
        html2canvas(document.getElementById("canvas"))
        //id container 부분만 스크린샷
         .then(function (canvas) {

        //이미지 저장
        	 var myImg = canvas.toDataURL('image/jpeg', 0.5);
 			myImg = myImg.replace("data:image/jpeg;base64,", "");
        	//console.log(myImg);
        	
        	$.ajax({
        		type : "POST",
				data : {
					"imgSrc" : myImg,
					"memberId" : "<%= loginMember.getMemberId() %>",
					"codiArr" : arr2
				},
				dataType : "text",
				url : '<%= request.getContextPath() %>/canvas',
				success(data) {
					console.log("이미지 저장 성공!");
				},
				error : function(a, b, c) {
					alert("error");
				}
        	});

        	}).catch(function (err) {
       			 console.log(err);
        	}); 

        const codiArr = new Set(arr);
        console.log(codiArr);
        
		const arr2 = [...codiArr].join(", ");
		  
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
