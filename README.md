# TIL

#####################################################################################2021.07.18
View & Window
_Overview
Text Views - Label, Text Field, Text View

Controls - Button, Switch, Slider, Page Control, Date Picker, Segmented Control, Steeper

Content Views - Image View, Picker View, Progress View,

                             Activity Indicator View, Web View, Map View

Container Views - Scroll View, Table View, Collection View

Bars - Navigation Bar, Tab Bar, Tool Bar, Search Bar



#####################################################################################2021.07.17
_Outlet and Action
_Delegate Pattern

#####################################################################################2021.07.16
_Mastering iOS
_Interface Builder

#####################################################################################2021.07.15
Mastering iOS
_Hello, Interface Builder
_Outlet and Action

#####################################################################################2021.07.13
Mastering iOS
_Hello, iOS Project
_Hello, Xcode


#####################################################################################2021.07.13
NEXT_iOS!

Inheritance and Polymorphism
_Inheritance
//상속
class Figure {
    var name = "Unknow"
    
    init(name: String){
        self.name = name
    }
    
    func draw() {
        print("draw \(name)")
    }
}

class Circle: Figure {
    var radius = 0.0
}

let c = Circle(name: "Circle")
c.radius
c.name
c.draw()
//서브클래스는 슈퍼클래스로부터 상속

final class
//파이널클래스는 상속이 금지
final Rectangle: Figure {
    var width = 0.0
    var height = 0.0
}

class Square: Rectangle {
    
}

#####################################################################################2021.07.11_3
Method and Subscrip
_
class Sample {
var data = 0
static var sharedDate = 123

func doSomething() {
    print(data)
    Sample.sharedDate
}

func call() {
    doSomething()
}
}

let a = Sample()
a.data
a.doSomething()
a.call()

struct Size {
var width = 0.0
var height = 0.0
//가평식에서 속성을 바꾸는 메소드를 구현할 때 , 반드시 뮤테이팅으로 선언해야한다.
mutating func enlarge() {
    width += 1.0
    height += 1.0
}
}

var s = Size()
s.enlarge()

_Type Method
Type Methods
class Circle {
    static let pi = 3.14
    var radius = 0.0
    
    func getArea() -> Double {
        return radius * radius * Circle.pi
    }
    class func printPi() {
        print(pi)
    }
}

Circle.printPi()

class StrokeCircle: Circle {
    override static func printPi() {
        print(pi)
    }
}

_Subscripts
let list = ["A", "B", "C"]
list[0]

class List {
var data = [1, 2, 3]
    subscript(i index: Int) -> Int {
        get {
            return data[index]
        }
        
        set {
            data[index] = newValue
        }
    }
}


var l = List()
l[i: 0]

l[i: 1] = 123

struct Matrix {
    var data = [[1, 2, 3],
    [4, 5, 6],
    [7, 8, 9]]
    
    subscript(row: Int, col: Int) -> Int {
        return data[row][col]
    }
}

let m = Matrix()
m[0, 0]

#####################################################################################2021.07.11_3
Property
_Stored Properties
struct Person {
    let name: String = "John Doe"
    var age: Int = 33


Explicit Member Expression
var p = Person()
p.name
p.age

p.age = 30

Lazy Stored Properties
struct Image {
    init() {
        print("new image")
    }
}

struct BlogPost {
    let title: String = "Title"
    let content: String = "Content"
    lazy var attachment: Image = Image()
    
    let date: Date = Date()
    
    lazy var formattedDate: String = {
        let f = DateFormatter()
        f.dateStyle = .long
        f.timeStyle = .medium
        return f.string(from: date)
    }
}

var post = BlogPost()
post.attachment


_Computed Properties
class Person {
   var name: String
   var yearOfBirth: Int

   init(name: String, year: Int) {
      self.name = name
      self.yearOfBirth = year
   }
    
    var age: Int {
            let calendar = Calendar.current
            let now = Date()
            let year = calendar.component(.year, from: now)
            return year - yearOfBirth
    
    }
}

let p = Person(name: "Jogn", year: 2002)
p.age

p.yearOfBirth


_Property Observer
class Size {
    var width = 0.0 {
        willSet {
            print(width, "=>", newValue)
        }
        didSet {
        print(oldValue, "=>", width)
        }
    }
}

let s = Size()
s.width = 123


_Type Properties
Stored Type Properties

class Math {
    static let pi = 3.14
}

let m = Math()
//m.pi
Math.pi


Computed Type Properties

enum Weekday: Int {
    case sunday = 1, monday, tuesday, wednesday,
         thursday, friday, saturday
    
    static var today: Weekday {
        let cal = Calendar.current
        let today = Date()
        let weekday = cal.component(.weekday, from: today)
        return Weekday(rawValue: weekday)!
        
    }
}

Weekday.today


_self
struct Size {
   var width = 0.0
   var height = 0.0
    
    mutating func reset(value: Double) {
//        width = value
//        height = value
        self = Size(width: value, height: value)
    }
}



//    func calcArea() -> Double {
//        return width * height
//    }
//
//    var area: Double {
//        return calcArea()
//    }
//
//    func update(width: Double, height: Double) {
//        self.width = width
//        self.height = height
//    }
//
//    func doSomething() {
//        let c = { self.width * self.height}
//    }
//
//    static let unit = ""
//
//    static func doSomething() {
//        //self.width
//        self.unit
//
//    }
//}
//셀프는 현재의 인스턴스에 접근하기 위해 사용하는 특별한 속성이다
//셀프를 타입멤버에서 사용하면 인스턴스가 아닌 형식 자체를 나타낸다

#####################################################################################2021.07.11_2
Structure and Class
_Structure
struct Person {
    var name: String
    var age: Int
    
    func speak() {
        print("Hello")
    }
}


let p = Person(name: "Steve", age: 50)

let name = "Paul"
name

p.name
p.age

p.speak()


Class
class Person {
    var name = "John Doe"
    var age = 0
    
    func speak() {
        print("Hello")
    }
}

let p = Person()

_Initializer Syntax
let str = "123"
let num = Int(str)

class Position {
    var x: Double
    var y: Double
    
    init() {
        x = 0.0
        y = 0.0
    }

//생성자는 속성 초기화가 제일 중요하고 유일한 목적, 생성자 실행이 종료되는 시점에는 모든 속성의 초기값이 저장되어 있어야 한다.

init(value: Double) {
    x = value
    y = value
  }
}

let a = Position()
a.x
a.y

let b = Position(value: 100)
b.x
b.y
//열거형,구조체,클래스는 모두 설계도이다
//설계도에 따라서 인스턴스를 만들기 위해서는 초기화 과정이 반드시 필요
//생성자를 호출하면 초기화가 시작되고 생성자 실행이 완료되면 모든 속성이 초기화된다
//에러 없이 초기화가 되면 인스턴스 생성

_Value Types and Reference Types
//가평식과 참조형식의 차이점
//분류방법
//스위프트에서 가평식은(구조체,열거형,튜플)  참조형식(클래스,클로져)

struct PositionValue {
    var x = 0.0
    var y = 0.0
}

var v = PositionValue()
var o = PositionValue()


var v2 = v
var o2 = o

v2.x = 12
v2.y = 34

v
v2


o2.x = 12
o2.y = 34

o
o2

_Nested Types
//형식 내부의 선언된 형식

class One {
    struct Two {
        enum Three {
            case a
            
            class Four {
                
            }
        }
    }
    
    var a = Two()
}

let two: One.Two = One.Two()



#####################################################################################2021.07.11
Enumeration
_Enumeration Types
let left = "left"
let center = "center"
let right = "right"

var alignment = center

if alignment == "Center" {
    
}

_Syntax
enum Alignment {
    case left
    case right
    case center
}

Alignment.center

var textAlignment = Alignment.center

textAlignment = .left

if textAlignment == .center {
    
}

switch textAlignment {
case .left:
    print("left")
case .right:
    print("right")
case .center:
    print("center")
}

###################2021.07.10_2
Set#1
Set

Set Type
//중복된 요소는 무시한다
let set: Set<Int> = [1, 2, 2, 3, 3, 3]
set.count


Inspecting a Set
set.count
//비어있는지 확인
set.isEmpty

Testing for Membership
//요소가 포함되어 있는지 확인
set.contains(1)

Adding and Removing Elements
var words = Set<String>()

var insertResult = words.insert("Swift")
insertResult.inserted
insertResult.memberAfterInsert

insertResult = words.insert("Swift")
insertResult.inserted
insertResult.memberAfterInsert

var updateResult = words.update(with: "Swift")
updateResult

updateResult = words.update(with: "Apple")
updateResult

var value = "Swift"
value.hashValue

updateResult = words.update(with: "value")
updateResult

value = "Hello"
value.hashValue

updateResult = words.update(with: "value")
updateResult

struct SampleData: Hashable {
    var hashValue: Int = 123
    var data: String
    
    init(  data: String) {
        self.data = data
    }
    static func ==(lhs: SampleData, rhs: SampleData)
    -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}


var sampleSet = Set<SampleData>()

var data = SampleData("Swift")
data.hashValue

var r = sampleSet.insert(data)
r.inserted
r.memberAfterInsert
sampleSet

data.data = insertResult(data)
r.inserted
r.memberAfterInsert
sampleSet

SmapleSet.update(with: data)
SampleSet


Set#2
Comparing Sets
var a: Set = [1, 2, 3, 4, 5, 6, 7, 8, 9]
var b: Set = [1, 3, 5, 7, 9]
var c: Set = [2, 4, 6, 8, 10]
let d: Set = [1, 7, 5, 9, 3]

a == b
a != b

b == d

b.elementsEqual(d)

a.isSubset(of: a)
a.isStrictSubset(of: a)

b.isSubset(of: a)
b.isStrictSubset(of: a)

a.isSubset(of: a)
a.isStrictSubset(of: a)

a.isSubset(of: b)
a.isStrictSubset(of: b)

a.isSubset(of: c)
a.isStrictSubset(of: c)


a.isDisjoint(with: b)
a.isDisjoint(with: c)
b.isDisjoint(with: c)



Combining Setsa = [1, 2, 3, 4, 5, 6, 7, 8, 9]
b = [1, 3, 5, 7, 9]
c = [2, 4, 6, 8, 10]

var result = b.union(c)

result = b.union(a)
b.formUnion(c)
b




###################2021.07.10
Dictionary#3
Comparing Dictionaries
let a = ["A": "Apple", "B": "Banana", "C": "City"]
let b = ["A": "Apple", "C": "City", "B": "Banana"]

a == b
a != b

//a.elementsEqual(b) { (lhs, rhs) -> Bool in
//    print(lhs.keym rhs.key)
//    return lhs.key.caseInsensitiveCompare(rhs.key)
//        == .orderedSame &&
//}
let aKeys = a.keys.sorted()
let bKeys = b.keys.sorted()

aKeys.elementsEqual(bKeys) { (lhs, rhs) -> Bool in
    guard lhs.caseInsensitiveCompare(rhs)
            == .orderedSame else {
        return false
    }
    
    guard let lv = a[lhs], let rv = b[rhs],
          lv.caseInsensitiveCompare(rv) == .orderedSame
    else {
        return false
    }
    return true
}



Finding Elements
//검색구현
//words?????????????
words = ["A": "Apple", "B": "Banana", "C": "City"]

let c: ((String, String)) -> Bool in = {
    $0.0 == "B" || $0.1.contains("i")
}

words.contains(where: c)

let r = words.first(where: c)
r?.key
r?.value


words.filter(c)

###################2021.07.09
Dictionary#1
Dictionary
Dictionary Literal

var dict = ["A": "Apple", "B": "Bnana"]
dict = [:]


Dictionary Type
//정식문법let dict1: Dictionary<String, Int>
//단축let dict2: [String: Int]


Creating a Dictionary
let words = ["A": "Apple", "B": "Banana", "C": "City"]

let emptyDict: [String: String] = [:]

let emptyDict2 = [String: String]()
let emptyDict3 = Dictionary<String, String>()


Inspecting a Dictionary
//저장된 요소의 숫자를 확인
words.count
words.isEmpty


Accessing Keys and Values
//저장되어있는 요소의 접근
words["A"]
words["Apple"]
//key를 통해 접근하기 때문에 애플은 인식못함

let a = words["E"]
let b = words["E", default: "Empty"]


for k in words.keys {
    print(k)
}

for v in words.values {
    print(v)
}

let keys = Array(words.keys)
let values = Array(words.values)

Dictionary#2
Adding Keys and Values
//새로운 요소를 추가하고 삭제하는 방법

var words = [String: String]()

words["A"] = "Apple"
words["B"] = "Banana"

words.count
words


words["B"] = "Ball"

words.count
words

//Key가 존재한다면 새로운 값을, 기존 값이 있다면 변경


words.updateValue("City", forKey: "C")

words.updateValue("Circle", forKey: "C")

//Insert + Update = Upsert



Removing Keys and Values
//요소를 삭제하는 방법
words
words["B"] = nil

words

words["Z"] = nil

//삭제하고 삭제된 값을 보여줌
words.removeValue(forKey: "A")
//삭제되서 nil
words.removeValue(forKey: "A")


//전체요소 삭제
words.removeAll()







###################2021.07.08
Dictionary


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
