
// == 금액 세자리 마다 콤마를 찍어서 리턴시켜주는 함수
function func_comma(num){

		var sResult = "";
		
		if(isNaN(num)){	
		// isNaN(문자 또는 문자열) ==> 입력받은 문자 또는 문자열이 숫자가 아니라면 true
		// isNaN(문자 또는 문자열) ==> 입력받은 문자 또는 문자열이 숫자이라면 false
		// NaN 은 Not a Number 이다.
			alert("숫자가 아니군요.");
			
		}
		else{
			// alert("숫자입니다.");
			// alert( num.length /3 ); ==> 3.33333333335
			// alert( parseInt(num.length /3) ); ==> 3
			
			var nBlockCount = 0; // 세자리마다 분할되어 나온 블럭수
			var nStartCommaIndex = 0; // 콤마가 최초로 찍히는 인덱스 값
			
			if(num.length % 3 != 0){ // 입력받은 숫자의 길이가 3의 배수가 아닌 경우
				nBlockCount = parseInt(num.length / 3) + 1;
				nStartCommaIndex = num.length % 3;
			}
			else{ // 입력받은 숫자의 길이가 3의 배수인 경우
				nBlockCount = num.length / 3;
				nStartCommaIndex = 3;
			}
			
			var nStartIndex = 0;
			for(var i=0; i<nBlockCount; i++ ){
				// num <== 1234567890
				var sComma = ( i < nBlockCount-1 )?",":"";
				sResult += num.substring(nStartIndex, nStartCommaIndex) + sComma;
				
				// num.substring(0,1) + ","		1번째		1,
				// num.substring(1,4) + ","		2번째		234,
				// num.substring(4,7) + ","		3번째		567,
				// num.substring(7,10) 			4번째		890
				
				nStartIndex = nStartCommaIndex;
				nStartCommaIndex += 3;
				
			} // end of for
			
		} // end of if~else
		
		
		return sResult;
} // end of function func_comma(num){}


// 버블정렬
function func_ascSort(arrArray){
	     
    for(var i=0; i<arrArray.length; i++){
        
    	for(var j=0; j<arrArray.length-1; j++){
           // j=0; j<4 j++
           // j=0; j<3 j++
           // j=0; j<2 j++
           // j=0; j<1 j++
           
           if(Number(arrArray[j])>Number(arrArray[j+1])){
              
              var temp = arrArray[j];
              arrArray[j] = arrArray[j+1];
              arrArray[j+1] = temp;
              
           }
                                                     
        }//end of for 안
        
     }//end of for 밖
     
     var sResult = arrArray.join(",");
     
     return sResult;
	
} // end of function func_ascSort(arrArray){}


// == 주민번호를 검사하는 함수 == //
/*
  주민번호 공식에 맞으면 true 를 리턴하고, 주민번호 공식에 틀리면 false 를 리턴한다.
 */
function func_jubunCheck(jubun) {
	
	// 9210201234567(공식에 틀린것), 9510101013212(공식에 맞는것)
	
	if(jubun.length != 13){
		return false;
	}
	else{
		// 9*2 + 2*3 + 1*4 + 0*5 + 2*6 + 0*7 + 1*8 + 2*9 + 3*2 + 4*3 + 5*4 + 6*5
		var nSum = 0;	// 누적용 변수
		
		for(var i=0; i<12; i++){
			if(i<8){
				nSum += Number(jubun.substring(i,i+1)) * (i+2);
			}
			else{
				nSum += Number(jubun.substring(i,i+1)) * (i-6);
			}
			
		} // end of for
		
		var nResult = nSum%11;  // nSum 을 11로 나눈 나머지
		nResult = 11- nResult;  // 11- nResult
		nResult = nResult % 10;	// nResult % 10;
		
		if(nResult == Number(jubun.substring(12,13))){
			return true;
		}
		else{
			return false;
		}
		
	} // if~else
	
	
	
} // end of function func_jubunCheck(jubun) {} 




























