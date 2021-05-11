<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<c:set var="path" value="${pageContext.request.contextPath}" />
<link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.16.0/umd/popper.min.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>

<style>

body{
	width:100%;
	height:100%;
}

#content{
	width:100%;
	height:100%;
	display:flex;
	justify-content:center;
	align-items:center;
}

#questionBox{
	width:60%;
	height:50%;
}

#questionBoxNav{

	text-align:right;
	font-weight:bold;
	font-size:200%;
}

#questionBoxContentDiv{
	font-weight:bold;
	font-size:200%;
	text-align:center;
}

#questionBoxContentDiv a{
	font-weight:bold;
	font-size:5vh;
}


#answer{
	width:100%;
	heigth:200%;
	margin-top:2vh;
	padding:2vh;
}

#nextDiv{
	display:flex;
	justify-content:center;
	align-items:center;
	margin:2vh;
}

#next{
	font-size:5vh;
	width:80%;
}

</style>
<jsp:include page="/WEB-INF/views/common/header.jsp" /> 
 
<section id="content">
<div id="questionBox">
	<div id="questionBoxNav"></div>
	<div id="questionBoxContentDiv"><a>Question : </a><a id="questionBoxContentField"></a></div>
	<input type="text" id="answer"  class="form-control" placeholder="answer" aria-describedby="basic-addon1">
	<div id="nextDiv" >
		<button type="button" id="next" class="btn btn-info">Next</button>  
	</div>
</div>
</section>

<jsp:include page="/WEB-INF/views/common/footer.jsp" /> 


<script>

"use strict";

let qallCount = 0;
let qcurCount = 0;
let array = new Array();
let resultarray = new Array();
let question = function(mid,mquestion,mmark,right_answer_count,answer_count){
		this.mid = mid;
		this.mquestion = mquestion; 
		this.mmark = mmark; 
		this.right_answer_count = right_answer_count; 
		this.answer_count = answer_count;
}

let result = function(mid,resultContent){
	this.mid = mid;
	this.resultContent = resultContent;
}

function questionSet(){
	<c:forEach items="${quList}" var="item">
		array.push(new question("${item.mid}","${item.mquestion}","${item.mmark}","${item.right_answer_count}","${item.answer_count}"));
	</c:forEach>

	qallCount = array.length;
	$("#questionBoxNav").html((qcurCount + 1)+"/"+qallCount);
	$("#questionBoxContentField").html(array[qcurCount].mquestion);

}

$("#next").click((e) => {
	let val = $("#answer").val();
	if(val != ""){
	resultarray.push(new result(qcurCount + 1,val));
		$("#answer").val("");
	}else{
		console.log("값이 비어있음");
		return;
	}
	
	console.log("qallCount : "+qallCount+", qcurCount : "+(qcurCount + 1));
	
	if(qallCount == qcurCount + 1){
		console.log("==========================");
		console.log("재출");
		for(let i in resultarray){
			console.log("데이터 : "+resultarray[i].mid+", "+resultarray[i].resultContent);
		}
		  $.ajax({
		 	   type:"POST",
		 	   dataType: 'json',
		 	   data:{
		 		   "resultarray" : JSON.stringify(resultarray)
		 	   },
		 	   url:"${path}/re",
		
		 	   success:function (data){
		 		   console.log("data : "+JSON.stringify(data));
		 	
	               $.each(data, function (i, item) {
	                    console.log("mid : "+item.mid+" rc : "+item.resultContent+" yesno : "+item.yesno);
	                });
		 		   
		 	   }
			}); 
	}

	if(qallCount > qcurCount + 1){
		qcurCount++;
		$("#questionBoxNav").html("");
		$("#questionBoxContentField").html(array[qcurCount].mquestion);
		$("#questionBoxNav").html((qcurCount + 1)+"/"+qallCount);
	}

})

questionSet();

</script>