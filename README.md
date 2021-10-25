# TIL
#####################################################################################2021.10.25_1
Generics_2
제네릭 타입의 정의

제네릭(Generics) 구조체 / 클래스 / (열거형)
/**====================================================================
 - 클래스, 구조체, 열거형의 타입이름 뒤에 타입 파라미터<T>를 추가하면, 제네릭 타입으로 선언됨
 - 타입 파라미터는 타입(형식) 이름뒤에 선언, 타입 제약 문법도 동일함  GridPoint<T: Equatable>

 - 속성의 자료형, 메서드의 파라미터형식, 리턴형을 타입 파라미터로 대체 가능
 ======================================================================**/


// 구조체로 제네릭의 정의하기
// 클래스, 구조체를 정의하는 데, 안의 멤버 변수들은 여러가지 타입을 가질 수 있는 가능성이 있을 것 같다면?


struct Member {
    var members: [String] = []
}



struct GenericMember<T> {
    var members: [T] = []
}



var member1 = GenericMember(members: ["Jobs", "Cook", "Musk"])
var member2 = GenericMember(members: [1, 2, 3])




// 클래스로 제네릭의 정의하기

class GridPoint<A> {
    var x: A
    var y: A
    
    init(x: A, y: A){
        self.x = x
        self.y = y
    }
}


let aPoint = GridPoint(x: 10, y: 20)
let bPoint = GridPoint(x: 10.4, y: 20.5)




// 열거형에서 연관값을 가질때 제네릭으로 정의가능
// (어짜피 케이스는 자체가 선택항목 중에 하나일뿐(특별타입)이고, 그것을 타입으로 정의할 일은 없음)

enum Pet<T> {
    case dog
    case cat
    case etc(T)
}



let animal = Pet.etc("고슴도치")


#제네릭(Generics) 구조체의 확장
// 정의

struct Coordinates<T> {
    var x: T
    var y: T
}



// 제네릭을 Extension(확장)에도 적용할 수 있다. (확장 대상을 제한하는 것도 가능은 함)

extension Coordinates {     // Coordinates<T> (X)
    
    // 튜플로 리턴하는 메서드
    func getPlace() -> (T, T) {
        return (x, y)
    }
}


let place = Coordinates(x: 5, y: 5)
print(place.getPlace())




// where절 추가도 가능
// Int타입에만 적용되는 확장과 getIntArray() 메서드

extension Coordinates where T == Int {     // Coordinates<T> (X)
    
    // 튜플로 리턴하는 메서드
    func getIntArray() -> [T] {
        return [x, y]
    }
}


let place2 = Coordinates(x: 3, y: 5)
place2.getIntArray()




//let place3 = Coordinates(x: 3.5, y: 2.5)
//place3.getIntArray()


#타입 제약(Type Constraint)
/**==================================================================
 - 제네릭에서 타입을 제약할수 있음
 - 타입 매개 변수 이름 뒤에 콜론으로 "프로토콜" 제약 조건 또는 "단일 클래스"를 배치 가능
 - (1) 프로토콜 제약 <T: Equatable>
 - (2) 클래스 제약 <T: SomeClass>
====================================================================**/



// Equatable 프로토콜을 채택한 타입만 해당 함수에서 사용 가능 하다는 제약

func findIndex<T: Equatable>(item: T, array:[T]) -> Int? {     // <T: Equatable>
    for (index, value) in array.enumerated() {
        if item == value {
            return index
        }
    }
    return nil
}


let aNumber = 5
let someArray = [3, 4, 5, 6, 7]

if let index = findIndex(item: aNumber, array: someArray) {
    print("밸류값과 같은 배열의 인덱스: \(index)")
}


// 클래스 제약의 예시


class Person {}
class Student: Person {}

let person = Person()
let student = Student()



// 특정 클래스와 상속관계에 내에 있는 클래스만 타입으로 사용할 수 있다는 제약  (구조체, 열거형은 사용 못함)
// (해당 타입을 상속한 클래스는 가능)

func personClassOnly<T: Person>(array: [T]) {
    // 함수의 내용 정의
}


personClassOnly(array: [person, person])
personClassOnly(array: [student, student])

//personClassOnly(array: [Person(), Student()])


#반대로 구체/특정화(specialization) 함수구현도 가능
/**=================================================================================
 - 항상 제네릭을 적용시킨 함수를 실행하게만 하면, 또다른 불편함이 생기지 않을까?
 - (제네릭 함수가 존재하더라도) 동일한 함수이름에 구체적인 타입을 명시하면, 해당 구체적인 타입의 함수가 실행됨
 ===================================================================================**/


// 문자열의 경우, 대소문자를 무시하고 비교하고 싶어서 아래와 같이 구현 가능 ⭐️
// 위의 findIndex<T: Equatable>(item: T, array:[T]) -> Int? 와 완전 동일

func findIndex(item: String, array:[String]) -> Int? {
    for (index, value) in array.enumerated() {
        if item.caseInsensitiveCompare(value) == .orderedSame {
            return index
        }
    }
    return nil
}



let aString = "jobs"
let someStringArray = ["Jobs", "Musk"]


if let index2 = findIndex(item: aString, array: someStringArray) {
    print("문자열의 비교:", index2)
}

#####################################################################################2021.10.25
Generics
Part21 - 제네릭(Generics)
제네릭 문법

제네릭(Generics) 문법이 왜 필요한가?
// 제네릭이라는 문법의 필요성 알아보기

// 정수 2개

var num1 = 10
var num2 = 20



// 두 숫자를 스왑(서로 교환)하는 함수의 정의
func swapTwoInts(_ a: inout Int, _ b: inout Int) {
    let tempA = a
    a = b
    b = tempA
}



// 위에서 정의한 함수의 실행
swapTwoInts(&num1, &num2)

print(num1)
print(num2)



// 만약, Double을 교환하고 싶다면?, String을 교환하고 싶다면?


// Double을 스왑하는 함수의 정의

func swapTwoDoubles(_ a: inout Double, _ b: inout Double) {
    let tempA = a
    a = b
    b = tempA
}



// (정수가 아닌) 문자열을 스왑하는 함수의 정의

func swapTwoStrings(_ a: inout String, _ b: inout String) {
    let tempA = a
    a = b
    b = tempA
}

/**======================================================================
 - 제네릭이 없다면, 함수(클래스, 구조체, 열거형 등)타입마다 모든 경우를 다 정의해야 하기 때문에
 - 개발자의 할일이 늘어난다. (유지보수/재사용성 관점에서 어려움)
=========================================================================**/


#또다른 예시
// 배열을 가지고
let numbers = [2, 3, 4, 5]
let scores = [3.0, 3.3, 2.4, 4.0, 3.5]
let people = ["Jobs", "Cook", "Musk"]



// 출력하는 함수 만들기 ===> 각 케이스(타입)마다 필요한 함수를 만들어야함
func printIntArray(array: [Int]) {
    for number in array {
        print(number)
    }
}


func printDoubleArray(array: [Double]) {
    for number in array {
        print(number)
    }
}


func printStringArray(array: [String]) {
    for number in array {
        print(number)
    }
}


printIntArray(array: numbers)
printDoubleArray(array: scores)
printStringArray(array: people)



// 따지고 보면 기능은 똑같은데..
// 타입이 다르다는 이유로 여러개의 함수를 만드는 것이 비효율적이라는 것


##제네릭(Generics)의 개념이 없다면, 함수를 모든 경우마다 다시 정의해야 한다.
/**===================================================================================
 - 제네릭 문법
 - 형식에 관계없이, 한번의 구현으로 모든 타입을 처리하여, 타입에 유연한 함수 작성가능 (유지보수/재사용성 증가)
 - (함수 뿐만아니라) 구조체 / 클래스 / 열거형도 제네릭으로 일반화 가능


 - 타입 파라미터는 함수 내부에서 파라미터 형식이나 리턴형으로 사용됨 (함수 바디에서 사용하는 것도 가능)
 - 보통은 T를 사용하지만 다른 이름을 사용하는 것도 문제가 없음, 형식이름이기 때문에 UpperCamelcase로 선언
 - 2개이상을 선언하는 것도 가능


 - 제네릭은 타입에 관계없이, 하나의 정의(구현)로 모든 타입(자료형)을 처리할 수 있는 문법
 - 제네릭 함수, 제네릭 구조체/클래스
 - 일반 함수와 비교해보면, 작성해야하는 코드의 양이 비약적으로 감소


 - 타입 파라미터는 실제 자료형으로 대체되는 플레이스 홀더(어떤 기호같은것) ===> 새로운 형식이 생성되는 것이 아님
 - 코드가 실행될때 문맥에 따라서 실제 형식으로 대체되는 "플레이스 홀더"일뿐
======================================================================================**/


#제네릭 함수의 정의

제네릭(Generics) 함수를 정의하는 방법
/**================================================================================
 - 타입 파라미터<T>는 함수 내부에서 파라미터의 타입이나 리턴형으로 사용됨 (함수 바디에서 사용하는 것도 가능)
 - (1) 관습적으로 Type(타입)의 의미인 대문자 T를 사용하지만,
       다른 문자를 사용해도 됨 <U> <A> <B> <Anything> (Upper camel case사용해야함)
 - (2) <T, U> <A, B> 이렇게 타입파라미터를 2개이상도 선언 가능
 ==================================================================================**/


// 파라미터의 타입에 구애받지 않는 일반적인(제네릭) 타입을 정의

func swapTwoValues<T>(_ a: inout T, _ b: inout T) {      // 플레이스홀더의 역할(표시 역할일뿐) (같은 타입이어야함)
    let tempA = a
    a = b
    b = tempA
}



var string1 = "hello"
var string2 = "world"



// 제네릭으로 정의한 함수 사용해보기

swapTwoValues(&string1, &string2)     // 같은 타입이라면, 어떠한 값도 전달 가능 해짐
print(string1)
print(string2)





// 배열을 출력하는 예제

func printArray<T>(array: [T]) {
    for element in array {
        print(element)
    }
}


printArray(array: numbers)     // 플레이스홀더 ====> [Int]
printArray(array: scores)      // 플레이스홀더 ====> [Double]
printArray(array: people)      // 플레이스홀더 ====> [String]



#제네릭의 사용예시 - 스위프트 문법
// 스위프트에서 컬렉션은 모두 구조체의 제네릭 타입으로 구현되어 있음


// 배열 타입
let array1: [String] = ["Steve", "Allen"]
let array2: Array<String> = ["Cook", "Musk"]      // 실제 컴파일시 내부에서 일어나는 일



// 딕셔너리 타입
let dictType1: [String: Int] = ["Steve": 20, "Paul": 24]
let dictType2: Dictionary<String, Int> = ["Alex": 25, "Michel": 18]


// 옵셔널 타입
var optionalType1: String?
var optionalType2: Optional<String>



// 실제로 스위프트 내부 구현에는 제네릭을 많이 사용
// (이제 볼 줄 알게됨)

//swap(<#T##a: &T##T#>, <#T##b: &T##T#>)
#####################################################################################2021.10.23_5
동시성프로그래밍의 메모리구조/ 동시성프로그래밍의 문제점
동시큐에서 직렬큐로 보내기

Thread-safe하지 않을때, 처리하는 방법
// 배열은 여러쓰레드에서 동시에 접근하면 문제가 생길 수 있다.


var array = [String]()

let serialQueue = DispatchQueue(label: "serial")


for i in 1...20 {
    DispatchQueue.global().async {
        print("\(i)")
        //array.append("\(i)")    //  <===== 동시큐에서 실행하면 동시다발적으로 배열의 메모리에 접근
        
        serialQueue.async {        // 올바른 처리 ⭐️
            array.append("\(i)")
        }
    }
}




// 5초후에 배열 확인하고 싶은 코드 일뿐...

DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
    print(array)
    //PlaygroundPage.current.finishExecution()
}
#####################################################################################2021.10.23_4
GCD사용시 주의사항_2
클로저의 강한 참조 주의

강한참조의 경우 주의해서 사용해야함

강한 참조
// 강한 참조가 일어나고, (서로가 서로를 가르키는) 강한 참조 사이클은 일어나지 않지만
// 생각해볼 부분이 있음


class ViewController: UIViewController {
    
    var name: String = "뷰컨"
    
    func doSomething() {
        DispatchQueue.global().async {
            sleep(3)
            print("글로벌큐에서 출력하기: \(self.name)")
        }
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}


func localScopeFunction() {
    let vc = ViewController()
    vc.doSomething()
}


//localScopeFunction()

//글로벌큐에서 출력하기: 뷰컨
//뷰컨 메모리 해제
/**=======================================================
 - (글로벌큐)클로저가 강하게 캡처하기 때문에, 뷰컨트롤러의 RC가 유지되어
 - 뷰컨트롤러가 해제되었음에도, 3초뒤에 출력하고 난 후 해제됨
 - (강한 순환 참조가 일어나진 않지만, 뷰컨트롤러가 필요없음에도 오래 머무름)

 - 그리고 뷰컨트롤러가 사라졌음에도, 출력하는 일을 계속함
=========================================================**/


약한 참조 - 클로저 부분에서 학습했던 내용
class ViewController1: UIViewController {
    
    var name: String = "뷰컨"
    
    func doSomething() {
        // 강한 참조 사이클이 일어나지 않지만, 굳이 뷰컨트롤러를 길게 잡아둘 필요가 없다면
        // weak self로 선언
        DispatchQueue.global().async { [weak self] in
            guard let weakSelf = self else { return }
            sleep(3)
            print("글로벌큐에서 출력하기: \(weakSelf.name)")
        }
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}


func localScopeFunction1() {
    let vc = ViewController1()
    vc.doSomething()
}


localScopeFunction1()

//뷰컨 메모리 해제
//글로벌큐에서 출력하기: nil
/**=======================================================
 - 뷰컨트롤러를 오래동안 잡아두지 않음
 - 뷰컨트롤러가 사라지면 ===> 출력하는 일을 계속하지 않도록 할 수 있음
   (if let 바인딩 또는 guard let 바인딩까지 더해서 return 가능하도록)
=========================================================**/

#####################################################################################2021.10.23_3
GDC사용시 주의사항
플레이그라운드 vs 실제 앱 (주의)

실제 앱에서는 UI관련작업들이 DispatchQueue.main(메인큐)에서 동작하지만, 플레이 그라운드에서는 DispatchQueue.global()(글로벌 디폴트큐)에서 동작한다. 따라서 플레이그라운드에서는 메인큐에 일을 시키면 안된다.
// DispatchQueue.main ====> 앱에서는 UI를 담당
// DispatchQueue.global() ====> 플레이그라운드에서 프린트영역를 담당





#UI업데이트는 메인쓰레드에서

유저인터페이스(즉, 화면)와 관련된 작업은 메인쓰레드에서 진행해야 함
var imageView: UIImageView? = nil


let url = URL(string: "https://bit.ly/32ps0DI")!


// URL세션은 내부적으로 비동기로 처리된 함수임.
URLSession.shared.dataTask(with: url) { (data, response, error) in
    
    if error != nil{
        print("에러있음")
    }
    
    guard let imageData = data else { return }
    
    // 즉, 데이터를 가지고 이미지로 변형하는 코드
    let photoImage = UIImage(data: imageData)
    
    // 🎾 이미지 표시는 DispatchQueue.main에서 🎾
    DispatchQueue.main.async {
        imageView?.image = photoImage
    }
    
    
}.resume()


#UI와 관련된 일은 다시 메인쓰레드로 보내야 함
DispatchQueue.global().async {
    
    // 비동기적인 작업들 ===> 네트워크 통신 (데이터 다운로드)
    
    DispatchQueue.main.async {
        // UI와 관련된 작업은 
    }
}

sleep(4)

PlaygroundPage.current.finishExecution()



#올바른 비동기함수의 설계

리턴(return)이 아닌 콜백함수를 통해, 끝나는 시점을 알려줘야 한다.
함수(메서드)를 아래처럼 설계하면 절대 안된다.
func getImages(with urlString: String) -> UIImage? {
    
    let url = URL(string: urlString)!
    
    var photoImage: UIImage? = nil
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print("에러있음: \(error!)")
        }
        // 옵셔널 바인딩
        guard let imageData = data else { return }
        
        // 데이터를 UIImage 타입으로 변형
        photoImage = UIImage(data: imageData)
        
    }.resume()

    
    return photoImage    // 항상 nil 이 나옴
}



getImages(with: "https://bit.ly/32ps0DI")    // 무조건 nil로 리턴함 ⭐️



#올바른 함수(메서드)의 설계 - 콜백함수의 사용법
func properlyGetImages(with urlString: String, completionHandler: @escaping (UIImage?) -> Void) {
    
    let url = URL(string: urlString)!
    
    var photoImage: UIImage? = nil
    
    URLSession.shared.dataTask(with: url) { (data, response, error) in
        if error != nil {
            print("에러있음: \(error!)")
        }
        // 옵셔널 바인딩
        guard let imageData = data else { return }
        
        // 데이터를 UIImage 타입으로 변형
        photoImage = UIImage(data: imageData)
        
        completionHandler(photoImage)
        
    }.resume()
    
}



// 올바르게 설계한 함수 실행
properlyGetImages(with: "https://bit.ly/32ps0DI") { (image) in
    
    // 처리 관련 코드 넣는 곳...
    
    DispatchQueue.main.async {
        // UI관련작업의 처리는 여기서
    }
    
}



sleep(5)


PlaygroundPage.current.finishExecution()
#####################################################################################2021.10.23_2
GCD개념 및 종류
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

큐(Queue/대기열)의 종류

1)메인큐
//메인큐 = 메인쓰레드("쓰레드1번"을 의미), 한개뿐이고 Serial큐

let mainQueue = DispatchQueue.main

2) 글로벌큐
// 6가지의 Qos를 가지고 있는 글로벌(전역) 대기열

let userInteractiveQueue = DispatchQueue.global(qos: .userInteractive)
let userInitiatedQueue = DispatchQueue.global(qos: .userInitiated)
let defaultQueue = DispatchQueue.global()  // 디폴트 글로벌큐
let utilityQueue = DispatchQueue.global(qos: .utility)
let backgroundQueue = DispatchQueue.global(qos: .background)
let unspecifiedQueue = DispatchQueue.global(qos: .unspecified)

3) 프라이빗(커스텀)큐
//기본적인 설정은 Serial, 다만 Concurrent설정도 가능
let privateQueue = DispatchQueue(label: "com.inflearn.serial")

sleep(5)

PlaygroundPage.current.finishExecution()


#####################################################################################2021.10.23_1
직렬(Serial)큐 VS 동시큐(Concurrent)
Serial 직렬큐
let serialQueue = DispatchQueue(label: "com.inflearn.serial")



serialQueue.async {
    task1()
}

serialQueue.async {
    task2()
}

serialQueue.async {
    task3()
}


// 비동기적으로 보내더라도, 순서대로 출력


Concurrent 동시큐
let concurrentQueue = DispatchQueue.global()


concurrentQueue.async {
    task1()
}

concurrentQueue.async {
    task2()
}

concurrentQueue.async {
    task3()
}



sleep(5)
PlaygroundPage.current.finishExecution()

#####################################################################################2021.10.23
직렬과 동시의 개념
import Foundation
import PlaygroundSupport
PlaygroundPage.current.needsIndefiniteExecution = true

큐로 보내면 다른 쓰레드로 배치

다른 쓰레드로 보낼 수있는 기본 코드 살펴보기
// "디폴트 글로벌큐 생성","비동기적으로"
DispatchQueue.global().async {
    
    //다른 쓰레드로 보낼 작업을 배치
    
}


#클로저는 작업을 하나로 묶음
// 전체가 하나의 작업 ===> 내부적으로는 동기적으로 동작 ⭐️
DispatchQueue.global().async {
    print("Task1 시작")
    print("Task1-1")
    print("Task1-2")
    print("Task1-3")
    print("Task1 종료")
}




// 위의 코드랑 아래의 코드는 전혀다름... 순서를 보장할 수 없음
// 아래의 코드는 작업이 5개로 분할된 개념

DispatchQueue.global().async {
    print("Task2 시작")
}


DispatchQueue.global().async {
    print("Task2-1")
}

DispatchQueue.global().async {
    print("Task2-2")
}

DispatchQueue.global().async {
    print("Task2-3")
}

DispatchQueue.global().async {
    print("Task2 종료")
}

sleep(2)

PlaygroundPage.current.finishExecution()



Async Sync
// 동기적인 함수의 정의

func task1() {
    print("Task 1 시작")
    sleep(2)
    print("Task 1 완료★")
}

func task2() {
    print("Task 2 시작")
    sleep(2)
    print("Task 2 완료★")
}

func task3() {
    print("Task 3 시작")
    sleep(2)
    print("Task 3 완료★")
}


// 비동기적인 함수의 정의

func task4() {
    DispatchQueue.global().async {
        print("Task 4 시작")
        sleep(2)
        print("Task 4 완료★")
    }
}

func task5() {
    DispatchQueue.global().async {
        print("Task 5 시작")
        sleep(2)
        print("Task 5 완료★")
    }
}

func task6() {
    DispatchQueue.global().async {
        print("Task 6 시작")
        sleep(2)
        print("Task 6 완료★")
    }
}


#코드레벨에서의 동기(sync) VS 비동기(async)
동기적인 작업의 진행
task1()   // 일이 끝나야 다음줄로 이동 (내부 동기)
task2()   // 일이 끝나야 다음줄로 이동 (내부 동기)
task3()   // 일이 끝나야 다음줄로 이동 (내부 동기)


비동기적인 작업의 진행
// 내부적으로 비동기처리가 되어있는 함수들


task4()   // 일이 끝나지 않아도 다음줄로 이동 (내부 비동기)
task5()   // 일이 끝나지 않아도 다음줄로 이동 (내부 비동기)
task6()   // 일이 끝나지 않아도 다음줄로 이동 (내부 비동기)


sleep(4)
PlaygroundPage.current.finishExecution()



#####################################################################################2021.10.22
비동기프로그래밍에 대한 이해
import Foundation
import PlaygroundSupport
// 플레이 그라운드 작업 중간에 멈추지 않게 하기 위함
// (비동기작업으로 인해, 플레이그라운드의 모든 작업이 끝난다고 인식할 수 있기때문에 사용)
PlaygroundPage.current.needsIndefiniteExecution = true


#빨리 끝나는 작업들
다른 쓰레드를 사용해야할지에 대해 인지하지 못했던 간단했던 작업들
// 간단한 프린트 작업 예시 (컴퓨터, 아이폰은 이정도 작업들은 금방 처리 가능)

func task1() {
    print("Task 1 시작")
    print("Task 1 완료★")
}

func task2() {
    print("Task 2 시작")
    print("Task 2 완료★")
}

func task3() {
    print("Task 3 시작")
    print("Task 3 완료★")
}

func task4() {
    print("Task 4 시작")
    print("Task 4 완료★")
}

func task5() {
    print("Task 5 시작")
    print("Task 5 완료★")
}


task1()
task2()
task3()
task4()
task5()


#오래 걸리는 작업들
이제 네트워킹과 같이 오래걸리는 작업이 있다면
// 함수가 임의적으로 오래걸리도록 정의


func task6() {
    print("Task 6 시작")
    sleep(2)
    print("Task 6 완료★")
}

func task7() {
    print("Task 7 시작")
    sleep(2)
    print("Task 7 완료★")
}

func task8() {
    print("Task 8 시작")
    sleep(2)
    print("Task 8 완료★")
}

func task9() {
    print("Task 9 시작")
    sleep(2)
    print("Task 9 완료★")
}

func task10() {
    print("Task 10 시작")
    sleep(2)
    print("Task 10 완료★")
}



// 비동기처리를 하지 않으면 10초이상이 걸림

task6()
task7()
task8()
task9()
task10()

#오래 걸리는 작업을 비동기 처리를 한다면
DispatchQueue.global().async {
    task6()
}

DispatchQueue.global().async {
    task7()
}

DispatchQueue.global().async {
    task8()
}

DispatchQueue.global().async {
    task9()
}

DispatchQueue.global().async {
    task10()
}






sleep(4)
// 작업이 종료되었으니 플레이그라운드 실행 종료 Ok.
PlaygroundPage.current.finishExecution()

#####################################################################################2021.10.21_2
NetWorking_2
네트워크 통신(서버와의 통신)의 기초

요청(Request) ➡︎ 서버데이터(JSON) ➡︎ 분석(Parse) ➡︎ 변환 (우리가 쓰려는 Struct/Class)

// 서버에서 주는 데이터 ===========================================================
struct MovieData: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let rank: String
    let movieNm: String
    let audiCnt: String
    let audiAcc: String
    let openDt: String
}



// 내가 만들고 싶은 데이터 (우리가 쓰려는 Struct / Class) =======================
struct Movie {
    static var movieId: Int = 0   // 아이디가 하나씩 부여되도록 만듦
    let movieName: String
    let rank: Int
    let openDate: String
    let todayAudience: Int
    let totalAudience: Int
    
    init(movieNm: String, rank: String, openDate: String, audiCnt: String, accAudi: String) {
        self.movieName = movieNm
        self.rank = Int(rank)!
        self.openDate = openDate
        self.todayAudience = Int(audiCnt)!
        self.totalAudience = Int(accAudi)!
        Movie.movieId += 1
    }
    
}



// 서버와 통신 ===========================================================
struct MovieDataManager {
    
    let movieURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
    
    let myKey = "7a526456eb8e084eb294715e006df16f"
    
    func fetchMovie(date: String, completion: @escaping ([Movie]?) -> Void) {
        let urlString = "\(movieURL)&key=\(myKey)&targetDt=\(date)"
        performRequest(with: urlString) { movies in
            completion(movies)
        }
    }
    
    func performRequest(with urlString: String, completion: @escaping ([Movie]?) -> Void) {
        print(#function)
        
        // 1. URL 구조체 만들기
        guard let url = URL(string: urlString) else { return }
        
        // 2. URLSession 만들기 (네트워킹을 하는 객체 - 브라우저 같은 역할)
        let session = URLSession(configuration: .default)
        
        // 3. 세션에 작업 부여
        let task = session.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!)
                completion(nil)
                return
            }
            
            guard let safeData = data else {
                completion(nil)
                return
            }
            
            
            // 데이터 분석하기
            if let movies = self.parseJSON(safeData) {
                //print("parse")
                completion(movies)
            } else {
                completion(nil)
            }
        }
        
        // 4.Start the task
        task.resume()   // 일시정지된 상태로 작업이 시작하기 때문
    }
    
    
    func parseJSON(_ movieData: Data) -> [Movie]? {
        // 함수실행 확인 코드
        print(#function)
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(MovieData.self, from: movieData)
            
            let dailyLists = decodedData.boxOfficeResult.dailyBoxOfficeList
            
            // 반복문으로 movie배열 생성 ⭐️
//            var myMovielists = [Movie]()
//
//            for movie in dailyLists {
//
//                let name = movie.movieNm
//                let rank = movie.rank
//                let openDate = movie.openDt
//                let todayAudi = movie.audiCnt
//                let accAudi = movie.audiAcc
//
//                let myMovie = Movie(movieNm: name, rank: rank, openDate: openDate, audiCnt: todayAudi, accAudi: accAudi)
//
//                myMovielists.append(myMovie)
//            }
            
            // 고차함수를 이용해 movie배열 생성하는 경우 ⭐️
            let myMovielists = dailyLists.map {
                Movie(movieNm: $0.movieNm, rank: $0.rank, openDate: $0.openDt, audiCnt: $0.audiCnt, accAudi: $0.audiAcc)
            }
            
            return myMovielists
            
        } catch {
            //print(error.localizedDescription)
            
            // (파싱 실패 에러)
            print("파싱 실패")
            
            return nil
        }
        
    }
    
}


// 뷰컨트롤러에서 일어나는 일 ===========================================================
// 빈배열
var downloadedMovies = [Movie]()

// 데이터를 다운로드 및 분석/변환하는 구조체
let movieManager = MovieDataManager()


// 실제 다운로드 코드
movieManager.fetchMovie(date: "20210201") { (movies) in
    
    if let movies = movies {
        
        // 배열 받아서 빈배열에 넣기
        downloadedMovies = movies
        dump(downloadedMovies)
        
        print("전체 영화 갯수 확인: \(Movie.movieId)")
    } else {
        print("영화데이터가 없습니다. 또는 다운로드에 실패했습니다.")
    }
}

#####################################################################################2021.10.21_1
NetWorking
Part20 - 1 - 네트워킹(Networking)
네트워크 통신(서버와의 통신)의 기초

참고 URL
// 영화 진흥위원회 오픈 API
// https://www.kobis.or.kr/kobisopenapi/homepg/main/main.do


// 요청주소
// http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json


// 키: 각자의 것으로 발급


// 요청 예시
// http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=KEYVALUE&targetDt=20210201


// JSON데이터를 스위프트 코드로 변환
// https://app.quicktype.io/

#session(세션) 영단어 뜻: 기간 / 시간
// 세션 ==> 연결 상태 유지 ⭐️
// 일정 시간동안 같은 브라우저(사용자)로부터 들어오는 연결 상태를 일정하게 유지시키는 기술(상태)

iOS에서의 네트워킹의 기본
// 0. URL주소 - 문자열로
let movieURL = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?&key=⭐️본인들각자의키값입력⭐️&targetDt=20210201"


// 1. URL 구조체 만들기
let url = URL(string: movieURL)!


// 2. URLSession 만들기 (네트워킹을 하는 객체 - 브라우저 같은 역할)
let session = URLSession.shared


// 3. 세션에 (일시정지 상태로)작업 부여
let task = session.dataTask(with: url) { (data, response, error) in
    if error != nil {
        print(error!)
        return
    }
    
    guard let safeData = data else {
        return
    }
    
    // 데이터를 그냥 한번 출력해보기
    //print(String(decoding: safeData, as: UTF8.self))
    
    dump(parseJSON1(safeData)!)
    
    
}

// 4.작업시작
task.resume()   // 일시정지된 상태로 작업이 시작하기 때문


// ⭐️ 비동기적으로 동작함




// 받아온 데이터를 우리가 쓰기 좋게 변환하는 과정 (분석) ======================================

// 현재의 형태
func parseJSON1(_ movieData: Data) -> [DailyBoxOfficeList]? {
    
    do {
        // 스위프트5
        // 자동으로 원하는 클래스/구조체 형태로 분석
        // JSONDecoder
        let decoder = JSONDecoder()
        
        let decodedData = try decoder.decode(MovieData.self, from: movieData)

        return decodedData.boxOfficeResult.dailyBoxOfficeList
        
    } catch {
        
        return nil
    }
    
}




// 예전의 형태
func parseJSON2(_ movieData: Data) -> [DailyBoxOfficeList]? {
    
    do {
        
        var movieLists = [DailyBoxOfficeList]()
        
        // 스위프트4 버전까지
        // 딕셔너리 형태로 분석
        // JSONSerialization
        if let json = try JSONSerialization.jsonObject(with: movieData) as? [String: Any] {
            if let boxOfficeResult = json["boxOfficeResult"] as? [String: Any] {
                if let dailyBoxOfficeList = boxOfficeResult["dailyBoxOfficeList"] as? [[String: Any]] {
                    
                    for item in dailyBoxOfficeList {
                        let rank = item["rank"] as! String
                        let movieNm = item["movieNm"] as! String
                        let audiCnt = item["audiCnt"] as! String
                        let audiAcc = item["audiAcc"] as! String
                        let openDt = item["openDt"] as! String
                        
                        // 하나씩 인스턴스 만들어서 배열에 append
                        let movie = DailyBoxOfficeList(rank: rank, movieNm: movieNm, audiCnt: audiCnt, audiAcc: audiAcc, openDt: openDt)

                        
                        movieLists.append(movie)
                    }

                    return movieLists

                }
            }
        }

        return nil
        
    } catch {
        
        return nil
    }
    
}




// 서버에서 주는 데이터의 형태 ====================================================

struct MovieData: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let rank: String
    let movieNm: String
    let audiCnt: String
    let audiAcc: String
    let openDt: String
}




#####################################################################################2021.10.21
네트워크 통신의 이해, HTTP Protocol
CRUD 네트워킹
GET메서드(서버에서 데이터 읽어오기)

(예) 인스타그램 - 내가 팔로잉하는 사람들의 게시글 보기
func getMethod() {
    
    // URL구조체 만들기
    guard let url = URL(string: "http://dummy.restapiexample.com/api/v1/employees") else {
        print("Error: cannot create URL")
        return
    }
    
    // URL요청 생성
    var request = URLRequest(url: url)
    request.httpMethod = "GET"
    
    
    // 요청을 가지고 작업세션시작
    URLSession.shared.dataTask(with: request) { data, response, error in
        // 에러가 없어야 넘어감
        guard error == nil else {
            print("Error: error calling GET")
            print(error!)
            return
        }
        // 옵셔널 바인딩
        guard let safeData = data else {
            print("Error: Did not receive data")
            return
        }
        // HTTP 200번대 정상코드인 경우만 다음 코드로 넘어감
        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
            
        // 원하는 모델이 있다면, JSONDecoder로 decode코드로 구현 ⭐️
        print(String(decoding: safeData, as: UTF8.self))


    }.resume()     // 시작
}


getMethod()


#POST메서드(서버에 내가 원하는 new데이터 업로드하기)

(예) 인스타그램 - 나의 포스트 올리기 / 다른 사람의 게시물에 댓글 달기 / 서비스 가입하기
func postMethod() {
    
    guard let url = URL(string: "http://dummy.restapiexample.com/api/v1/create") else {
        print("Error: cannot create URL")
        return
    }
    
    // 업로드할 모델(형태)
    struct UploadData: Codable {
        let name: String
        let salary: String
        let age: String
    }
    
    // 실제 업로드할 (데이터)인스턴스 생성
    let uploadDataModel = UploadData(name: "Jack", salary: "3540", age: "23")
    
    // 모델을 JSON data 형태로 변환
    guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
        print("Error: Trying to convert model to JSON data")
        return
    }
    
    // URL요청 생성
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type") // 요청타입 JSON
    request.setValue("application/json", forHTTPHeaderField: "Accept") // 응답타입 JSON
    request.httpBody = jsonData
    
    
    // 요청을 가지고 세션 작업시작
    URLSession.shared.dataTask(with: request) { data, response, error in
        // 에러가 없어야 넘어감
        guard error == nil else {
            print("Error: error calling POST")
            print(error!)
            return
        }
        // 옵셔널 바인딩
        guard let safeData = data else {
            print("Error: Did not receive data")
            return
        }
        // HTTP 200번대 정상코드인 경우만 다음 코드로 넘어감
        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
        
        // 원하는 모델이 있다면, JSONDecoder로 decode코드로 구현 ⭐️
        print(String(decoding: safeData, as: UTF8.self))
        
    }.resume()   // 시작
}

postMethod()



#PUT메서드(서버에 현존하는 데이터 업데이트하기)

(예) 인스타그램 - 나의 포스트 수정하기 / 다른 사람 게시물의 좋아요 누르기 / 나의 정보 수정
func putMethod() {
    guard let url = URL(string: "https://reqres.in/api/users/2") else {
        print("Error: cannot create URL")
        return
    }
    
    // 업로드할 모델(형태)
    struct UploadData: Codable {
        let name: String
        let job: String
    }
    
    // 실제 업로드할 (데이터)인스턴스 생성
    let uploadDataModel = UploadData(name: "Nicole", job: "iOS Developer")
    
    // 모델을 JSON data 형태로 변환
    guard let jsonData = try? JSONEncoder().encode(uploadDataModel) else {
        print("Error: Trying to convert model to JSON data")
        return
    }
    
    // URL요청 생성
    var request = URLRequest(url: url)
    request.httpMethod = "PUT"
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = jsonData
    
    // 요청을 가지고 작업세션시작
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard error == nil else {
            print("Error: error calling PUT")
            print(error!)
            return
        }
        guard let safeData = data else {
            print("Error: Did not receive data")
            return
        }
        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
        
        // 원하는 모델이 있다면, JSONDecoder로 decode코드로 구현 ⭐️
        print(String(decoding: safeData, as: UTF8.self))
        
    }.resume()
}

putMethod()



#DELETE메서드(서버에 현존하는 데이터 삭제하기)

(예) 인스타그램 - 나의 포스트 삭제하기
func deleteMethod() {
    guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/1") else {
        print("Error: cannot create URL")
        return
    }
    
    // URL요청 생성
    var request = URLRequest(url: url)
    request.httpMethod = "DELETE"
    
    // 요청을 가지고 작업세션시작
    URLSession.shared.dataTask(with: request) { data, response, error in
        guard error == nil else {
            print("Error: error calling DELETE")
            print(error!)
            return
        }
        guard let safeData = data else {
            print("Error: Did not receive data")
            return
        }
        guard let response = response as? HTTPURLResponse, (200 ..< 299) ~= response.statusCode else {
            print("Error: HTTP request failed")
            return
        }
        
        // 원하는 모델이 있다면, JSONDecoder로 decode코드로 구현 ⭐️
        print(String(decoding: safeData, as: UTF8.self))
        
    }.resume()
}

deleteMethod()

#####################################################################################2021.10.20_7
Defer
Defer문

할일을 미루는 defer문에 대한 이해
// defer문은 코드의 실행을 스코프가 종료되는 시점으로 연기시키는 문법
// 일반적인 사용은, 어떤 동작의 마무리 동작을 특정하기 위해서 사용 (정리의 개념)


func deferStatement1() {
    
    defer {
        print("나중에 실행하기")
    }
    
    print("먼저 실행하기")
}

deferStatement1()






func deferStatement2() {
    
    if true {
        print("먼저 실행하기")
        return
    }
    
    defer {                   // 디퍼문이 호출되어야, 해당 디퍼문의 실행이 예약되는 개념
        print("나중에 실행하기")
    }
}

deferStatement2()






// 등록한 역순으로 실행  ====> 일반적으로 하나의 디퍼문만 사용하는 것이 좋음

func deferStatement3() {
    defer {
        print(1)
    }
    defer {
        print(2)
    }
    defer  {
        print(3)
    }
}

deferStatement3()





// 어떻게 실행될까?

for i in 1...3 {
    defer { print ("Defer된 숫자?: \(i)") }
    print ("for문의 숫자: \(i)")
}
#####################################################################################2021.10.20_6
에러를 던지는 함수를 처리하는 함수

에러 정의
// 에러정의
enum SomeError: Error {
    case aError
}


// 에러를 던지는 함수 정의 (무조건 에러를 던진다고 가정)
func throwingFunc() throws {
    throw SomeError.aError
}


// 에러의 처리
do {
    try throwingFunc()
} catch {
    print(error)
}

일반적인 함수로 처리
// 함수 내부에서 do-catch문으로 에러를 처리
// 즉, 발생한 에러를 catch블럭에서 받아서 알맞은 처리

func handleError() {
    do {
        try throwingFunc()
    } catch {
        print(error)
    }
}

handleError()


1 - throwing함수로 에러 다시 던지기
/**====================================================
 - 함수 내에서 에러를 직접처리하지 못하는 경우, 에러를 다시 던질 수 있음
 ====================================================**/

func handleError1() throws {
    //do {
    try throwingFunc()
    //}                     // catch블럭이 없어도 에러를 밖으로 던질 수 있음 ⭐️
}



do {
    try handleError1()   // 에러를 받아서 처리 가능
} catch {
    print(error)
}

2 - rethrowing함수로 에러 다시 던지기(rethrows 키워드)
/**================================================================
 - 에러를 던지는 throwing함수를 파라미터로 받는 경우, 내부에서 다시 에러를 던지기 가능
 - rethrows키워드 필요 (Rethrowing메서드)
 ==================================================================**/


// 다시 에러를 던지는 함수(방법1)
func someFunction1(callback: () throws -> Void) rethrows {
    try callback()             // 에러를 다시 던짐(직접 던지지 못함)
    // throw (X)
}


// 다시 에러를 던지는 함수(방법2) - 에러변환
func someFunction2(callback: () throws -> Void) rethrows {
    enum ChangedError: Error {
        case cError
    }
    
    do {
        try callback()
    } catch {   // catch구문에서는 throw (O)
        throw ChangedError.cError    // 에러를 변환해서 다시 던짐
    }
}




// 실제 에러를 다시던지는(rethrowing)함수를 처리하는 부분

do {
    try someFunction1(callback: throwingFunc)
} catch {
    print(error)
}



do {
    try someFunction2(callback: throwingFunc)
} catch {
    print(error)
}


#메서드 / 생성자

메서드 / 생성자에 throw키워드의 적용
/**=======================================================================
 - 에러는 1)Throwing함수 뿐만아니라, 2) 메서드와 3)생성자에도 적용 가능
 - 에러는 던질 수 있는 메서드는 Throwing메서드, 에러는 던질 수 있는 생성자는 Throwing생성자
 =========================================================================**/

// 에러 정의

enum NameError: Error {
    case noName
}



// 생성자와 메서드에도 적용 가능
class Course {
    var name: String
    
    init(name: String) throws {
        if name == "" {
            throw NameError.noName
        } else {
            self.name = name
            print("수업을 올바르게 생성")
        }
    }
    
}



// 에러 처리 (생성자에 대한)

do {
    let _ = try Course(name: "스위프트5")
} catch NameError.noName {
    print("이름이 없어 수업이 생성 실패하였습니다.")
}


#생성자와 메서드의 재정의
class NewCourse: Course {
    
    override init(name: String) throws {
        try super.init(name: name)
        
    }
}


/**=================================================================
 - Throwing 메서드/생성자는 재정의할 때, 반드시 Throwing메서드/생성자로 재정의해야함
   (Throwing 메서드/생성자를 일반 메서드/생성자로 재정의 불가)

 - 일반 메서드/생성자를 Throwing 메서드/생성자로 재정의 하는 것은 가능
   (일반 메서드/생성자의 범위가 더 큼)
 
 [상속관계에서]
 - (상위) throws    (하위) throws재정의    (O 가능)
 
 - (상위) 일반       (하위) throws재정의    (O 가능)
   (상위) throws    (하위) 일반재정의       (X 불가능)
 
 - (상위) throws    (하위) rethrows재정의  (O 가능)
   (상위) rethrows  (하위) throws재정의    (X 불가능)

 - Throwing메서드와 Rethrowing메서드를 비교하면 Rethrowing메서드의 범위가 더 작음
 ===================================================================**/

#####################################################################################2021.10.20_5
에러 처리 방법
에러 함수 정의

// 1) 에러 정의 (어떤 에러가 발생할지 경우를 미리 정의)

enum HeightError: Error {  //에러 프로토콜 채택
    case maxHeight
    case minHeight
}



// 2) 에러가 발생할 수 있는 함수에 대한 정의

func checkingHeight(height: Int) throws -> Bool {
    
    if height > 190 {
        throw HeightError.maxHeight
    } else if height < 130 {
        throw HeightError.minHeight
    } else {
        if height >= 160 {
            return true
        } else {
            return false
        }
    }
}

에러를 처리하는 방법 - try / try? / try!
/**===========================================
 1) 에러 정식 처리 방법
============================================**/

do {
    let isChecked = try checkingHeight(height: 200)
    
    if isChecked {
        print("청룡열차 가능")
    } else {
        print("후룸라이드 가능")
    }
} catch {
    print("놀이기구 타는 것 불가능")
}



/**===========================================
 2) try? (옵셔널 트라이) ===> 옵셔널 타입으로 리턴

   (1) 정상적인 경우 ==> (정상)리턴타입으로 리턴
   (2) 에러가 발생하면 ==> nil 리턴
============================================**/


let isChecked = try? checkingHeight(height: 200)      // Bool?

// 당연히, 옵셔널 타입을 벗겨서 사용해야함




/**===========================================
 3) try! (Forced 트라이) ===> 에러가 날 수 없는 경우에만 사용 가능

   (1) 정상적인 경우 ==> (정상)리턴타입으로 리턴
   (2) 에러가 발생하면 ==> 런타임에러
============================================**/


let isChecked2: Bool = try! checkingHeight(height: 150)      // Bool


// 에러가 발생할 수 없다고 확신이 있는 경우만 사용해야 함


#Catch블럭 처리법
// catch블럭은 do블럭에서 발생한 에러만을 처리하는 블럭
// 모든 에러를 반드시 처리해야만 함 (글로벌 스코프에서는 모든 에러를 처리하지 않아도 컴파일 에러발생하지 않음)



// 패턴이 있는 경우(모든 에러를 각각 따로 처리 해야함)

do {
    
    let isChecked = try checkingHeight(height: 100)
    print("놀이기구 타는 것 가능: \(isChecked)")
    
} catch HeightError.maxHeight  {    // where절을 추가해서, 매칭시킬 에러패턴에 조건을 추가할 수 있음
    
    print("키가 커서 놀이기구 타는 것 불가능")
    
} catch HeightError.minHeight {      // 생략가능
    
    print("키가 작아서 놀이기구 타는 것 불가능")
    
}



// catch 패턴이 없이 처리도 가능

do {
    
    let isChecked = try checkingHeight(height: 100)
    print("놀이기구 타는 것 가능: \(isChecked)")
    
} catch {    // error 상수를 제공 (모든 에러가 넘어옴)
    print(error.localizedDescription)
    
    if let error = error as? HeightError {    // 실제 우리가 정의한 구체적인 에러 타입이 아니고, 에러 타입(프로토콜)이 넘어올 뿐
        switch error {
        case .maxHeight:
            print("키가 커서 놀이기구 타는 것 불가능")
        case .minHeight:
            print("키가 작아서 놀이기구 타는 것 불가능")
        }
    }
}

Catch블럭의 처리 (Swift 5.3)
// 스위프트 5.3 버전 업데이트

do {
    
    let isChecked = try checkingHeight(height: 100)
    print("놀이기구 타는 것 가능: \(isChecked)")
    
} catch HeightError.maxHeight, HeightError.minHeight {   // 케이스 나열도 가능해짐
    
    print("놀이기구 타는 것 불가능")
    
}

#####################################################################################2021.10.20_4
Part_20 Error Handling
Part20 - 에러 처리(Error Handling)
에러 처리 문법

에러(오류)의 이해
/**=========================================================================
 - 에러의 종류는
   1) 컴파일 타임 에러 ===> 스위프트 문법과 관련된 에러(컴파일러가 미리 알고 수정해야한다고 알려줌)
   2) 런타임 에러 ===> 프로그램이 실행되는 동안 발생

 - 런타임 에러 ===> 크래시(앱이 강제로 종료)
   ===> 발생가능한 에러를 미리 처리해 두면, 강제종료되지 않음 (개발자가 처리해야만 하는 에러)
 ===========================================================================**/

(런타임)에러 처리가 왜 필요할까?
/**====================================================================================
 - 앱이 실행하는 중간에 왜 꺼질까?
 
 - 어떤 얘기치 못한 상황이 발생할 수 있음
 - (네트워크 통신을 하는 등의 경우에서) 서버에서 데이터를 못 받아와서 ==> 꺼짐

 - 앱이 그냥 꺼지는 게 좋은가? 아니면 예를들어 "서버에서 문제가 발생했습니다. 잠시뒤에 다시 접속해 주세요"라고
   알려주는 것이 좋은 가?
 
 - 프로세스 중에서, 예외적인 상황(에러)이 발생하는 것이 미리 가능성 등을 처리해 놓으면
   앱이 무작정 꺼지는 것을 예방할 수 있음 ⭐️


 - 에러는 일반적으로 동작. 즉, 함수의 처리과정에서 일어남
 - 함수를 정의할때, 예외적인 일이 발생하는 경우가 발생할 수 있는 함수이다.라고 정의하고 처리하는 과정을 배울 것임


 - (에러 발생 가능)함수 ====>  함수 실행시에 조금 다르게 처리해야함(에러 처리) ⭐️
 =====================================================================================**/

에러 처리의 과정 (3단계)
// 1) 에러 정의 (어떤 에러가 발생할지 경우를 미리 정의)

enum HeightError: Error {    //에러 프로토콜 채택 (약속)
    case maxHeight
    case minHeight
}




// 2) 에러가 발생할 수 있는 함수에 대한 정의

func checkingHeight(height: Int) throws -> Bool {    // (에러를 던잘수 있는 함수 타입이다)
    
    if height > 190 {
        throw HeightError.maxHeight
    } else if height < 130 {
        throw HeightError.minHeight
    } else {
        if height >= 160 {
            return true
        } else {
            return false
        }
    }
}




// 3) 에러가 발생할 수 있는 함수의 처리(함수의 실행) ===> 기존과 조금 다르다 (try와 do-catch문으로 처리)


do {
    
    let isChecked = try checkingHeight(height: 200)
    print("놀이기구 타는 것 가능: \(isChecked)")
    
} catch {
    
    print("놀이기구 타는 것 불가능")
    
}

/**================================================
 - do블럭  - 함수를 통한 정상적인 처리의 경우 실행하는 블럭
 - catch블럭 - 함수가 에러를 던졌을 경우의 처리 실행하는 블럭
 ==================================================**/

에러 발생가능한 함수의 형태
/**=========================
 - () throws -> ()
 - (Int) throws -> ()
============================**/


//[1, 2, 3, 4, 5].map(<#T##transform: (Int) throws -> T##(Int) throws -> T#>)

#####################################################################################2021.10.20_3
메모리 누수(Memory Leak)의 사례
강한참조 사이클로 인한 메모리누수의 사례

// 클로저 18-9번 파일과 동일 내용


class Dog {
    var name = "초코"
    
    var run: (() -> Void)?
    
    func walk() {
        print("\(self.name)가 걷는다.")
    }
    
    func saveClosure() {
        // 클로저를 인스턴스의 변수에 저장
        run = {
            print("\(self.name)가 뛴다.")
        }
    }
    
    deinit {
        print("\(self.name) 메모리 해제")
    }
}



func doSomething() {
    let choco: Dog? = Dog()
    choco?.saveClosure()       // 강한 참조사이클 일어남 (메모리 누수가 일어남)
}



doSomething()

#####################################################################################2021.10.20_2
메모리 누수(Memory Leak)현상의 해결
#1 - 약한 참조(Weak Reference)
class Dog {
    var name: String
    weak var owner: Person?     // weak 키워드 ==> 약한 참조
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}


class Person {
    var name: String
    weak var pet: Dog?         // weak 키워드 ==> 약한 참조
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}


var bori: Dog? = Dog(name: "보리")
var gildong: Person? = Person(name: "홍길동")


// 강한 참조 사이클이 일어나지 않음
bori?.owner = gildong
gildong?.pet = bori



// 메모리 해제가 잘됨(사실 이 경우 한쪽만 weak으로 선언해도 상관없음)
bori = nil
gildong = nil
약한 참조의 경우, 참조하고 있던 인스턴스가 사라지면, nil로 초기화 되어있음
// nil로 설정하고 접근하면 ===> nil

//gildong = nil
//bori?.owner   // gildong만 메모리 해제시켰음에도 ===> nil

#2 - 비소유 참조(Unowned Reference)
class Dog1 {
    var name: String
    unowned var owner: Person1?    // Swift 5.3 이전버전에서는 비소유참조의 경우, 옵셔널 타입 선언이 안되었음
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}

class Person1 {
    var name: String
    unowned var pet: Dog1?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}


var bori1: Dog1? = Dog1(name: "보리1")
var gildong1: Person1? = Person1(name: "홍길동1")


// 강한 참조 사이클이 일어나지 않음
bori1?.owner = gildong1
gildong1?.pet = bori1



// 메모리 해제가 잘됨(사실 이 경우 한쪽만 unowned로 선언해도 상관없음)
bori1 = nil
gildong1 = nil

비소유 참조의 경우, 참조하고 있던 인스턴스가 사라지면, nil로 초기화 되지 않음
// nil로 설정하고 접근하면 ===> 에러 발생

// 1) 에러발생하는 케이스

//gildong1 = nil
//bori1?.owner   // nil로 초기화 되지 않음 에러 발생


// 2) 에러가 발생하지 않게 하려면

//gildong1 = nil
//bori1?.owner = nil      // 에러 발생하지 않게 하려면, nil로 재설정 필요 ⭐️
//bori1?.owner



#####################################################################################2021.10.20_1
Memory Leak(메모리 누수) 현상에 대한 이해
메모리 관리

Memory Leak(메모리 누수) 현상에 대한 이해
class Dog {
    var name: String
    var owner: Person?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}


class Person {
    var name: String
    var pet: Dog?
    
    init(name: String) {
        self.name = name
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}


var bori: Dog? = Dog(name: "보리")
var gildong: Person? = Person(name: "홍길동")


bori?.owner = gildong
gildong?.pet = bori


// 강한 참조 사이클(Strong Reference Cycle)이 일어남

bori = nil
gildong = nil


/**==========================================
 - 객체가 서로를 참조하는 강한 참조 사이클로 인해
 - 변수의 참조에 nil을 할당해도 메모리 해제가 되지 않는
 - 메모리 누수(Memory Leak)의 상황이 발생
=============================================**/


#Memory Leak의 해결방안
/**==========================================
 - RC를 고려하여, 참조 해제 순서를 주의해서 코드 작성
    ===> 신경쓸 것이 많음/실수 가능성
 
 - 1) Weak Reference (약한 참조)
 - 2) Unowned Reference (비소유 참조)
=============================================**/

#####################################################################################2021.10.20
Part-19 ARC_메모리관리
Part19 - 메모리 관리
ARC(Automatic Reference Counting)를 통한 메모리 관리

MRC(Manual RC) vs ARC(Automatic RC)
// MRC(수동 RC관리)와 ARC(자동 RC)

class Dog {
    var name: String
    var weight: Double
    
    init(name: String, weight: Double) {
        self.name = name
        self.weight = weight
    }
    
    deinit {
        print("\(name) 메모리 해제")
    }
}


var choco: Dog? = Dog(name: "초코", weight: 15.0)  //retain(choco)   RC: 1
var bori: Dog? = Dog(name: "보리", weight: 10.0)   //retain(bori)    RC: 1


choco = nil   // RC: 0
//release(choco)
bori = nil    // RC: 0
//release(bori)


/**========================================================================
 - 예전 언어들은 모든 메모리를 수동 관리했음
 - 실제로 개발자가 모든 메모리 해제 코드까지 삽입해야함 (실수할 가능성 높음)
 

 - retain() 할당 ---> release() 해제
    (RC  +1)           (RC  -1)

 - 개발자는 실제 로직 구현 포함, 메모리 관리에 대한 부담이 있었음 ⭐️


 - 따라서, 현대적 언어들은 대부분 자동 메모리 관리 모델을 사용
 - 스위프트의 경우, 컴파일러가 실제로
   retain() 할당 ---> release() 해제 코드를 삽입한다고 보면됨
 - 컴파일러가 메모리 관리코드를 자동으로 추가해 줌으로써, 프로그램의 메모리 관리에 대한 안정성 증가


 - 단지 아래와 같은 메커니즘의 실행을 수동(Manual)으로 할 것인지,
   자동(Automatic)으로 할 것인지의 차이

 [ARC모델의 기반: 소유정책과 참조카운팅]
   1.소유정책 - 인스턴스는 하나이상의 소유자가 있는 경우 메모리에 유지됨
             (소유자가 없으면, 메모리에서 제거)
   2.참조카운팅 - 인스턴스(나)를 가르키는 소유자수를 카운팅

 - (쉽게 말하면, 인스턴스를 가르키고 있는 RC가 1이상이면 메모리에 유지되고, 0이되면 메모리에서 제거됨)
 =======================================================================**/


#ARC(Automatic Reference Counting)
var dog1: Dog?
var dog2: Dog?
var dog3: Dog?


dog1 = Dog(name: "댕댕이", weight: 7.0)     // RC + 1   RC == 1
dog2 = dog1                               // RC + 1   RC == 2
dog3 = dog1                               // RC + 1   RC == 3


dog3?.name = "깜둥이"
dog2?.name
dog1?.name



dog3 = nil                                // RC - 1   RC == 2
dog2 = nil                                // RC - 1   RC == 1
dog1 = nil                                // RC - 1   RC == 0    // 메모리 해제
#####################################################################################2021.10.19_2
함수형 프로그래밍
참고) 함수형 프로그래밍

함수형 프로그래밍(Functional Programming)이란?
명령형 프로그래밍
// 배열의 합을 구하는 문제 - 어떻게(how) 구현해낼까?

let numbers = [1, 2, 3]

var sum = 0

for number in numbers {
    sum += number
}

print(sum)

#함수형 프로그래밍(선언형)
let newNnumbers = [1, 2, 3]
var newSum = 0


// 기존의 함수를 어떻게 조합해서 결과(what)를 만들까?

newSum = newNnumbers.reduce(0) { $0 + $1 }

print(newSum)



/**=======================================================================
 [함수형 프로그래밍]
 - 함수를 이용해서, "사이드 이펙트가 없도록" 선언형으로 프로그래밍 하는 것
   (함수형 프로그래밍은 결과를 도출하기 위해 "함수"를 사용하는 것에 지나지 않음)

 - 산에 올라가는 방법은
   1)"산을 걸어서 올라가는 방법"(명령형)  vs  2) "헬리곱터에서 정상에서 내리는 방법"(함수형)
 
 [함수형/선언형]
 - 개발자는 중간과정을 신경쓰지 않고,
 - 이미 정의된 함수를 가지고 "어떻게 조합해서 결과를 만들어 낼까"만 신경쓰면 됨
 - ==> 모두가 map/filter/reduce의 쓰는 방법을 알고 있기 때문

 - 간결한 코드 작성이 가능해짐 ⭐️
 - SwiftUI에서 사용하는 방식
==========================================================================**/



// 위의 배열 중에, 홀수만 제곱해서, 그 숫자를 다 더한 값은?

var numbersArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]



var newResult = numbersArray
                        .filter { $0 % 2 != 0 }
                        .map { $0 * $0 }
                        .reduce(0) { $0 + $1 }

print(newResult)





// 추가 참고자료
// https://youtu.be/jVG5jvOzu9Y   (함수형 프로그래밍이 뭔가요? - 얄팍한 코딩사전)
// https://youtu.be/HZkqMiwT-5A   (함수형 프로그래밍이 뭐하는 건가요? - 곰튀김 님)
// https://youtu.be/cXi_CmZuBgg   (Functional Reactive Programming 패러다임 - 곰튀김 님)
#####################################################################################2021.10.19_1
고차함수(forEach, compactMap, flatMap)✔
2) 기타 고차함수

#4 - forEach함수
/**====================================================
 - 기존 배열 등의 각 아이템을 활용해서
   각 아이템별로 특정 작업(작업 방식은 클로저가 제공)을 실행
 - (각 아이템을 활용해서 각각 특정 작업을 실행할때 사용)
 ======================================================**/


let immutableArray = [1, 2, 3, 4, 5]


immutableArray.forEach { num in
    print(num)
}

immutableArray.forEach { print("숫자: \($0)") }


#5 - compactMap함수
/**====================================================
 - 기존 배열 등의 각 아이템을 새롭게 매핑해서(매핑방식은 클로저가 제공)
   변형하되, 옵셔널 요소는 제거하고, 새로운 배열을 리턴
 - (map + 옵셔널제거)
 - 옵셔널은 빼고, 컴팩트(compact)하게
 - (옵셔널 바인딩의 기능까지 내장)
 ======================================================**/


let stringArray: [String?] = ["A", nil, "B", nil, "C"]


var newStringArray = stringArray.compactMap { $0 }
print(newStringArray)



let numbers = [-2, -1, 0, 1, 2]


var positiveNumbers = numbers.compactMap { $0 >= 0 ? $0 : nil }

print(positiveNumbers)

// 사실 이런 경우는 filter로 가능
//numbers.filter { $0 >= 0 }



// compactMap은 아래와 같은 방식으로도 구현 가능

newStringArray = stringArray.filter { $0 != nil }.map { $0! }
print(newStringArray)

#6 - flatMap함수
/**====================================================
 - 중첩된 배열의 각 배열을 새롭게 매핑해서(매핑방식은 클로저가 제공)
 - 내부 중첩된 배열을 제거하고 리턴
 - (중첩배열을 flat하게 매핑)
 ======================================================**/


var nestedArray = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

print(nestedArray.flatMap { $0 })






var newNnestedArray = [[[1,2,3], [4,5,6], [7, 8, 9]], [[10, 11], [12, 13, 14]]]

var numbersArray = newNnestedArray
                            .flatMap { $0 }
                            .flatMap { $0 }

print(numbersArray)
#####################################################################################2021.10.19
고차함수(map, filter, reduce)✔
Part18-1 - 고차함수
1) 기본 고차함수 3가지

고차함수(Higher-order Function)란?
/**==========================================================
 - 고차원의 함수
 - 함수를 파라미터로 사용하거나, 함수실행의 결과를 함수로 리턴하는 함수


 - 일반적으로 함수형 언어를 지향하는 언어들에 기본적으로 구현되어 있음
 - 아래의 3가지 함수를 다룸

 - 1) map 함수
 - 2) filter 함수
 - 3) reduce 함수

 - (추가적으로: forEach, compactMap, flatMap)


 - Sequence, Collection 프로토콜을 따르는 컬렉션(배열, 딕셔너리, 세트 등)
   에 기본적으로 구현되어 있는 함수
 - (Optional타입에도 구현되어 있음)
 ============================================================**/

#1 - map함수
/**====================================================
 - 기존 배열 등의 각 아이템을 새롭게 매핑해서(매핑방식은 클로저가 제공)
   새로운 배열을 리턴하는 함수
 - (각 아이템을 매핑해서, 변형해서 새로운 배열을 만들때 사용)
 ======================================================**/


let numbers = [1, 2, 3, 4, 5]

//numbers.map(<#T##transform: (Int) throws -> T##(Int) throws -> T#>)



var newNumbers = numbers.map { (num) in
    return "숫자: \(num)"
}


newNumbers = numbers.map { "숫자: \($0)" }


//print(numbers)
//print(newNumbers)   // ["숫자: 1", "숫자: 2", "숫자: 3", "숫자: 4", "숫자: 5"]





var alphabet = ["A", "B", "C", "D"]


//names.map(<#T##transform: (String) throws -> T##(String) throws -> T#>)



var newAlphabet = alphabet.map { (name) -> String in
    return name + "'s good"
}


//print(alphabet)
//print(newAlphabet)

#2 - filter함수
/**====================================================
 - 기존 배열 등의 각 아이템을 조건(조건은 클로저가 제공)을
   확인후, 참(true)을 만족하는 아이템을 걸러내서 새로운 배열을 리턴
 - (각 아이템을 필터링해서, 걸러내서 새로운 배열을 만들때 사용)
 ======================================================**/


let names = ["Apple", "Black", "Circle", "Dream", "Blue"]

//names.filter(<#T##isIncluded: (String) throws -> Bool##(String) throws -> Bool#>)



var newNames = names.filter { (name) -> Bool in
    return name.contains("B")
}


print(newNames)






let array = [1, 2, 3, 4, 5, 6, 7, 8]


//array.filter(<#T##isIncluded: (Int) throws -> Bool##(Int) throws -> Bool#>)


var evenNumersArray = array.filter { num in
    return num % 2 == 0
}

evenNumersArray = array.filter { $0 % 2 == 0 }

print(evenNumersArray)


// 함수로 전달해보기

//func isEven(_ i: Int) -> Bool {
//    return i % 2 == 0
//}


//let evens = array.filter(isEven)



evenNumersArray = array.filter { $0 % 2 == 0 }.filter { $0 < 5 }

print(evenNumersArray)


#3 - reduce함수
/**====================================================
 - 기존 배열 등의 각 아이템을 클로저가 제공하는 방식으로 결합해서
   마지막 결과값을 리턴(초기값 제공할 필요)
 - (각 아이템을 결합해서 단 하나의 값으로 리턴)
 ======================================================**/


var numbersArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

//numbersArray.reduce(<#T##initialResult: Result##Result#>, <#T##nextPartialResult: (Result, Int) throws -> Result##(Result, Int) throws -> Result#>)



var resultSum = numbersArray.reduce(0) { (sum, num) in
    return sum + num
}

print(resultSum)



resultSum = numbersArray.reduce(100) { $0 - $1 }

print(resultSum)


# map / filter / reduce의 활용 ⭐️
numbersArray = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10]

// 위의 배열 중에, 홀수만 제곱해서, 그 숫자를 다 더한 값은?


var newResult = numbersArray
                        .filter { $0 % 2 != 0 }
                        .map { $0 * $0 }
                        .reduce(0) { $0 + $1 }

print(newResult)


// 1, 9, 25, 49, 81 ===> 165
#####################################################################################2021.10.18_6
Closures 사용법 예시
import UIKit

class ViewController: UIViewController {
 
    
    let emailTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Email"
        tf.backgroundColor = UIColor(white: 0, alpha: 0.3)
        tf.borderStyle = .roundedRect
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.translatesAutoresizingMaskIntoConstraints = false
        //view.addSubview(tf)    // 뷰컨트롤러의 view에 접근 못함
        return tf
    }()
    
    // 아래 버튼2와 비교
    lazy var button: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("My Button", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = UIColor.blue
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        return button
    }()
    
    // 위의 버튼과 비교
    let button2 = UIButton(type: .system)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        
        // emailTextField를 뷰 컨트롤러의 view에 하위뷰로 더하기
        view.addSubview(emailTextField)
        setupUI()
        setupExampleButton2()
    }
    
    // 오토레이아웃을 코드로 잡기
    func setupUI() {
        // emailTextField 관련 오토레이아웃
        emailTextField.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        emailTextField.widthAnchor.constraint(equalToConstant: 150).isActive = true
        emailTextField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        // button 관련 오토레이아웃
        button.topAnchor.constraint(equalTo: emailTextField.bottomAnchor, constant: 20).isActive = true
        button.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    func setupExampleButton2() {
        // button2 관련 설정
        button2.setTitle("New Button", for: .normal)
        button2.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        button2.setTitleColor(.white, for: .normal)
        button2.backgroundColor = UIColor.blue
        button2.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button2)

        // button2 관련 오토레이아웃
        button2.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 20).isActive = true
        button2.widthAnchor.constraint(equalToConstant: 150).isActive = true
        button2.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true

    }
    
    
    
}
#####################################################################################2021.10.18_5
escaping, autoclosures
@escaping 키워드

함수의 파라미터 중 클로저 타입에 @escaping 키워드가 필요한 경우
/**==========================================================================
 - 원칙적으로 함수의 실행이 종료되면 파라미터로 쓰이는 클로저도 제거됨
 - @escaping 키워드는 클로저를 제거하지 않고 함수에서 탈출시킴(함수가 종료되어도 클로저가 존재하도록 함)
 - ==> 클로저가 함수의 실행흐름(스택프레임)을 벗어날 수 있도록 함
 ============================================================================**/
 
 

// (1) 클로저를 단순 실행 (non-escaping) =====================
//     (지금까지 다뤘던 내용)

func performEscaping1(closure: () -> ()) {
    print("프린트 시작")
    closure()
}


performEscaping1 {
    print("프린트 중간")
    print("프린트 종료")
}




// (2) 클로저를 외부변수에 저장 (@escaping 필요) =================

/**===========================================
 @escaping 사용의 대표적인 경우
 - 1) 어떤 함수의 내부에 존재하는 클로저(함수)를 외부 변수에 저장
 - 2) GCD (비동기 코드의 사용)
 =============================================**/



var aSavedFunction: () -> () = { print("출력") }

//aSavedFunction()



func performEscaping2(closure: @escaping () -> ()) {
    aSavedFunction = closure         // 클로저를 실행하는 것이 아니라  aSavedFunction 변수에 저장
    //closure()
}


//aSavedFunction()


performEscaping2(closure: { print("다르게 출력") })


//aSavedFunction()




// 또다른 예제 (GCD 비동기 코드)


func performEscaping1(closure: @escaping (String) -> ()) {
    
    var name = "홍길동"
    
    DispatchQueue.main.asyncAfter(deadline: .now() + 1) {   //1초뒤에 실행하도록 만들기
        closure(name)
    }
    
}



performEscaping1 { str in
    print("이름 출력하기: \(str)")
}



@autoclosure 키워드

함수의 파라미터 중 클로저 타입에 @autoclosure 키워드를 붙이는 이유
// 클로저 앞에 @autoclosure 키워드 사용(파라미터가 없는 클로저만 가능)

func someFuction(closure: @autoclosure () -> Bool) {
    if closure() {
        print("참입니다.")
    } else {
        print("거짓입니다.")
    }
}


var num = 1


// 실제로 함수를 사용하려고 하면


//someFuction(closure: <#T##Bool#>)

someFuction(closure: num == 1)


/**========================================================================
 - 일반적으로 클로저 형태로 써도되지만, 너무 번거로울때 사용
 - 번거로움을 해결해주지만, 실제 코드가 명확해 보이지 않을 수 있으므로 사용 지양(애플 공식 문서)
 - 잘 사용하지 않음. 읽기위한 문법
==========================================================================**/



// autoclosure는 기본적으로 non-ecaping 특성을 가지고 있음

func someAutoClosure(closure: @autoclosure @escaping () -> String) {
    DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
        print("소개합니다: \(closure())")
    }
}


someAutoClosure(closure: "제니")
#####################################################################################2021.10.18_4
Closures 메모리 구조
클로저의 캡처

클로저의 Capuring Value
var stored = 0


let closure = { (number: Int) -> Int in
    stored += number
    return stored
}




closure(3)

closure(4)   // 어떤 결과가 나올까?

closure(5)

stored = 0

closure(5)   // 어떤 결과가 나올까?



#캡처 현상
일반적인 함수
// 함수 내에서 함수를 실행하고, 값을 리턴하는 일반적인 함수

func calculate(number: Int) -> Int {
    
    var sum = 0
    
    func square(num: Int) -> Int {
        sum += (num * num)
        return sum
    }
    
    let result = square(num: number)
    
    return result
}


calculate(number: 10)
calculate(number: 20)
calculate(number: 30)

#변수를 캡처하는 함수(중첩 함수의 내부 함수) - 캡처 현상의 발생
/**=======================================================
 - 아래와 같은 경우, 중첩함수로 이루어져 있고
 - 내부 함수 외부에 계속 사용해야하는 값이 있기 때문에 캡처 현상이 발생
 
 - (함수/클로저를 변수에 저장하는 시점에 캡처) ==> 클로저도 레퍼런스 타입
=========================================================**/


func calculateFunc() -> ((Int) -> Int) {
    
    var sum = 0
    
    func square(num: Int) -> Int {
        sum += (num * num)
        return sum
    }
    
    return square
}




// 변수에 저장하는 경우(Heap 메모리에 유지)
var squareFunc = calculateFunc()


squareFunc(10)
squareFunc(20)
squareFunc(30)



// 변수에 저장하지 않는 경우
// (Heap메모리에 유지하지 않음)

//calculateFunc()(10)
//calculateFunc()(20)
//calculateFunc()(30)



// 레퍼런스 타입
var dodoFunc = squareFunc
dodoFunc(20)

#####################################################################################2021.10.18_3
Closures 문법 최적화,실제 사용 예시✔
클로저의 문법 최적화

클로저는 실제 사용시 읽기 쉽고, 간결한 코드 작성을 위해 축약된 형태의 문법을 제공함
/**=============================================================================
 [문법 최적화(간소화)]
 - 1) 문맥상에서 파라미터와 리턴밸류 타입 추론(Type Inference)
 - 2) 싱글 익스프레션인 경우(한줄), 리턴을 안 적어도 됨(Implicit Return)
 - 3) 아규먼트 이름을 축약(Shorthand Argements) ===> $0, $1
 - 4) 트레일링 클로저 문법: 함수의 마지막 전달 인자(아규먼트)로 클로저 전달되는 경우, 소괄호를 생략 가능
 ===============================================================================**/

트레일링(Trailing) 클로저 - 후행 클로저 문법
// 1) (클로저를 파라미터로 받는 함수)정의

func closureParamFunction(closure: () -> Void) {
    print("프린트 시작")
    closure()
}




// 2) 함수를 실행할때 클로저 형태로 전달
// 함수의 마지막 전달 인자(아규먼트)로 클로저 전달되는 경우, 소괄호를 생략 가능

closureParamFunction(closure: {
    print("프린트 종료")
})

closureParamFunction(closure: ) {      // 소괄호를 앞으로 가져오기
    print("프린트 종료")
}

closureParamFunction() {               // 아규먼트 생략가능
    print("프린트 종료")
}


// 소괄호를 아예 생략할 수 있다.
// ==> 아래 형태가 함수를 실행하고 마지막 아규먼트로 클로저를 전달했다는 형태에 익숙해져야함

closureParamFunction {
    print("프린트 종료")
}



// 연습

// 1) (함수를 파라미터로 받는 함수)정의

func closureCaseFunction(a: Int, b: Int, closure: (Int) -> Void) {
    let c = a + b
    closure(c)
}


// 2) 함수를 실행할때 클로저 형태로 전달

closureCaseFunction(a: 5, b: 2) { number in      // 소괄호가 클로저 앞에서 닫힘
    print("출력할까요? \(number)")
}


#파라미터 및 생략 등의 간소화
// 함수의 정의

func performClosure(param: (String) -> Int) {
    param("Swift")
}



// 문법을 최적화하는 과정

// 1) 타입 추론(Type Inference)

performClosure(param: { (str: String) in
    return str.count
})

performClosure(param: { str in
    return str.count
})


// 2) 한줄인 경우, 리턴을 안 적어도 됨(Implicit Return)

performClosure(param: { str in
    str.count
})


// 3) 아규먼트 이름을 축약(Shorthand Argements)

performClosure(param: {
    $0.count
})


// 4) 트레일링 클로저

performClosure(param: {
    $0.count
})

performClosure() {
    $0.count
}

performClosure { $0.count }


#축약 형태로의 활용
let closureType1 = { (param) in
    return param % 2 == 0
}

let closureType2 = { $0 % 2 == 0 }





let closureType3 = { (a: Int, b:Int) -> Int in
    return a * b
}

let closureType4: (Int, Int) -> Int = { (a, b) in
    return a * b
}

let closureType5: (Int, Int) -> Int = { $0 * $1 }

#클로저 활용의 실제 활용 예시
// ⭐️ 현재 여기서는 형태에만 주목하면됨 (앱을 만들어 보고 보면 이해됨)


// 1) 첫번째 예시

//URLSession(configuration: .default)
//    .dataTask(with: <#T##URL#>, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)



//URLSession(configuration: .default).dataTask(with: URL(string: "https://주소")!) { (data, response, error) in
//    // 데이터 처리하는 코드
//}





// 2) 두번째 예시



//Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false, block: <#T##(Timer) -> Void#>)

Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { (timer) in
    print("0.5초뒤에 출력하기")
}





// 3) 세번째 예시

class ViewController: UIViewController {
    
    
}

let vc = ViewController()


//vc.dismiss(animated: true, completion: <#T##(() -> Void)?##(() -> Void)?##() -> Void#>)

vc.dismiss(animated: true) {
    print("화면을 닫는 것을 완료했습니다.")
}


#콜백 함수: 함수를 실행하면서, 파라미터로 전달하는 함수
// 주로 함수가 실행된 결과는 콜백 함수로 전달받아 처리하기 때문에

#멀티플 트레일링 클로저 - Swift 5.3
// 여러개의 함수를 파라미터로 사용할때

func multipleClosure(first: () -> (), second: () -> (), third: () -> ()) {
    first()
    second()
    third()
}



// 기존 방식에서는 마지막 클로저만 트레일링 클로저로 쓸 수 있었음
// (클로저의 경계에서 코드가 헷갈릴 가능성이 있었음)

multipleClosure(first: {
    print("1")
}, second: {
    print("2")
}) {
    print("3")
}



multipleClosure {
    print("mutil-1")
} second: {
    print("mutil-2")
} third: {
    print("mutil-3")
}



// 아규먼트 레이블을 생략하는 경우

func multipleClosure2(first: () -> (), _ second: () -> (), third: () -> ()) {
    first()
    second()
    third()
}


// 아큐먼트 레이블을 생략하지 못함

multipleClosure2 {
    print("1")
} _: {
    print("2")
} third: {
    print("3")
}





// 멀티 트레일링 클로저 - 실사용 예시

//UIView.animate(withDuration: <#T##TimeInterval#>, animations: <#T##() -> Void#>, completion: <#T##((Bool) -> Void)?##((Bool) -> Void)?##(Bool) -> Void#>)



UIView.animate(withDuration: <#T##TimeInterval#>) {
    <#code#>
} completion: { (<#Bool#>) in
    <#code#>
}

#####################################################################################2021.10.18_2
Closures 사용하는 이유
클로저의 사용

#클로저를 왜 사용하는가? - 1
// 1) (클로저를 파라미터로 받는 함수)정의

func closureParamFunction(closure: () -> ()) {
    print("프린트 시작")
    closure()
}


// 파라미터로 사용할 함수/클로저를 정의

func printSwiftFunction() {          // 함수를 정의
    print("프린트 종료")
}


let printSwift = { () -> () in      // 클로저를 정의
    print("프린트 종료")
}



// 함수를 파라미터로 넣으면서 실행 (그동안에 배운 형태로 실행한다면)

closureParamFunction(closure: printSwiftFunction)

closureParamFunction(closure: printSwift)





// 2) 함수를 실행할때 클로저 형태로 전달 (클로저를 사용하는 이유)


closureParamFunction(closure: { () -> () in
    print("프린트 종료")           // 본래 정의된 함수를 실행시키면서, 클로저를 사후적으로 정의 가능
})                              // (활용도가 늘어남)



closureParamFunction(closure: { () -> () in
    print("프린트 종료 - 1")
    print("프린트 종료 - 2")
})


#클로저를 왜 사용하는가? - 2
// 1) (클로저를 파라미터로 받는 함수)정의

func closureCaseFunction(a: Int, b: Int, closure: (Int) -> Void) {
    let c = a + b
    closure(c)
}




// 2) 함수를 실행할 때 (클로저 형태로 전달)

closureCaseFunction(a: 5, b: 2, closure: { (n) in    // 사후적 정의
    print("이제 출력할께요: \(n)")
})



closureCaseFunction(a: 5, b: 2) {(number) in      // 사후적 정의
    print("출력할까요? \(number)")
}


closureCaseFunction(a: 5, b: 3) { (number) in      // 사후적 정의
    print("출력")
    print("출력")
    print("출력")
    print("값: \(number)")
}

#여러가지 예시로 정확하게 이해하기
let print1 = {
    print("1")
}

let print2 = {
    print("2")
}

let print3 = {
    print("3")
}


// 함수의 정의

func multiClosureFunction(closure1: () -> Void, closure2: () -> Void) {
    closure1()
    closure2()
}





// 함수의 실행

multiClosureFunction(closure1: print1, closure2: print2)

multiClosureFunction(closure1: print2, closure2: print3)


multiClosureFunction(closure1: {
    print("1")
}, closure2: {
    print("2")
})



// 함수의 정의

func performClosure(closure: () -> ()) {
    print("시작")
    closure()
    print("끝")
}



// 함수의 실행

performClosure(closure: {
    print("중간")
})

#####################################################################################2021.10.18_1
Closures의 형태
함수와 클로저의 형태 비교

클로저의 형태
// 함수의 형태

func add(a: Int, b: Int) -> Int {
    let result = a + b
    return result
}



// 클로저의 형태

let _ = {(a: Int, b: Int) -> Int in
    let result = a + b
    return result
}


 //클로저의 형태(타입 추론이 가능한 경우)

let _: (Int, Int) -> Int = {(a, b) in
    let result = a + b
    return result
}

#클로저의 형태

가장 많이 사용하는 형태: 리턴형에 대한 표기를 생략 가능
let aClosure1 = { (str: String) in
    return "Hello, \(str)"
}



let aClosure2: (String) -> String = { (str) in     //아규먼트 레이블을 따로 사용하지 않음
    return "Hello, \(str)"
}



let aClosure3 = {
    print("This is a closure.")
}

#파라미터의 타입의 생략도 대부분 가능하다.
let closureType4 = { str in               // 컴파일러가 타입 추론 가능한 경우 생략 가능
    return str + "!"
}

#####################################################################################2021.10.18
Part_18 Closure
Closure의 개념
Part18 - 클로저(Closure)
클로저 - 이름이 없는(익명) 함수

함수의 타입에 대한 표기 (복습)
// 함수의 타입 표기법

let functionA: (String) -> String      // 1)파라미터 문자열, 2)리턴형 문자열

let functionB: (Int) -> ()             // 1)파라미터 정수, 2)리턴형 없음

let functionC: (String) -> Void        // 1)파라미터 문자열, 2)리턴형 없음

#기존의 함수의 형태와 클로저의 형태 비교
// 함수의 정의

func aFunction(str: String) -> String {
    return "Hello, \(str)"
}

// 클로저의 형태

let _ = {(str: String) -> String in
    return "Hello, \(str)"
}

#생각의 전환 ➞ 중괄호는 클로저(함수)이다!
let aClosureType = { () -> () in              // 변수에 담아서 호출하는 것도 가능
    print("안녕")
}


//let aClosureType = { print("안녕") }         // () -> ()



aClosureType()

#함수를 1급객체(First-class Object)로 취급
/**================================================
 - 함수를 1급 객체로 취급
 
 - 1) 함수를 변수에 할당할 수 있다.
 - 2) 함수를 파라미터로 전달이 가능하다.
 - 3) (함수에서) 함수를 반환할 수 있다. (리턴 가능)
 ==================================================**/



func aFunction1(_ param: String) -> String {
    return param + "!"
}


func aFunction2(name: String) -> String {
    return name + "?!??"
}



// 함수를 변수에 할당가능(변수가 함수를 가르키게 됨)

var a: (String) -> String = aFunction1

a("안녕")


a = aFunction2

a("hello")




// 함수(클로저)를 변수에 할당해서

let closureType = { (param: String) -> String in         // 클로저 리터럴
    return param + "!"
}



// 사용(실행)

closureType("스티브")

#####################################################################################2021.10.16_3
self VS Self
self  vs  Self
##self키워드의 사용 (소문자)
간단한 중첩 타입의 예제

// 1) 인스턴스를 가르키기 위해 사용

class Person {
    var name: String
    init(name: String) {
        self.name = name
    }
}



// 2) 새로운 값으로 속성 초기화 가능한 패턴 (값타입에서)

struct Calculator {
    var number: Int = 0
    
    mutating func plusNumber(_ num: Int) {
        number = number + num
    }
    
    // 값 타입(구조체, 열거형)에서 인스턴스 값 자체를 치환 가능
    mutating func reset() {
        self = Calculator()    // 값 타입은 새로 생성해서 치환하는 것도 가능
    }
}




// 3) 타입멤버에서 사용하면, 인스턴스가 아닌 타입 자체를 가르킴

struct MyStruct {
    static let club = "iOS부서"
    
    static func doPrinting() {
        print("소속은 \(self.club)입니다.")
    }
}




// 4) 타입 인스턴스를 가르키는 경우에 사용 (외부에서 타입을 가르키는 경우)

class SomeClass {
    static let name = "SomeClass"
}


let myClass: SomeClass.Type = SomeClass.self
// SomeClass.Type ===> 메타타입 (후반부에 다룰 예정)


SomeClass.name
SomeClass.self.name


Int.max
Int.self.max


##Self키워드의 사용 (대문자)
(특정 타입 내부에서) 해당 타입을 가르키는 용도로 Self를 사용

// 1) 타입을 선언하는 위치에서 사용하거나,
// 2) 타입속성/타입메서드를 지칭하는 자리에서 대신 사용 가능

extension Int {
    // 타입 저장 속성
    static let zero: Self = 0     // Int 타입
    //static let zero: Int = 0
    
    // 인스턴스 계산속성
    var zero: Self {  // 1) 타입을 선언하는 위치에서 사용
        return 0
    }
//    var zero: Int {
//        return 0
//    }
    
    // 2) 타입 속성/메서드에서 지칭
    static func toZero() -> Self {
        return Self.zero      // Int.zero
    }

    
    // 인스턴스 메서드
    func toZero() -> Self {
        return self.zero     // 5.zero
    }
}



Int.zero
5.zero

Int.toZero()
5.toZero()


프로토콜에서의 Self사용 (프로토콜을 채택하는 해당 타입을 가르킴)
// 이진법으로 표현된 정수에서 쓰이는 프로토콜
// 프로토콜의 확장 ===> 구현의 반복을 줄이기 위한 문법

extension BinaryInteger {
    func squared() -> Self {  // 타입자체(Int)를 가르킴
        return self * self    // 인스턴스(7)를 가르킴
    }
}

// 간단하게 얘기하면 Int, UInt 간에도 비교가능하도록 만드는 프로토콜
// (타입이 다름에도 비교가 가능)

let x1: Int = -7
let y1: UInt = 7


if x1 <= y1 {
    print("\(x1)가 \(y1)보다 작거나 같다.")
} else {
    print("\(x1)가 \(y1)보다 크다.")
}



// 실제로는 Int가 BinaryInteger 프로토콜을 채택
// Int에 기본구현으로 squared() 메서드가 제공  ===>  func squared() -> Int {..}


7.squared()

#####################################################################################2021.10.16_2
Nested Type_2✔
중첩 타입(Nested Types)의 사용예시

실제 앱에서 swift파일을 따로 만들어 실수하기 쉬운 "문자열" 모음을 아래처럼도 사용 가능


struct K {
    static let appName = "MySuperApp"
    static let cellIdentifier = "ReusableCell"
    static let cellNibName = "MessageCell"
    static let registerSegue = "RegisterToChat"
    static let loginSegue = "LoginToChat"
    
    struct BrandColors {
        static let purple = "BrandPurple"
        static let lightPurple = "BrandLightPurple"
        static let blue = "BrandBlue"
        static let lighBlue = "BrandLightBlue"
    }
    
    struct FStore {
        static let collectionName = "messages"
        static let senderField = "sender"
        static let bodyField = "body"
        static let dateField = "date"
    }
}



// 문자열 대신에 아래처럼 사용할 수 있음 ⭐️ (문자열 실수는 치명적인 에러를 발생시킴)

let app = K.appName      // "MySuperApp"
let color = K.BrandColors.blue    // "BrandLightBlue"


#메세지 모델의 설계 (참고)
// 어떤 메신저에서 메세지를 모델로 설계한다면
// 가정 1) 보낸 사람, 2) 받는 사람 3) 메세지 보낸 시간 4)

class Message {
    // 상태를 중첩타입으로 (와부에서 접근못하게 하려면, private으로 선언가능)
    private enum Status {
        case sent
        case received
        case read
    }
    
    // 보낸 사람, 받는 사람
    let sender: String, recipient: String, content: String
    
    // 보낸 시간
    let timeStamp: Date
    
    // 메세지 상태 정보 (보냄/받음/읽음)
    private var status: Message.Status = Message.Status.sent
    
    init(sender: String, recipient: String, content: String) {
        self.sender = sender
        self.recipient = recipient
        self.content = content
        
        self.timeStamp = Date()   // 현재시간 생성 ===> 시간은 유저가 주는 정보 아님
    }
    
    func getBasicInfo() -> String {
        return "보낸사람: \(sender), 받는사람: \(recipient), 메세지 내용: \(content), 보낸 시간: \(timeStamp.description), "
    }
    
    // 메세지 상태에 따라서, 색깔 바뀜
    func statusColor() -> UIColor {
        switch status {
        case .sent:
            return UIColor(red: 1, green: 0, blue: 0, alpha: 1)
        case .received:
            return UIColor(red: 0, green: 0, blue: 1, alpha: 1)
        case .read:
            return UIColor(red: 0, green: 1, blue: 1, alpha: 1)
        }
    }
}


let message1 = Message(sender: "홍길동", recipient: "임꺽정", content: "뭐해?")
print(message1.getBasicInfo())

sleep(1)

let message2 = Message(sender: "임꺽정", recipient: "홍길동", content: "그냥있어")
print(message2.getBasicInfo())

#####################################################################################2021.10.16_1
Nested Type_1✔
Part17 - 중첩 타입

#중첩 타입을 배우는 목적
/**==================================================
 1) 중첩타입으로 선언된 API들을 볼줄 알아야함 ⭐️
    DateFormatter.Style.full
    (중간 타입에 대문자가 나오면, 중첩타입임을 인지)
 
 2) 실제 앱을 만들때 중첩 선언을 잘 활용해야함 (타입 간의 관계 명확성)
 3) 하나의 타입의 내부 구조(계층 관계 등)를 디테일하게 설계 가능
 ====================================================**/

중첩 타입(Nested Types)

간단한 중첩 타입의 예제

// 타입 내부에 타입을 선언하는 것은 언제나 가능

class Aclass {
    struct Bstruct {
        enum Cenum {
            case aCase   // 열거형에는 케이스 필요
            case bCase
            
            struct Dstruct {
                
            }
        }
        var name: Cenum
    }
}


// 타입 선언과 인스턴스의 생성

let aClass: Aclass = Aclass()

let bStruct: Aclass.Bstruct = Aclass.Bstruct(name: .bCase)

let cEnum: Aclass.Bstruct.Cenum = Aclass.Bstruct.Cenum.aCase     // 열거형은 케이스선택

let dStruct: Aclass.Bstruct.Cenum.Dstruct = Aclass.Bstruct.Cenum.Dstruct()


/**==============================================================================
 - 왜 사용할까?
 - 1) 특정 타입 내에서만 사용하기 위함
      Bstruct는 Aclass타입과 관계가 있고, Aclass없이는 의미가 없을 수 있음 (그래서 범위를 명확히 한정)
 - 2) 타입 간의 연관성을 명확히 구분하고, 내부 구조를 디테일하게 설계 가능
================================================================================**/


#Swift 공식 문서의 예제 (실제 사용 방법)
struct BlackjackCard {

    // 중첩으로 선언 타입 ==============================================
    // Suit(세트) 열거형
    enum Suit: Character {     // 원시값(rawValue)사용
        case spades = "♠", hearts = "♡", diamonds = "♢", clubs = "♣"
    }

    // 순서(숫자) 열거형
    enum Rank: Int {     // 원시값(rawValue)사용
        case two = 2, three, four, five, six, seven, eight, nine, ten
        case jack, queen, king, ace   // (원시값 존재하지만 사용하지 않고자 함 ===> values)
        
        // Values 타입정의 (두개의 값을 사용) //===> 열거형 값(순서)을 이용 새로운 타입을 반환하기 위함
        struct Values {
            let first: Int, second: Int?
        }
        
        // (읽기) 계산 속성 (열거형 내부에 저장 속성은 선언 불가)
        var values: Values {
            switch self {
            case Rank.ace:
                return Values(first: 1, second: 11)    // 에이스 카드는 1 또는 11 로 쓰임
            case .jack, .queen, .king:
                return Values(first: 10, second: nil)  // 10으로 쓰임
            default:
                return Values(first: self.rawValue, second: nil)    // 2 ~ 10까지의 카드는 원시값으로 쓰임
            }
        }
    }
    
    // 블랙잭 카드 속성 / 메서드  =======================================
    // 어떤 카드도, 순서(숫자)와 세트(Suit)를 가짐
    let rank: Rank, suit: Suit
    
    // (읽기) 계산속성
    var description: String {
        get {
            var output = "\(suit.rawValue) 세트,"
            output += " 숫자 \(rank.values.first)"
            
            if let second = rank.values.second {   // 두번째 값이 있다면 (ace만 있음)
                output += " 또는 \(second)"
            }
            
            return output
        }
    }
}



// A - 스페이드

let card1 = BlackjackCard(rank: .ace, suit: .spades)
print("1번 카드: \(card1.description)")



// 5 - 다이아몬드

let card2 = BlackjackCard(rank: .five, suit: .diamonds)
print("2번 카드: \(card2.description)")

//let card2 = BlackjackCard(rank: <#T##BlackjackCard.Rank#>, suit: <#T##BlackjackCard.Suit#>)




// 정의한 타입을 외부에서 사용하기 위해서는 중첩되어 있는 타입도 붙여야함(강제) ====> 훨씬 명확해짐

let heartsSymbol: Character  = BlackjackCard.Suit.hearts.rawValue

let suit = BlackjackCard.Suit.hearts

#실제 API의 사용 예시 (일단 형태에만 집중)
// 실제 API에서 중첩 타입을 사용하는 경우

let fomatter = DateFormatter()

// dateStype변수의 타입 확인해보기
fomatter.dateStyle = .full
fomatter.dateStyle = DateFormatter.Style.none

/**==========================================================
 - var dateStyle: Style { get set }                 (타입확인)
 - var dateStyle: DateFormatter.Style { get set }   (내부정의)
============================================================**/



// 타입 확인하기 위해

let setting1: DateFormatter.Style = DateFormatter.Style.full
let setting2: DateFormatter.Style = DateFormatter.Style.medium


// Style.full     // ===> 만약에 외부에 선언되어 있다면, 실제 명확하지 않음
// Style.medium


// 만약에 이렇게 선언했다면 어떤 타입과 관계가 있는지 명확하지 않음
// (이 열거형만 보면 어디서 쓰일지 유추 불가)

enum Style {
    case full
    case long
    case medium
    case none
}


struct DateFormatters {
    var style: Style
    //var style: DateFormatters.Style
    
    // 중첩타입으로 선언
//    enum Style {
//        case full
//        case long
//        case medium
//        case none
//    }
}


var dateStyle1 = DateFormatters(style: .full)
dateStyle1 = DateFormatters(style: Style.full)
dateStyle1.style = Style.full
dateStyle1.style = .full



// 중첩타입으로 선언했을때 사용법 (타입을 쓸려면 전체 중첩타입을 다 써야함)

//var dateStyle2 = DateFormatters(style: .full)
//dateStyle2 = DateFormatters(style: DateFormatters.Style.full)
//dateStyle2.style = DateFormatters.Style.full
//dateStyle2.style = .long

#####################################################################################2021.10.16
Method Dispatch
Part16 - Method Dispatch
메서드 디스패치(Method Dispatch)
1 - 직접 디스패치 Direct Dispatch (Static)

struct MyStruct {
    func method1() { print("Struct - Direct method1") }
    func method2() { print("Struct - Direct method2") }
}


let myStruct = MyStruct()
myStruct.method1()
myStruct.method2()

2 - 테이블 디스패치 Table Dispatch (동적 디스패치)
class FirstClass {
    func method1() { print("Class - Table method1") }
    func method2() { print("Class - Table method2") }
}

/**================================================
 func method1() { print("Class - Table method1") }
 func method2() { print("Class - Table method2") }
===================================================**/


// 자식클래스에서 테이블을 따로 보유
class SecondClass: FirstClass {
    override func method2() { print("Class - Table method2-2") }
    func method3() { print("Class - Table method3") }
}

/**================================================
 func method1() { print("Class - Table method1") }
 func method2() { print("Class - Table method2-2") }
 func method3() { print("Class - Table method3") }
===================================================**/



let first = FirstClass()
first.method1()
first.method2()


let second = SecondClass()
second.method1()
second.method2()
second.method3()


3 - 메세지 디스패치 Message Dispatch (메세지 디스패치)
/**============================================
 - 예전 Objective-C 에서 사용하던 방식
 - 방식에 대한 이해만 하면됨. 문법에 관련된 내용은 아니므로
   굳이 암기할 필요는 없음
=============================================**/


class ParentClass {
    @objc dynamic func method1() { print("Class - Message method1") }
    @objc dynamic func method2() { print("Class - Message method2") }
}


/**================================================
 func method1() { print("Class - Message method1") }
 func method2() { print("Class - Message method2") }
===================================================**/



class ChildClass: ParentClass {
    @objc dynamic override func method2() { print("Class - Message method2-2") }
    @objc dynamic func method3() { print("Class - Message method3") }
}


/**================================================
 super class
 func method2() { print("Class - Message method2-2") }   // 재정의한 메서드는 다시 주소가짐
 func method2() { print("Class - Message method3") }
===================================================**/


let child = ChildClass()
child.method1()
child.method2()
child.method3()


###프로토콜의 메서드 디스패치(Witness Table)
Table Dispatch (Virtual Table / Witness Table)

프로토콜 - Witness Table
protocol MyProtocol {
    func method1()    // 요구사항 - Witness Table
    func method2()    // 요구사항 - Witness Table
}


extension MyProtocol {
    // 요구사항의 기본 구현 제공
    func method1() { print("Protocol - Witness Table method1") }
    func method2() { print("Protocol - Witness Table method1") }
    
    // 필수 요구사항은 아님 ==> Direct Dispatch
    func anotherMothod() {
        print("Protocol Extension - Direct method")
    }
}

클래스 - Virtual Table
class FirstClass: MyProtocol {
    func method1() { print("Class - Virtual Table method1") }
    func method2() { print("Class - Virtual Table method2") }
    func anotherMothod() { print("Class - Virtual Table method3") }
}

/**==============================================================
[Class Virtual Table]
- func method1() { print("Class - Virtual Table method1") }
- func method2() { print("Class - Virtual Table method2") }
- func anotherMothod() { print("Class - Virtual Table method3") }
=================================================================**/

/**==============================================================
[Protocol Witness Table]
- func method1() { print("Class - Virtual Table method1") }   // 요구사항 - 우선순위 반영⭐️
- func method2() { print("Class - Virtual Table method2") }   // 요구사항 - 우선순위 반영⭐️
=================================================================**/



let first = FirstClass()
first.method1()           // Class - Virtual Table method1
first.method2()           // Class - Virtual Table method2
first.anotherMothod()     // Class - Virtual Table method3


let proto: MyProtocol = FirstClass()
proto.method1()           // Class - Virtual Table method1  (Witness Table)
proto.method2()           // Class - Virtual Table method2  (Witness Table)
proto.anotherMothod()     // Protocol Extension - Direct method


#####################################################################################2021.10.15_7
프로토콜 확장의 적용 제한
6) 프로토콜 확장의 적용 제한
(전 강의에서 다룬)프로토콜의 확장


protocol Remote {
    func turnOn()        // 요구사항
    func turnOff()       // 요구사항
}


extension Remote {
    func turnOn() { print("리모콘 켜기") }
    func turnOff() { print("리모콘 끄기") }
}


#프로토콜 확장 - 형식을 제한 가능
protocol Bluetooth {
    func blueOn()
    func blueOff()
}

/**====================================================
 - 프로토콜 확장에서 where절을 통해, 프로토콜의 확장의 적용을 제한 가능
 - "특정 프로토콜"을 채택한 타입에만 프로토콜 확장이 적용되도록 제한
    where Self: 특정프로토콜
 
 - 특정 프로토콜을 채택하지 않으면, 프로토콜의 확장이 적용되지 않기 때문에
   (확장이 없는 것과 동일하게) 메서드를 직접구현 해야함
=======================================================**/


// 특정 프로토콜을 채택한 타입에만 프로토콜 확장이 적용되도록 제한
// (Remote 프로토콜을 채택한 타입만 확장 적용 가능)
extension Bluetooth where Self: Remote {   // 본 확장의 적용을 제한시키는 것 가능 (구체적 구현의 적용범위를 제한)
    func blueOn() { print("블루투스 켜기") }
    func blueOff() { print("블루투스 끄기") }
}


// Remote프로토콜을 채택한 타입만 Bluetooth 확장이 적용됨
// Remote프로토콜을 채택하지 않으면 ===> 확장이 적용되지 않기 때문에 직접 구현 해야함
class SmartPhone: Remote, Bluetooth {
    
    
}





let sphone = SmartPhone()
sphone.turnOn()           // 리모콘 켜기
sphone.turnOff()          // 리모콘 끄기
sphone.blueOn()           // 블루투스 켜기
sphone.blueOff()          // 블루투스 끄기

#####################################################################################2021.10.15_6
프로토콜의 확장✔
5) 프로토콜의 확장(Protocol Extension)
프로토콜의 확장 - 프로토콜 지향 프로그래밍 ⭐️

protocol Remote {
    func turnOn()
    func turnOff()
}


// 채택 ===> 실제구현해야함(여러타입에서 채택한다면 반복적으로 구현해야하는 점이 불편)

class TV1: Remote {
    //func turnOn() { print("리모콘 켜기") }
    //func turnOff() { print("리모콘 끄기") }
}


// 채택 ===> 실제구현해야함(여러타입에서 채택한다면 반복적으로 구현해야하는 점이 불편)

struct Aircon1: Remote {
    //func turnOn() { print("리모콘 켜기") }
    //func turnOff() { print("리모콘 끄기") }
}


#프로토콜의 확장 ➞ 기본(디폴트) 구현 제공 ⭐️
/**==============================================================================
 - (귀찮은 방식으로) 프로토콜을 채택한 모든 타입에서, 실제 구현을 계속적으로 반복해야하는 불편함을 덜기 위해
 - "프로토콜 확장"을 제공해서 메서드의 디폴트 구현을 제공함 (코드의 중복을 피할 수 있음)
===============================================================================**/


extension Remote {                         // (요구사항의 메서드 우선순위 적용 - 프로토콜 메서드 테이블 만듦)
    func turnOn() { print("리모콘 켜기") }    // 1. (채택)구현시 해당 메서드 2. 기본 메서드
    func turnOff() { print("리모콘 끄기") }   // 1. (채택)구현시 해당 메서드 2. 기본 메서드
    
    func doAnotherAction() {               // (요구사항 메서드 X - 테이블 만들지 않음)
        print("리모콘 또 다른 동작")            // 타입에 따른 선택 (Direct Dispatch)
    }
}


#프로토콜의 확장을 통한 다형성 제공 - 프로토콜 지향 프로그래밍
// 클래스 ⭐️ ==================================================

class Ipad: Remote {
    func turnOn() { print("아이패드 켜기") }

    func doAnotherAction() { print("아이패드 다른 동작") }
}


/**=================================================
 [Class Virtual 테이블]
 - func turnOn()          { print("아이패드 켜기") }
 - func turnOff()         { print("리모콘 끄기") }
 - func doAnotherAction() { print("아이패드 다른 동작") }
====================================================**/


let ipad: Ipad = Ipad()
ipad.turnOn()           // 클래스 - V테이블
ipad.turnOff()          // 클래스 - V테이블
ipad.doAnotherAction()  // 클래스 - V테이블

// 아이패드 켜기
// 리모콘 끄기
// 아이패드 다른 동작



/**=====================================
 [Protocol Witness 테이블] - 요구사항
 - func turnOn()  { print("아이패드 켜기") }
 - func turnOff() { print("리모콘 끄기") }
========================================**/


let ipad2: Remote = Ipad()
ipad2.turnOn()           // 프로토콜 - W테이블
ipad2.turnOff()          // 프로토콜 - W테이블
ipad2.doAnotherAction()  // 프로토콜 - Direct (직접 메서드 주소 삽입)

// 아이패드 켜기
// 리모콘 끄기
// 리모콘 또 다른 동작





// 구조체 ⭐️ ==================================================

struct SmartPhone: Remote {
    func turnOn() { print("스마트폰 켜기") }

    func doAnotherAction() { print("스마트폰 다른 동작") }
}


/**=====================================
 [구조체] - 메서드 테이블이 없음
========================================**/


// 본래의 타입으로 인식했을때
var iphone: SmartPhone = SmartPhone()
iphone.turnOn()             // 구조체 - Direct (직접 메서드 주소 삽입)
iphone.turnOff()            // 구조체 - Direct (직접 메서드 주소 삽입)
iphone.doAnotherAction()    // 구조체 - Direct (직접 메서드 주소 삽입)

// 스마트폰 켜기
// 리모콘 끄기
// 스마트폰 다른 동작



/**=====================================
 [Protocol Witness 테이블] - 요구사항
 - func turnOn()  { print("스마트폰 켜기") }
 - func turnOff() { print("리모콘 끄기") }
========================================**/


// 프로토콜의 타입으로 인식했을때
var iphone2: Remote = SmartPhone()
iphone2.turnOn()            // 프로토콜 - W테이블
iphone2.turnOff()           // 프로토콜 - W테이블
iphone2.doAnotherAction()   // 프로토콜 - Direct (직접 메서드 주소 삽입)

// 스마트폰 켜기
// 리모콘 끄기
// 리모콘 또 다른 동작

#####################################################################################2021.10.15_5
프로토콜의 선택적 요구사항의 구현
4) 선택적 요구사항의 구현(Optional Protocol Requirements)
어트리뷰트
/**==================================================================================
 - 어트리뷰트 키워드
 - @available, @objc, @escaping, @IBOutlet, @IBAction 등등

 - Attribute(어트리뷰트) ===> 컴파일러에게 알려주는 특별한 신호이자, 추가적인 정보를 제공 (2가지 종류가 있음)
 - https://docs.swift.org/swift-book/ReferenceManual/Attributes.html

 - 1) 선언에 대한 추가정보 제공
 - 2) 타입에 대한 추가정보 제공


 - 사용 방법
 - @어트리뷰트이름          ======> (예시)  @available
 - @어트리뷰트이름(아규먼트)  ======> (예시)  @available(iOS *)
==================================================================================**/


// (실제 예시)

@available(iOS 10.0, macOS 10.12, *)
class SomeType {      // "SomeType" 선언은 iOS 10.0 버전이상에서만 읽을 수 있음
    
}

#선택적인(구현해도 되고 안해도 되는) 멤버선언하기
/**========================================================================
 - @objc는 스위프트로 작성한 코드를 오브젝티브C 코드에서도 사용할 수 있게 해주는 어트리뷰트
 - 프로토콜에서 요구사항 구현시, 반드시 강제하는 멤버가 아니라 선택적인 요구사항으로 구현할때 사용
 
 - 프로토콜 앞에는 "@objc"추가
 - 멤버 앞에는 "@objc optional"을 모두 추가
==========================================================================**/


@objc protocol Remote {
    @objc optional var isOn: Bool { get set }
    func turnOn()
    func turnOff()
    @objc optional func doNeflix()
}


class TV: Remote {
    var isOn = false
    
    func turnOn() {}
    
    func turnOff() {}
    
}


/**========================================================
 - 선택적 멤버를 선언한 프로토콜 구현시
 - 오브젝티브-C에 해당하는 클래스 전용 프로토콜임 (구조체, 열거형 채용 불가) ⭐️
 - (오브젝티브C는 구조체와 열거형에서 프로토콜 채택을 지원하지 않음)
==========================================================**/


let tv1: TV = TV()
print(tv1.isOn)   // Bool타입



let tv2: Remote = TV()
print(tv2.isOn)          // Bool? 타입 (선택적 구현 사항이기 때문에 해당 멤버가 없으면 ===> nil로 반환)
tv2.doNeflix?()          // (선택적으로 선언했기 때문에, 함수가 없을 수도 있음 ===> 옵셔널체이닝 필요)

#####################################################################################2021.10.15_4
프로토콜의 상속
3-2) 기타 프로토콜(Protocols)관련 문법
프로토콜은 1) 프로토콜 간에 상속이 가능하고 2) 다중 상속이 가능

프로토콜도 상속이 가능 / 다중 상속이 가능 (어짜피 여러가지 요구사항의 나열일뿐)
protocol Remote {
    func turnOn()
    func turnOff()
}


protocol AirConRemote {
    func Up()
    func Down()
}


protocol SuperRemoteProtocol: Remote, AirConRemote {   // 프로토콜끼리, 상속 구조를 만드는 것이 가능 ⭐️
    // func turnOn()
    // func turnOff()
    // func Up()
    // func Down()
    
    func doSomething()
}


// 프로토콜의 채택 및 구현

class HomePot: SuperRemoteProtocol {
    func turnOn() { }
    
    func turnOff() { }
    
    func Up() { }
    
    func Down() { }
    
    func doSomething() { }
}


#클래스 전용 프로토콜 (AnyObject)
// 클래스 전용 프로토콜로 선언
// (AnyObject프로토콜을 상속)

protocol SomeProtocol: AnyObject {      // AnyObject는 클래스 전용 프로토콜
    func doSomething()
}


// 구조체에서는 채택할 수 없게 됨 ⭐️
//struct AStruct: SomeProtocol {
//
//}


// 클래스에서만 채택 가능
class AClass: SomeProtocol {
    func doSomething() {
        print("Do something")
    }
}

#프로토콜 합성(Protocol Composition) 문법
// 프로토콜을 합성하여 임시타입으로 활용 가능 ⭐️

protocol Named {
    var name: String { get }
}

protocol Aged {
    var age: Int { get }
}


// 하나의 타입에서 여러개의 프로토콜을 채택하는 것 당연히 가능 (다중 상속과 비슷한 역할)

struct Person: Named, Aged {
    var name: String
    var age: Int
}


// 프로토콜을 두개를 병합해서 사용 하는 문법(&로 연결)
func wishHappyBirthday(to celebrator: Named & Aged) {   // 임시적인 타입으로 인식
    print("생일축하해, \(celebrator.name), 넌 이제 \(celebrator.age)살이 되었구나!")
}


let birthdayPerson = Person(name: "홍길동", age: 20)
wishHappyBirthday(to: birthdayPerson)



let whoIsThis: Named & Aged = birthdayPerson      // 임시적인 타입으로 저장 (두개의 프로토콜을 모두 채택한 타입만 저장 가능)

#####################################################################################2021.10.15_3
타입으로써의 프로토콜✔
3-1) 타입으로써의 프로토콜(Protocols as Types)
프로토콜은 타입이다.

프로토콜은 타입

// 프로토콜은 ===> First Class Citizen(일급객체)이기 때문에, 타입(형식)으로 사용할 수 있음


protocol Remote {
    func turnOn()
    func turnOff()
}


class TV: Remote {
    func turnOn() {
        print("TV켜기")
    }
    
    func turnOff() {
        print("TV끄기")
    }
}


struct SetTopBox: Remote {
    func turnOn() {
        print("셋톱박스켜기")
    }
    
    func turnOff() {
        print("셋톱박스끄기")
    }
    
    func doNetflix() {
        print("넷플릭스 하기")
    }
}



let tv = TV()
tv.turnOn()
tv.turnOff()


let sbox = SetTopBox()
sbox.turnOn()
sbox.turnOff()
//sbox.doNetflix()

#프로토콜 타입 취급의 장점
// 프로토콜의 타입 취급의 장점 - 1 ⭐️

let electronic: [Remote] = [tv, sbox]      // 프로토콜의 형식으로 담겨있음


for item in electronic {   // 켜기, 끄기 기능만 사용하니 타입캐스팅을 쓸 필요도 없음 (다만, 프로토콜에 있는 멤버만 사용가능)
    item.turnOn()
}




// 프로토콜의 타입 취급의 장점 - 2 ⭐️

func turnOnSomeElectronics(item: Remote) {
    item.turnOn()
}

turnOnSomeElectronics(item: tv)
turnOnSomeElectronics(item: sbox)

#프로토콜 준수성 검사
/**==================================================================================
 - is / as 연산자 사용가능

 - is 연산자 ===> 특정 타입이 프로토콜을 채택하고 있는지 확인 (참 또는 거짓) / 그 반대도 확인가능
 - as 연산자 ===> 타입 캐스팅 (특정 인스턴스를 프로토콜로 변환하거나, 프로토콜을 인스턴스 실제형식으로 캐스팅)
====================================================================================**/


// 1) is연산자 ==============================

// 특정타입이 프로토콜을 채택하고 있는지 확인
tv is Remote
sbox is Remote


// 프로토콜 타입으로 저장된 인스턴스가 더 구체적인 타입인지 확인 가능
electronic[0] is TV
electronic[1] is SetTopBox




// 2) as연산자 ==============================

// 업캐스팅(as)
let newBox = sbox as Remote
newBox.turnOn()
newBox.turnOff()



// 다운캐스팅(as?/as!)
let sbox2: SetTopBox? = electronic[1] as? SetTopBox
sbox2?.doNetflix()

//(electronic[1] as? SetTopBox)?.doNetflix()

#####################################################################################2021.10.15_2
메서드의 요구사항 정의하는 방법✔
2-2) 메서드의 요구사항 정의하는 방법
메서드 요구사항 정의

/**===============================================================
 [프로토콜 메서드 요구사항]
 - 메서드의 헤드부분(인풋/아웃풋)의 형태만 요구사항으로 정의
 - mutating 키워드: (구조체로 제한하는 것은 아님) 구조체에서 저장 속성 변경하는 경우,
                  구조체도 채택 가능하도록 허락하는 키워드
 - 타입 메서드로 제한 하려면, static키워드만 붙이면 됨
   (채택해서 구현하는 쪽에서 static / class 키워드 모두 사용 가능)
=================================================================**/

// 1) 정의
protocol RandomNumber {
    static func reset()         // 최소한 타입 메서드가 되야함 (class로 구현해서 재정의를 허용하는 것도 가능)
    func random() -> Int
    //mutating func doSomething()
}


// 2) 채택 / 3) 구현
class Number: RandomNumber {
    
    static func reset() {
        print("다시 셋팅")
    }
    
    func random() -> Int {
        return Int.random(in: 1...100)
    }
    
}


let n = Number()
n.random()
Number.reset()




// 1) 정의
protocol Togglable {
    mutating func toggle()        // mutating의 키워드는 메서드 내에서 속성 변경의 의미일뿐(클래스에서 사용 가능)
}


// 2) 채택 / 3) 구현
enum OnOffSwitch: Togglable {
    case on
    case off
    
    mutating func toggle() {
        switch self {   // .on   .off
        case .off:
            self = .on
        case .on:
            self = .off
        }
    }
}


var s = OnOffSwitch.off
s.toggle()
s.toggle()


class BigSwitch: Togglable {
    var isOn = false
    
    func toggle() {      // mutating 키워드 필요없음 (클래스 이기 때문)
        isOn = isOn ? false : true
    }
}


var big = BigSwitch()
print(big.isOn)
big.toggle()
print(big.isOn)

#메서드 요구사항 - 생성자 요구사항
protocol SomeProtocol {     // 생성자를 요구사항으로 지정 가능
    init(num: Int)
}


/**===================================================================
 [생성자 요구사항] (실제 프로젝트에서 사용하는 경우 드뭄)
 - (1) 클래스는 (상속 고려해야함) 생성자 앞에 required를 붙여야함 (하위에서 구현을 강제)
       (구조체의 경우 상속이 없기 때문에, required키워드 필요 없음)
 - (2) 아니면 final을 붙여서 상속을 막으면 required 생략가능
 - (3) 클래스에서는 반드시 지정생성자로 구현할 필요없음(편의생성자로 구현도 가능)
 =====================================================================**/

// 예제 - 1 ======================

class SomeClass: SomeProtocol {
    required init(num: Int) {
        // 실제 구현
    }
}

class SomeSubClass: SomeClass {
    // 하위 클래스에서 생성자 구현 안하면 필수 생성자는 자동 상속
    // required init(num: Int)
    
}



// 예제 - 2 ======================

protocol AProtocol {
    init()
}

class ASuperClass {
    init() {
        // 생성자의 내용 구현
    }
}

class ASubClass: ASuperClass, AProtocol {
    // AProtocol을 채택함으로 "required" 키워드 필요하고, 상속으로 인한 "override(재정의)" 재정의 키워드도 필요
    required override init() {
        // 생성자의 내용 구현
    }
}


#생성자 요구사항 - 실패가능 생성자의 경우
/**==========================================================
 (실패가능/불가능 생성자 요구사항)
 - init?() 요구사항 ➡︎  init() / init?() / init!()로 구현 (O)
 - init()  요구사항 ➡︎  init?() 로 구현 (X - 범위가 더 넓어지는 것 안됨)
 ===========================================================**/

// 실패가능 생성자

protocol AProto {
    init?(num: Int)        // (객체의 타입이 맞을까?)  AClass? <==== AClass은 범위가 속해있음
}


// 구조체에서 채택 (required 키워드는 필요없음)

struct AStruct: AProto {  // Failable/Non-failable 모두 요구사항을 충족시킴
    
    //init?(num: Int) {}
    
    init(num: Int)  {}
    
    //init!(num: Int)  {}     // 이것도 괜찮음
}


// 클래스에서 채택

class AClass: AProto {
    required init(num: Int) {}
}

#메서드 요구사항 - 서브스크립트 요구사항
/**===================================================================
 [서브스크립트 요구사항]
 - get, set 키워드를 통해서 읽기/쓰기 여부를 설정 (최소한의 요구사항일뿐)
 - get키워드 ===> 최소한 읽기 서브스크립트 구현 / 읽기,쓰기 모두 구현 가능
 - get/set키워드 ===> 반드시 읽기,쓰기 모두 구현해야함
 =====================================================================**/


protocol DataList {
    subscript(idx: Int) -> Int { get }     // (서브스크립트 문법에서) get 필수 (set 선택)
}



struct DataStructure: DataList {
    
//    subscript(idx: Int) -> Int {    // 읽기 전용 서브스크립트로 구현한다면
//        get {
//            return 0
//        }
//    }
    
    subscript(idx: Int) -> Int {    // (최소한만 따르면 됨)
        get {
            return 0
        }
        set {                 // 구현은 선택
            // 상세구현 생략
        }
    }
}

#(관습적인) 프로토콜 채택과 구현 - 확장(Extension)에서
protocol Certificate {
    func doSomething()
}


class Person {
    
}

// 관습적으로 본체보다는 확장에서, 채택 구현 (코드의 깔끔한 정리 가능)
extension Person: Certificate {
    func doSomething() {
        print("Do something")
    }
}

#####################################################################################2021.10.15_1
프로토콜의 문법✔
2) 프로토콜(Protocols) 문법
프토토콜의 기본 문법

// 프로토콜? 규약 (약속)  ======> "자격증"

// 1) 정의
protocol MyProtocol {   // 최소한의 요구사항 나열

}

//:> 클래스에서 상속이 있는 경우, 1) 상위 클래스를 먼저 선언 후, 2) 프로토콜 채택 선언

class FamilyClass { }


// 2) 채택 (클래스, 구조체, 열거형 다 가능)
class MyClass: FamilyClass, MyProtocol {    // 상위클래스인 FamilyClass를 먼저 선언
    // 3) (속성/메서드) 구체적인 구현
}


struct MyStruct: MyProtocol {
    // 3) (속성/메서드) 구체적인 구현
}


enum MyEnum: MyProtocol {
    // 3) (속성/메서드) 구체적인 구현
}


#프로토콜의 요구사항의 종류
/**========================================================================
 - 프로토콜을 채택하려는 클래스, 구조체, 열거형에 최소한 이런 내용을 구현해야한다고 선언하는 부분

 - 1. 속성 요구사항
 - 2. 메서드 요구사항 (메서드/생성자/서브스크립트)
==========================================================================**/


#속성의 요구사항 정의하는 방법
/**=====================================================
  [프로토콜 속성의 요구사항]
 - 속성의 뜻에서 var로 선언 (let으로 선언할 수 없음)
 - get, set 키워드를 통해서 읽기/쓰기 여부를 설정 (최소한의 요구사항일뿐)
 - 저장 속성/계산 속성으로 모두 구현 가능
=======================================================**/


protocol RemoteMouse {
    
    var id: String { get }                // ===> let 저장속성 / var 저장속성 / 읽기계산속성 / 읽기,쓰기 계산속성
    
    var name: String { get set }          // ===> var 저장속성 / 읽기,쓰기 계산속성

    static var type: String { get set }   // ===> 타입 저장 속성 (static)
                                          // ===> 타입 계산 속성 (class)
}


// 채택하면, (최소한의)요구사항을 정확하게 따라서 구현해야함

// 인스턴스 저장/계산 속성 =========================

struct TV: RemoteMouse {
    
    var id: String = "456"
    
    var name: String = "삼성티비"
    
    static var type: String = "리모콘"
}


let myTV = TV()
myTV.id
myTV.name
TV.type


// 타입 속성 ===================================
// 1) 저장 타입 속성으로 구현

class SmartPhone: RemoteMouse {
    var id: String {
        return "777"
    }
    
    var name: String {
        get { "아이폰" }
        set { }
    }
    
    static var type: String = "리모콘"     // 타입 저장 속성은 (상속은 되지만) 재정의 원칙적 불가능
}


// 2) 계산 타입 속성으로 구현

class Ipad: RemoteMouse {
    var id: String = "777"
    
    var name: String = "아이패드"
    
    class var type: String {       // 타입 계산 속성은 재정의 가능 (class키워드 가능)
        get { "리모콘" }
        set { }
    }
}

#####################################################################################2021.10.15
Part_15 Protocol
Part15 - 프로토콜(Protocols)
프로토콜(Protocols)
프토토콜의 필요성에 대한 인식

프로토콜: 영어로 규약 / 협약
// 프로토콜? 규약/협약(약속)  ======> "자격증" / "리모콘"
// 프로토콜이 뭔지, 무엇을 가능하게 만들까? 왜 프로토콜의 개념이 필요할까?

// 정의

protocol SomeProtocol {     // 요구사항을 정의 (자격증의 필수 능력만 정의)
    func playPiano()
}



// 채택 및 구현

// 구조체에서 채택
struct MyStruct: SomeProtocol {       // 이제 자격증의 능력이 생긴 것임
    func playPiano() {
        // 구체적인 구현
    }
}

// 클래스에서 채택
class MyClass: SomeProtocol {        // 이제 자격증의 능력이 생긴 것임
    func playPiano() {
        // 구체적인 구현
    }
}


// 따르면 ===> 능력을 갖게 된다.


#프토토콜의 필요성에 대한 인식 - 클래스와 상속의 단점 ⭐️
// 예제

class Bird {
    
    var isFemale = true
    
    func layEgg() {
        if isFemale {
            print("새가 알을 낳는다.")
        }
    }
    
    func fly() {
        print("새가 하늘로 날아간다.")
    }
}


class Eagle: Bird {
    
    // isFamale
    // layEgg()
    // fly()
    
    func soar() {
        print("공중으로 치솟아 난다.")
    }
}


class Penguin: Bird {
    
    // isFamale
    // layEgg()
    
    // fly()       // 상속 구조에서는 펭귄이 어쩔 수 없이 날개됨 ⭐️
    
    func swim() {
        print("헤엄친다.")
    }
}


// struct가 될 수도 없고(클래스로만 구현가능), 무조건 Bird를 상속해야만 함
class Airplane: Bird {
    
    // isFamale
    // layEgg()         // 상속 구조에서는 비행기가 알을 낳게됨 ⭐️
    
    override func fly() {
        print("비행기가 엔진을 사용해서 날아간다")
    }
}


// 플라잉 박물관을 만듦

struct FlyingMuseum {
    func flyingDemo(flyingObject: Bird) {
        flyingObject.fly()
    }
}


let myEagle = Eagle()
myEagle.fly()
myEagle.layEgg()
myEagle.soar()


let myPenguin = Penguin()
myPenguin.layEgg()
myPenguin.swim()
myPenguin.fly()     // 문제 ===> 펭귄이 날개 됨(무조건적인 멤버 상속의 단점)


let myPlane = Airplane()
myPlane.fly()
myPlane.layEgg()         // 문제 ===> 비행기가 알을 낳음



let museum = FlyingMuseum()     // 타입 정의 ===> 오직 Bird 클래스 밖에 안됨
museum.flyingDemo(flyingObject: myEagle)
museum.flyingDemo(flyingObject: myPenguin)
museum.flyingDemo(flyingObject: myPlane)    // Bird를 상속해야만 사용 가능




/**======================================================================
 - 프로토콜은 위와 같은 상황을 해결해주는 해결책이다.

 - 1) "fly()"라는 동작을 따로 분리해내어서, 굳이 상속을 하지 않고도 사용가능하게 만들려면?
 - 2) 꼭 클래스가 아닌, 구조체에서도 "fly()"기능을 동작하게 하려면?
======================================================================**/


#프토토콜의 도입 - 클래스와 상속의 단점을 보완 ⭐️
// "fly()"라는 기능을 따로 분리해 내기

protocol CanFly {
    func fly()      // 구체적인 구현은 하지 않음 ===> 구체적인 구현은 자격증을 채택한 곳에서
}



class Bird1 {
    
    var isFemale = true
    
    func layEgg() {
        if isFemale {
            print("새가 알을 낳는다.")
        }
    }

}


class Eagle1: Bird1, CanFly {    // "CanFly" 자격증을 채택
    
    // isFemale
    // layEgg()
    
    func fly() {
        print("독수리가 하늘로 날라올라 간다.")
    }
    
    func soar() {
        print("공중으로 활공한다.")
    }
}


class Penguin1: Bird1 {
    
    // isFemale
    // layEgg()
    
    func swim() {
        print("물 속을 헤엄칠 수 있다.")
    }
}


// 구조체에서 채택도 가능
struct Airplane1: CanFly {
    func fly() {
        print("비행기가 날아간다")
    }
}



// 박물관을 만듦

struct FlyingMuseum1 {
    func flyingDemo(flyingObject: CanFly) {     // 중요한 기능 ===> 프로토콜을 타입으로 인식
        flyingObject.fly()
    }
}



let myEagle1 = Eagle1()
myEagle1.fly()
myEagle1.layEgg()
myEagle1.soar()


let myPenguin1 = Penguin1()
myPenguin1.layEgg()
myPenguin1.swim()
//myPenguin1.fly()     // 더이상 펭귄이 날지 않음


let myPlane1 = Airplane1()
//myPlane1.layEgg()         // 더이상 비행기가 알을 낳지 않음
myPlane1.fly()


let museum1 = FlyingMuseum1()
museum1.flyingDemo(flyingObject: myEagle1)
//museum1.flyingDemo(flyingObject: myPenguin1)   // 더이상 "CanFly"자격증이 없는 펭귄은 날지 못함
museum1.flyingDemo(flyingObject: myPlane1)





// 예제 출처 (유데미 - 안젤라 님 강의)
// https://www.udemy.com/course/ios-13-app-development-bootcamp/

#####################################################################################2021.10.14_4
멤버의 확장(서브스크립트), 멤버의 확장(중첩타입)
4) 멤버의 확장(서브스크립트)

서브스크립트의 확장
// 확장으로 서브스크립트 추가 가능함

// Int(정수형 타입)에 서브스크립트 추가해보기 (기본자리수의 n자리의 십진수 반환하도록 만들기)

// 예시
// 123456789[0]    // 9
// 123456789[1]    // 8
// 123456789[2]    // 7


extension Int {
    subscript(num: Int) -> Int {
        
        var decimalBase = 1
        
        for _ in 0..<num {
            decimalBase *= 10
        }
        
        return (self / decimalBase) % 10
        
    }
}



123456789[0]      // (123456789 / 1) ==> 123456789 % 10 ==> 나머지 9
123456789[1]      // (123456789 / 10) ==> 12345678 % 10 ==> 나머지 8
123456789[2]      // (123456789 / 100) ==> 1234567 % 10 ==> 나머지 7
123456789[3]      // (123456789 / 1000) ==> 123456 % 10 ==> 나머지 6




// Int값에 요청된 자릿수가 넘어간 경우 0 반환

746381295[9]     // 0


// 앞에 0 이 존재 하는 것과 같음

746381295[12]



멤버의 확장(중첩타입)
5) 멤버의 확장(중첩타입)

중첩 타입(Nested Types)
// 클래스, 구조체 및 열거형에 새 중첩 유형을 추가 가능

// Int(정수형 타입)에 종류(Kind) ====> 중첩 열거형 추가해 보기

extension Int {
    
    enum Kind {       // 음수인지, 0인지, 양수인지
        case negative, zero, positive
    }
    
    var kind: Kind {    // 계산 속성으로 구현
        switch self {
        case 0:                   // 0인 경우
            return Kind.zero
        case let x where x > 0:   // 0보다 큰경우
            return Kind.positive
        default:                  // 나머지 (0보다 작은 경우)
            return Kind.negative
        }
    }
}




let a = 1
a.kind       // 숫자 1의 (인스턴스) 계산속성을 호출 ====> 해당하는 열거형(Int.Kind타입)을 리턴

let b = 0
b.kind

let c = -1
c.kind


Int.Kind.positive
Int.Kind.zero
Int.Kind.negative


let d: Int.Kind = Int.Kind.negative





// 위의 확장을 통해서, 어떤 Int값에서도 중첩 열거형이 쓰일 수 있음

// 위의 확장을 활용한 ===> 함수 만들어보기

func printIntegerKinds(_ numbers: [Int]) {
    for number in numbers {
        switch number.kind {
        case .negative:
            print("- ", terminator: "")
        case .zero:
            print("0 ", terminator: "")
        case .positive:
            print("+ ", terminator: "")
        }
    }
    print("")
}



// 함수 실행해보기

printIntegerKinds([3, 19, -27, 0, -6, 0, 7])      // + + - 0 - 0 +

#####################################################################################2021.10.14_3
생성자의 확장✔
3) 멤버의 확장(생성자)

생성자의 확장
본체의 지정생성자를 호출하는 방식으로만 생성자 구현 가능
/**=========================================================================
 - 새로운 (편의)생성자를 확장으로 추가 가능(쉬운 방법으로 인스턴스를 초기화하는 방법을 제공 가능)
 - 다만, 본체의 지정 생성자를 호출하는 방법으로만 구현 가능

  [클래스]
 - 편의 생성자만 추가 가능
 - 지정생성자 추가 불가 / 소멸자 추가 불가 (항상 본래의 클래스에서 정의해야 함)

 
  [구조체] ⭐️
 - 구조체는 (원래) 편의 생성자가 존재하지 않음
 - (편의 생성자와 비슷한) 생성자를 추가하여 본래의 지정 생성자를 호출하는 방법으로만 구현 가능
   (즉, 편의생성자와 같은 역할. 그리고 본체의 생성자를 호출 할 때까지 self에 접근이 안됨)
 
 - (본체) 생성자 작성
 - 기본 생성자/멤버와이즈 생성자 제공 안됨
 - 확장의 생성자에서 ===> (본래) 지정 생성자 호출해야함
 
 - (예외) (본체) 저장속성에 기본값제공 + 생성자 정의 안한 경우
 - 기본 생성자/멤버와이즈 생성자가 자동제공
 - 확장의 생성자에서 ===> 생성자 구현 가능 ⭐️  / 기본 생성자/멤버와이즈 생성자 호출도 가능
=========================================================================**/


구조체 - 생성자 확장의 예시
// 포인트 구조체, 사이즈 구조체

struct Point {
    var x = 0.0, y = 0.0
    
    //init(x: Double, y: Double)
    
    //init()
}



struct Size {
    var width = 0.0, height = 0.0
}



// Rect구조체

struct Rect {     // 기본값 제공 ===> 기본 생성자 / 멤버와이즈 생성자가 자동 제공 중
    var origin = Point()
    var size = Size()
}



let defaultRect = Rect()    // 기본생성자

//Rect(origin: Point(x: <#T##Double#>, y: <#T##Double#>), size: Size(width: <#T##Double#>, height: <#T##Double#>))

let memberwiseRect = Rect(origin: Point(x: 2.0, y: 2.0),
                          size: Size(width: 5.0, height: 5.0))    // 멤버와이즈 생성자




extension Rect {
    // 센터값으로 Rect 생성하는 생성자 만들기
    init(center: Point, size: Size) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        
        // 본체의 - 멤버와이즈 생성자 호출 (원칙) ⭐️
        self.init(origin: Point(x: originX, y: originY), size: size)
        
        // 예외적인 경우 (저장속성에 기본값 + 본체에 생성자 구현 안한 경우, 생성자 구현 가능)
        //self.origin = Point(x: originX, y: originY)
        //self.size = size
    }
}

// 새로 추가한 생성자로 인스턴스 생성해보기

let centerRect = Rect(center: Point(x: 4.0, y: 4.0),
                      size: Size(width: 3.0, height: 3.0))


#클래스 - 생성자 확장의 예시
// UIColor 기본 생성자
var color = UIColor(red: 0.3, green: 0.5, blue: 0.4, alpha: 1)
    


extension UIColor {      // 익스텐션 + 편의생성자 조합
    
    convenience init(color: CGFloat) {   // Float   / Double
        self.init(red: color/255, green: color/255, blue: color/255, alpha: 1)
    }

}


// 일단 아주 쉽게 객체 생성하는 방법을 제공 가능해짐

UIColor(color: 1)
//UIColor(red: <#T##CGFloat#>, green: <#T##CGFloat#>, blue: <#T##CGFloat#>, alpha: <#T##CGFloat#>)

#####################################################################################2021.10.14_2
멤버의 확장(메서드)
2) 멤버의 확장(메서드)

2-1. (타입)메서드의 확장
// 애플이 만든 타입메서드 예시

Int.random(in: 1...100)


extension Int {
    static func printNumbersFrom1to5() {
        for i in 1...5 {
            print(i)
        }
    }
}


// 항상 1부터 5까지를 출력

Int.printNumbersFrom1to5()


2-2. (인스턴스)메서드의 확장
// Int타입에 특정 프린트 구문 확장해보기

extension String {
    func printHelloRepetitions(of times: Int) {
        for _ in 0..<times {
            print("Hello \(self)!")
        }
    }
}



"Steve".printHelloRepetitions(of: 4)
//"Swift".printHelloRepetitions(of: 5)
    

//Hello Steve!
//Hello Steve!
//Hello Steve!
//Hello Steve!


mutating 인스턴스 메서드의 확장
구조체(열거형)에서, 자신의 속성을 변경하는 메서드는 mutating키워드 필요
// 제곱하는 메서드 만들어 보기

extension Int {
    mutating func square() {    // 기존 메서드와 동일하게, mutating 키워드 필요
        self = self * self
    }
}



var someInt = 3
someInt.square()    // 9

#####################################################################################2021.10.14_1
멤버의 확장(계산 확장)
1) 멤버의 확장(계산 속성)

1-1. (타입)계산 속성의 확장
// (타입) 계산 속성 또는 (인스턴스) 계산 속성 확장 가능
// (저장된 속성을 추가하거나 기존 속성에 속성 관찰자를 추가 할 수는 없음)


extension Double {
    static var zero: Double { return 0.0 }
}

Double.zero


1-2. (인스턴스)계산 속성의 확장
// 인스턴스의 (읽기전용) 계산 속성을 기존의 애플이 만든 Double 타입에 추가 하는 예제


// 자신의 단위를 입력하여 ==> 미터 기준으로 바꾸는 예제

extension Double {
    var km: Double { return self * 1_000.0 }   // 인스턴스 자신에 1000 곱하기
    var m: Double { return self }
    var cm: Double { return self / 100.0 }
    var mm: Double { return self / 1_000.0 }
    var ft: Double { return self / 3.28084 }
}


let oneInch = 25.4.mm
print("1인치는 \(oneInch) 미터")       // 1인치는 0.0254 미터"


let threeFeet = 3.ft
print("3피트는 \(threeFeet) 미터")     // 3피트는 0.914399970739201 미터"




// 인스턴스자체에 즉, Double의 리터럴값에 .(점)문법을 사용하여 거리 변환을 수행하도록 만듦


// Double 값 1.0  ===> "1 미터"를 나타내는 것으로 간주됨
// m 계산 속성이 self를 반환 (1.m 표현식은 Double값 1.0을 계산하는 것임)

// 1 킬로미터는 Double 값에 1_000.00을 곱하여 "미터로 변환"
// ft 계산 속성은 Double 값을 3.28084로 나누어 피트에서 "미터로 변환"



let aMarathon = 42.km + 195.m
print("마라톤은 \(aMarathon) 미터의 길이임")        // 마라톤은 42195.0 미터의 길이임"





extension Int {
    var squared: Int {
        return self * self
    }
}


func squared(num: Int) -> Int {     // 이런식으로 함수를 만드는 것보다 훨씬 간단하고, 더 간결하게 만들 수 있음
    return num * num
}


Int(123).squared
123.squared


squared(num: 123)

#####################################################################################2021.10.14
확장의 개념
Part14 - 확장(Extensions)

확장(Extensions)
확장의 개념에 대한 이해
/**=================================================================================
 - 상속과 확장의 비교
 - (상속 - 수직적 개념) 성격이 비슷한 "타입을 새로"만들어, 데이터를 추가하고, 기능(메서드)을 변형시켜 사용하려는 것
 - (확장 - 수평적 개념) "현재 존재하는 타입"에 기능(메서드)을 추가하여 사용하려는 것
 
 
 - 현재 존재하는 타입
 - 1)클래스, 2)구조체, 3)열거형 (그리고 프로토콜) 타입에 확장(새로운 기능 추가)이 가능함
 - (새 기능을 추가 할 수 있지만 기존 기능을 재정의 할 수는 없음)
 
 
 - 확장의 장점
 - 원본 소스 코드에 대한 액세스 권한이없는 유형을 확장하는 기능이 포함 (소급-모델링 retroactive modeling)
 - 예) Int, String, Double 등 애플이 미리 만들어 놓은 타입에 확장도 가능
 ===================================================================================**/


확장 문법
// 기존 타입

class SomeType {
    
}


// 확장

extension SomeType {      // 기존의 타입에 extension 이라는 키워드를 사용해서 확장하고, 새로운 기능을 정의
    // 새로운 기능을 추가 가능(메서드 형태만 가능) ⭐️
    
}



// 기존 유형에 새 기능을 추가하기 위해 확장을 정의하면
// 확장이 정의되기 전에 생성된 경우에도 기존 인스턴스에서 새 기능을 사용 가능함


#예시를 통한 확장의 이해
class Person {
    var id = 0
    var name = "이름"
    var email = "1234@gmail.com"
    
    func walk() {
        print("사람이 걷는다.")
    }
}


class Student: Person {
    var studentId = 1
    
    override func walk() {
        print("학생이 걷는다.")
    }
    
    func study() {
        print("학생이 공부한다.")
    }
}


extension Student {  // 스위프트에서는 확장에서 구현한 메서드에 대한 재정의가 불가 ⭐️ (@objc 붙이면 가능)
    func play() {
        print("학생이 논다.")
    }
}


class Undergraduate: Student {
    var major = "전공"
    
    override func walk() {
        print("대학생이 걷는다.")
    }
    
    override func study() {
        print("대학생이 공부한다.")
    }
    
    func party() {
        print("대학생이 파티한다.")
    }
    
    // func play()
    
//    override func play() {     // 스위프트에서는 확장에서 구현한 메서드에 대한 재정의가 불가 ⭐️
//        print("대학생이 논다.")
//    }
}



//extension Undergraduate {
//    override func play() {
//        print("대학생이 논다.")
//    }
//}


#확장의 장점
extension Int {
    var squared: Int {
        return self * self
    }
}


5.squared
3.squared
7.squared


#확장 가능 멤버의 종류
확장에서는 메서드형태만 정의 가능
/**==========================================================================================
 - 클래스, 구조체, (열거형) 확장가능 멤버
 
 - (원본 형식이 붕어빵틀 역할을 하기 때문에), 저장속성은 정의할 수 없음
 
 
 - 1) (타입) 계산 속성, (인스턴스) 계산 속성
 - 2) (타입) 메서드, (인스턴스) 메서드
 - 3) 새로운 생성자  (⭐️ 다만, 클래스의 경우 편의생성자만 추가 가능 / 지정생성자 및 소멸자는 반드시 본체에 구현)
 - 4) 서브스크립트
 - 5) 새로운 중첩 타입 정의 및 사용
 - 6) 프로토콜 채택 및 프로토콜 관련 메서드
 
 
 - 프로토콜에 대한 확장도 가능(자세한 내용은 프로토콜에서 다룰 예정)
 ============================================================================================**/


#지정생성자는 본체에서 인스턴스를 찍어내는 중요역할을 하므로 ➞ 지정생성자는 확장에서 구현하지 못함


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


