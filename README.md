# TIL
###################2021.07.08
Collection
Array#1
Array Basics
Creating an Array

let nums = [1, 2, 3]

let emptyArray: [Int] = []

let emptyArray2 = Array<Int>()
let empty3 = [Int]()

let zeroArray = [Int](repeating: 0, count: 10)




Inspecting an Array

nums.count

nums.count == 0

nums.isEmpty
emptyArray.isEmpty




Accessing Elements

//배열인덱스는 0부터 시작
let fruits = ["Apple", "Banana", "Mellon"]
fruits[0]
fruits[2]

fruits[0...1]

fruits[fruits.startIndex]
fruits[fruits.index(before: fruits.endIndex)]

fruits.first
fruits.last

emptyArray.first
emptyArray.last

//emptyArray[0]

Array#2
Adding Elements

//새로운 요소를 추가 삭제하고 싶다면 var
//let으로 설정한다면 추가삭제 불가
var alphabet = ["A", "B", "C"]
alphabet.append("E")

//2개 이상의 요소를 추가하고 싶다면
alphabet.append(contentsOf: ["F", "G"])

//중간에 넣을때
alphabet.insert("D", at: 3)
alphabet.insert(contentsOf: ["a", "b", "c"], at: 0)

alphabet[0...2] = ["x", "y", "z"]
alphabet

alphabet.replaceSubrange(0...2, with: ["a", "b", "c"])
alphabet

alphabet[0...2] = ["z"]
alphabet

alphabet[0..<1] = []
alphabet


Removing Elements

//요소를 삭제하는 방법
alphabet = ["A", "B", "C", "D", "E", "F", "G"]
//하나의 요소를 삭제
alphabet.remove(at: 2)
alphabet

alphabet.removeFirst()
alphabet

alphabet.removeFirst(2)
alphabet

alphabet.removeAll()

alphabet.popLast()

alphabet = ["A", "B", "C", "D", "E", "F", "G"]
alphabet.popLast()
alphabet

alphabet.removeSubrange(0...2)
alphabet

alphabet[0...2] = []
alphabet




Array#3
Comparing Arrays

//배열에서 비교,검색,정렬
let a = ["A", "B", "C"]
let b = ["a", "b", "c"]

a == b
a != b

a.elementsEqual(b)

a.elementsEqual(b) { (lhs, rhs) -> Bool in
    return lhs.caseInsensitiveCompare(rhs)
        == .orderedSame
}




Finding Elements

let nums = [1, 2, 3, 1, 4, 5, 2, 6, 7, 5, 0]
nums.contains(1)
nums.contains(8)

nums.contains { (n) -> Bool in
    return n % 2 == 0
}

nums.first { (n) -> Bool in
    return n % 2 == 0
}

nums.firstIndex { (n) -> Bool in
    return n % 2 == 0
}

nums.firstIndex(of: 1)

nums.lastIndex(of: 1)




Sorting on Array

//배열을 정렬
//sort = 배열을 직접 정렬
//sorted = 정렬된 새로운 배열을 리턴

nums.sorted()
nums

nums.sorted { (a, b) -> Bool in
    return a > b
}

nums.sorted().reversed()
[Int](nums.sorted().reversed())

var mutableNums = nums

mutableNums.sort()
mutableNums.reverse()

//위치바꾸기
mutableNums
mutableNums.swapAt(0, 1)
//렌덤으로 순서바꾸기
mutableNums.shuffle()


###################2021.07.07
Structure
###################2021.07.06
String Options #1
Case Insensitive Option
"A" == "a"
"A".caseInsensitiveCompare("a") == .orderedSame

"A" .compare("a", options: [.caseInsensitive])
    == .orderedSame

NSString.CompareOptions
//cont + Commd + click


Literal Option
let a = "\u{D55C}"
let b = "\u{1112}\u{1161}\u{11AB}"

a == b
a.compare(b) == .orderedSame

a.compare(b, options: [.literal]) == .orderedSame



Backwards Option
let korean = "행복하세요"
let english = "Be happy"
let arabic = "كن سعيدا"

if let range = english.range(of: "p", options: [.backwards]) {
    english.distance(from: english.startIndex, to:
                        range.lowerBound)
}
//backward는 문자열의 검색 방향을 바꾸는 옵션


Anchored Option
let str = "Swift Programing"

if let result = str.range(of: "Swift") {
    print(str.distance(from: str.startIndex, to:
                        result.lowerBound))
} else {
    print("not found")
}


if let result = str.range(of: "Swift", options:
                            [.backwards]) {
    print(str.distance(from: str.startIndex, to:
                        result.lowerBound))
} else {
    print("not found")
}

if let result = str.range(of: "Swift", options:
                            [.anchored]) {
    print(str.distance(from: str.startIndex, to:
                        result.lowerBound))
} else {
    print("not found")
}

if let result = str.range(of: "Swift", options:
                            [.anchored, .backwards]) {
    print(str.distance(from: str.startIndex, to:
                        result.lowerBound))
} else {
    print("not found")
}

str.lowercased().hasPrefix("swift")

if let _ = str.range(of: "swift", options:
                        [.anchored, .caseInsensitive]) {
    print("same prefix")
}


###################2021.07.05
###################2021.07.04
String Editing #2
###########Replacing Substrings
//문자열의 일부를 교체 및 삭제하는 방법
var str = "Hello, Objective-C"
if let range = str.range(of: "Objective-C") {
    str.replaceSubrange(range, with: "Swift")
}
str

if let range = str.range(of: "Hello") {
    _ = str.replacingCharacters(in: range, with: "Hi")
}

var s = str.replacingOccurrences(of: "Swift", with: "Awesome Swift")
s

s = str.replacingOccurrences(of: "swift", with: "Awesome Swift")

s
//대소문자 구분



#############Removing Substrings
//특정 문자나 범위 삭제 방법
var str = "Hello Awesome Swift!!!"

let lastCharIndex = str.index(before: str.endIndex)

var removed = str.remove(at: lastCharIndex)

removed
str

removed = str.removeFirst()
removed
str

str.removeFirst(2)
str

str.removeLast(2)
str

if let range = str.range(of: "Awesome") {
    str.removeSubrange(range)
str
}

str.removeAll()
str

str.removeAll(keepingCapacity: true)


str = "Hello, Awesome Swift!!!"

var substr = str.dropLast()

substr = str.dropLast(3)



String Editing #1
Appending Strings and Characters

//문자열을 편집하는 방법
//문자열 뒤에 새로운 문자열을 연결하는 방법

//[
//var str = "Hello"
//str.append(", ")
//str
//
//let s = str.appending("Swift")
//str
//s
//s.appending("!!")
//
//"File size is ".appendingFormat("%.1f", 12.3456)
//]

var str = "Hello Swift"

str.insert(",", at: str.index(str.startIndex, offsetBy: 5))

if let sIndex = str.firstIndex(of: "S") {
   str.insert(contentsOf: "Awesome", at: sIndex)
}
str


###################2021.07.03_3
SubString
let str = "Hello, Swift"
let l = str.lowercased()

var first = str.prefix(1)
//서브 스트링은 원본 문자열의 메모리를 공유한다

first.insert("!", at: first.endIndex)

str
first

let newStr = String(str.prefix(1))
//문자열에서 특정 범위를 추출하는 방법
//오류메세지 : Deprecated = 나중에 버젼 바뀌면 사용 안된다는 메세지

//let s = str[str.startIndex ..< str.index(str.startIndex, offsetBy: 2)]
//위 아래 같은 코드
let s = str[..<str.index(str.startIndex, offsetBy: 2)]

//1. 원본메모리를 공유한다
//2. s변수의 저장된 문자열을 바꾸지않는다면 새로운 문자열은 생성되지 않는다
//3. s변수의 저장된 문자열을 바꾸면 그 시점에 새로운 문자열 생성된다
//4. 직접 새로운 문자열을 생성하고 싶다면, String 생성자를 사용한다.

str [str.index(str.startIndex, offsetBy: 2)...]

let lower = str.index(str.startIndex, offsetBy: 2)
let upper = str.index(str.startIndex, offsetBy: 5)
str[lower ... upper]


###################2021.07.03_2  
String Basics  
//문자열 처리 테크닉

var str = "Hello, Swift String"
var emptystr = ""
emptystr = String()

let a = String(true)
//문자열 "true" ""로 확인

let b = String(12)
//숫자 12가 아닌 문자열 12
let c = String(12.34)

let d = String(str)

let hex = String(123, radix: 16)
//16진수
let octal = String(123, radix: 8)
//8진수
let binary = String(123, radix: 2)
//2진수

//문자열을 초기화할 때 그냥 지우는게 아니라 특정 문자를 원하는 개수만큼 채워서 초기화하는 방법
let reapeatStr = "💀"
let repeatStr = String(repeating: "💀", count: 7)
let unicode = "\u{1f44f}"

let e = "\(a) \(b)"
let f = a + b
//공백넣기" " ->   let f = a + " " + b
str  += "!!"

//문자열 개수 확인
str.count
str.count == 0
str.isEmpty

str == "Apple"
"apple" != "Apple"
"apple" < "Apple"

//대소문자 변환
str.lowercased()
str.uppercased()
str
//첫 문자를 대문자로 변환
str.capitalized
"apple ipad" .capitalized

for char in "Hello" {
    print(char)
}

//랜덤으로 뽑기
let num = "1234567890"
num.randomElement()

//섞어서 문자열로 배열하기
num.shuffled()


###################2021.07.03_1
String Indices
//문자열 인덱스

let str = "Swift"

let firstCh = str[str.startIndex]
print(firstCh)

let lastCharIndex = str.index(before: str.endIndex)
let lastCh = str[lastCharIndex]
print(lastCh)

let secondCharIndex = str.index(after: str.startIndex)
let secondCh = str[secondCharIndex]
print(secondCh)

var thirdCharIndex = str.index(str.startIndex, offsetBy: 2)
var thirdCh = str[thirdCharIndex]
print(thirdCh)

thirdCharIndex = str.index(str.endIndex, offsetBy: -3)
thirdCh = str[thirdCharIndex]
print(thirdCh)

if thirdCharIndex < str.endIndex && thirdCharIndex >=
    str.startIndex {
    
}


###################2021.07.02
_String Substring
_String Editing #1
_String Editing #2
_String Comparison
_String Searching
_String Options #1
_String Options #2


###################2021.07.01
_New String Interpolation
_String Indices
_String Index
_String Basics


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
