# TIL
#####################################################################################2021.10.02_2
Class연습
//Class 연습

var greeting = "Hello, playground"


class Book {
    var name: String
    var price: Int
    var company: String
    var author: String
    var pages: Int
    
    init(n: String, p: Int, c: String, a: String, ps: Int) {
        self.name = n
        self.price = p
        self.company = c
        self.author = a
        self.pages = ps
    }
}

var book1 = Book(n: "스위프트", p: 10000, c: "인프런", a: "앨런", ps: 600)
var book2 = Book(n: "회계원리", p: 20000, c: "아이파", a: "김승철", ps: 500)

book2.name


//
class Movie {
    var name: String
    var jenre: String
    var actor: String
    var director: String
    var day: String
    
    init(name: String, jenre: String, actor: String, director: String, day: String) {
        self.name = name
        self.jenre = jenre
        self.actor = actor
        self.director = director
        self.day = day
    }
}

var movie = Movie(name: "맨인더다크", jenre: "스릴러", actor: "할배", director: "누구?", day: "몇 년 전 쯤?")
//애플에서도 구조체(Struct),클래스(Class) 중 구조체를 선호 (상속이 반드시 필요할 떈 클래스를 사용)



#####################################################################################2021.10.02_1
Initializer(초기화)
#구조체, 클래스의 초기화의 의미
앞에서의 객체의 생성

class Dog {
    var name = "강아지"    // 속성에 기본값을 넣어서 생성
    var weight = 0
    
    func sit() {
        print("앉았습니다.")
    }
    
    func layDown() {
        print("누웠습니다.")
    }
}



var bori = Dog()
bori.name
bori.weight



bori.name = "보리"
bori.name
bori.weight = 15
bori.weight


#초기화 메서드 / 이니셜라이저(initializer)
생성자(이니셜라이저)는 인스턴스를 만들때 사용하는 특별한 메서드
class Dog1 {
    var name: String
    var weight: Int
    
    // 생성자 , self는 인스턴스 이름
    init(n: String, w: Int) {
        self.name = n
        self.weight = w
    }
    
    func sit() {
        print("\(self.name)가 앉았습니다.")
    }
    
    func layDown() {
        print("\(self.name)가 누웠습니다.")
    }
}


var dog1 = Dog1(n: "뭉이", w: 12)
dog1.name
dog1.weight
dog1.sit()
dog1.layDown()


var dog2 = Dog1(n: "땡이", w: 10)


/**==========================================================================
 - 초기화 메서드/이니셜라이저
 - init(파라미터)

 - 모든 저장 속성(변수)을 초기화 해야함 (구조체, 클래스 동일)
 - 생성자 실행 종료시점에는 모든 속성의 초기값이 저장되어 있어야 함(초기화가 완료되지 않으면 컴파일 에러)
 - 생성자의 목적은 결국 "저장속성 초기화"

 - 클래스, 구조체, (열거형)은 모두 설계도 일뿐이고,
 - 실제 데이터(속성), 동작(메서드)을 사용하기 위해서는 ===> 초기화 과정이 반드시 필요함
=============================================================================**/



var dog3 = Dog1(n: "흰둥이", w: 25)


var dog4 = Dog1.init(n: "초코", w: 13)


#인스턴스 초기화 완료 ➞ 메모리에 정상적으로 인스턴스가 생성
생성자(이니셜라이저)와 self 키워드
class Dog2 {
    var name: String
    var weight: Int
    
    init(name: String, weight: Int) {
        self.name = name
        self.weight = weight
    }
    
    func sit() {
        print("\(self.name) 앉았습니다.")
    }
    
    func layDown() {
        print("\(name) 누웠습니다.")
    }
}


// 인스턴스내에서 동일한 변수명, 상수명을 사용할때
// 가르키는 것을 명확하게 하기 위해 self키워드를 사용

#self 키워드는 클래스/구조체 내에서 해당 인스턴스(자기자신)를 가르킴
초기화의 의미 - 속성이 옵셔널 타입인 경우
class Dog3 {
    var name: String?
    var weight: Int
    
    init(weight: Int) {
        //self.name = "강아지"
        self.weight = weight
    }
    
    func sit() {
        print("\(name) 앉았습니다.")
    }
    
    func layDown() {
        print("\(name) 누웠습니다.")
    }
}



var dog5 = Dog3(weight: 10)
dog5.name
print(dog5.name)
print(dog5.weight)

dog5.sit()

#옵셔널타입을 가진 변수의 경우는 반드시 초기화값이 있을 필요는 없음 ➞ nil로 초기화되기 때문

#Identity Operators(식별 연산자)
// 식별 연산자 - 두개의 참조가 같은 인스턴스를 가르키고 있는지를 비교하는 방법

print(dog1 === dog2)
print(dog1 !== dog2)

#####################################################################################2021.10.02
Class and Struct, Memory
#클래스와 구조체
/**=========================================================
 - 클래스와 구조체 둘다, 메모리에 찍어낸 것을 인스턴스(instance)라고 함
 - 인스턴스는 실제로 메모리에 할당되어 구체적 실체를 갖춘 것이라는 의미

 - 스위프트에서는 클래스의 instance를 특별히 객체(object)라고 부름

 - 클래스의 인스턴스(객체)
 - 구조체의 인스턴스
 - 열거형의 인스턴스


 - ⭐️ 가장 큰 차이는 메모리 저장 방식의 차이 ⭐️

 - 1) 구조체
    - 값형식(Value Type)
    - 인스턴스 데이터를 모두 스택(Stack)에 저장
    - (복사시) 값을 전달할때마다 복사본을 생성 (다른 메모리 공간 생성)
    - 스택(Stack)의 공간에 저장, 스택 프레임 종료시, 메모리에서 자동 제거
 
 - 2) 클래스
    - 참조형식(Reference Type)
    - 인스턴스 데이터는 힙(Heap)에 저장, 해당 힙을 가르키는 변수는 스택에 저장하고
    - 메모리 주소값이 힙(Heap)을 가르킴
    - (복사시) 값을 전달하는 것이 아니고, 저장된 주소를 전달
    - 힙(Heap)의 공간에 저장, ARC시스템을 통해 메모리 관리(주의해야함)
 ==========================================================**/


// 그렇지만 그 외의 면에서는 클래스와 구조체는 거의 동일하므로,
// 클래스와 구조체를 동시에 살펴볼 것 임.
//
// 특별하게 차이를 언급하지 않는 한,
// 클래스의 기능은 동일하게 구조체에서 가지고 있다고 보면 됨



#클래스와 구조체의 메모리
class Person {
    var name = "사람"
}



struct Animal {
    var name = "동물"
}




var p = Person()    // x1234
p.name

var a = Animal()
a.name



var p2 = p       // (클래스)     // x1234


//p.name = "혜리"

p.name
p2.name





var a2 = a       // (구조체)
a.name = "강아지"

a.name
a2.name


#클래스와 구조체의 let과 var키워드
class PersonClass {
    var name = "사람"
    var age = 0
}



struct AnimalStruct {
    var name = "동물"
    var age = 0
}



let pclass = PersonClass()
let astruct = AnimalStruct()



pclass.name = "사람1"
pclass.name



//astruct.name = "동물1"
astruct.name

#접문법 / 명시적 멤버 표현식(Explicit Member Expression)의 정확한 의미
// 내부의 요소. 즉, 클래스, 구조체의 인스턴스의 멤버에 접근한다.

// 멤버는 속성, 메서드를 포함



bBird.fly()


Int.random(in: 1...10)

#관습적인 부분들에 대한 이해
/**=====================================
 - 일반적으로 클래스, 구조체 선언할때 모두
 - 1) 속성 2) 메서드 순서대로 작성
=====================================**/

#주의점 - (참고) 클래스 내부에는 직접 메서드(함수) 실행문이 올 수 없다. ⭐️
// 메서드 실행문은 메서드의 정의문 내에 존재해야함
// 처음 코딩하면서 자주 실수하는 부분임에 유의 

