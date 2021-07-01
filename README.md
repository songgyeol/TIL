# TIL

###################2021.07.01
_New String Interpolation
_String Indices
_String Index
_String Basic


2021.06.28
###################String Interpolation
var str = "12.34KB"

let size = 12.34
str = String(size) + "KB"
//문자열을 더블로 바꿀 수 없음, 더블을 문자열로 바꿈
// Interpolating = 문자열 삽입 or 보관

str = "\(size)KB"
//단점 - 직관적으로 문자열을 구상할 수 있지만, 원하는 포맷을 지정할 수 없음

-Format Specifier
//원하는 포맷 지정
str = String(format: "%.1fKB", size)
//.1은 소숫점 1자리, f는 실수

String(format: "Hello, %@", "Swift")
//%@문자는 문자열과 참조형식을 대체시 사용
       String(format: "%d", 12)
//정수는 %d 사용(대소문자 상관없음,보통 소문자 사용)     정수만 대체
    String(format: "%010.3f", 12.34)

String(format: "[%d]", 123)
String(format: "[%10d]", 123)
String(format: "[%-10d]", 123)

let firstName = "yeo jin"
let lastName = "yoon"

let korFormat = "그녀의 이름은 %@ %@ 입니다."
let engFormat = "Her name is %@ %@."
String(format: korFormat, firstName, lastName)
String(format: engFormat, firstName, lastName)

//%2$@ %1$@ 순서변경
//let korFormat = "그녀의 이름은 %2$@ %1$@ 입니다."
//let engFormat = "Her name is %1$@ %2$@."
//
//String(format: korFormat, firstName, lastName)
//String(format: engFormat, firstName, lastName)


//\는 두번
str = "\\"
print(str)

print("A\tb")
// \t는 탭 추가

print("c\nD")
// \n 줄바꿈

print("\"Hello\" He said.")
//추가 \"

#################Multiline String Literal
// /n 줄바꿈 = 이스케이프시퀀스
//싱글라인리터럴
let loremIpsum = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod \ntempor incididunt ut labore et dolore magna aliqua."

//멀티라인리터럴
let multiline = """
        Lorem ipsum dolor sit amet,\
        consectetur adipiscing elit, sed do eiusmod
            tempor incididunt ut labore et dolore magna aliqua.
    """
//단독으로 """ 작성,, 들여쓰기, 동일선상 및 좌측에 위치해야함 , 멀티라인리터럴에서 \사용시 줄바꿈 취소




###################Strings and character
--Strings and Characters
let s = "String"
let c: Character = "C"

let emptyChar: Character = " "

let emptyString = " "
//문자열은 길이를 기준으로 빈 문자열을 판단
//빈 문자열은 -> let emptyString = ""
emptyString.count

let emptyString2 = String()


-String Types
var nsstr: NSString = "str"

let swiftStr: String = nsstr as String
//as String = 타입캐스팅
nsstr = swiftStr as NSString

-Mutability
//문자열의 가변성
let immutableStr = "str"
//immutableStr = "new str"

var mutableStr = "str"
mutableStr = "new str"

-Unicode
let str = "Swift String"

str.utf8
str.utf16

//cont + commd + spacebar = 이모티콘
var thumbUP = "👍"

thumbUP = "\u{1F44D}"
//👍
//올린 엄지
//유니코드: U+1F44D, UTF-8: F0 9F 91 8D
//유니코드값으로 이모티콘 삽입 가능

########################//  튜플매칭?!
-Tuple Matching

let resolution = (1920.0, 1080.0)

if resolution.0 == 3840 && resolution.1 == 2160 {
    print("4K")
}

switch resolution {
case let(w, h) where w / h == 16.0 / 9.0:
    print("16:9")
case (_, 1080):
    print("1080p")
case (3840...4096, 2160):
    print("4K")
default:
    break
}


2021.06.27
Tuple
-Tuple Decomposition
-//분해

let data = ("<html>", 200, "OK", 12.34)

//let body = data.0
//let code = data.1
//let messaage = data.2
//let size = data.3

let (body, code, message, _) = data



2021.06.26 15:49
git hub



2021.06.26
Tuple + test

## This is Title

- list 1
- list 2
- list 3
- list 4
