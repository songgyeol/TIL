# TIL
#####################################################################################2021.10.13_3
Any, AnyObject✔
#Any와 AnyObject를 위한 타입 캐스팅
Any와 AnyObject 타입

/**===================================================================
 - 스위프트에서 제공하는 불특정한 타입을 다룰 수 있는 타입을 제공
 
 1) Any 타입
 - 기본 타입(Int, String, Bool, ...) 등 포함, 커스텀 클래스, 구조체, 열거형, 함수타입
   까지도 포함해서 어떤 타입의 인스턴스도 표현할 수 있는 타입 (옵셔널타입도 포함)
 
 2) AnyObject 타입
 - 어떤 클래스 타입의 인스턴스도 표현할 수 있는 타입
======================================================================**/



// 1) Any타입 ============================================

var some: Any = "Swift"
some = 10
some = 3.2



// 단점 ===> 저장된 타입의 메모리 구조를 알 수없기 때문에, 항상 타입캐스팅해서 사용해야함 ⭐️


class Person {
    var name = "이름"
    var age = 10
}

class Superman {
    var name = "이름"
    var weight = 100
}


// Any타입의 장점: 모든 타입을 담을 수 있는 배열을 생성 가능            // (String) -> String
let array: [Any] = [5, "안녕", 3.5, Person(), Superman(), {(name: String) in return name}]


//array[1].count
(array[1] as! String).count





// 2) AnyObject타입 =======================================
//클래스의 객체만 담을 수 있는 타입

let objArray: [AnyObject] = [Person(), Superman(), NSString()]

//objArray[0].name
(objArray[0] as! Person).name







// 타입캐스팅 + 분기처리

for (index, item) in array.enumerated() {
    // (0,  5)
    // (1, "안녕")
    // (2, 3.5)
    // ...
    
    switch item {
    case is Int:                                  // item is Int
        print("Index - \(index): 정수입니다.")
    case let num as Double:                       // let num = item as Double
        print("Index - \(index): 소수 \(num)입니다.")
    case is String:                               // item is String
        print("Index - \(index): 문자열입니다.")
    case let person as Person:                    // let person = item as Person
        print("Index - \(index): 사람입니다.")
        print("이름은 \(person.name)입니다.")
        print("나이는 \(person.age)입니다.")
    case is (String) -> String:                   // item is (String) -> String
        print("Index - \(index): 클로저 타입입니다.")
    default:
        print("Index - \(index): 그 이외의 타입입니다.")
    }
}


#옵셔널값의 Any 변환
/**==================================================================
- 의도적인 옵셔널값의 사용
- Any는 모든 타입을 포함하므로, 의도적인 옵셔널값을 사용하려면 Any타입으로 변환하면
  컴파일러가 알려주는 경고를 없앨 수 있음
 
- 왜?
- 옵셔널값은 임시적인 값일 뿐이므로, 일반적으로 개발자들은 옵셔널 바인딩을 해서
  언래핑해서 안의 값을 사용해야함 ===> 그래서 경고를 통해 알려줌
  (Any로 변환하겠다는 것은 그 자체를 사용하겠다는 의미임 ===> 경고 없음)
==================================================================**/



let optionalNumber: Int? = 3
print(optionalNumber)          // 경고
print(optionalNumber as Any)   // 경고 없음

#####################################################################################2021.10.13_2
상속과 다형성✔
#타입과 다형성(Polymorphism)
상속관계에서 인스턴스의 다형성에 대한 이해

class Person {
    var id = 0
    var name = "이름"
    var email = "abc@gmail.com"
    
    func walk() {
        print("사람이 걷는다.")
    }
}


class Student: Person {
    // id
    // name
    // email
    var studentId = 1
    
    override func walk() {         // 재정의 메서드. walk() - 1
        print("학생이 걷는다.")
    }
    
    func study() {
        print("학생이 공부한다.")
    }
}



class Undergraduate: Student {
    // id
    // name
    // email
    // studentId
    var major = "전공"
    
    override func walk() {       // 재정의 메서드. walk() - 2
        print("대학생이 걷는다.")
    }
    
    override func study() {      // 재정의 메서드. study() - 1
        print("대학생이 공부한다.")
    }
    
    func party() {
        print("대학생이 파티를 한다.")
    }
}



let person1 = Person()
person1.walk()



let student1 = Student()
//let student1: Person = Student()
student1.walk()
student1.study()



let undergraduate1 = Undergraduate()
//let undergraduate1: Person = Undergraduate()
undergraduate1.walk()
undergraduate1.study()
undergraduate1.party()


#다형성(Polymorphism) ⭐️ (여러가지 모양)
/**================================================================
 [다형성(Polymorphism)]
 - 하나의 객체(인스턴스)가 여러가지의 타입의 형태로 표현될 수 있음을 의미.
   (또는 하나의 타입으로 여러 종류의 객체를 여러가지 형태(모습)로 해석될 수 있는 성격)
 
 - 다형성이 구현되는 것은 "클래스의 상속"과 깊은 연관이 있음(향후 배울 프로토콜과도 연관)
===================================================================**/



let people: [Person] = [Person(), Student(), Undergraduate()]


// 반복문
for person in people {
    person.walk()
}


// 한개씩
people[0].walk()     // Person 타입으로 인식 (Person 인스턴스)
people[1].walk()     // Person 타입으로 인식 (Student 인스턴스)
people[2].walk()     // Person 타입으로 인식 (Undergraduate 인스턴스)


#상속관계에서 다형성은 메서드를 통해 발현
/**============================================================
 - 업캐스팅된 타입(Person) 형태의 메서드를 호출하더라도 실제 메모리에서 구현된
   "재정의된" 메서드(Undergraduate의 메서드 테이블)가 호출되어 실행 ⭐️
 
 - 타입의 저장 형태는 속성/메서드에 대한 접근가능 범위를 나타내는 것이고,
   다형성은 인스턴스에서 메모리의 실제 구현 내용에 대한 것임
   (메서드는 재정의 가능하고, 메서드 테이블을 통해 동작)
 =============================================================**/

#####################################################################################2021.10.13_1
다운캐스팅의 정확한 의미에 대한 이해✔
타입 캐스팅
인스턴스 타입을 검사 - is 연산자 / 클래스 계층 상의 타입 변환 - as 연산자

상속: 기본적으로 데이터(저장 속성)를 추가하는 관점에서 생각


class Person {
    var id = 0
    var name = "이름"
    var email = "abc@gmail.com"
}


class Student: Person {
    // id
    // name
    // email
    var studentId = 1
}


class Undergraduate: Student {
    // id
    // name
    // email
    // studentId
    var major = "전공"
}



let person1 = Person()
person1.id
person1.name
person1.email



let student1 = Student()
student1.id
student1.name
student1.email
student1.studentId // 추가적으로



let undergraduate1 = Undergraduate()
undergraduate1.id
undergraduate1.name
undergraduate1.email
undergraduate1.studentId
undergraduate1.major    //  추가적으로


인스턴스 타입의 (메모리구조에 대한) 힌트를 변경하는 - as 연산자 (type cast operator)

as 연산자
/**===================================================================
 - 타입캐스팅 / 타입캐스팅 연산자 (이항 연산자)
 (1) Upcasting (업캐스팅)
 - 인스턴스 as 타입
 - 하위클래스의 메모리구조로 저장된 인스턴스를 상위클래스 타입으로 인식

 (2) Downcasting (다운캐스팅) (실패가능성이 있음)
 - 인스턴스 as? 타입  / 인스턴스 as! 타입
   ▶︎ as? 연산자
    - 참이면 반환타입은 Optional타입
    - 실패시 nil 반환
   ▶︎ as! 연산자
    - 참이면 반화타입은 Optional타입의 값을 강제 언래핑한 타입
    - 실패시 런타임 오류
 
 [타입캐스팅의 의미]
 - 인스턴스 사용시에 어떤 타입으로 사용할지(속성/메서드) 메모리구조에 대한 힌트를 변경하는 것
 - 메모리의 값을 수정하는 것이 아님
 - (단순히 해당 타입의 인스턴스인 것처럼 취급하려는 목적)
======================================================================**/



let person: Person = Person()
person.id
person.name
person.email
//person.studentId    // Value of type 'Person' has no member 'studentId'
//person.major          // Value of type 'Person' has no member 'major'



/**=========================
 [Undergraduate인스턴스]
 - id: 0
 - name: "이름"
 - email: "abc@gmail.com"
 - studentId: 0
 - major: "전공"
 ==========================**/

// 그런데, 왜 studentId 와 major 속성에는 접근이 되지 않을까? ⭐️

// person2변수에는 Person타입이 들어있다고 인식되는 것임
// ===> 그래서 접근불가 ===> 접근하고 싶다면 메모리구조에 대한 힌트(타입)를 변경 필요


#as? / as! (다운캐스팅)
let ppp = person as? Undergraduate  // Undergraduate? 타입



if let newPerson = person as? Undergraduate {   // if let 바인딩과 함께 사용 (옵셔널 언래핑)
    newPerson.major
    print(newPerson.major)
}

// 실제로 인스턴스의 접근 범위를 늘려주는 것 뿐임

let person3: Undergraduate = person as! Undergraduate
person3.major


#as (업캐스팅)
let undergraduate2: Undergraduate = Undergraduate()
undergraduate2.id
undergraduate2.name
undergraduate2.studentId
undergraduate2.major
//undergraduate2.name = "길동"




let person4 = undergraduate2 as Person       // 항상 성공 (컴파일러가 항상 성공할 수 밖에 없다는 것을 알고 있음)
person4.id
person4.name
//person4.studentId
//person4.major


##참고) as 연산자의 활용
Bridging (브릿징) ➞ 서로 호환되는 형식을 캐스팅해서 쉽게 사용하는 것
// 스위프트에서는 내부적으로 여전히 Objective-C의 프레임워크를 사용하는 것이 많기 때문에
// 서로 완전히 상호 호환이 가능하도록 설계해놓았음(completely interchangeable)
// 타입 캐스팅을 강제(as!)할 필요 없음


let str: String = "Hello"
let otherStr = str as NSString

#####################################################################################2021.10.13
is / as 연산자
Part13 - 타입캐스팅(Type Casting)
타입 캐스팅
인스턴스 타입을 검사 - is 연산자 / 클래스 계층 상의 타입 변환 - as 연산자

상속: 기본적으로 데이터(저장 속성)를 추가하는 관점에서 생각
class Person {
    var id = 0
    var name = "이름"
    var email = "abc@gmail.com"
}


class Student: Person {
    // id
    // name
    // email
    var studentId = 1
}



class Undergraduate: Student {
    // id
    // name
    // email
    // studentId
    var major = "전공"
}



let person1 = Person()
person1.id
person1.name
person1.email



let student1 = Student()
student1.id
student1.name
student1.email
student1.studentId // 추가적으로



let undergraduate1 = Undergraduate()
undergraduate1.id
undergraduate1.name
undergraduate1.email
undergraduate1.studentId
undergraduate1.major    //  추가적으로

#인스턴스 타입을 검사하는 - is 연산자 (type check operator)
is 연산자 - 타입에 대한 검사를 수행하는 연산자
/**==================================
 - 인스턴스 is 타입   (이항연산자)
   ▶︎ 참이면 true 리턴
   ▶︎ 거짓이면 false 리턴
 
 - 상속관계의 계층에서 포함관계를 생각해보면 쉬움
=====================================**/


// 사람 인스턴스는 학생/대학생 타입은 아니다. (사람 타입이다.)
person1 is Person                // true
person1 is Student               // false
person1 is Undergraduate         // false


// 학생 인스턴스는 대학생 타입은 아니다.  (사람/학생 타입니다.)
student1 is Person               // true
student1 is Student              // true
student1 is Undergraduate        // false


// 대학생 인스턴스는 사람이거나, 학생이거나, 대학생 타입 모두에 해당한다.
undergraduate1 is Person         // true
undergraduate1 is Student        // true
undergraduate1 is Undergraduate  // true




// 예제를 통한 활용

let person2 = Person()
let student2 = Student()
let undergraduate2 = Undergraduate()


let people = [person1, person2, student1, student2, undergraduate1, undergraduate2]


// 학생 인스턴스의 갯수를 세고 싶다.

var studentNumber = 0

for someOne in people {
    if someOne is Student {
        studentNumber += 1
    }
}


print(studentNumber)

#####################################################################################2021.10.12_7
소멸자(Deinitialization)
#소멸 - 초기화 해제
소멸(Deinitialization)

/**==================================================================
 - 소멸자
 - 인스턴스가 메모리에서 해제되기 직전 정리가 필요한 내용을 구현하는 메서드
 - 클래스 정의시 클래스에는 최대 1개의 소멸자(deinitializer)를 정의 가능
 - 소멸자는 파라미터(매개 변수)를 사용하지 않음
 
 - 소멸자(초기화 해제) 작동 방식
 - Swift는 클래스의 인스턴스(객체)를 자동 참조 계산(ARC) 방식을 통해 메모리 관리
 - 일반적인 경우(강한 순환 참조를 제외한)에는 메모리에서 해제될때
 - 수동으로 관리를 수행할 필요가 없음
 
 
 - 그러나 특별한 작업을 수행중인 경우, 몇가지 추가 정리를 직접 수행해야 할 수 있음
 - 예) 인스턴스에서 파일을 열고 일부 데이터를 쓰는 경우,
      클래스 인스턴스가 할당 해제되기 전에 파일을 닫아야 파일에 손상이 안 갈 수 있음
 - 소멸자에서는 인스턴스의 모든 속성에 액세스 할 수 있으며
   해당 속성을 기반으로 동작을 수정할 수 있음 (예 : 닫아야하는 파일의 이름 조회)
 
 
 [상속이 있는 경우]
 - 상위클래스 소멸자는 해당 하위클래스에 의해 상속됨
 - 상위클래스 소멸자는 하위클래스 소멸자의 구현이 끝날 때 자동으로 호출됨
 - 상위클래스 소멸자는 하위클래스가 자체적인 소멸자를 제공하지 않더라도 항상 호출됨
====================================================================**/


#소멸자(Deinitialers)
class Aclass {
    var x = 0
    var y = 0
    
    deinit {
        print("인스턴스의 소멸 시점")
    }
}



var a: Aclass? = Aclass()
a = nil   // 메모리에 있던 a인스턴스가 제거됨

#소멸자는 클래스에만 존재
// 생성자는 필요한 만큼 구현할 수 있지만, 소멸자는 하나만 구현 가능함
// 소멸자는 직접호출할 수 없고(직접 호출하는 문법이 없고),
// 인스턴스(객체)가 메모리에서 제거되기 직전에 자동으로 호출됨⭐️

#####################################################################################2021.10.12_6
실패가능생성자 Failable
#실패가능 생성자
실패가능 생성자(Failable Initializers) - init?(파라미터)

/**============================================================================
 - 실패가능 생성자는 인스턴스 생성에 실패할 수도 있는 가능성을 가진 생성자 (클래스, 구조체, 열거형 가능)
   (실패가 불가능하게 만들어서, 아예 에러가 나고 앱이 완전히 꺼지는 가능성보다는
    실패가능 가능성 생성자를 정의하고 그에 맞는 예외 처리를 하는 것이 더 올바른 방법임)

 - 생성자에 ?를 붙여서 init?(파라미터) 라고 정의하면 실패가능 생성자로 정의되는 것임
   (다만, 동일한 파라미터를 가진 생성자는 유일해야함. 오버로딩으로 실패가능/불가능을 구분 짓지 못함)
===============================================================================**/



struct Animal {
    let species: String
    
    // 실패가능 생성자
    init?(species: String) {
        if species.isEmpty {
            return nil            // 생성자 내에서 실패 가능 부분에 nil을 리턴하면 됨  (문법적 약속)
        }
        self.species = species
    }
    
}


let a = Animal(species: "Giraffe")    // ====> 인스턴스 생성

let b = Animal(species: "")           // 문자열이기에 유효한 타입이지만 =====> nil



// 엄밀히 말하면 생성자는 값을 반환하지 않고, 초기화가 끝날 때까지 모든 저장 속성이 값을 가져 올바르게 초기화되도록하는 것임
// 초기화 성공을 나타 내기 위해 return 키워드를 사용하지 않음 (문법적 약속)

#열거형의 실패가능 생성자 활용
enum TemperatureUnit {
    case kelvin
    case celsius
    case fahrenheit
    
    init?(symbol: Character) {
        switch symbol {
        case "K":
            self = TemperatureUnit.kelvin
        case "C":
            self = TemperatureUnit.celsius
        case "F":
            self = TemperatureUnit.fahrenheit
        default:
            return nil
        }
    }
}


let c: TemperatureUnit = TemperatureUnit.celsius      // TemperatureUnit()

let f: TemperatureUnit? = TemperatureUnit(symbol: "F")



// 열거형의 원시값 설정 (실패가능 생성자의 구현과 유사)

enum TemperatureUnit1: Character {
    case kelvin = "K"
    case celsius = "C"
    case fahrenheit = "F"
}


// 원시값이있는 열거형은 자동으로 실패가능 생성자 init?(rawValue :)를 구현함 ==> 일치하면 인스턴스 생성, 아니면 nil

 
let f1: TemperatureUnit1? = TemperatureUnit1(rawValue: "F")     // .fahrenheit

let u: TemperatureUnit1? = TemperatureUnit1(rawValue: "X")      // nil


#1)초기화 실패의 전달 (호출관계)
/**============================================================
 - (한마디로) 실패불가능 생성자는 다른 실패가능 생성자를 호출 불가능 ⭐️
 
 (동일단계 - 델리게이트 어크로스)
 - 실패가능  ===> 실패불가능  (호출/위임) (OK)
 - 실패불가능 ===> 실패가능   (호출/위임) (X)
 
 (상속관계 - 델리게이트 업)
 - (상위)실패가능  <=== (하위)실패불가능  (호출/위임)  (X)
 - (상위)실패불가능 <=== (하위)실패가능   (호출/위임)  (OK)
 

 - 두 경우 모두 초기화 실패를 유발하는 다른 생성자에 위임하면
 - 전체 초기화 프로세스가 즉시 실패하고 더 이상 초기화 코드가 실행되지 않음
==============================================================**/


// 상속관계에서의 호출 예제

// 상품

class Product {
    let name: String
    init?(name: String) {
        if name.isEmpty { return nil }
        self.name = name
    }
}


// 온라인 쇼핑 카트의 항목을 모델링

class CartItem: Product {
    let quantity: Int
    init?(name: String, quantity: Int) {
        if quantity < 1 { return nil }     // 상품의 갯수가 1보다 작으면 ====> 카트 항목 생성 실패
        self.quantity = quantity           // 수량이 한개 이상이면 ====> 초기화 성공
        super.init(name: name)             // "" (빈문자열이면)  ====> 실패 가능 위임 OK
    }
}



if let twoSocks = CartItem(name: "sock", quantity: 2) {
    print("아이템: \(twoSocks.name), 수량: \(twoSocks.quantity)")
}



if let zeroShirts = CartItem(name: "shirt", quantity: 0) {
    print("아이템: \(zeroShirts.name), 수량: \(zeroShirts.quantity)")
} else {
    print("zero shirts를 초기화 불가(갯수가 없음)")
}



if let oneUnnamed = CartItem(name: "", quantity: 1) {
    print("아이템: \(oneUnnamed.name), 수량: \(oneUnnamed.quantity)")
} else {
    print("이름없는 상품 초기화 불가")
}

#2)(상속관계에서) 재정의 하기
/**===============================================================
 - (상위)실패가능  ===> (하위)실패불가능  재정의 (OK)  (강제 언래핑 활용 가능)
 - (상위)실패불가능 ===> (하위)실패가능   재정의  (X)
 ===============================================================**/

범위로 따져보기(실패가능 생성자의 범위가 더 큼)
// 서류라는 클래스 정의

class Document {
    
    var name: String?
    
    init() {}                // 서류 생성 (실패불가능) (이름은 nil로 초기화)
    
    init?(name: String) {    // 실패가능 생성자 ===> 이름이 "" 빈문자열일때, 초기화 실패(nil)
        if name.isEmpty { return nil }
        self.name = name
    }
}


// 자동으로 이름지어지는 서류

class AutomaticallyNamedDocument: Document {
    
    override init() {                // 재정의 (상위) 실패불가능 =====> (하위) 실패불가능
        super.init()
        self.name = "[Untitled]"
    }
    
    override init(name: String) {    // 재정의 (상위) 실패가능 =====> (하위) 실패불가능
        super.init()                 // 실패불가능 활용가능
        if name.isEmpty {
            self.name = "[Untitled]"
        } else {
            self.name = name
        }
    }
}


let autoDoc = AutomaticallyNamedDocument(name: "")
autoDoc.name



// 이름없는(Untitled) 서류

class UntitledDocument: Document {
    
    override init() {               // 재정의 (상위) 실패가능 =====> (하위) 실패불가능
        //super.init()
        super.init(name: "[Untitled]")!    // 강제 언래핑(!)으로 구현 ⭐️
    }
}


#실패가능 생성자를 init!(파라미터)로 정의하기
/**=========================================================================
 - 일반적으로 init 키워드 (init?) 뒤에 물음표를 배치하여 적절한 유형의 선택적 인스턴스를 생성하는
   실패 가능한 이니셜 라이저를 정의함. 또는 적절한 유형의 암시적으로 래핑되지 않은 선택적
   인스턴스를 만드는 실패 가능한 이니셜 라이저를 정의 할 수 있음.
   
 - 물음표 대신 init 키워드 (init!) 뒤에 느낌표

  ================================
 - init? ====> init! 위임 가능
 - init! ====> init? 위임 가능

 - init? ====> init! 로 재정의 가능
 - init! ====> init? 로 재정의 가능
 =================================


 - init ====> init! 위임 가능 (실패할 수도 있어짐) ⭐️
=============================================================================**/

#####################################################################################2021.10.12_5
필수생성자 Required
#필수 생성자
필수 생성자(Required Initializers)

class Aclass {
    var x: Int
    required init(x: Int) {
        self.x = x
    }
}


// 클래스 생성자 앞에 required(요구된/필수의) 키워드 사용시
// 하위 생성자는 반드시 해당 필수 생성자를 구현 해야함



class Bclass: Aclass {
//    required init(x: Int) {
//        super.init(x: x)
//    }
}


// 하위 클래스에서 필수생성자를 구현할 때는, 상위 필수생성자를 구현하더라도
// override(재정의) 키워드가 필요없고, required 키워드만 붙이면 됨

#필수생성자 자동 상속 조건: 다른 지정 생성자 구현 안하면 ➞ 자동 상속
// (자동상속 조건을 따르기 때문에, 다른 지정 생성자 구현 안하면 자동으로 필수생성자 상속됨)




class Cclass: Aclass {
    init() {
        super.init(x: 0)
    }
    
    required init(x: Int) {
        super.init(x: x)       // 호출시 required init으로 호출하지 않음
    }
}


// init() 생성자를 구현하면, 자동 상속 조건을 벗어나기 때문에
// required init(x: Int) 필수생성자 구현해야 함

#필수 생성자 사용 예시 (UIView)
class AView: UIView {
//    required init?(coder: NSCoder) {         // 구현을 안해도 자동상속
//        fatalError("init(coder:) has not been implemented")
//    }
}


class BView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

#####################################################################################2021.10.12_4
지정생성자와 편의생성자의 예외사항
#클래스의 지정, 편의 생성자 상속의 예외사항
클래스의 생성자 자동 상속 규칙

지정생성자 자동상속의 예외 상황 → 저장속성의 기본값 설정
/**============================================================
 - 새 저장 속성이 아예 없거나, 기본값이 설정되어 있다면 (실패 가능성 배제)
   ===> 슈퍼클래스의 지정생성자 모두 자동 상속(하위에서 어떤 재정의도 하지 않으면)
===============================================================**/

편의생성자 자동상속의 예외 상황 → 상위지정생성자 모두 상속
/**============================================================
   (초기화 실패 가능성 배제시) 자동 상속
 
 - (1) 지정 생성자 자동으로 상속하는 경우
 - (2) 상위 지정생성자 모두 재정의 구현 (실패 가능성 배제)

   (결국, 모든 지정생성자를 상속하는 상황이 되면 편의생성자는 자동으로 상속됨)
===============================================================**/


지정 생성자와 편의 생성자의 실제 사례 - 애플 공식 문서
// 음식

class Food {
    var name: String
    
    init(name: String) {     // 지정생성자
        self.name = name
    }
    
    convenience init() {     // 편의생성자 ===> 지정생성자 호출
        self.init(name: "[Unnamed]")
    }
}



let namedMeat = Food(name: "Bacon")   // namedMeat의 이름은 "Bacon"
namedMeat.name

let mysteryMeat = Food()      // mysteryMeat의 이름은 "[Unnamed]"
mysteryMeat.name


// 상위의 지정생성자 ⭐️
// init(name: String)    지정생성자
// convenience init()    편의생성자


// 레서피 재료

class RecipeIngredient: Food {
    var quantity: Int
    
    init(name: String, quantity: Int) {  // 모든 속성 초기화
        self.quantity = quantity
        super.init(name: name)
    }
    
    override convenience init(name: String) {    // 상위 지정생성자를 편의생성자로 재정의 ===> 지정생성자 호출
        self.init(name: name, quantity: 1)
    }
    
    // convenience init() { }      // 자동 상속 (예외 규칙)
}



let oneMysteryItem = RecipeIngredient()    //  편의생성자
oneMysteryItem.name
oneMysteryItem.quantity

let oneBacon = RecipeIngredient(name: "Bacon")
let sixEggs = RecipeIngredient(name: "Eggs", quantity: 6)



// 상위의 지정생성자 ⭐️
// init(name: String, quantity: Int)          지정생성자
// override convenience init(name: String)    편의생성자
// convenience init()                         편의생성자



// 쇼핑아이템 리스트

class ShoppingListItem: RecipeIngredient {
    
    var purchased = false       // 모든 저장속성에 기본값 설정
    
    var description: String {
        var output = "\(quantity) x \(name)"
        output += purchased ? " ✔" : " ✘"
        return output
    }
    
    // init(name: String, quantity: Int) {}    // 지정생성자 모두 자동 상속
    
    // convenience init(name: String) {}       // 따라서 ====> 편의상속자도 모두 자동 상속됨
    
    // convenience init() {}                   // 따라서 ====> 편의상속자도 모두 자동 상속됨
    
}




var breakfastList = [
    ShoppingListItem(),
    ShoppingListItem(name: "Bacon"),
    ShoppingListItem(name: "Eggs", quantity: 6),
]


breakfastList[0].name
//breakfastList[0].name = "Orange juice"
breakfastList[0].purchased = true


for item in breakfastList {
    print(item.description)
}


// 출력결과 ============================

// 1 x Orange juice ✔
// 1 x Bacon ✘
// 6 x Eggs ✘
#####################################################################################2021.10.12_3
지정생성자 / 편의생성자 상속과 재정의 규칙
#클래스의 지정, 편의 생성자의 상속과 재정의
생성자의 상속과 재정의


/**====================================================================
 - 하위클래스는 기본적으로 상위클래스 생성자를 상속하지 않고, 재정의 하는 것이 원칙
 - (올바르게 초기화되지 않을 수 있는 가능성을 배제 - 하위클래스에 최적화 안되어 있음)
   ===> (안전한 경우에만) 상위클래스의 생성자가 자동 상속됨

 - 재정의 (동일한 이름을 가진 생성자를 구현하는 것)
 - 하위클래스의 커스텀 생성자 구현 전에 ⭐️(상위클래스의) 재정의 생성자를 작성해야 실수하지 않음 ⭐️
======================================================================== **/


생성자 상속시 구현 규칙
/**=============================================================
// ☑️ 원칙: 1) 상위의 지정생성자(이름/파라미터)와 2) 현재단계의 저장속성을 고려해서 구현 ⭐️⭐️

 
[1단계 - 상위 생성자에 대한 고려]

 - 상위에 어떤 지정 생성자가 존재하는지?
 - (상위) 지정 생성자 ===> 1) 하위클래스에서 지정 생성자로 구현 (재정의)
 -                ===> 2) 하위클래스에서 편의 생성자로 구현 가능 (재정의)
 -                ===> 3) 구현 안해도됨(반드시 재정의하지 않아도 됨)

 - (상위) 편의 생성자 ===> 재정의를 하지 않아도 됨 (호출 불가가 원칙이기 때문에 재정의 제공 안함)
 -                ===> (만약에 동일한 이름을 구현했다면) 그냥 새로 정의한 것임


[2단계 - (현재단계의) 생성자 구현]

 - 1) 지정 생성자 내에서
 -   ===> (1) 나의 모든 저장 속성을 초기화해야함
 -   ===> (2) 슈퍼 클래스의 지정 생성자 호출

 - 2) 편의 생성자 내에서
 -   ===> 현재 클래스의 지정생성자 호출 해야함 (편의 생성자를 거치는 것은 상관없음)
          (결국 지정 생성자만 모든 저장 속성을 초기화 가능)
===============================================================**/




// 기본(Base) 클래스

class Aclass {
    var x = 0
    
    // init() {}                // 기본 생성자가 자동으로 제공됨
}


let a = Aclass()
print("a 출력해보기 a.x: \(a.x)")



// 상위의 지정생성자 ⭐️
// init()


class Bclass: Aclass {
    
    var y: Int

    
    // 🎾 [1단계] 상위의 지정생성자 고려 ==============================
    // 상위에 동일한 이름이 있으므로 재정의 해야함 (이 형태는 안됨)
//    init() {
//
//    }
    
    // (선택 1) 지정생성자로 재정의
    override init() {       // 상위 클래스와 "이름이 동일한 생성자" 구현은 재정의만 가능함(올바른 재정의) (지정생성자로 구현)
        self.y = 0
        super.init()
    }
    
    
    // (선택 2) 서브클래스에서 편의생성자로 구현해보기
    // 상위 클래스와 "이름이 동일한 생성자" 구현은 재정의만 가능함(올바른 재정의) (지정생성자 필요)
//    override convenience init() {
//        self.init(y: 0)
//    }
    
    // (선택 3) 재정의 하지 않을 수도 있음 (상속안함)
    
    
    // 🎾 [2단계] (현재단계의) 생성자 구현 ============================
    
    init(y: Int) {
        self.y = y
        super.init()
    }

}



let b = Bclass()
print("b 출력해보기 b.x: \(b.x), b.y: \(b.y)")



// 상위의 지정생성자 ⭐️
// init()
// init(y: Int)


class Cclass: Bclass {
    
    var z: Int
    
    override init() {      // 상위 클래스와 "이름이 동일한 생성자" 구현(올바른 재정의)
        self.z = 0
        super.init()       // 2단계 값설정(커스텀)없고, 상위구현에 기본 init() 만 있는 경우 생략가능(암시적 요청)
    }
    
    init(z: Int) {
        self.z = z
        super.init()       // 2단계 값설정(커스텀)없고, 상위구현에 기본 init() 만 있는 경우 생략가능(암시적 요청)
    }
    
}



let c = Cclass()
print("c 출력해보기 c.x: \(c.x), c.y: \(c.y), c.z: \(c.z)")

let d = Cclass(z: 1)
print("d 출력해보기 d.x: \(d.x), d.y: \(d.y), d.z: \(d.z)")



#애플 공식 문서의 예제로 복습
class Vehicle {
    
    var numberOfWheels = 0
    
    var description: String {
        return "\(numberOfWheels) wheel(s)"
    }
    
    // init() { }
}


// numberOfWheels의 저장 속성에 기본값을 제공, 생성자 구현하지 않았으므로
// ===> 기본 생성자 init() 자동제공


let vehicle = Vehicle()
print("Vehicle: \(vehicle.description)")    // Vehicle: 0 wheel(s)



// 상위의 지정생성자 ⭐️
// init()


// 서브클래스 정의

class Bicycle: Vehicle {
    
    override init() {
        super.init()            // 수퍼클래스 호출 반드시 필요
        numberOfWheels = 2      // 초기화의 2단계 값설정
    }
    
}


// 커스텀 init() 정의 ===> 생성자가 상위클래스의 이름과 동일 하므로 재정의 키워드 필요
// 상위 지정생성자 호출하여 메모리 초기화 후, 상위에서 구현한 속성에 접근하여 2로 셋팅(2단계 값설정)



let bicycle = Bicycle()
print("Bicycle: \(bicycle.description)")    // Bicycle: 2 wheel(s)




// 상위의 지정생성자 ⭐️
// init()



// 서브클래스 정의

class Hoverboard: Vehicle {
    
    var color: String
    
    // (읽기) 계산 속성 재정의
    override var description: String {
        return "\(super.description) in a beautiful \(color)"
    }
    
//    override convenience init() {
//        self.init(color: "빨간색")
//    }
    
    init(color: String) {
        self.color = color      // (현재 클래스) 저장 속성 초기화
        super.init()          // =====> 여기서 암시적으로 호출됨
    }
    
}


// 생성자에서 Hoverboard 클래스는 색상 속성만 설정
// 2단계 값설정(커스텀)없고, 상위구현에 기본 init() 만 있는 경우 생략가능(암시적 요청) ⭐️



let hoverboard = Hoverboard(color: "silver")
print("Hoverboard: \(hoverboard.description)")     // Hoverboard: 0 wheel(s) in a beautiful silver
#####################################################################################2021.10.12_2
생성자
#4) 생성자(Initializer)
구조체 vs 클래스 생성자(Initializer)
/**=======================================
 - (지정)생성자   <=====>  편의 생성자


 [구조체의 생성자]
 - 1) 지정 생성자, (자동제공되는 멤버와이즈생성자)
 - 2) 실패가능생성자


 [클래스의 생성자]
 - 1) 지정 생성자
 - 2) 편의 생성자  (상속과 관련)
 - 3) 필수 생성자  (상속과 관련)
 - 4) 실패가능생성자
=========================================**/


#구조체 생성자
여러개의 지정 생성자 구현
구조체나 클래스, 둘다 아래처럼 구현 가능(오버로딩을 지원하므로)
// 그렇지만, 이런 방식이 올바른 구현 방법은 아님

struct Color {
    let red, green, blue: Double
    
    init() {      // 기본 생성자. 기본값을 설정하면 자동으로 제공됨
        red = 0.0
        green = 0.0
        blue = 0.0
    }

    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }
    
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
}

#구조체(값타입)의 지정생성자의 구현
struct Color1 {
    let red, green, blue: Double
    
    init() {      // 구조체는 다른 생성자를 호출하는 방식도 가능 ⭐️
        //red = 0.0
        //green = 0.0
        //blue = 0.0
        self.init(red: 0.0, green: 0.0, blue: 0.0)
    }

    init(white: Double) {    // 구조체는 다른 생성자를 호출하는 방식도 가능 ⭐️
        //red   = white
        //green = white
        //blue  = white
        self.init(red: white, green: white, blue: white)
    }
    
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
}


// 값타입(구조체)의 경우 자체 지정생성자 작성할 때
// 생성자 내에서 self.init(...)를 사용하여 다른 이니셜라이저를 호출하도록 할 수 있음

#클래스 생성자
클래스의 지정(Designated) vs 편의 생성자(Convenience)
class Color2 {
    let red, green, blue: Double
    
    convenience init() {
        self.init(red: 0.0, green: 0.0, blue: 0.0)
        //self.init(white: 0.0)
    }

    convenience init(white: Double) {
        //red   = white
        //green = white
        //blue  = white
        self.init(red: white, green: white, blue: white)
    }
    
    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
}

/**========================================================================
 - 일단 편의 생성자는 편리하게 생성하기 위한 서브(Sub)생성자라고 보면됨(메인이 아닌)
 - ===> (메인) 지정 생성자에 의존하는 방식 (지정 생성자 호출)

 - 지정 생성자는 모든 속성을 초기화 해야함
 - 편의 생성자는 모든 속성을 초기화 할 필요가 없음(편의적 성격)

  ⭐️
 - 클래스는 상속을 지원하므로, 변수가 여러개 이고,
 - 여러 지정 생성자를 지원했을때 상속 관계에서 개발자가 실수할 수 있는 여러가지 가능성이 있음.
 - 따라서, 초기화 과정을 조금 간편하게 만들고,
 - 상속관계에서 개발자가 실수 할 수 있는 여러가능성을 배제하기 위한 생성자임

 - 반대로 말하자면 모든 속성을 초기화하지 않는다면 ===> 편의생성자로 만드는 것이 복잡도나 실수를 줄일 수 있음
 - 결국, 생성자의 가능한 중복을 없애고 다른 지정 생성자를 호출하는 패턴으로 구현해야 함
 ==========================================================================**/


##(이미 모든 속성을 초기화하는 지정생성자가 있다면) 모든 속성을 초기화하지 않는 경우 편의생성자로 구현을 권장
클래스의 상속과  지정/편의 생성자 사용 예시
class Aclass {
    var x: Int
    var y: Int
    
    init(x: Int, y: Int) {    // 지정생성자 - 모든 저장 속성 설정
        self.x = x
        self.y = y
    }
    
    convenience init() {     // 편의생성자 - (조금 편리하게 생성) 모든 저장 속성을 설정하지 않음
        self.init(x: 0, y: 0)
    }
}


// 상속이 일어나는 경우 ⭐️

class Bclass: Aclass {
    
    var z: Int
    
    init(x: Int, y: Int, z: Int) {    // 실제 메모리에 초기화 되는 시점
        self.z = z                 // ⭐️ (필수)
        //self.y = y               // 불가 (메모리 셋팅 전)
        super.init(x: x, y: y)     // ⭐️ (필수) 상위의 지정생성자 호출
        //self.z = 7
        //self.y = 7
        //self.doSomething()
    }
    
    convenience init(z: Int) {
        //self.z = 7     //==========> self에 접근불가
        self.init(x: 0, y: 0, z: z)
        //self.z = 7
    }
    
    convenience init() {
        self.init(z: 0)
    }
    
    func doSomething() {
        print("Do something")
    }
}



let a = Aclass(x: 1, y: 1)
let a1 = Aclass()


let b = Bclass(x: 1, y: 1, z: 1)
let b1 = Bclass(z: 2)
//b1.x
let b2 = Bclass()

클래스의 상속과 지정 생성자와 편의 생성자의 호출 규칙
/**===============================================================================
 - 생성자 위임 규칙(Initializer Delegation)

 - (1) 델리게이트 업(Delegate up)
 -     서브클래스의 지정생성자는 수퍼 클래스의 지정생성자를 반드시 호출해야함
 - (2) 델리게이트 어크로스(Delegate across)
 -     편의생성자는 동일한 클래스에서 다른 이니셜 라이저를 호출해야하고, 궁극적으로 지정생성자를 호출해야함


 - ===> 인스턴스 메모리 생성에 대한 규칙이 존재함(규칙을 안지키면 인스턴스가 올바르게 초기화되지 않음)
=================================================================================**/

클래스의 상속과 초기화 과정의 이해(2단계 초기화 과정) - 그림으로 이해 ⭐️
/**==================================================================
 - 인스턴스의 모든 저장 속성이 초기값을 가지면 완전히 초기화된 것임(생성 완료)

 - 각 단계에서 선언된 저장속성은 각 해당 단계에서 초기값을 가져야 함
 - ===> 그리고나서 수퍼클래스로 생성 위임(델리게이트 업)이 일어나야 함


 - [1단계] (필수사항)
 - 해당 클래스에서 선언한 모든 저장속성에 값이 있는지 확인하여 메모리 초기화
 - 상위 지정생성자로 델리게이트 업하여 (해당 단계의) 모든 저장 속성의 메모리 초기화
 - (최종적으로) Base 클래스가 모든 저장 속성에 값이 있는지 확인하면
 - 저장속성이 완전히 초기화 된 것으로 간주되어 인스턴스가 생성 완료

 
 - [2단계] (선택사항)
 - 인스턴스의 생성 완료 후,
 - 상속관계의 맨 위에서 아래로 내려가면서, 호출된 각각의 생성자가 인스턴스를 추가로 커스텀함
 - (커스텀의 의미: 새로운 값을 셋팅하거나 메서드 호출 등이 가능)
 - 메모리가 초기화가 완료된 후이므로
 - 이제 self 속성에 접근이 가능해지고, 속성을 수정하거나 인스턴스 메서드를 호출이 가능해짐
 =====================================================================**/

#####################################################################################2021.10.12_1
초기화의 과정과 생성자
3) 초기화(Initialization)
초기화(Initialization)와 생성자(Initializer)

/**=====================================================================
 - 초기화는 클래스, 구조체, 열거형의 인스턴스를 생성하는 과정임
 - 각 "저장 속성"에 대한 초기값을 설정하여 인스턴스를 사용가능한 상태로 만드는 것
   (열거형은 저장속성이 존재하지 않으므로, case중에 한가지를 선택 및 생성)

 - 결국, 이니셜라이저의 실행이 완료되었을 때,
 - 인스턴스의 모든 저장속성이 초기값을 가지는 것이 ==> 생성자(Initializer)의 역할

 - 참고) 소멸자
 - 생성자와 반대개념의 소멸자(Deinitializer)도 있음
 - 소멸자 ==> 인스턴스가 해제되기 전에 해야할 기능을 정의하는 부분
=====================================================================**/


#생성자(Initializer) 구현의 기본
// 클래스, 구조체, (열거형) 동일

class Color {
    //let red, green, blue: Double    // 동일한 타입일때, 한줄에 작성가능
    let red: Double
    let green: Double
    let blue: Double
    
    
    // 생성자도 오버로딩(Overloading)을 지원 (파리미터의 수, 아규먼트 레이블, 자료형으로 구분)
    
    init() {      // "init()" -> 기본 생성자. 저장 속성의 기본값을 설정하면 "자동" 구현이 제공됨
        red = 0.0
        green = 0.0
        blue = 0.0
    }

    init(white: Double) {
        red   = white
        green = white
        blue  = white
    }

    init(red: Double, green: Double, blue: Double) {
        self.red   = red
        self.green = green
        self.blue  = blue
    }
}



/**===================================================
 - 초기화의 방법(저장속성이 초기값 가져야 함)
 - 1) 저장 속성의 선언과 동시에 값을 저장
 - 2) 저장 속성을 옵셔널로 선언 (초기값이 없어도 nil로 초기화됨)
 - 3) 생성자에서 값을 초기화

 - 반드시 생성자를 정의해야만 하는 것은 아님 ⭐️
 
 - 1-2번 방법으로 이니셜라이저를 구현하지 않아도,
 - 컴파일러는 기본 생성자(Default Initializer)를 자동으로 생성함 ==> init()
 - ==> 이니셜라이저 구현하면, 기본 생성자를 자동으로 생성하지 않음
======================================================**/




var color = Color()   // 기본 생성자 호출. 결국 Color()는 생성자를 호출하는 것임 (메서드 호출 문법과 형태 동일)
//var color2 = Color.init()


//color = Color(white: <#T##Double#>)
//color = Color.init(white: <#T##Double#>)

//color = Color(red: <#T##Double#>, green: <#T##Double#>, blue: <#T##Double#>)
//color = Color.init(red: <#T##Double#>, green: <#T##Double#>, blue: <#T##Double#>)


#멤버와이즈 이니셜라이저(Memberwise Initializer) - 구조체의 특별한 생성자
구조체는 멤버와이즈 이니셜라이저 자동 제공
struct Color1 {
    var red: Double = 1.0
    var green: Double = 1.0
    var blue: Double

}



/**============================================================
 - 생성자 기본 원칙
 - 컴파일러는 기본 생성자(Default Initializer)를 자동으로 생성함 ==> init()
 - ==> 이니셜라이저 구현하면, 기본 생성자를 자동으로 생성하지 않음

 - 구조체는 저장 속성들이 기본값을 가지고 있더라도,
 - 추가적으로 Memberwise멤버와이즈(멤버에 관한) 이니셜라이저를 자동으로 제공함

 - 개발자가 직접적으로 생성자를 구현하면, 멤버와이즈 이니셜라이저가 자동으로 제공되지 않음 ⭐️
   (멤버와이즈 이니셜라이저는 편의적 기능일뿐)
 ==============================================================**/


//var color1 = Color1()
//color1 = Color1(red: 1.0, green: 1.0, blue: 1.0)



// 구조체에서만 선언된 저장 속성의 이름을 파라미터로 제공하기 때문에
// 멤버에 관한 생성자를 제공한다는 뜻에서 멤버와이즈 이니셜라이저라고 부름
// (Memberwise 뜻: 멤버에 관하여) ( ~ wise:  ~ 에 관하여)




/**==================================================
 - 왜 멤버와이즈 이니셜라이저를 제공할까?
 
 - 굳이 이유를 찾자면, 클래스보다 더 편하게 쓰기 위함일 것으로 추측
 - 클래스의 경우에는, 생성자가 상속하고 관련이 있기 때문에 복잡
=====================================================**/

#####################################################################################2021.10.12
클래스의 상속과 재정의
#2) 재정의(Overriding)
오버로딩(overloading) vs 오버라이딩(overriding)

/**==============================================================================
 - 오버로딩(overloading) - (엉어 뜻: 과적) 함수에서 함수의 하나의 이름에 여러 함수를 대응시켜서 사용
 - 오버라이딩(overriding) - (영어 뜻: 재정의) 클래스의 상속에서 상위클래스의 속성/메서드를 재정의(기능을 약간 변형하여 사용)하는 것

 - 재정의
 - 서브클래스에서 슈퍼클래스의 동일한 멤버를 변형하여 구현

 - 재정의 가능한 대상(멤버)
 - 1) 속성 (하지만, 저장 속성에 대한 재정의는 어떠한 경우에도 불가능)
 - 2) 메서드 (메서드, 서브스크립트, 생성자)

    ==> 속성과 메서드는 재정의 방식이 다름 ⭐️
==============================================================================**/

class Aclass {
    func doSomething() {
        print("Do something")
    }
}

class Bclass: Aclass {
    override func doSomething() {
        print("Do another job")
    }
}

저장속성의 재정의는 원칙적 불가 (데이터 구조의 변형은 불가)
재정의(overriding)의 기본 문법

class SomeSuperclass {
    // 저장속성
    var aValue = 0
    
    // 메서드
    func doSomething() {
        print("Do something")
    }
}



class SomeSubclass: SomeSuperclass {
    // 저장속성의 재정의는 원칙적 불가
    //override var aValue = 3
    
    // 저장속성 ===> (재정의) 계산속성
    // 그러나, 메서드 형태로 부수적 추가는 가능
    override var aValue: Int {
        get {
            return 1
        }
        set {    // self로 쓰면 안됨
            super.aValue = newValue
        }
    }
    
    // 메서드는 (어떤 형태로든)재정의 가능 ===> 변형 / 대체
    override func doSomething() {
        super.doSomething()
        print("Do something 2")
        //super.doSomething()
    }
}


2-1) 재정의 방식
1) 속성의 재정의 (엄격)
/**===============================================================================================
 - (타입/인스턴스 속성을 구분해서 생각해야 하지만, 실질적으로 타입 속성을 재정의 하는 것은 드문 일이므로 배제하고 생각하면 됨)


 - (1) 저장 속성의 재정의
 - 원칙적으로 불가능(고유의 메모리 공간은 유지 해야함)
 -  ==> 저장 속성은 고유의 메모리 공간이 있으므로 하위클래스에서 고유의 메모리 공간을 바꾸는 방식으로의 재정의는 불가능

 - (메서드 형태로 추가하는 방식의 재정의는 가능)
 -  ==> 읽기/쓰기 가능한 계산속성으로 재정의 가능(메서드) (읽기만 가능한 계산 속성으로 정의 불가능 - 기능 축소는 불가능 X)
 -  ==> 속성 감시자를 추가는 가능(메서드) (실질적 단순 메서드를 추가해서 저장 속성이 변하는 시점을 관찰할뿐)


 - (2) 계산 속성(메서드)의 재정의
 - (실질적인 메서드이기 때문에 메서드 형태로의 재정의만 가능. 기능의 범위를 축소하는 형태로의 재정의는 불가능)
 
 - (상위)읽기전용 계산 속성을 ===> (하위)읽기/쓰기가 가능한 가능한 속성으로 재정의 가능(확장 O)
 -                      ===> 속성 감시자를 추가하는 재정의는 불가능 (읽기 전용 속성을 관찰 할 수 없음 - 논리에 안 맞음)
 - (상위)읽기/쓰기 계산 속성을 ===> (하위)읽기만 가능한 가능한 속성으로만 재정의 불가능(기능 제한 X)
 -                      ===> 속성 감시자를 추가하는 재정의 가능 (관찰은 가능)

   ===================================
   - 읽기 메서드 ===> 읽기 메서드
   - 쓰기 메서드 ===>    x      (불가능)

   - 읽기 메서드 ===> 읽기 메서드
   -    x     ===> 쓰기 메서드  (가능)   // 확장은 가능
   ===================================


 - ⭐️ 인스턴스 속성의 대원칙
 - 1) 저장 속성 재정의는 원칙적으로 불가능(하위 속성에서 상위 속성의 고유의 메모리 공간을 변형 불가).
      메서드 방식(계산 속성으로의 재정의 가능)으로 추가는 가능
 - 2) 계산 속성의 유지/확장은 가능, 축소는 불가능
 - 3) 속성 감시자(메서드)를 추가하는 재정의는 언제나 가능(실질적 단순 메서드 추가)
      (다만, 읽기전용 계산 속성을 관찰하는 것은 의미 없으므로 불가능)


 - (실질적으로 드뭄)
 - 타입 속성의 재정의 원칙
 - 1) 타입 저장 속성은 재정의 불가 - static키워드 (계산속성으로 재정의하거나, 속성 감시자를 추가하는 것도 불가능)
 - 2) 타입 계산 속성 - class 키워드인 경우 계산 속성 재정의 (확장방식) 가능.
 - 3) 재정의한 타입 저장/계산 속성에는 감시자 추가 원칙적으로 불가
===============================================================================================**/


2)메서드의 재정의 (메서드, 스크립트, 생성자)- 타입/인스턴스 속성 관계 없음
/**============================================================================================
 - 속성에 비해, 메서드의 재정의는 자유로운 편(⭐️다만, 생성자의 재정의는 메모리 생성 규칙이 존재하므로 뒤에서 따로 다룰 예정)

 - 상위 클래스 인스턴스 메서드 또는 타입 메서드 상관없이 기능을 추가하는 것도 가능하고,
 - 상위 기능을 무시하고 새롭게 구현 하는 것도 가능(제약 없음 - 메서드 이름만 동일하고 완전히 새롭게 구현 가능하다고 생각하면됨)


 - 다만, 기능을 추가하는 구현을 선택할시에 상위구현의 기능을 먼저 실행할지의 여부는 개발자의 선택
===============================================================================================**/


#2-2) 재정의 예시

1) 속성의 재정의(엄격)
class Vehicle {
    var currentSpeed = 0.0

    var halfSpeed: Double {
        get {
            return currentSpeed / 2
        }
        set {
            currentSpeed = newValue * 2
        }
    }
}



class Bicycle: Vehicle {
    // 저장 속성 추가는 당연히 가능
    var hasBasket = false
    
    // 1) 저장속성 ===> ⭐️ 계산속성으로 재정의(메서드 추가) 가능
    override var currentSpeed: Double {
        // 상위 속성이기 때문에 super키워드 필요
        get {
            return super.currentSpeed       // 1.0
        }
        set {
            super.currentSpeed = newValue
        }
    }

    // 1) 저장속성 ===> ⭐️ 속성감시자를 추가하는 재정의(메서드 추가)는 가능
//    override var currentSpeed: Double {
//        // 상위 속성이기 때문에 super키워드 필요
//        willSet {
//            print("값이 \(currentSpeed)에서 \(newValue)로 변경 예정")
//        }
//        didSet {
//            print("값이 \(oldValue)에서 \(currentSpeed)로 변경 예정")
//        }
//    }
    
    // ⭐️ 계산속성을 재정의 가능 (super키워드 주의)
//    override var halfSpeed: Double {
//        get {
//            return super.currentSpeed / 2
//        }
//        set {
//            super.currentSpeed = newValue * 2
//        }
//    }
    
    // ⭐️ 계산속성을 재정의 하면서, 속성감시자 추가 가능 (속성감시자 부분 참고)
//    override var halfSpeed: Double {
//        willSet {
//            print("값이 \(halfSpeed)에서 \(newValue)로 변경 예정")
//        }
//        didSet {
//            print("값이 \(oldValue)에서 \(halfSpeed)로 변경 예정")
//        }
//    }
    
}


2) 메서드의 재정의
class Vehicle1 {
    var currentSpeed = 0.0
    
    var datas = ["1", "2", "3", "4", "5"]
    
    func makeNoise() {
        print("경적을 울린다.")
    }
    
    subscript(index: Int) -> String {
        get {
            if index > 4 {
                return "0"
            }
            return datas[index]
        }
        set {
            datas[index] = newValue
        }
    }
}


// 메서드의 재정의 방식 ⭐️

class Bicycle1: Vehicle1 {
    
    // 1) 상위 => 하위 호출 (가능)
//    override func makeNoise() {
//        super.makeNoise()
//        print("자전거가 지나간다고 소리친다.")
//    }
    
    // 2) 하위 => 상위 호출 (가능)
//    override func makeNoise() {
//        print("자전거가 지나간다고 소리친다.")
//        super.makeNoise()
//    }
    
    // 3) 상위구현 아예 무시 (가능)
    override func makeNoise() {
        print("경적을 울리고, 자전거가 지나간다고 소리친다.")
    }
    
    // 서브스크립트도 재정의 가능
    override subscript(index: Int) -> String {
        get {
            if index > 4 {
                return "777"
            }
            return super[index]
        }
        set {
            super[index] = newValue
        }
    }
}


let v = Bicycle1()
v.currentSpeed
v.makeNoise()
//v[0]



2-3) 메모리 구조를 통한 이해
상속과 재정의(Overriding) 그리고 메모리 구조

/**================================================================
 - 재정의(overriding) - 현재의 클래스에 맞게 상위 멤버를 변형시키서, 사용 하려는 것


 - 대원칙:
 - 1) 저장 속성 재정의 불가
 - 2) 메서드는 자유롧게 재정의 가능(다만, 기능 확장만 가능 - 기능 축소 불가의 의미)

 - (재정의를 하지 않아도, 상속에서는 당연히 모든 멤버의 상속이 일어남)
 

 - 저장 속성은 실제 인스턴스에 각각의 멤버별(속성별로) 저장공간이 있고,
 - 변형하는 것이 불가 (상속의 기본 원칙)

 - 메서드는 타입(데이터 영역)에만 배열형태로 주소값을 저장되어 존재하므로
 - 각 상속단계에서 재정의 되고 대체 되는 것이 당연
==================================================================**/

#####################################################################################2021.10.11
Property

#####################################################################################2021.10.08
Protocol

#####################################################################################2021.10.07
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

#####################################################################################2021.10.06
Ingeritance, Initialiazation

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


