# TIL
#####################################################################################2021.10.29
문자열 (일부)포함여부 및 앞/뒤 글자의 반환
문자열에서 일치여부 확인하기

let string = "Hello, world!"



// 전체문자열에서 포함여부

string.contains("Hello")
string.lowercased().contains("hello")
string.contains("world")


// 접두어/접미어 포함여부

string.hasPrefix("Hello")
string.hasPrefix("world")
string.lowercased().hasPrefix("world")

string.hasSuffix("!")
string.hasSuffix("world!")





// 접두어/접미어 반환 (앞에서 또는 뒤에서 몇글자 뽑아내기)

string.prefix(2)
string.suffix(3)


// 공통 접두어 반환

string.commonPrefix(with: "Hello, swift")
string.commonPrefix(with: "hello", options: [.caseInsensitive])



// 앞/뒤를 drop시킨 나머지 반환

string.dropFirst(3)
string.dropLast(3)

#####################################################################################2021.10.28_8
문자열 비교하기

문자열의 단순 비교
// 비교연산자 (대소문자 구별)

"swift" == "Swift"   // false
"swift" != "Swift"   // true   ===> 둘의 문자는 다른 것임



// 크기 비교하기 (유니코드 비교)

"swift" < "Swift"      // false ====> 첫 글자의 (유니코드) 순서를 비교
"swift" <= "Swift"     // false ====> 소문자가 (유니코드/아스키코드) 더 뒤에 위치
//"Swift" <= "swift"     // true


// 대소문자 무시하고 비교는?
// (간단하게는 일치시킨 후 비교)

"swift".lowercased() == "Swift".lowercased()



#대소문자무시하고 비교하는 메서드 존재 → caseInsensitiveCompare(문자열)
var a = "swift"
var b = "Swift"



a.caseInsensitiveCompare(b) == ComparisonResult.orderedSame

//문자열.caseInsensitiveCompare(<#T##aString: StringProtocol##StringProtocol#>)


/**========================================================
 ComparisonResult 열거형 타입으로 정의  (비교 결과 타입)
  1) .orderedSame          // 동일
  2) .orderedAscending     // 오름차순
  3) .orderedDescending    // 내림차순
 
 - 단순 같은지 틀린지 뿐만아니라, 결과가 오름차순/내림차순인지
   내림차순인지 알수 있어서 결과값이 활용성이 높고 보다 구체적인 정보 제공가능 ⭐️
   (다만, 처음 사용하는 입장에서 헷갈릴 수 있으므로 잘 알고
   사용해야하는 불편함이 있을 수 있음)
===========================================================**/


#문자열 비교 메서드

문자열에서 일치여부 확인 메서드 사용

#일치여부 메서드 사용 → "다양한 옵션"적용이 가능해서 비교를 여러가지 방식으로 활용가능
// 문자열.compare(_:options:range:locale:) ⭐️


var name = "Hello, Swift"


name.compare("hello", options: [.caseInsensitive]) == .orderedDescending    // 내림차순  ( , ==>  )



#문자열 비교 옵션(String.CompareOptions)과 비교 결과
// String.CompareOptions (비교 옵션)

/**==========================================
 [String.CompareOptions 구조체]와 내부의 타입 속성들
 - .caseInsensitive       // 대소문자 무시하고 ⭐️
 
 - .diacriticInsensitive  // 발음구별기호 무시하고
 - .widthInsensitive      // 글자 넓이 무시하고
 
 - .forcedOrdering        // 강제적 오름차순/내림차순 정렬순 (대소문자 무조건 구별 의미)
 - .literal               // (유지코드 자체로) 글자그대로
 - .numeric               // 숫자 전체를 인식해서 비교
 
 - .anchored              // (앞부분부터) 고정시키고 (접두어)
 - .backwards             // 문자 뒷자리부터

 - .regularExpression     // 정규식 검증 ⭐️
=============================================**/



// 옵션 입력 부분
// OptionSet 프로토콜 채택시, 여러개의 옵션을 배열 형식으로 전달 가능
//NSString.CompareOptions
/**==========================================
 struct CompareOptions : OptionSet   프로토콜 채택
=============================================**/




// .diacriticInsensitive 발음구별기호 무시하고
"café".compare("cafe", options: [.diacriticInsensitive]) == .orderedSame


// .widthInsensitive 글자 넓이 무시하고
"ァ".compare("ｧ", options: [.widthInsensitive]) == .orderedSame




// .forcedOrdering 강제적 오름차순/내림차순 정렬순 (대소문자 무조건 구별 의미)
"Hello".compare("hello", options: [.forcedOrdering, .caseInsensitive]) == .orderedAscending


// .numeric 옵션 숫자 전체를 인식해서 비교
"album_photo9.jpg".compare("album_photo10.jpg", options: [.numeric]) == .orderedAscending


// .literal 옵션
"\u{D55C}".compare("\u{1112}\u{1161}\u{11AB}", options: [.literal]) == .orderedSame
// "한"(완성형)     "ㅎ+ㅏ+ㄴ"(조합형)




// .anchored 옵션 (앞부분부터) 고정시키고 (접두어)
if let _ = "Hello, Swift".range(of: "Hello", options: [.anchored]) {   // 범위리턴 ===> 접두어 기능
    print("접두어 일치")
}


// .anchored 옵션 + .backwards 뒷자리부터 고정 (접미어)
if let _ = "Hello, Swift".range(of: "Swift", options: [.anchored, .backwards]) {   // ===> 접미어 기능
    print("접미어 일치")
}
