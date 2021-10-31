# TIL
#####################################################################################2021.10.31
Part_25 Advanced Operator
스위프트의 정수타입/ 숫자 리터럴

#숫자 리터럴

스위프트의 숫자 리터럴 표기방법
//스위프트의     숫자 리터럴을 표기하는 방법

var num: Int = 25


// 2진법/8진법/16진법의 수도 직접 써 넣을 수 있음
num = 0b00011001
num = 0o31
num = 0x19


// 큰숫자는 읽기 쉽게하기위해 언더바를 붙이는 것도 가능
// (단순히 언더바를 읽지않음)
num = 1_000_000
num = 10_000_000
num = 10000_0000


#스위프트 정수 타입과 범위
/**========================================
[스위프트의 정수 타입]
 - 플랫폼 사양에 따르는 타입 : Int, UInt (최근 대부분 64비트)
 -  8-bit : Int8, UInt8
 - 16-bit : Int16, UInt16
 - 32-bit : Int32, UInt32
 - 64-bit : Int64, UInt64
===========================================**/


MemoryLayout<Int8>.size   // 1바이트
Int8.max      //  127    ( 2^7승 -1)
Int8.min      // -128    (-2^7승)


MemoryLayout<UInt8>.size     // 1바이트
UInt8.max     //  255     ( 2^8승 -1)
UInt8.min     //    0


MemoryLayout<Int>.size     // 8바이트
Int.max       //  9223372036854775807   ( 2^63승 -1)
Int.min       // -9223372036854775808   (-2^63승 )

#####################################################################################2021.10.29_2
특정문자의 (검색 및) 제거
어떻게 문자열에 있는 특정문자들을 제거할 수 있을까?
/**==========================================================
[특정 문자들을 제거할때 사용하기 위한 메서드]
 
1) 간단하게 앞뒤의 특정 문자를 제거하는 메서드
 - 문자열.trimmingCharacters(in: <#T##CharacterSet#>)

 
2) 문자열의 중간에 특정 문자를 제거하는 방법 ⭐️
   "해당 특정 문자"를 기준으로 (잘라서) 문자열을 배열로 ===> (다시 배열을) 문자열로
 
 - 문자열.components(separatedBy: <#T##CharacterSet#>).joined()
=========================================================**/
//CharacterSet.uppercaseLetters




// 1) 앞뒤의 공백문자의 제거

var userEmail = " my-email@example.com "

var trimmedString = userEmail.trimmingCharacters(in: [" "])
print(trimmedString)
// "my-email@example.com" (처음, 마지막의 공백 문자열 제거)



// CharacterSet 개념을 활용해서
trimmedString = userEmail.trimmingCharacters(in: .whitespaces)
print(trimmedString)




// 2) 앞뒤의 특정문자의 제거

var someString = "?Swift!"
var removedString = someString.trimmingCharacters(in: ["?","!"])
print(removedString)


someString = "?Swi!ft!"
removedString = someString.trimmingCharacters(in: ["?","!"])
print(removedString)       // 중간에 있는 !는 제거하지 못함



#중간에 있는 특수문자의 제거 원리: 해당 특수문자를 기준으로 문자열을 배열로 만든다음 → 다시 문자열로 변환
// 3) (중간에 포함된)공백문자의 제거

var name = " S t e v e "
var removedName = name.components(separatedBy: " ").joined()    //["", "S", "t", "e", "v", "e", ""]
print(removedName)



// 4) (중간에 포함된)특수문자의 제거

var phoneNum = "010-1234-1234"
var newPhoneNum = phoneNum.components(separatedBy: "-").joined()   // ["010", "1234", "1234"]
print(newPhoneNum)


// 5) 여러개의 특수문자를 한꺼번에 제거

var numString =  "1+2-3*4/5"
var removedNumString =  numString.components(separatedBy: ["+","-","*","/"]).joined()
print(removedNumString)




// 6) components(separatedBy:)와 거의 동일한 메서드 split(separator:) 그러나 차이는 있음

var str =  "Hello Swift"
var arr = str.split(separator: " ")    // 서브스트링으로 리턴함
print(arr)
print(arr.joined())


// - (1) split은 Substring 배열로 리턴
str.split(separator: " ")



// - (2) split은 클로저를 파라미터로 받기도 함 (클로저에서 원하는 함수내용을 정의하면 되므로 활용도가 더 높을 수 있음)
str.split { $0 == " " }

//str.split(whereSeparator: <#T##(Character) throws -> Bool#>)



#(미리 정의된) 특정 문자 집합(Set)의 개념을 이용하면, 조금 더 편하게 사용가능
// 구조체로 구현되어 있는
// 문자집합 (문자열 검색, 잘못된 문자 삭제 등에 주로 활용) (기본적인 Set성격)

/**=========================================
 [CharacterSet] 유니코드 기준
 - .symbols                // 기호
 - .alphanumerics          // 문자 + 숫자
 - .decimalDigits          // 10진법 숫자
 - .letters                // 문자 (유니코드상 Letter, Mark 카테고리 해당 문자)
 - .lowercaseLetters       // 소문자
 - .uppercaseLetters       // 대문자  ["A", "B", "C", "D", "E" ...]
 - .whitespaces            // 공백문자 [" "]
 - ....등등
 
 참고: https://developer.apple.com/documentation/foundation/characterset
============================================**/



// 문자셋을 활용해서

userEmail = " my-email@example.com "

var characterSet = CharacterSet.whitespaces   // 공백문자 집합

trimmedString = userEmail.trimmingCharacters(in: characterSet)
print(trimmedString)




name = " S t e v e "

removedName = name.components(separatedBy: characterSet).joined()
print(removedName)




var phoneNumbers = "010 1111 2222"
print(phoneNumbers.components(separatedBy: .whitespaces).joined())


#특정 문자열 검색에도 활용가능
name = "hello+world"


if let range = name.rangeOfCharacter(from: .symbols) {
    print(name[range])
}

#####################################################################################2021.10.29_1
정규식 / 정규표현식
정규식(정규표현식)을 이용한 문자열의 판별

#정규식(正規式)은 "특정한 규칙"을 가진 문자열의 집합을 표현하는 데 사용하는 형식 언어
// (스위프트에만 해당하는 것이 아님)


// 올바른 전화번호 형식일까?
// (정규식 확인하는 코드)

let number = "010-1234-12345"


// 정규식 (RawString으로 작성하면 메타문자를 바로 입력가능) ===> 가독성 높아짐
// (스위프트에서는 \ 백슬레시를 이스케이프 문자로 인식하기 때문)

var telephoneNumRegex = #"[0-9]{3}\-[0-9]{4}\-[0-9]{4}"#


if let _ = number.range(of: telephoneNumRegex, options: [.regularExpression]) {
    print("유효한 전화번호로 판단")
}



#간단한 정규식 사용
// 정규식에 대한 내용을 찾으려면, 구글 및 유튜브 검색 및 활용

/**=========================================================**/
  #"[0-9]{3}[- .]?[0-9]{4}[- .]?[0-9]{4}"#   // 전화번호 러프하게
  #".*@.*\..*"#                              // 이메일 러프하게
  #"[0-9]{3}\-[0-9]{3}"#                     // 우편번호 러프하게
/**=========================================================**/



// 참고
// https://www.youtube.com/watch?v=Gg0tlbrxJSc
// https://www.youtube.com/watch?v=-5cnj7q1-YY
// https://regexr.com/
// https://regexr.com/5nvc2

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
