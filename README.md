# TIL
#####################################################################################2021.10.05_2
Part_12
상속Inheritance, 초기화Initialization
#Part12 - 클래스의 상속과 초기화
1) 클래스의 상속
상속(Inheritance)

상속은 유일하게 클래스에서만 지원하는 기능(구조체는 상속 불가능)
/**=============================================================
 - 상속은 쉽게 말하면, 본질적으로 성격이 비슷한 타입을 새로만들어
 - 1) 데이터(저장속성)를 추가하거나 2) 기능(메서드)를 변형시키서 사용하려는 것
=============================================================**/

상속의 기본 문법
class AClass {
    var name = "이름"
}


class BClass: AClass {
    // name
    var id = 0
}


let b = BClass()


// BClass는 AClass를 상속해서 구현
// 서브클래스는 슈퍼클래스로부터 멤버를 상속함


// 클래스의 상속 금지의 키워드 final
// (경우에 따라서, 클래스의 상속을 금지해야하는 경우가 있음)


// (final를 각 멤버 앞에 붙인 경우, 해당 멤버 재정의 불가라는 뜻)


#상속(Inheritance)의 예시
기본적으로 상속은 데이터(저장 속성)을 추가하는 관점에서 생각
class Person {
    var id = 0
    var name = "이름"
    var email = "abc@gmail.com"
}


class Student: Person {
    // id
    // name
    // email
    
    var studentId = 0
}



class Undergraduate: Student {
    // id
    // name
    // email
    // studentId
    
    var major = "전공"
}




// 상위 클래스에서 존재하는 멤버를 변형하는 것을 재정의라고 함
// 재정의를 하려는 멤버에는 override 키워드를 붙여야함 (자세한 내용은 다음 강의에서 다룰 예정)


#UIKit의 상속 구조
/**=================================================================================
 - 실제 예시 - 상속이 어떤 식으로 쓰일 까?

 - 애플이 미리 만들어 놓은 UIKit에서는 상속의 구조가 세밀하고 복잡하게 만들어져 있음
 - 상속의 구조를 외울 필요는 없고, 대략적인 내용만 이해하면 됨 =====> 프레임워크 강의에서 자세하게 설명 예정
 ====================================================================================**/


#####################################################################################2021.10.05_1
Private, Sigleton
#접근 제어의 개념
접근 제어(Access Control)

class SomeClass {
    private var name = "이름"
    
    func nameChange(name: String) {
        self.name = name
    }
}



var s = SomeClass()
s.nameChange(name: "홍길동")


#Part11 - 3 싱글톤(Singleton)
싱글톤(Singleton) 패턴

싱글톤 패턴이 필요한 이유
/**=======================================================
 - 앱 구현시에, 유일하게 한개만 존재하는 객체가 필요한 경우에 사용
 - (특정한 유일한 데이터/관리 객체가 필요한 경우)

 - 한번 생성된 이후에는 앱이 종료될때까지, 유일한 객체로 메모리에 상주
=======================================================**/

싱글톤 패턴의 문법적 이해
class Singleton {
    // 타입 프로퍼티(전역변수)로 선언
    static let shared = Singleton()      // 자신의 객체를 생성해서 전역변수에 할당
    var userInfoId = 12345
    private init() {}
}


//:> 변수로 접근하는 순간 lazy하게 동작하여, 메모리(데이터 영역)에 올라감

Singleton.shared


let object = Singleton.shared
object.userInfoId = 1234567

Singleton.shared.userInfoId


let object2 = Singleton.shared    // 유일한 객체를 가르키는 것일뿐
object2.userInfoId


Singleton.shared.userInfoId




// 그렇지만 아래와 같은 것도 가능 ===> 새로운 객체를 생성한 것임

//let object3 = Singleton()
//object3.userInfoId



// private init() 설정으로 새로운 객체 추가적 생성이 불가하게 막는 것 가능

#실제 사용 예시
// 앱을 실행하는 동안, 하나의 유일한 객체만 생성되어서, 해당 부분을 관리

let screen = UIScreen.main    // 화면
let userDefaults = UserDefaults.standard    // 한번생성된 후, 계속 메모리에 남음!!!
let application = UIApplication.shared   // 앱
let fileManager = FileManager.default    // 파일
let notification = NotificationCenter.default   // 노티피케이션(특정 상황, 시점을 알려줌)
#####################################################################################2021.10.05
Subscript
#3) 서브스크립트
서브스크립트(Subscripts) - (배열, 딕셔너리에서 이미 경험)

/**=====================================
- 서브스크립트?
- 대괄호를 이용해서 접근가능하도록 만든 문법을 가르킴

 - 배열
   array[인덱스]

 - 딕셔너리
   dictionary[키]
========================================**/



var array = ["Apple", "Swift", "iOS", "Hello"]


array[0]
array[1]



// 내부적으로 대괄호를 사용하면 어떤 값을 리턴하도록 구현이 되어 있어서 가능한 일



// 인스턴스.0
// 인스턴스.method()   =====> 이런 형태가 아닌

// 인스턴스[파라미터]     =====> 이런 형태로 동작을 가능하게한 문법 (대괄호로 메서드의 기능을 대신)


#서브스크립트는 특별한 형태의 메서드
(인스턴스) 서브스크립트(Subscripts)의 직접 구현 - 클래스, 구조체, (열거형)
// 인스턴스 메서드로써의 서브스크립트 구현


class SomeData {
    var datas = ["Apple", "Swift", "iOS", "Hello"]

    
    subscript(index: Int) -> String {     // 1) 함수와 동일한 형태이지만, 이름은 subscript
        get {                             // 2) get/set은 계산속성에서의 형태와 비슷
            return datas[index]
        }
        set(parameterName) {
            datas[index] = parameterName         // 또는 파라미터 생략하고 newValue로 대체 가능(계산 속성의 setter와 동일)
        }
    }
    
}


var data = SomeData()
data[0]
//data[0] = "AAA"



// 파라미터 생략 불가(값이 반드시 필요)
// 리턴형도 생략 불가능(저장할 값의 타입 명시 필요)

// 읽기 전용(read-only)으로 선언 가능 (set블록은 선택적으로 구현이 가능하고, 쓰기 전용으로의 선언은 불가)


Int.random(in: 1...10)


#서브스크립트 사용 예시 - 대괄호 형태로 사용하는 메서드이다.
struct TimesTable {
    let multiplier: Int = 3
    
    subscript(index: Int) -> Int {
        return multiplier * index
    }
}


let threeTimesTable = TimesTable()

print("6에 3배를 하면 숫자 \(threeTimesTable[6]) 이(가) 나옵니다.")






struct Matrix {
    // 2차원 배열
    var data = [["1", "2", "3"], ["4", "5", "6"], ["7", "8", "9"]]
    
    // 2개의 파라미터를 받는 읽기전용 서브스크립트의 구현
    subscript(row: Int, column: Int) -> String? {
        if row >= 3 || column >= 3 {
            return nil
        }
        return data[row][column]
    }
}


// 2개의 파라미터를 받는 서브스크립트 구현도 가능


var mat = Matrix()

mat[0, 1]!     // 대괄호 안에 파라미터 2개 필요

#타입 서브스크립트(Type Subscripts) - 클래스, 구조체, (열거형)
enum Planet: Int {   // 열거형의 원시값
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
    
    static subscript(n: Int) -> Planet {    // Self
        return Planet(rawValue: n)!
    }
}

let mars = Planet[4]      // Planet.venus
print(mars)




// static 또는 class 키워드로 타입 자체의 서브스크립트 구현 가능
// class는 상속시 재정의 가능
#####################################################################################2021.10.04_1
Type Method
타입 메서드(Type Methods)
// 메서드이지만, 인스턴스의 성격이 아닌 타입 자체의 성격에 가까운 메서드 일때

class Dog {
    static var species = "Dog"
    
    var name: String
    var weight: Double
    
    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
    
    func sit() {
        print("\(name)가 앉았습니다.")
    }
    
    func trainning() {
        print("월월 저는 \(Dog.species)입니다.")
        sit()
        sit()
        self.sit()
    }
    
    func changeName(newName name: String) {
        self.name = name
    }
    
    static func letmeKnow() {     // 타입 메서드에서, 타입속성에 접근시에는 타입으로 접근하지 않아도 됨
        print("종은 항상 \(species)입니다.")      // Dog.species라고 써도됨
    }
    
}


let bori = Dog(name: "보리", weight: 20.0)
bori.sit()


bori.changeName(newName: "말썽쟁이보리")
bori.sit()


// 타입 메서드의 호출 ⭐️

Dog.letmeKnow()



// 인스턴스 기능이 아닌, 타입 자체에 필요한 기능을 구현할때 주로 사용
// 타입 자제가 가져야 하는 공통된 기능(동작) 구현시


#실제, 타입 메서드 사용 예시
//Int.random(in: <#T##Range<Int>#>)

Int.random(in: 1...100)



//Double.random(in: <#T##ClosedRange<Double>#>)
Double.random(in: 1.2...3.7)

#클래스 - 타입 메서드의 상속
// 상속부분을 공부하고 다시 살펴볼 예정
// 타입 메서드를 상속시 재정의가능 하도록 하려면 ===> static 키워드를 상속가능한 class 키워드로 바꿔야함

// 상위클래스

class SomeClass {
    class func someTypeMethod() {     // 타입 메서드
        print("타입과 관련된 공통된 기능의 구현")
    }
}


SomeClass.someTypeMethod()



// 상속한 서브클래스

class SomeThingClass: SomeClass {
    override class func someTypeMethod() {
        //super.someTypeMethod()
        print("타입과 관련된 공통된 기능의 구현(업그레이드)")
    }
}



SomeThingClass.someTypeMethod()


#class - 상속시 재정의 가능 키워드
// static 키워드로 선언하면 (상속시)재정의 불가 (상속이 불가한 것 아님)
#####################################################################################2021.10.04
Instance Method
Part11 - 2 구조체, 클래스의 메서드
#1) 인스턴스 메서드
인스턴스 메서드(Instance Methods)

class Dog {
    var name: String
    var weight: Double
    
    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
    
    func sit() {
        print("\(name)가 앉았습니다.")
    }
    
    func layDown() {
        print("\(name)가 누웠습니다.")
    }
    
    func play() {
        print("열심히 놉니다.")
    }
    
    func changeName(newName name: String) {
        self.name = name
    }
}



let bori = Dog(name: "보리", weight: 20.0)

// 인스턴스(객체)의 메서드

bori.sit()
bori.layDown()
bori.play()


bori.changeName(newName: "말썽쟁이보리")
bori.name
bori.sit()
bori.layDown()
bori.play()




let choco = Dog(name: "초코", weight: 20.0)

// 인스턴스(객체)의 메서드는 인스턴스의 이름을 통해 호출 가능

choco.sit()
choco.layDown()
choco.play()


#클래스의 인스턴스 메서드(Instance Methods)
class Dog1 {
    static var species = "Dog"
    
    var name: String
    var weight: Double
    
    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
    
    func sit() {
        print("\(name)가 앉았습니다.")
    }
    
    func trainning() {
        print("월월 저는 \(Dog1.species)입니다.")
        sit()
        sit()
        self.sit()     // self키워드는 명확하게 지칭하는 역할일 뿐
    }
    
    func changeName(newName name: String) {
        self.name = name
    }
    
}


let bori1 = Dog1(name: "보리", weight: 20.0)
bori1.trainning()


bori1.changeName(newName: "말썽쟁이보리")
bori1.sit()

#구조체의 인스턴스 메서드(Instance Methods)
// 값 타입(구조체, 열거형)에서 기본적으로 인스턴스 메서드 내에서 속성을 수정할 수 없음
// 수정하려면, mutating(변형되는)키워드를 붙이면 속성 수정 가능해짐(클래스와 구조체의 차이)


struct Dog2 {
    var name: String
    var weight: Double
    
    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
    
    func sit() {
        print("\(name)가 앉았습니다.")
    }
    
    mutating func changeName(newName name: String) {
        self.name = name
    }
    
}

#값타입의 인스턴스 메서드 내에서 자신의 속성값 수정은 원칙적 불가 ➞ mutating 키워드 필요
// mutate: 변형되다 (mutating - 변형되는)
// 컴파일러가 알아서 수정해줌 (실수에 대한 자동 방지가 되지만, 문법적으로 인지하고 있어야함)


#오버로딩(Overloading)
// 함수에서의 오버로딩과 동일하게, 클래스, 구조체, 열거형의 메서드에서도 오버로딩을 지원


