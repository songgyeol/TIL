# TIL
#####################################################################################2021.09.25
#Dice Game
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var firstImageView: UIImageView!
    @IBOutlet weak var secondImageView: UIImageView!
    //주사위 바구니 만들기
    var diceArray: [UIImage] = [#imageLiteral(resourceName: "black1"), #imageLiteral(resourceName: "black2"), #imageLiteral(resourceName: "black3"), #imageLiteral(resourceName: "black4"), #imageLiteral(resourceName: "black5"), #imageLiteral(resourceName: "black6")]
     
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //시작 다이스 이미지 변경하는 법
        firstImageView.image = diceArray[5]
        secondImageView.image = diceArray[5]
        
        
    }

    @IBAction func rollButtonTapped(_ sender: UIButton) {
        //첫번째 이미지뷰의 이미지를 랜덤으로 변경
        //firstImageView.image = //랜덤이미지
        firstImageView.image = diceArray.randomElement()
        
        
        //두번째 이미지뷰의 이미지를 랜덤으로 변경
        secondImageView.image = diceArray.randomElement()
    
    }
    
    
}

#####################################################################################2021.09.24
Dice Game

#####################################################################################2021.09.23_2
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var myButton: UIButton!
    
    //앱의 화면에 들어오면 처음 실행시키는 함수
    override func viewDidLoad() {
        super.viewDidLoad()
    
        mainLabel.backgroundColor = UIColor.yellow
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        
        
        mainLabel.text = "안녕하세요"
        mainLabel.backgroundColor = UIColor.yellow
        mainLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1) //Color Literal
        //글자정렬
        mainLabel.textAlignment = NSTextAlignment.left
                //속성보면 타입나옴 복사해서 붙이기
        //버튼글자색
        myButton.backgroundColor = .yellow
        myButton.setTitleColor(.black, for: .normal)
    
    
    }
    
    

}
#####################################################################################2021.09.23_1
#import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    
    
    //앱의 화면에 들어오면 처음 실행시키는 함수
    override func viewDidLoad() {
        super.viewDidLoad()
    
        mainLabel.backgroundColor = UIColor.yellow
        
    }
    
    @IBAction func buttonPressed(_ sender: UIButton) {
        
        
        
        mainLabel.text = "안녕하세요"
        mainLabel.backgroundColor = UIColor.yellow
        mainLabel.textColor = #colorLiteral(red: 0.1764705926, green: 0.01176470611, blue: 0.5607843399, alpha: 1) //Color Literal
        //글자정렬
        mainLabel.textAlignment = NSTextAlignment.left
                //속성보면 타입나옴 복사해서 붙이기

   
    }
    

}
}

#####################################################################################2021.09.23
앱 만들기 기초

#####################################################################################2021.09.22_4
Unknown
@unknown 키워드
만약, 열거형의 케이스가 늘어난다면 항상 올바른 처리를 하고 있다고 말할 수 있을까?


// 만약에 로그인의 경우의 수가 늘어난다면 (Non-frozen 열거형 / 얼지않은)
// (프로젝트에서 실제 늘어날 수 있는 경우가 많음)

enum LoginProvider: String {      // 3가지 케이스 ===> 4가지 케이스
    case email
    case facebook
    case google
    case kakaotalk
}


let userLogin = LoginProvider.email



// 스위치문은 (특히, 열거형)표현식에 대한 분기처리에 최적화
// (다만, 열거형의 케이스가 늘어나는 경우에 대한 안정성 보장은 별개)

switch userLogin {                // 처리하는 방식을 조금 변형
case .email:
    print("이메일 로그인")
case .facebook:
    print("페이스북 로그인")
//case .google:
//    print("구글 로그인")
default:                         // default블럭만 추가해두는 것이 안전할까? ⭐️
    print("구글 로그인")
}

// 여기서는 간단히 눈에 보일 수 있지만, 실제 프로젝트에서는 찾기 힘듦


#처리하는 로직이 항상 옳다는 보장을 하지 못함
// 에러는 나지 않을 수 있지만, 로직이 옳다고 할 수 없음

@unknown 어트리튜트를 활용하는 방법 - Swift 5.0 ~
/**===================================================
 - @unknown 키워드를 default블럭에 추가해둠
 
 - switch문에서 열거형의 모든 케이스를 다루지 않는 경우,
   스위치문에서 모든 열거형의 케이스를 다루지 않았다고
   경고를 통해 알려줌 ===> 개발자의 실수 가능성을 컴파일 시점에 알려줌
 
 - "Switch must be exhatstive"로 알려줌
 =====================================================**/
// unknown: 알려지지 않은


switch userLogin {
case .email:
    print("이메일 로그인")
case .facebook:
    print("페이스북 로그인")
case .google:
    print("구글 로그인")
@unknown default:
    print("그 외의 모든 경우")
}
#####################################################################################2021.09.22_3
Optional Pattern
#옵셔널 패턴(Optional Pattern)
옵셔널 타입에서 열거형 케이스 패턴을 더 간소화한 옵셔널 패턴(Optional Pattern)

열거형 내부에 "연관값"을 사용시 ➞ 1) 열거형 케이스 패턴 / 2) 옵셔널 패턴

let a: Int? = 1


// 1) 열거형 케이스 패턴 (앞에서 배운)

switch a {
case .some(let z):
    print(z)
case .none:  // nil이라고 써도됨
    print("nil")
}


// 2) 옵셔널 패턴 (현재 배울)

switch a {
case let z?:      // .some을 조금 더 간소화하는 문법
    print(z)
case nil:         // .none 이라고 써도됨
    print("nil")
}


#옵셔널 패턴의 사례 (열거형 케이스 패턴과 비교)
// 옵셔널타입으로 선언

let num: Int? = 7
print(num)



// 1) 열거형 케이스 패턴

switch num {
case .some(let x):      // let x = num
    print(x)
case .none:
    break
}


// 2) 옵셔널 패턴 (.some을 ? 물음표로 대체 가능한 패턴)

switch num {
case let x?:           // let x? = Optional.some(num)
    print(x)
case .none:
    break
}



// 특정 사례만 다루는 (if문) ================================

// 1) 열거형 케이스 패턴

if case .some(let x) = num {
    print(x)
}



// 2) 옵셔널 패턴 (.some을 ? 물음표로 대체 가능한 패턴)

if case let x? = num {        // "옵셔널(?) 물음표를 띄어내고, x 상수로 보자"의 의미라고 생각하면 됨
    print(x)
}


#옵셔널 패턴(for문) - 옵셔널타입 요소 배열
// 옵셔널 타입을 포함하는 배열에서 반복문을 사용하는 경우, 옵셔널 패턴을 사용하면 편리함

let arrays: [Int?] = [nil, 2, 3, nil, 5]



// 1) 열거형 케이스 패턴

for case .some(let number) in arrays {
    print("Found a \(number)")
}



// 2) 옵셔널 패턴

for case let number? in arrays {
    print("Found a \(number)")
}
#####################################################################################2021.09.22_2
열거형에 연관값이 있는 경우
#열거형에 연관값이 있는 경우
연관값(Associated Values)이 있는 경우와 switch문 (열거형 case 패턴) - Enumeration Case Pattern

/**==========================================
 - 연관값이 있는 열거형의 활용 (열거형 case 패턴) ⭐️
 - 구체적 정보(연관값)를 변수에 바인딩(let/var가능)하는 패턴
 
 [열거형 case 패턴]
 - case Enum.case(let 변수이름):
 - case let Enum.case(변수이름):
 
 [스위치문 뿐만 아니라, 조건문/반복문에서도 활용가능]
 - 1) switch문 (대부분)
 - 2) if / guard / for-in / while (필요한 경우)
 ===========================================**/

// 연관값이 있는 열거형 - 구체적인 정보가 연관값에 들어 있음
// 구체적인 정보를 꺼내서 사용해야하는, 로직 구현의 문제와 연관


 
enum Computer {                         // 3가지로 정의
    case cpu(core: Int, ghz: Double)
    case ram(Int, String)
    case hardDisk(gb: Int)
}


var chip = Computer.cpu(core: 8, ghz: 3.1)


switch chip {                          // 수십가지로도 처리 가능 (필요한 처리 확장 가능)
case .cpu(core: 8, ghz: 3.1):
    print("CPU 8코어 3.1GHz입니다.")
case .cpu(core: 8, ghz: 2.6):
    print("CPU 8코어 2.6GHz입니다.")
case .cpu(core: 4, ghz: let ghz):       // let ghz = 연관값  (cpu가 4코어인 경우, ghz에 저장된 연관값을 꺼내서 바인딩)
    print("CPU 4코어 \(ghz)HGz입니다.")
case .cpu(core: _, ghz: _):
    print("CPU 칩 입니다.")
case .ram(32, _):
    print("32기가램 입니다.")
case .ram(_, _):
    print("램 입니다.")
case let .hardDisk(gb: gB):            // let gB = 연관값
    print("\(gB)기가 바이트 하드디스크 입니다.")
default:                               // 대부분 default문이 필요하기도 함
    print("그 외에 나머지는 관심이 없습니다. 그렇지만 칩이긴 합니다.")
}


// 연관값을 가지고 있는 열거형의 경우, 원하는 로직으로 잘 정의해서 처리해야하는 것에 주의

#연관값(Associated Values)이 있는 경우, if / guard / for-in / while 문 (열거형 case 패턴)
// 값 하나를 사용하기 위해서, 스위치문을 전체를 다 써야하는 불편함이 있었음

switch chip {
case Computer.hardDisk(gb: let gB):      // let gB = 연관값
    print("\(gB)기가 바이트 하드디스크임")
default:
    break
}
// = 위와 동일한 코드, if로도 가능
if case Computer.hardDisk(gb: let gB) = chip {
    print("\(gB)기가 바이트 하드디스크임")
}


#특정 케이스만 다루기 위해서 if문이나 반복문(for문) 사용 가능
chip = Computer.hardDisk(gb: 128)    // 256


// if문에서도 스위치문에서 사용하는 case문과 같이 사용 가능 ⭐️

if case Computer.hardDisk(gb: let gB) = chip {
    print("\(gB)기가 바이트 하드디스크임")
}


if case Computer.hardDisk(gb: let gB) = chip, gB == 256 {    // 처리를 다양하게 활용 가능
    print("256기가 바이트 하드디스크임")
}

let chiplists: [Computer] = [
    .cpu(core: 4, ghz: 3.0),
    .cpu(core: 8, ghz: 3.5),
    .ram(16, "SRAM"),
    .ram(32, "DRAM"),
    .cpu(core: 8, ghz: 3.5),
    .hardDisk(gb: 500),
    .hardDisk(gb: 256)
]


for case let .cpu(core: c, ghz: h) in chiplists {    // 배열중에서 특정 케이스만 뽑아서 활용 가능 ⭐️
    print("CPU칩: \(c)코어, \(h)헤르츠")
}


// 일반 for문과 비교 =====> 모든 경우

for chip in chiplists {
    print("\(chip)")
}


열거형 케이스 패턴(for문) - 옵셔널타입 요소 배열
// 옵셔널 타입을 포함하는 배열에서 반복문을 사용하는 경우

let arrays: [Int?] = [nil, 2, 3, nil, 5]


for case .some(let number) in arrays {
    print("Found a \(number)")
}
#####################################################################################2021.09.22_1
열거형과 스위치문의 활용
열거형과 switch문
열거형의 정의와 switch문을 통한 활용

열거형에 대한 구체적인 처리는 스위치(switch)문과 함께 쓸때, 사용성이 높아짐
// 로그인 타입을 정의

enum LoginProvider: String {      // 3가지로 정의
    case email
    case facebook
    case google
}


let userLogin = LoginProvider.facebook




// 열거형은 한정된 사례로 만든 타입이고,
// 스위치문은 표현식에 대한 분기처리에 최적화

switch userLogin {                   // 3가지로 분기처리
case .email:
    print("이메일 로그인")
case .facebook:
    print("페이스북 로그인")
case .google:
    print("구글 로그인")
}




// 물론 특정한 경우도 처리 가능

if LoginProvider.email == userLogin {
    print("이메일 로그인")
}


#열거형에 (연관값이 없고), 옵셔널 열거형의 경우
switch문의 편의성 (열거형 case 패턴) - Enumeration Case Pattern

// 열거형의 선언

enum SomeEnum {
    case left
    case right
}


// 타입을 다시 옵셔널 열거형으로 선언 ⭐️

let x: SomeEnum? = .left


/**==================================================
 [SomeEnum?의 의미] 옵셔널 열거형
 
 - 값이 있는 경우 .some ===> 내부에 다시 열거형 .left /.right
 - 값이 없는 경우 .none ===> nil
=====================================================**/


// 원칙

switch x {
case .some(let value):      // Optional.some(let value) = Optional.some(SomeEnum.left)  ⭐️
    switch value {
    case .left:
        print("왼쪽으로 돌기")
    case .right:
        print("오른쪽으로 돌기")
    }
case .none:
    print("계속 전진")
}



// 편의적 기능 제공 ⭐️

switch x {
case .some(.left):
    print("왼쪽으로 돌기")
case .some(.right):
    print("오른쪽으로 돌기")
case .none:
    print("계속 전진")
}



// 전체적으로 full name으로 풀어서 쓴다면..

//switch x {
//case Optional.some(SomeEnum.left):
//    print("왼쪽으로 돌기")
//case Optional.some(SomeEnum.right):
//    print("오른쪽으로 돌기")
//case Optional.none:
//    print("계속 전진")
//}


#스위치문의 편의성
switch문에서 옵셔널 열거형 타입을 사용할때, 벗기지 않아도 내부값 접근가능
// 스위치문은 옵셔널 열거형 타입의 사용시, 편의성을 제공


switch x {     // 예전에는 x! 라고 써줘야 했음 (스위치문에서 옵셔널 타입도 ok)
case .left:
    print("왼쪽으로 돌기")
case .right:
    print("오른쪽으로 돌기")
case nil:
    print("계속 전진")
}
#####################################################################################2021.09.22
옵셔널 타입에 대한 정확한 이해
스위프트의 옵셔널(Optional) 타입
/**==========================
 - 옵셔널 타입의 내부 구현
 
   enum Optional<Wrapped> {     // 제네릭 문법
       case some(Wrapped)
       case none
   }
============================**/


var num: Int? = 7

// 열거형(한정된 사례)
//Optional.some(7)
//Optional.none




switch num {
case .some(let a):  // let a = 7     // 열거형 case 패턴을 활용해서, 내부 연관값을 꺼냄
    print(a)
case .none:
    print("nil")
    //print(num!)
}



//switch num {
//case Optional.some(let a):
//    print(a)
//case Optional.none:
//    print("nil")
//}

##.none과 nil은 완전히 동일
// .none은 명시적인 열거형으로 표현한 것이고, 일반적으로는 값이 없다는 의미의 nil키워드를 사용할뿐

#####################################################################################2021.09.21_7
Enum_원시값,연관값
열거형의 원시값과 연관값
열거형의 원시값(Raw Values)

열거형의 원시값은 매칭되는 기본값(정수/문자열)을 정해, 열거형을 좀 더 쉽게 활용 가능
// 여러가지 형태로 원시값을 정의 가능 (Hashable한 - Int / String / Character / Double 등 가능)

enum Alignment: Int {
    case left
    case center
    case right
}

// 원시값 입력안하면 0, 1, 2  이렇게 자동으로 저장됨 (정수의 경우 숫자가 하나씩 증가)
// 1(설정시), 2, 3
// 0, 2(설정시), 3

enum Alignment1: String {
    case left = "L"
    case center = "C"
    case right = "R"
}


let align = Alignment(rawValue: 0)    // 인스턴스 생성시 - 옵셔널타입으로 리턴 (실패가능)
let leftValue = Alignment.center.rawValue     // 접근연산자를 통해 원시값 자체에도 접근가능

Alignment1(rawValue: "C")             // (가능하지만) 문자열 방식으로는 잘 사용하지는 않음
let centerValue = Alignment1.center.rawValue


#원시값(Raw Values)의 활용
숫자 또는 문자열과 매칭시켜 자유롭게 활용 가능 (숫자 ←→ 열거형 타입)
// 가위 바위 보 열거형 만들기

enum RpsGame: Int {
    case rock
    case paper
    case scissors
}


// 실제 앱을 만들때는
RpsGame(rawValue: 0)!
RpsGame(rawValue: 1)
RpsGame(rawValue: 2)



// 논리적으로 nil이 될 수 없다면
let number = Int.random(in: 0...100) % 3    // 3을 조금 더 멋지게 처리할 수 있는 것은 고급내용에서 다룸
print(RpsGame(rawValue: number)!)      // 출력은 하지만 문자열은 아님에 주의


// 옵셔널값을 안전하게 벗겨서 사용
if let r = RpsGame(rawValue: 0) {
    print(r)                           // 출력은 하지만 문자열은 아님에 주의
}



// 행성 열거형 만들기
enum Planet: Int {
    case mercury = 1, venus, earth, mars, jupiter, saturn, uranus, neptune
}

let planet = Planet(rawValue: 2)!
// Planet.mercury

let num = planet.rawValue
print(num)

#열거형의 연관값(Associated Values)
열거형의 연관값은 구체적인 추가정보를 저장하기 위해 사용
enum Computer {
    case cpu(core: Int, ghz: Double)
    case ram(Int, String)
    case hardDisk(gb: Int)
}


// 각 케이스별로 상이한 특징이 있고, 그것을 저장 / 활용할 필요가 있을 때
// 개별케이스마다 저장할 형식을 따로 정의(자료형에 제한이 없음 / 튜플의 형태)
// 하나의 케이스에 서로다른 연관값을 저장할 수 있음 ===> 선언시점이 아니라, 새로운 열거형 값을 생성할때 저장


let myChip1 = Computer.cpu(core: 8, ghz: 3.5)
let myChip2 = Computer.cpu(core: 4, ghz: 2.0)

let myChip3 = Computer.ram(16, "DRAM")
let myChip4 = Computer.ram(4, "SRAM")
let myChip5 = Computer.ram(32, "DRAM")

let myChip6 = Computer.hardDisk(gb: 128)
let myChip7 = Computer.hardDisk(gb: 512)


// 원시값을 활용한다면 ====> 불가능

enum Computer1: String {
    case cpu = "6coreX2.6ghz"
    case ram = "32GBXDDR4"
    case hardDisk = "256gb"
}

// 모든 케이스들을 다 만들수가 없음

#원시값(Raw Values)과 연관값(Associated Values)의 차이
/**=============================================================================
 - 1) 자료형 선언 방식: 선언하는 위치가 다름
 - 2) 선언 형식: (1) 원시값 ===> 2가지중 1가지 선택 / (2)연관값 ===> 튜플의 형태로 형식 제한 없음
 - 3) 값의 저장 시점: (원시값: 선언시점 / 연관값: 새로운 열거형 값을 생성할때 )
 - 4) 서로 배타적: 하나의 열거형에서 원시값과 연관값을 함께 사용하는 것은 불가능 함
=================================================================================**/

#연관값(Associated Values)의 활용
var chip = Computer.cpu(core: 8, ghz: 2.0)


switch chip {
case .cpu(core: 8, ghz: 3.1):
    print("CPU 8코어 3.1GHz입니다.")
case .cpu(core: 8, ghz: 2.6):
    print("CPU 8코어 2.6GHz입니다.")
case .ram(32, _):
    print("32기가램 입니다.")
default:
    print("그 이외의 칩에는 관심이 없습니다.")
}



// 연관값을 가진 케이스를 패턴 매칭시키기

switch chip {
case let .cpu(a, b):    // let a = 연관값, let b = 연관값
    print("CPU \(a)코어 \(b)GHz입니다.")
case let .ram(a, _):
    print("램 \(a)기가램 입니다.")
case let .hardDisk(a) :
    print("하드디스크 \(a)기가 용량입니다.")
}
#####################################################################################2021.09.21_6
열거형Enumeration
Part10 - 열거형
열거형(Enumerations)
연관된 상수(케이스)들을 하나의 이름으로 묶은 자료형

// 케이스가 선택가능한(한정됨) 가짓 수로 정해져 있을때 정의

enum Weekday {
    case monday
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}


enum CompassPoint {
    case north, south, east, west
}


#언제 열거형을 사용하는가?
/**=====================================
 [한정된 사례(정해진 갯수) 안에서 정의할 수 있을때]
 
 - 월 / 화 / 수 / 목 / 금 / 토 / 일
 - 동 / 서 / 남 / 북
 - 좌로 정렬 / 가운데 정렬 / 우측 정렬
 - 초등학교 / 중학교 / 고등학교 / 대학교
 - 남 / 여
 - 가위 / 바위 / 보
 ======================================**/


// 열거형을 사용하면 코드의 가독성과 안정성이 높아짐 ===> 명확한 분기 처리 가능

#열거형 타입
열거형은 타입이다!

var today: Weekday = Weekday.monday

today = .tuesday

// 일요일인 경우만 특정한 처리를 하고 싶을때

if today == .sunday {
   
}

// 모든 각각의 경우를 처리하고 싶을때

if today == .monday {
    print("오늘은 월요일입니다.")
} else if today == .tuesday {
    print("오늘은 화요일입니다.")
} else if today == .wednesday{
    print("오늘은 수요일입니다.")
} else if today == .thursday{
    print("오늘은 목요일입니다.")
} else if today == .friday{
    print("오늘은 금요일입니다.")
} else if today == .saturday{
    print("오늘은 토요일입니다.")
} else {
    print("오늘은 일요일입니다.")
}

#열거형은 항상 switch문으로 분기처리 가능
switch today {
case .monday:
    print("오늘은 월요일입니다.")
case .tuesday:
    print("오늘은 화요일입니다.")
case .wednesday:
    print("오늘은 수요일입니다.")
case .thursday:
    print("오늘은 목요일입니다.")
case .friday:
    print("오늘은 금요일입니다.")
case .saturday:
    print("오늘은 토요일입니다.")
case .sunday:
    print("오늘은 일요일입니다.")
}
#####################################################################################2021.09.21_5
Collection 관련 이론
KeyValuePairs
딕셔너리와 유사한 형태이지만, 배열처럼 순서가 있는 컬렉션

/**========================================================
 - 스위프트 5.2 버전에 등장
 - 딕셔너리와 비슷한 형태지만, "순서"가 있는 컬렉션

 - key값이 해셔블(hashable)일 필요없음 (검색 알고리즘상 빠르지 않음)
 - key값이 동일한 것도 가능
========================================================**/


let introduce: KeyValuePairs = ["first": "Hello", "second": "My Name", "third":"is"]

#KeyValuePairs의 기본 기능
introduce.count
introduce.isEmpty

#요소에 접근
// 배열처럼, 인덱스로 접근 가능
// 요소에서는 튜플방식으로 접근

introduce[0]

//print("\(introduce[0].key)는 \(introduce[0].value) 입니다.")
//print("\(introduce[1].key)는 \(introduce[1].value) 입니다.")
//print("\(introduce[2].key)는 \(introduce[2].value) 입니다.")

#반복문과의 결합
for value in introduce {
    print("\(value.key)는 \(value.value) 입니다.")
}

#append / remove 같은 기능이 없음
// 딕셔너리이지만, 저장된 순서가 중요할 경우, 또는 데이터가 반복될 경우만 임시적/제한적으로 사용

#####################################################################################2021.09.21_4
Set
#3) 세트(Set)
집합: 수학에서의 집합과 비슷한 연산을 제공하는 컬렉션

/**==============================================================
 - Set의 문법 약속
 - 생김새는 배열과 같음(따라서, 생성시 타입을 선언 해야함)
 - 수학에서의 집합과 동일하기 때문에 요소는 유일해야함(순서가 존재하지 않음)
 ================================================================**/


var set: Set = [1, 1, 2, 2, 3, 3, 3]

print(set)



#Set을 언제 사용하는가?
Set의 값과 Dictionary의 키값은 Hashable
// 정렬순서보다 검색속도가 중요한 경우에 사용
// 검색에 내부적으로 Hashing 알고리즘 사용
// (hashing ===> 특정값을 고정된 길이의 값으로 변환하는 기법으로 인덱싱과 암호화에서 자주 사용됨)
// 또는 유일하면서, 집합의 수학적인 개념(합집합/교집합/차집합/대칭차집합)을 이용할 필요가 있을 때 (집합을 계산하기 간편한 함수를 내장)

#Set의 타입 표기
// 단축문법
let set1: Set = [1, 2, 3]

// 정식문법
let set2: Set<Int> = [1, 2, 3]

#빈 Set의 생성
let emptySet: Set<Int> = []
let emptySet1 = Set<Int>()

#Set의 기본 기능
set.count
set.isEmpty


set.contains(1)
set.randomElement()

#업데이트 (update) - 삽입하기 / 교체하기 / 추가하기
// 서브스크립트 관련 문법 없음 ⭐️

// (정식 기능) 함수 문법

set.update(with: 1)     // Int?


set.update(with: 7)     // 새로운 요소가 추가되면 ====> 리턴 nil

#Set는 append 함수를 제공하지 않음
// append는 순서가 있는 컬렉션의 끝에 추가하는 개념
// Set은 순서가 없기 때문에, update를 통해서 추가

#삭제(제거)하기 (remove)
var stringSet: Set<String> = ["Apple", "Banana", "City", "Swift"]


// 요소 삭제해 보기
stringSet.remove("Swift")     // "Swift" 삭제한 요소를 리턴
stringSet                     // ["Hello", "Apple"]



// 존재하지 않는 요소를 삭제해보기
stringSet.remove("Steve")       // nil    (에러는 발생하지 않음)



// 전체요소 삭제
stringSet.removeAll()
stringSet.removeAll(keepingCapacity: true)


#Set의 활용
Set의 정의

var a: Set = [1, 2, 3, 4, 5, 6, 7, 8, 9]
var b: Set = [1, 3, 5, 7, 9]
var c: Set = [2, 4, 6, 8, 10]
var d: Set = [1, 7, 5, 9, 3]


#Set의 비교
a == b
a != b

//Set(정렬되지 않은 컬렉션)은 어짜피 순서는 중요하지 않음
b == d  // 항상 true

#부분집합 / 상위집합 / 서로소
a = [1, 2, 3, 4, 5, 6, 7, 8, 9]
b = [1, 3, 5, 7, 9]     // 홀수 모음
c = [2, 4, 6, 8, 10]    // 짝수 모음
d = [1, 7, 5, 9, 3]     // 홀수 모음



// 부분집합 여부를 판단

b.isSubset(of: a)   // true 부분집합 여부
b.isStrictSubset(of: a)   // false 진부분집합 여부



// 상위집합

a.isSuperset(of: b)    // true 상위집합 여부
a.isStrictSuperset(of: b)   // false  진상위집합 여부


// 서로소 여부

d.isDisjoint(with: c)


#합집합
a = [1, 2, 3, 4, 5, 6, 7, 8, 9]
b = [1, 3, 5, 7, 9]
c = [2, 4, 6, 8, 10]
d = [1, 7, 5, 9, 3]



var unionSet =  b.union(c)


//b.formUnion(c)      // 원본변경

#교집합
var interSet = a.intersection(b)

//a.formIntersection(b)      // 원본변경


#차집합
var subSet = a.subtracting(b)

//a.subtract(b)       // 원본변경

#대칭차집합
var symmetricSet = a.symmetricDifference(b)

//a.formSymmetricDifference(b)       // 원본변경

#반복문과의 결합
let iteratingSet: Set = [1, 2, 3]


for num in iteratingSet {    // 정렬되지 않은 컬렉션이기 때문에, 실행할때마다 순서가 달라짐
    print(num)
}


#기타 유의점
var newSet: Set = [1, 2, 3, 4, 5]

var newArray: Array = newSet.sorted()


##Set을 정렬하면, 배열로 리턴함 (정렬은 순서가 필요하기 때문)##
#####################################################################################2021.09.21_3
Dictionary_Hashable_2
#딕셔너리의 비교
let a = ["A": "Apple", "B": "Banana", "C": "City"]
let b = ["A": "Apple", "C": "City", "B": "Banana"]


// 비교 연산자
a == b   // true
// 딕셔너리는 원래 순서가 없기 때문에, 순서는 상관없음
// (순서 상관없이 무조건 true나옴 - Hashable하기 때문에, 순서 상관없이 비교가능)


a != b   // false


#딕셔너리의 활용
// 딕셔너리의 중첩 사용

var dict1 = [String: [String]]()        // 딕셔너리 밸류에 "배열"이 들어갈 수도 있다.


dict1["arr1"] = ["A", "B", "C"]
dict1["arr2"] = ["D", "E", "F"]
dict1

//dict1["arr"] = "A"



var dict2 = [String: [String: Int]]()     // 딕셔너리 안에 딕셔너리가 들어갈 수 있다.

dict2["dic1"] = ["name": 1, "age": 2]

dict2["dic2"] = ["name": 2, "age": 4]

dict2


#반복문과의 결합
// 딕셔너리 열거해서 프린트 하기

let dict = ["A": "Apple", "B": "Banana", "C": "City"]


// 딕셔너리는 열거하지 않아도, Named 튜플 형태로 하나식 꺼내서 전달
// 순서가 없으므로, 실행마다 순서가 달라짐 ⭐️



// 데이터 바구니이기 때문에,
// 차례대로 하나씩 꺼내서 사용하는 경우가 많을 수 있어서 아래처럼 활용 가능


for (key, value) in dict {
    print("\(key): \(value)")
}


for (key, _) in dict {
    print("Key :", key)
}


for (_, value) in dict {
    print("Value :", value)
}

#####################################################################################2021.09.21_2
Dictionary_Hashable
#2) 딕셔너리(Dictionary)
데이터를 키와 값으로 하나의 쌍으로 만들어 관리하는 컬렉션


/**==============================================================
 - 딕셔너리의 문법 약속
 - [] 대괄호로 묶는다. (쌍을 콜론으로 처리)
 - 키값은 유일해야함 / 중복 불가능(구분하는 요소이기 때문에) 밸류값은 중복 가능
 - 1개의 딕셔너리에는 동일한 자료형 쌍의 데이터만 담을 수 있음
 - 키값은 Hashble 해야함
================================================================**/

var dic = ["A": "Apple", "B": "Banana", "C": "City"]   // 딕셔너리 리터럴로 생성해서 저장

let dic1 = [1: "Apple", 2: "Banana", 3: "City"]

// 내부적으로 순서가 존재하지 않음

print(dic)
print(dic1)


#딕셔너리의 타입 표기
// 단축문법
var words: [String: String] = [:]

// 정식문법
let words1: Dictionary<Int, String>


#빈 딕셔너리의 생성
let emptyDic1: Dictionary<Int, String> = [:]
let emptyDic2 = Dictionary<Int, String>()
let emptyDic3 = [Int: String]()

//var dictFromLiteral = [:]    // 타입 정보가 없으면 유추할 수가 없다.

var dictFromLiteral = ["1": 1, "2": 2]

dictFromLiteral = [:]    // 이미 위에서 타입을 정의했다면, 아래에서 빈 값으로 넣는 것은 괜찮음



#딕셔너리의 기본 기능
dic = ["A": "Apple", "B": "Banana", "C": "City"]

dic.count
dic.isEmpty

// contains 함수가 존재하긴 하나, 뒤에서 배울 클로저의 내용을 알아야함
// dic.contains(where: <#T##((key: String, value: String)) throws -> Bool#>)

dic.randomElement()      // Named Tuple 형태로 리턴


#딕셔너리의 각 요소(element)에 대한 접근 (키 값으로 접근)
// 배열

var numsArray = [1, 2, 3, 4, 5]

numsArray[0]

###딕셔너리는 기본적으로 서브스크립트[ ]를 이용한 문법을 주로 사용###
// 딕셔너리
dic = ["A": "Apple", "B": "Banana", "C": "City"]



dic["A"]        // nil의 가능성 =====> String?(옵셔널)
//print(dic["A"])
//print(dic["Q"])



if let a = dic["A"] {    // 옵셔널 바인딩
    print(a)
} else {
    print("Not found")
}



// 딕셔너리는 값만 따로 검색하는 방법은 제공하지 않음. ⭐️
// 서브스크립트 문법으로 "키"를 전달


// 참고 (잘 사용하지는 않음)
dic["S", default: "Empty"]       // nil이 발생할 확률이 없음
// 자료가 없으면 기본값을 리턴하는 문법  ===> 리턴 String




dic.keys
dic.values


dic.keys.sorted()
dic.values.sorted()



for key in dic.keys.sorted() {     // 오름차순 정렬  ===> "return 배열" 배열이 됨
    print(key)
}



#업데이트 (update) - 삽입하기 / 교체하기 / 추가하기
words = [:]

words["A"] = "Apple"   // 애플로 다시 바꾸기
words

words["B"] = "Banana"  // 동일한 키가 없으면 ===> 추가하기
words

words["B"] = "Blue"    // 동일한 키가 있으면 ===> 기존 밸류 덮어쓰기
words


words.updateValue("City", forKey: "C")


// (정식 기능) 함수 문법 (update + insert = upsert)

words.updateValue("City", forKey: "C")   // 새로운 요소가 추가되면 ==> 리턴 nil
words


//words = [:]      // 빈 딕셔너리로 만들기
words = ["A": "A"]   // 전체 교체하기(바꾸기)


#딕셔너리는 append 함수를 제공하지 않음
// append는 순서가 있는 컬렉션의 끝에 추가하는 개념
// 딕셔너리는 순서가 없기 때문에, update를 통해서 추가


#삭제(제거)하기 (remove)
dic = ["A": "Apple", "B": "Banana", "C": "City"]

// 요소 삭제해 보기
dic["B"] = nil    // 해당요소 삭제
dic

dic["E"] = nil   // 존재하지 않는 키/값을 삭제 ======> 아무일이 일어나지 않음(에러아님)
dic


// 함수로 삭제해보기
dic.removeValue(forKey: "A")   // 삭제후, 삭제된 값 리턴
dic.removeValue(forKey: "A")   // 다시 삭제해보기 ===> nil리턴


// 전체 삭제하기
dic.removeAll()
dic.removeAll(keepingCapacity: true)
#####################################################################################2021.09.21_1

Part_9 Collection _3

#배열의 기타 기능
var nums = [1, 2, 3, 1, 4, 5, 2, 6, 7, 5, 0]

// 배열을 정리해보기

// 1) 배열을 직접정렬하는 메서드  sort  (동사)
// 2) 정렬된 새로운 배열을 리턴  sorted (동사ing/동사ed)



nums.sort()   // 배열을 직접 정렬 (오름차순) (배열리턴 하지 않음)
nums.sorted()    //오름차순으로 정렬


nums.reverse()   // 요소를 역순으로 정렬  (배열리턴 하지 않음)
nums.reversed()


nums.sorted().reversed()
// 새로운 배열은 생성하지 않고, 배열의 메모리는 공유하면서 역순으로 열거할 수 있는 형식을 리턴



// 배열을 랜덤으로 섞기

//nums.shuffle()    // 요소의 순서 랜덤으로 직접 바꾸기
//nums.shuffled()


#배열의 비교
let a = ["A", "B", "C"]
let b = ["a", "b", "c"]


// 두 배열을 비교해보기

a == b   // false
a != b   // true

// 개별요소 비교, 저장순서도 비교 하기 때문에


#활용
// 특정 요소 한개 삭제하기
// ===> 직접 삭제는 불가 (1) 인덱스 찾아서, (2) 인덱스에 해당하는 요소 지우기

var puppy1 = ["p", "u", "p", "p", "y"]



if let lastIndexOfP = puppy1.lastIndex(of: "p") {
    puppy1.remove(at: lastIndexOfP)
}



if !nums.isEmpty {            // "!"(true ====> false)  (false ====> true)
    print("\(nums.count) element(s)")
} else {
    print("empty array")
}


// 배열의 배열 접근

var data = [[1, 2, 3], [4, 5, 6], [7, 8, 9]]

data[0][2]


#반복문과의 결합
// 각 요소에 차례대로 접근, 배열과 반복문은 필연적으로 많이 쓰임

for i in nums {
    print(i)
}


#enumerate: 영어로 열거하다는 뜻
// enumerated() ===> 열거된 것들을 Named 튜플 형태로 한개씩 전달

// 데이터 바구니이기 때문에,
// 실제 번호표(index)까지 붙여서, 차례대로 하나씩 꺼내서 사용하는 경우가 많을 수 있어서 아래처럼 활용 가능

nums = [10, 11, 12, 13, 14]


// (offset: 0, element: 10)


for tuple in nums.enumerated() {
    //print(tuple)
    print("\(tuple.0) - \(tuple.1)")
}




for (index, word) in nums.enumerated() {      // 바로 뽑아내기
    print("\(index) - \(word)")
}




for (index, value) in nums.enumerated().reversed() {      // 거꾸로 뒤에서 부터
    print("\(index) - \(value)")
}

#####################################################################################2021.09.21
Part_9 Collection _2
#삽입하기 (insert)
var alphabet = ["A", "B", "C", "D", "E", "F", "G"]

// 앞 또는 중간에 삽입하기

alphabet.insert("c", at: 4)

//alphabet.insert("c", at: alphabet.endIndex)


alphabet.insert(contentsOf: ["a","b","c"], at: 0)

//alphabet.insert(contentsOf: ["a","b","c"], at: alphabet.endIndex)


#교체하기 (replace)
alphabet = ["A", "B", "C", "D", "E", "F", "G"]


// 요소 교체하기
alphabet[0] = "a"


// 범위를 교체하기
alphabet[0...2] = ["x", "y", "z"]


// 원하는 범위 삭제
alphabet[0...1] = []
alphabet


// 교체하기 함수 문법

alphabet.replaceSubrange(0...2, with: ["a", "b", "c"])


#추가하기 (append)
alphabet = ["A", "B", "C", "D", "E", "F", "G"]


alphabet += ["H"]



// 추가하기 함수 문법

alphabet.append("H")   // 맨 마지막에 추가하는 것

alphabet.append(contentsOf: ["H", "I"])



//alphabet.append(7)   // 에러 ===> 동일한 자료형만 저장가능함



#삭제(제거)하기 (remove)
alphabet = ["A", "B", "C", "D", "E", "F", "G"]

// 서브스크립트 문법으로 삭제

alphabet[0...2] = []   //빈배열 전달하면 해당 범위가 삭제


// 요소 한개 삭제
alphabet.remove(at: 2)  // 삭제하고, 삭제된 요소 리턴
//alphabet.remove(at: 8)    // 잘못된 인덱스 전달 ====> 에러발생


// 요소 범위 삭제
alphabet.removeSubrange(0...2)



alphabet = ["A", "B", "C", "D", "E", "F", "G"]


alphabet.removeFirst()   // 맨 앞에 요소 삭제하고 삭제된 요소 리턴 (리턴형 String)
alphabet.removeFirst(2)   // 앞의 두개의 요소 삭제 ===> 리턴은 안함


alphabet.removeLast()   // 맨 뒤에 요소 삭제하고 삭제된 요소 리턴 (리턴형 String)
alphabet.removeLast(2)



// 배열이 비어있는지도 잘 확인해보고 삭제(제거)해야함 =======> 에러
// alphabet.removeFirst()    // 리턴형 String
// alphabet.removeLast()     // 리턴형 String




// 배열의 요소 모두 삭제(제거)
alphabet.removeAll()
alphabet.removeAll(keepingCapacity: true)  // 저장공간을 일단은 보관해 둠. (안의 데이터만 일단 날림)




#####################################################################################2021.09.18
Part9~10_2
#####################################################################################2021.09.17
Part9~10

#####################################################################################2021.09.16
Part_9 Collection
Part9 - 컬렉션(Collection) _ 1
1) 배열(Array)
데이터를 순서대로 저장하는 컬렉션 (자동으로 순번 지정됨)

/**==============================================================
 - 배열의 문법 약속
 - [] 대괄호로 묶는다. 배열의 인덱스의 시작은 0부터 (모든 프로그래밍 언어 공통 사항)
 - 1개의 배열에는 동일한 타입의 데이터만 담을 수 있다.
 - (순서가 있기 때문에) 값은 중복 가능
================================================================**/


var numsArray = [1, 2, 3, 4, 5]   // 배열 리터럴로 배열을 생성해서 저장

let numsArray1 = [20, 2, 7, 4, 5, 7]

var stringArray = ["Apple", "Swift", "iOS", "Hello"]

#배열의 타입 표기
// 정식문법
let strArray1: Array<Int> = []


// 단축문법
let strArray2: [String] = []


#빈 배열의 생성
let emptyArray1: [Int] = []
let emptyArray2 = Array<Int>()
let emptyArray3 = [Int]()

#배열의 기본 기능
numsArray.count
numsArray.isEmpty


numsArray.contains(1)  //파라미터로 값을 전달
numsArray.contains(8)


numsArray.randomElement()


numsArray.swapAt(0, 1)


#배열의 각 요소(element)에 대한 접근
numsArray = [1, 2, 3, 4, 5]   // 배열 리터럴
stringArray = ["Apple", "Swift", "iOS", "Hello"]


// [] 서브스크립트 문법(대괄호를 이용한 특별한 함수)

stringArray[0]
stringArray[1]
stringArray[2]
stringArray[3]




stringArray[1] = "Steve"
print(stringArray)



stringArray.first   // 리턴값 String?  ====> 빈 배열이라면 nil 리턴
stringArray.last


// 배열의 시작 인덱스
stringArray.startIndex

stringArray.endIndex
//stringArray.endIndex.advanced(by: -1)


stringArray[stringArray.startIndex]

stringArray[stringArray.endIndex - 1]
//stringArray[stringArray.index(before: stringArray.endIndex)]



//stringArray.index(<#T##i: Int##Int#>, offsetBy: <#T##Int#>)



stringArray.firstIndex(of: "iOS")     // 앞에서 부터 찾았을때 "iOS"는 배열의 (앞에서부터) 몇번째

stringArray.lastIndex(of: "iOS")     // 뒤에서 부터 찾았을때 "iOS"는 배열의 (앞에서부터) 몇번째



if let index = stringArray.firstIndex(of: "iOS") {
    print(index)
}
#####################################################################################2021.09.15_4
Optional응용
함수와 옵셔널 타입의 사용
옵셔널타입의 파라미터 사용

// 옵셔널 파라미터 사용 함수의 정의

func doSomePrint(with label: String, name: String? = nil) {   // String? = nil
    print("\(label): \(name)")
}


// 함수의 실행

//doSomePrint(with: <#T##String#>, name: <#T##String?#>)


doSomePrint(with: "레이블", name: "스티브 잡스")

doSomePrint(with: "레이블", name: nil)

doSomePrint(with: "레이블")


일반적으로는 String? = nil (기본값까지 설정해서, 함수를 유연하게 사용하도록 함)

#####################################################################################2021.09.15_3
Optional 추출
옵셔널 타입 사용하기
옵셔널 타입: 값이 없을 수도 있는 경우를 포함하는(감싸고) 있는 임시적 타입

var num: Int?
var str: String? = "안녕하세요"
print(num)
print(str)

#옵셔널값을 추출하는 4가지 방법
강제로 값을 추출(Forced Unwrapping): 값이 있다는 것이 확실할때 사용

1.
// 강제 추출연산자 !를 옵셔널표현식 뒤에 붙여서 강제로 옵셔널값을 추출
print(str!)
//print(num!)       // 에러

2.
if문으로 nil이 아니라는 것 확인한 후, 강제로 벗기기
if str != nil {
    print(str!)
}

3.
옵셔널 바인딩 (if  let 바인딩) ⭐️⭐️⭐️
옵셔널 바인딩 - 바인딩이 된다면, 특정 작업을 하겠다는 의미

if let s = str {    // s라는 상수에 담긴다면    // nil
    print(s)
}

var optionalName: String? = "홍길동"



if let name = optionalName {
    print(name)
}


// 실제 앱을 만들때 guard let 바인딩 많이 사용

func doSomething(name: String?) {
    guard let n = name else { return }
    print(n)
}

doSomething(name: "hello")


4.
닐 코얼레싱 (Nil-Coalescing) 연산자를 사용하는 방법
코얼레싱(coalesce): 영어로 (더 큰 덩어리로) 합치다는 뜻
// 옵셔널 타입에 대하여, 디폴트(기본)값을 제시할 수 있을 때 사용
// (직접 값을 벗겨서 사용하는 것은 아니고, 디폴트값 제시를 통해 옵셔널 가능성을 없애는 방법)


// String? ====> String


var serverName: String? = "홍길동"


var userName = serverName ?? "미인증사용자"    // String타입




var hello = "인사하겠습니다. " + (str ?? "Say, Hi")
print(hello)



str = nil
print(str ?? "Say, Hi")



// 백그라운드 기본 색상이 선택이 안되어 있으면 ====> 회색

#####################################################################################2021.09.15_2
Part8 - Optional
Part8 - Optionals(옵셔널)
#타입의 기본 개념에 대한 이해

// 스위프트는 왜 옵셔널이라는 개념을 도입했을까?
// 모든 프로그래밍에서 아래와 같은 상황은 항상 골치거리임

var yourName: String        // 선언
//yourName = "홍길동"           // 값을 저장하지 않는다면..

print(yourName)   // (만약 저장과정이 없다면) 메모리에 저장된 값이 없는데 접근 ===> 🔸"에러"


#타입(Type)
// 지금까지의 타입 선언

let name: String = "Jobs"        // 명시적
let newName = "Musk"             // 암시적
var myAge = 20                   // 암시적
let myGrade: Double = 3.54       // 명시적

#옵셔널 타입(Optional Type)
// 모든 타입의 뒤에 ? 물음표를 붙이면 옵셔널 타입이 된다.

var num: Int? = 3
var yourAge: Int? = nil
var yourGrade: Double? = nil
var name1: String? = "Jobs"

num = nil
name1 = nil

// 값이 없어도 되는 타입으로 선언 했기 때문에, 값이 없어도 괜찮음

nil - 값이 없음을 나타내는 키워드 (실제 값이 없음이 아님)
옵셔널, 옵셔널 타입의 기본 개념에 대한 이해
// 메모리 공간에 "임시적인 타입"을 넣어놓으면 어떨까?

var optionalName: String?
//optionalName = "홍길동"


print(optionalName)   // 에러가 나지 않음 (옵셔널은 값이 없다는 것을 나타내는 키워드)


/**=========================================
- 옵셔널 타입 선언의 기본 규칙
- 1) nil 대입 가능
- 2) 자동 초기화 (값을 넣지 않을 시에 nil로 초기화) ⭐️
============================================**/


정식문법 표기
let num1: Int? = 2             // 간편표기
let num2: Optional<Int> = 0    // 정식문법

#옵셔널 타입 연습
//var optionalNum = nil         // 불가능한 형태

var optionalNum: Int? = nil     // (추론할 형식이 없기 때문에 반드시 타입 어노테이션으로 초기화해야됨)
optionalNum = 10

// 값이 없을 수도 있는 (임시적인)타입이야

print(optionalNum)      // Optional(10) //Optional은 포장지
print(optionalNum!)     // 10 !강제로 포장지 벗기기


let str: String = "Swift"
var optionalStr: String? = nil      //옵셔널 스트링 타입 ====> (값이 없을 수도 있는 타입이다)


var a: Int? = 7  // 옵셔널 인트
var b = a        // 값을 복사해서 담는 다면 타입은?

print(b)


var c: Int = 5
b = c     // Int를 Int?타입에 담을 수는 있다. (어쨌든 타입이 Int? 타입으로 바뀌어서 담김)

print(b)


#옵셔널 타입끼리의 연산은 불가능
옵셔널 타입끼리의 계산은 당연히 불가능
var numA: Int? = 3
var numB: Int? = 7

//print(numA + numB)


#####################################################################################2021.09.15_1
discardableResult
함수의 리턴값 유무
함수의 정의

// 리턴값(타입)이 없는 함수

func sayHello() {
    print("안녕하세요.")
}


//sayHello()


// 리턴값(타입)이 있는 함수

//@discardableResult
func sayHelloString() -> String {
    print("하이")
    return "안녕하세요"
}


sayHelloString()     // 실제 프로젝트에서 경고창 표시


#리턴 타입이 없는 함수(Void 타입) vs 리턴타입이 있는 함수의 차이 ⭐️

#리턴 타입이 없는 함수 ➞ 결과는 Void 타입
// 이렇게 사용하는 경우는 없음(결과값 없음)
//var hello: Void = sayhello1()
sayHello()         // 제어권

#리턴 타입이 있는 함수 ➞ 결국 결과로 "값"이 있는 것 ➞ (일반적으로)사용
// 함수 자체를 값으로 볼 수 있음
var hello = sayHelloString()       // 제어권 + 결과값

#리턴값이 있는 함수에서 리턴값을 사용하지 않는다면
// 기존의 방식

_ = sayHelloString()    // (결과값을 사용하지 않을때) 지금까지 많이 사용해오던 패턴

// 스위프트 5.2 부터

//@discardableResult   //어트리뷰트를 사용하도록함
#####################################################################################2021.09.15
guard문
가드문(guard statement)
불만족하는 조건을 사전에 걸러내는 조건문

if문의 단점 - 여러개의 조건이 있을때 코드의 가독성이 문제됨 ➞ guard문으로 단점 극복

// if문을 만족하는 경우, 지속적인 들여쓰기로 인해 코드의 가속성이 안 좋아질 수 있음
// (실제 프로젝트에서는 코드를 알아보기 힘듦)

/**=======================================================
 - guard문
 - 1) else문을 먼저 배치 - 먼저 조건을 판별하여 조기 종료(early exit)
 - 2) 조건을 만족하는 경우 코드가 다음 줄로 넘어가서 계속 실행
 - 3) 가드문에서 선언된 변수를 아래문장에서 사용 가능 (동일한 스코프로 취급) (guard let 바인딩 관련)
=======================================================**/
//if문은 참...거짓 종료 guard문은 거짓 종료

#가드문의 이해
func checkNumbersOf1(password: String) -> Bool {
    
    if password.count >= 6 {
        
        // 로그인을 처리하는 코드 작성
        // 1
        // 2
        // 3
        // 4
        // 5
        
        return true
        
    } else {
        
        return false
        
    }

}

func checkNumbersOf2(password: String) -> Bool {
    
    // 감시하다
    guard password.count >= 6 else {
        return false                          // 종료 조건 - 함수 내에서는 return / throw
    }
    
    // 로그인을 처리하는 코드 작성
    // 1
    // 2
    // 3
    // 4
    // 5
    
    return true
}

#가드문의 사용 예시
// 반드시 코드를 종료해야하는 조기 종료의 조건이 필요하므로, 로컬스코프(함수/반복문) 내에서만 사용 가능

func check(words: String) -> Bool {
    
    guard words.count >= 5 else {
        
        print("5글자 이하입니다.")
        
        return false                             // 종료 조건 - 함수 내에서는 return / throw
    }
    
    print("\(words.count)글자입니다.")
    
    return true
}

check(words: "안녕하세요")

실제 프로젝트에서 몇번 사용하다보면 바로 감이 옴
#####################################################################################2021.09.14_1
함수 실행의 메모리 구조 -1
참고) 함수 실행의 메모리 구조
3 + 4 = 7 에 대한 이해

var a1 = 3
var a2 = 4
var a3 = a1 + a2
print(a3)

3 + 4 = 7을 함수로 정의한다면

// 함수를 정의
func threeAndFour() {
    var a1 = 3
    var a2 = 4
    var a3 = a1 + a2
    print(a3)
}

// 함수의 실행
threeAndFour()

플레이그라운드에 대한 가정 (메모리 구조를 더 잘 이해하기 위함)
// 프로그래밍에서, 가장 처음으로 프로그래밍이 시작되는 곳은 main() 메인함수 (스위프트에서는 main.swift파일)
// 플레이 그라운드는 문법을 쉽게 공부하기 위한 목적이므로 main() 함수는 눈에 보이지 않지만, 구현이 되어있다고 가정

// (실제 앱을 만드는 것이 아니므로) 메모리 구조상 (static영역이 일단은 없다고 가정하기위해서) ➡︎ 현재 공부하는데 방해됨


func main() {
    
    var name = "홍길동"
    
    // 우리가 현재 구현하는 곳 ====> 현재의 플레이그라운드
       
}

main()    // 앱을 키면 ====> 프로그램을 실제 시작시킴

#addTwoNumbers(a: Int, b: Int) 함수
func addTwoNumbers(a: Int, b: Int) -> Int {
    var c = a + b
    return c
}



var num1 = 5    // 이 예제에서는 전역변수가 아닌 main()함수의 영역이라고 가정
var num2 = 3    // 이 예제에서는 전역변수가 아닌 main()함수의 영역이라고 가정

var num3 = addTwoNumbers(a: num1, b: num2)

print(num3)

#함수 실행시, 실제 메모리에서 어떻게 동작할까?
// 메모리 예제


var total: Int = 0    // 실제 전역변수라면 (데이터영역)


func square(_ i: Int) -> Int {     // x 제곱
    return i * i
}


func squareOfSum(_ x: Int, _ y: Int) -> Int {    // (x + y)(x + y)
    var z = square(x + y)
    return z
}


func startFunction() {
    var a = 4
    var b = 8
    total = squareOfSum(a, b)
}

startFunction()


#함수와 변수의 변화 예제
var a = 1       // 실제 전역변수라면
var b = 1       // 실제 전역변수라면


func addOneMore2() -> Int {
    b += 1
    return 5
}


func addOneMore1() {
    var num = 0
    a += 1
    num += addOneMore2()
    print(num)
}

addOneMore1()


#조건문과 반복문의 명령어(CPU) 구조
조건문(if문)

var c = 0

func someConditionalStatement(a: Int) {
    if a >= 0 {
        c += 1
    } else {
        c += 7
    }
}

someConditionalStatement(a: -3)

#반복문
var d = 0

func someLoop() {
    for i in 1...5 {
        d += i
    }
}

someLoop()
#####################################################################################2021.09.14
inout 파라미터
함수를 통해, 변수를 직접 수정하고 싶은 경우는 어떻게 해야할까?
함수내의 파라미터는 기본적으로 값타입이고(복사되서 전달) 임시상수이기 때문에 변경 불가 원칙

var num1 = 123     // 전역변수
var num2 = 456     // 전역변수


func swap(a: Int, b: Int) {
//    var c = a
//    a = b
//    b = c
}


swap(a: num1, b: num2)

#함수 내에서 변수를 직접 수정하도록 돕는 inout키워드 (참조로 전달)
inout 키워드(선언시),   & 사용(실행시)
num1 = 123
num2 = 456



func swapNumbers(a: inout Int, b: inout Int) {
    var temp = a
    a = b
    b = temp
}




// 함수 실행시에는 앰퍼샌드를 꼭 붙여야함

swapNumbers(a: &num1, b: &num2)


print(num1)
print(num2)



// 입출력 파라미터는 내부적으로 copy-in, copy-out 메모리 모델를 사용하지만, 실제 원본이 전달된다고 쉽게 생각하면 됨
// *copy-in, copy-out - 값을 복사해서 함수 바디 내부로 전달하고,
// 함수가 종료될때, 아규먼트로 전달한 변수에 복사됨(함수 바디 내부에서 외부로 복사되어 전달)



/**==========================================
 - inout파라미터 사용시 주의점
 - 1) 상수(let)나, 리터럴 전달하는 것 불가능
 - 2) 파라미터의 기본값 선언을 허용하지 않음
 - 3) 가변파라미터(여러개의 파라미터)로 선언하는 것 불가능
=============================================**/
#####################################################################################2021.09.13_5
제어전송문 정리
제어전송문 정리
#1) break
(1) switch문   (2) 반복문(for/while 등) 에서 사용

var a = 3

switch a {
case 1:
    break      // 실행하는 문장이 없을때, 반드시 입력 (약속)
case 2:
    print(a)
case 3:
    print("3입니다.")
case 4:
    print("안녕하세요")
default:
    break
}


// 가장 인접한 반복문을 아예 중지 ⭐️

for index in 1...10 {

    if index == 3 {
        break
    }

    print(index)
}


#2) fallthrough
switch문에서 사용

switch a {
case 1:
    break      // 실행하는 문장이 없을때, 반드시 입력 (약속)
case 2:
    print(a)
case 3:
    print("3입니다.")
    fallthrough
case 4:
    print("안녕하세요")
default:
    break
}

// 3입니다.
// 안녕하세요

#3) continue
반복문에서 사용(for/ while 등)
// continue는 반복문을 다음 싸이클로 보냄
// 다음 싸이클에서 계속 지속(continue)하라는 의미


for index in 1...10 {

    if index % 2 != 0 {
        continue
    }

    print(index)
}

#4) return
함수에서 사용
func doSomething() {
    print("1")
    print("2")
    
    if true {
        return
    }
    
    print("3")
    print("4")
}


doSomething()


5) throw
(에러가 발생할 수 있는) throwing 함수에서 사용
// 향후 Error Handling 부분을 배운 후, 복습

enum APIError: Error {
    case aError
    case bError
}



func doSomething2() throws -> String {
    print("1")
    print("2")
    
    if true {
        throw APIError.aError    // 리턴과 동일한 역할(함수를 종료시킴) ===> 에러를 던지고 함수를 벗어남
    }
    
    print("3")
    print("4")
    
    return "안녕하세요"
}
#####################################################################################2021.09.13_4
범위(Scope)에 대한 이해
#범위(Scope)
Scope - 함수, if, for문 등에 모두 해당

/**====================================================================================
 - 1. 변수는 코드에서 선언이 되어야, 그 이하의 코드에서 접근 가능(선언하기 이전에는 접근 불가함) (전역변수는 예외)
 - 2. 상위스코프(범위)에 선언된 변수와 상수에 접근가능하며, 하위스코프(범위)에는 접근할 수 없다.
 - 3. (동일한 스코프에서 이름이 중복될 수 없지만, 다른 스코프에서는 이름 중복이 가능)
       가장 인접한 스코프에 있는 변수와 상수에 먼저 접근 한다.
 =====================================================================================**/

#첫번째 예제
func greeting1() {
    print("Hello")
    
    var myName = "홍길동"
    print(myName)
    
    print(name)
    
    if true {
        print(myName)
        print(name)
    }
}


//print(myName)
//print(name)



greeting1()


var name = "잡스" // 전역변수 (메모리의 데이터 영역에 저장)


greeting1()


#두번째 예제
//func doSomething() {
//    print(realName)       // 코드는 순서대로 작동하기 때문에, 선언이 되어있어야 사용 가능
//
//    var realName = "앨런"
//}

//doSomething()


#세번째 예제
func sayGreeting1() {
    print("Hello")
    
    
    func sayGreeting2() {
        print("Hey")
        
        if true {
            print("")
        }
    }
    
    sayGreeting2()
    
}


//sayGreeting1()
//sayGreeting2()


##라인 맞추기 ➞ (전체선택: Command + A) ➞ (줄맞추기: Control + I)
#####################################################################################2021.09.13_3
함수의 오버로딩(overloading)
#함수의 오버로딩(overloading)
함수의 오버로딩에 대한 이해

오버로드(overload): 영어로 과적하다라는 뜻

// 같은 이름의 함수에 매개변수(파라미터)를 다르게 선언하여, 하나의 함수 이름에 실제 여러개의 함수를 대응 시키는 것
// ===> 쉽게말하면: 함수의 이름의 재사용


// 스위프트는 오버로딩을 지원하는 언어
// ⭐️ 함수이름, 파라미터 수/자료형, 아규먼트 레이블, 리턴형을 모두포함해서 함수를 식별

func doSomething(value: Int) {
    print(value)
}


func doSomething(value: Double) {
    print(value)
}


func doSomething(value: String) {
    print(value)
}


func doSomething(_ value: String) {
    print(value)
}


func doSomethging(value1: String, value2: Int) {
    print(value1, value2)
}

doSomething(value: 5)

doSomething(value: 3.4)

doSomething(value: 3)

// 오버로딩을 지원하지 않는 언어의 단점
// 같은 기능을 제공하는 함수를 파라미터 형식마다 이름을 다르게 구현해야하기 때문에 함수의 이름이 많아지고, 구별해서 사용하는 것이 어렵다.


#실제 애플에서 만들어놓은 함수들에도 오버로딩을 사용한 함수들이 많음
//print(<#T##items: Any...##Any#>, to: &<#T##TextOutputStream#>)
//print(<#T##items: Any...##Any#>, separator: <#T##String#>, terminator: <#T##String#>)
//print(<#T##items: Any...##Any#>, separator: <#T##String#>, terminator: <#T##String#>, to: &<#T##TextOutputStream#>)
#####################################################################################2021.09.13_2
함수 사용시 주의점
함수 사용시 주의점 ⭐️
함수의 파라미터에 대한 정확한 이해

// 함수의 파라미터
func someAdd(a: Int) -> Int {            // let a: Int   (값의 변경이 불가능)
    //a = a + 1
    return a
}
someAdd(a: 5)


함수 내의 변수의 Scope(스코프)
함수 내에서 선언한 변수의 Scope(범위) ➞ 함수의 바디로 제한됨

// 뒤쪽에서 메모리구조를 보면 명확하게 직관적으로 이해 가능
func sumOfNum(a: Int) -> Int {
    var sum = 0
    sum += a
    return sum
}

//sum


sumOfNum(a: 3)


#return 키워드의 정확한 이해
/**==============================================================
 - return 키워드의 역할
 - 1) 리턴타입이 있는 함수의 경우(아웃풋이 있는 경우):
      리턴 키워드 다음의 표현식을 평가한 다음에 그 결과를 리턴하면서 함수를 벗어남
 - 2) 리턴타입이 없는 함수의 경우(아웃풋이 없는 경우):
      함수의 실행을 중지하고 함수를 벗어남 ⭐️
=================================================================**/


// 리턴 타입이 있는 경우
func addFunction(num1: Int, num2: Int) -> Int {
    var result = num1 + num2
    return result
}
addFunction(num1: 3, num2: 4)


// 리턴 타입이 있는 경우
func valuationFunction(num: Int) -> Int {
    
    if num >= 5 {
        return num
    }

    return 0
}
valuationFunction(num: 3)

valuationFunction(num: 5)


// 리턴 타입이 없는 경우
func numberPrint(n num: Int) {
    
    if num >= 5 {
        print("숫자가 5이상입니다.")
        return
    }
    
    print("숫자가 5미만입니다.")
}

numberPrint(n: 7)

numberPrint(n: 4)

numberPrint(n: 5)


#리턴타입이 있는 경우, 함수의 실행문의 의미
//리턴 타입이 있는 함수를 호출하는 경우, 함수를 호출하는 것은 표현식 (표현식의 결과는 함수가 리턴하는 값)
func nameString() -> String {
    return "스티브"
}
var yourName: String = nameString()           // "스티브"


if nameString() == "스티브" {
    print("이름이 일치합니다.")
}

//var your: () -> String = nameString


#함수의 중첩 사용 - 중첩된 함수(Nested Functions)
// 함수 안에 함수를 작성할 수도 있다.
// (함수 안에 있는 함수는 밖에서 사용이 불가능)


// 함수를 제한적으로 사용하고 싶을 때, 사용

func chooseStepFunction(backward: Bool, value: Int) -> Int {
    
    func stepForward(input: Int) -> Int {
        return input + 1
    }
    
    func stepBackward(input: Int) -> Int {
        return input - 1
    }
    
    
    if backward {
        return stepBackward(input: value)
    } else {
        return stepForward(input: value)
    }
    
}

var value = 7

//case1
chooseStepFunction(backward: true, value: value)
//case2
chooseStepFunction(backward: false, value: value)



#함수 표기법(지칭), 함수의 타입 표기
참고) 함수 표기법

// 정의문
func doSomething() {
    print("출력")
}

func addPrintFunction(_ firstNum: Int, _ secondNum: Int) {
    print(firstNum + secondNum)
}


// 실행문
numberPrint(n: 3)
/**=============================================
 - 함수를 지칭하려는 경우, 함수를 어떻게 표기할까?
 - 1) 개발자 문서를 읽을 때 필요
 - 2) 함수를 지칭할때 필요(함수를 변수에 담거나)
================================================**/


// 함수의 표기법(함수를 지칭시)
// 1) 파라미터가 없는 경우, ()를 삭제

doSomething

// 2) 아규먼트 레이블이 있는 경우, 아규먼트 레이블까지를 함수의 이름으로 봄
numberPrint(n:)        //  "numberPrint n 함수이다."

// 3) 파라미터가 여러개인 경우, 콤마없이 아규먼트이름과 콜론을 표기
chooseStepFunction(backward:value:)

// 4) 아규먼트 레이블이 생략된 경우, 아래와 같이 표기
addPrintFunction(_:_:)

#함수 타입의 표기
// 변수에 정수를 저장하는 경우에 타입 표기
var num: Int = 5


// 함수의 타입 표기 방법
var function1: (Int) -> () = numberPrint(n:)

var function2: (Int, Int) -> () = addPrintFunction(_:_:)


// 변수가 함수를 가르키도록 할 수 있음
function2(3, 5)
#####################################################################################2021.09.13_1
Function Parameters,Argument
#함수의 파라미터, 아규먼트
파라미터(Parameter)

/**=============================================================
 - 파라미터: 함수 정의시, 함수 정의에 입력값으로 사용되는 변수(내부사용)
 - 아규먼트: 함수를 호출시, 함수가 필요한 파라미터의 타입과 일치하는 실제 값(외부사용)
================================================================**/


// 파라미터 이름만 사용할때(아규먼트 레이블 사용 안하면)

func printName(name: String) {                  // name: String  (파라미터)
    print("나의 이름은 \(name) 입니다.")
}

printName(name: "에디슨")          //   "에디슨" (아규먼트)


#아규먼트 레이블(Argument Label)
// 아큐먼트 레이블을 사용하면
func printName1(first name: String) {
    print("나의 이름은 \(name) 입니다.")
}

printName1(first: "뉴턴")



//아규먼트 레이블 사용 안하면
func someFunction(first: Int, second: Int) {
    print(first + second)
}

someFunction(first: 1, second: 2)


//아규먼트 레이블 사용하는 것의 이점 (일반적으로 함수를 사용할때 더 명확하게 무엇을 요구하는 지 알려줄 수 있다.)
func someFunction1(writeYourFirstNumber a:Int, writeYourSecondNumber b: Int) {
    print(a + b)
}

someFunction1(writeYourFirstNumber: 3, writeYourSecondNumber: 4)


아규먼트 레이블을 생략해서 사용하는 것도 가능 (와일드카드 패턴)
func addPrintFunction(_ firstNum: Int, _ secondNum: Int) {
    print(firstNum + secondNum)
}

addPrintFunction(1, 2)

#가변파라미터 - 함수의 파라미터에 정해지지 않은, 여러개의 값을 넣는 것도 가능(Variadic Parameters)
/**=============================================================
 - 1) 하나의 파라미터로 2개이상의 아규먼트를 전달할 수 있다.
 - 2) 아규먼트는 배열형태로 전달된다.
 - 3) 가변 파라미터는 개별함수마다 하나씩만 선언할 수있다.(선언 순서는 상관없음)
 - 4) 가변 파라미터는 기본값을 가질 수 없다.
===============================================================**/

func arithmeticAverage(_ numbers: Double...) -> Double {
    
    var total = 0.0
    
    for n in numbers {
        total += n
    }
    
    return total / Double(numbers.count)
}


//arithmeticAverage(5, 6, 7, 8, 9)

arithmeticAverage(1.5, 2.5, 3.5, 4.5)


#함수의 파라미터에 기본값(디폴트) 정하는 것도 가능
func numFunction(num1: Int, num2: Int = 5) -> Int {
    var result = num1 + num2
    return result
}


numFunction(num1: 3)
numFunction(num1: 3, num2: 7)



##아규먼트값이 항상 필요한 것이 아닐 수도 있다!
// 실제 애플이 미리 만들어 놓은 함수에는 기본값이 들어 있는 경우가 꽤 있다.

//print(<#T##items: Any...##Any#>, separator: <#T##String#>, terminator: <#T##String#>)

#####################################################################################2021.09.13
Part7 - Function
#함수(Function)
"특정한 작업(기능)"을 수행하는 코드의 묶음에 (식별할 수 있는 특정한) 이름을 부여하여 사용하는 것

// 함수(function)를 작성하는 방법(약속)

함수는 항상 2단계로 실행

// 1) 함수 정의문
func sayhello() {
    print("Hello, world!")
    print("Hello, Swift!")
    print("Hello, what's up, bro!")
}

// 2) 함수 실행문(call)
sayhello()

함수를 왜 사용할까? (함수 사용의 이유)
/**==================================================================
 - 1) 반복되는 동작을 단순화해서 재사용 가능
 - 2) 코드를 논리적 단위로 구분 가능
 - 3) 코드 길이가 긴 것을 단순화해서 사용 가능
 - 4) 미리 함수를 잘 만들어 놓으면, 개발자는 사용만 하면 됨(내부적 내용을 몰라도 사용 가능)
 ====================================================================**/

함수의 실행문(call)에 대한 인지
print("Hello")

sayhello()


소괄호 ( )는 함수의 실행이다!
// 소문자로 시작하고, 뒤에 () 소괄호(퍼렌서시스)가 오면 이것은 함수의 실행문이라는 것을 인지해야 함


#함수의 형태
함수가 인풋(input)이 있는 경우

// 함수 정의문
func saySomething(name: String) {
    print("안녕하세요 \(name) 님")
}


// 함수 실행문(call)
saySomething(name: "스티브")


var name = "Jobs"

saySomething(name: name)



함수가 아웃풋(output)이 있는 경우
// 아웃풋 앞에 return이라는 키워드를 사용해야 한다.

func sayHelloString() -> String {
    return "안녕하세요"
}

sayHelloString()

print(sayHelloString() + " 잡스 님")

// 함수를 호출하는 것도 표현식이 될 수 있다.(리턴형이 있는 경우)
// (표현식의 결과는 함수가 리턴하는 값)

var name1 = sayHelloString()


인풋과 아웃풋이 모두 있는 경우
// 함수 정의문
func plusFuntion(a: Int, b: Int) -> Int {
    let c = a + b
    return c       // 아웃풋이 있는 경우, 리턴키워드를 사용해야함
}

// 함수 실행문(call)
plusFuntion(a: 3, b: 4)

print(plusFuntion(a: 5, b: 6))

// 함수 정의문
func someFuntions(x: Int) -> Int {
    
    var y = 2 * x + 3
    
    return y
}


// 함수 실행문(call)
someFuntions(x: 2)


// 함수 정의문
func sayHello1(a: String) -> String {
    var say = "안녕 반가워. \(a)야. 나는 스위프트라고 해."
    return say
}


// 함수 실행문(call)
sayHello1(a: "아이유")

sayHello1(a: "GD")
print(sayHello1(a: "스티브잡스"))



// 함수 정의문
func number5() -> Int {
    return 5
}


// 함수 실행문(call)

number5()

print(number5())


#Void 타입의 이해 (아웃풋이 없는 경우)
func sayhello1() {
    print("Hello, Swift!")
}


func sayhello2() -> Void {
    print("Hello, Swift!")
}



func sayhello3() -> () {
    print("Hello, Swift!")
}

리턴 타입이 없는 함수(Void 타입) vs 리턴타입이 있는 함수의 차이 ⭐️

리턴 타입이 없는 함수 ➞ 결과는 Void 타입
sayhello1()         // 제어권

// 이렇게 사용하는 경우는 없음
//var hello: Void = sayhello1()

리턴 타입이 있는 함수 ➞ 결국 결과로 "값"이 있는 것 ➞ (일반적으로)사용
// 함수 자체를 값으로 볼 수 있음

print(sayHelloString())       // 제어권 + 결과값




#####################################################################################2021.09.12
반복문의 제어전송문(continue/ break)
제어전송문
반복문에서 쓰이는 제어전송문(Control Transfer Statement)

#1) continue
continue의 사용

for num in 1...20 {
    if num % 2 == 0 {   // num 2의 배수
        continue
    }
    print(num)
}

#2) break
break의 사용

for num in 1...20 {
    if num % 2 == 0 {
        break
    }
    print(num)
}

주의할점 - 중첩 사용시의 적용 범위
for i in 0...3 {
    print("OUTER \(i)")
    for j in 0...3 {
        if i > 1 {
            print("  j :", j)
            continue
            //break
        }
        print("  INNER \(j)")
    }
}

가장 인접한 범위의 반복문에 영향을 미침

#3) Labeled Statements

레이블이 매겨진 문장(Labeled Statements)과 continue, break의 사용

// 반복문을 중첩적으로 사용할때, 각 반복문에 이름을 붙여서, 가장 인접한 범위 이외의 반복문도 제어가능


OUTER: for i in 0...3 {
    print("OUTER \(i)")
    INNER: for j in 0...3 {
        if i > 1 {
            print("  j :", j)
            continue OUTER
            //break OUTER
        }
        print("  INNER \(j)")
    }
    
}
#####################################################################################2021.09.11_2
While / repeat_while
#2) while문
While문의 기본 형태

var sum = 0
var num = 1

while num <= 50 {   // 조건이 만족하는 동안 계속 반복
    sum += num
    num += 1      // 이런 조건이 필요 (위의 조건식을 변화시키지 않으면 무한 반복하게됨)
}
print("총 합의 출력: ", sum)
// 조건을 주의해서 짜야함

####무한반복(루프)을 주의####
/**============================================================
 for문과 비교
 - 1) 반복이 시작되기 전에, 반복 횟수가 정해져 있지 않을때 사용 (조건에 의해 반복)
 - 2) 조건이 거짓이 될 때까지 일련의 명령문 수행
     (반드시 while문 내부에서 조건을 변화시키는 일이 일어나야함)
==============================================================**/

3) repeat-While문
repeat-While문의 기본 형태
var i = 1

repeat {
    print("\(3) * \(i) = \(3 * i)")
    i += 1
} while i <= 9

// 일단 한번은 실행하고 나서, 조건을 판단해서 실행

// (조건(컨디션)이 마지막에 있음)
// 루프를 통과하는 각 패스의 끝 부분에서 조건을 평가

// (스위프트 이외의) 다른 언어에서는 do - while 문으로 명명


#while문과 repeat-While문의 차이
// 미세한 차이가 생길 수 있으므로 주의해서 사용해야 함

var number = 5
var sumOfNum = 0


while number < 5 {
    sumOfNum += number
    number += 1
}

number      // 5
sumOfNum    // 0


// 위와 차이가 생김
// repeat-while문은 코드를 먼저 실행한 다음 조건을 확인


number = 5
sumOfNum = 0

repeat {
    sumOfNum += number
    number += 1
} while number < 5

number      // 6
sumOfNum    // 5
#####################################################################################2021.09.11_1
For문 사용시 주의점
#for문 주의점
for문에서 선언하는 변수(상수)에 대한 정확한 이해

/**====================================================
 for문의 임시 상수
 - 1) for문이 진행되는 동안 사용이 되는 임시적인 상수(let)이다.
 - 2) for문에서 선언하는 변수(상수)는 for문 내에서만 사용이 가능하다.
======================================================= **/

var name = "홍길동"

for name in 1...5 {
    print(name)
}


for n in 1...5 {
    print(name)
}
//print(n)

/**===================================================
 일반적인 변수 (범위 - 스코프)
 - 1) for문 내부에서는 외부에 선언된 변수에는 접근이 가능하다.
 - 2) for문 내부에서 새롭게 선언한 변수에는 외부에서 접근이 불가능하다.
======================================================**/


var sum = 0

for i in 1...10 {
    sum += i
}
print(sum)



for index in 1...5 {
    print("For문 출력해보기: \(index)")
    print(name)
    var realName = "잡스"
    print(realName)
}

//print(realName)

#####################################################################################2021.09.11
Part6 - 반복문
#Part6 - Loops (반복문)
반복문의 종류
/**====================
- 1) For 반복문
- 2) While 반복문
     (1) while
     (2) repeat-while
=======================**/

1) for문
For문의 기본 형태
//스위프트 스타일의 문법은 직관적이고 쉽게 작성이 가능하도록 되어있음

for index in 1...5 {        //let index = 1, let index = 2, let index = 3, let index = 4, let index = 5
    print("For문 출력해보기: \(index)")
}


for index in 1...4 {
    print("\(index)에 5를 곱하면 \(index * 5)")
}
// 참고 >
// C언어/Java 스타일의 for 문 ====> 다른 언어들에 비해 엄청 읽기 쉽고 간결한 형태로 이루어짐

//for(int i = 0; i <= 5; i++) {
//
//}


// 이런 방식으로 많이 활용

var number = 10


for i in 1...number {
    print(i)
}

#참고) 와일드 카드 패턴
와일드 카드 패턴 _ (언더바)은 스위프트에서 생략의 의미!
for _ in 0...10 {
    print("hello")
}


let _ = "문자열"


(1...10).reversed()


let a = (1...10).reversed()

print(a)

#배열 등 컬렉션 타입에서도 사용 가능
// 컬렉션에서 각 아이템을 차례 차례 한번씩 뽑아서 중괄호 안에서 사용

let list = ["Swift", "Programming", "Language"]


for str in list {
    print(str)
}
// 뒤에서 배열 먼저 공부하고 와서 다시 보기


#문자열에서도 사용 가능
// 문자열에서 각 문자를 차례 차례 한개씩 뽑아서 중괄호 안에서 사용
for chr in "Hello" {
    print(chr)
    //print(chr, terminator: " ")     //다음줄로 넘어가지 말고, 한칸을 띄워라
}

#특정한 함수 활용 가능
// 역순으로 바꾸기

for number in (1...5).reversed() {
    print(number)
}

//홀수 또는 홀수만 뽑아내기
for number in stride(from: 1, to: 15, by:2) {     //마지막 숫자는 포함하지 않음
    print(number)
}

#stride: 성큼성큼 걷다.  //1~15까지인데, 2개씩 띄워서
let range = stride(from: 1, to: 15, by: 2)     //  StrideTo<Int>
print(range)
// 1, 3, 5, 7, 9, 11, 13
for i in range {
    print(i)
}

let range1 = stride(from: 1, through: 15, by: 2)     // StrideThrough<Int>
print(range1)
// 1, 3, 5, 7, 9, 11, 13, 15

for i in range1 {
    print(i)
}


let range2 = stride(from: 10, through: 2, by: -2)      //   StrideThrough<Int>
print(range2)
// 10, 8, 6, 4, 2

for i in range2 {
    print(i)
}
#####################################################################################2021.09.10_4
3) 패턴매칭 연산자(~=)
패턴매칭 연산자: 숫자가 범위내에 있는지 확인하는 연산자

let range = 1...10
range ~= 5
// 결과 값은 참과 거짓


10 <= n <= 100 이런 문장은 스위프트에서 성립하지 않는다.
var n = 20
if n >= 10 && n <= 100 {
    print("10이상, 100이하입니다.")
}

if 10...100 ~= n {
    print("10이상, 100이하입니다.")
}

연습
var age = 31


if 20...29 ~= age {
    print("20대 입니다.")
}




// 스위치문은 내부적으로 패턴매칭 연산잘로 구현이 되어있음


switch age {
case 20...29:
    print("20대 입니다.")
case 30...39:
    print("30대 입니다.")
default :
    break
}
#####################################################################################2021.09.10_3
#############################################범위연산자
2) 범위 연산자(Range Operators)
범위연산자: 스위프트에서 숫자의 범위를 간편하게 표시할때 사용

/**===================================================
// 아래의 숫자와 위의 숫자까지의 범위를 포함

// 자체가 특별한 타입으로 정의되어있고, 의미하긴 하지만
// 일반적으로 위와 같이 타입을 정의해서 사용하는 경우는 드물고,
// 1) 반복문(for문)    2) 배열    3) switch문
// 에서만 주로 활용하므로 위의 경우에 활용 방식을 이해하는 것이 더 중요

// 주의점>
// 내림차순 형식으로 표기 불가능  12...0
// 실수형식의 범위 표기도 가능하지만 사용하는 경우는 드뭄
=====================================================**/


let numbers = 1 ... 10


#Closed Range Operator(닫힌 범위연산자), One-Sided Ranges의 표기
let range = 1 ... 10     //ClosedRange<Int>

let range1 = 1...      //PartialRangeFrom<Int>

let range2 =  ...10    //PartialRangeThrough<Int>


// One-Sided 표기시에는 숫자와 범위연산자를 붙여서 써야함


#Half-Open Range Operator(반 개방 범위연산자), One-Sided Ranges의 표기
let rangeH = 1 ..< 10     //Range<Int>

let rangeH1 =  ..<10    //PartialRangeUpTo<Int>


// One-Sided 표기시에는 숫자와 범위연산자를 붙여서 써야함


#범위 연산자의 활용
for문과 함께 사용

for index in 1...5 {
    print("\(index) times 5 is \(index * 5)")
}


let names = ["Anna", "Alex", "Brian", "Jack"]
let count = names.count


for i in 0..<count {
    print("Person \(i + 1) is called \(names[i])")
}


for name in names[...2] {
    print(name)
}

#배열의 서브스크립트 문법과 함께 사용
names[...2]
names[..<1]

#switch문의 케이스에서 사용
var num = 23

switch num {
case 10...19:
    print("10대 입니다.")
case 20...29:
    print("20대 입니다.")
case 30...39:
    print("30대 입니다.")
default:
    print("그 외의 범위 입니다.")
}



let point = (1, 2)

switch point {
case (0, 0):
    print("(0, 0)은 원점 위에 있다.")
case (-2...2, -2...2):
    print("(\(point.0), \(point.1))은 원점의 주위에 있다.")
default:
    print("점은 (\(point.0), \(point.1))에 위치한다.")
}
#####################################################################################2021.09.10_2
Part5_삼항연산자와 범위연산자
#삼항연산자
1) 삼항 연산자(Ternary Conditional Operator)
기본 형태 / if문보다 조금은 한정적인 형태로 사용 가능

var a = 10

//if/else문

if a > 0 {
    print("1")
} else {
    print("2")
}
// 3항 연산자 (위의 if/else문과 완벽하게 동일)

=

a > 0 ? print("1") : print("2")
// 한줄인 경우
// 주로 값을 대입하는 경우 (주로 값에서 2가지에서 한가지를 선택하는 경우)

#조건에 따라 선택이 두가지인 경우 ➞ 삼항연산자를 떠올리자
사용 예시
var name = a > 0 ? "스티브" : "팀쿡"

//위는 아래와 같다..

if a > 0 {
    name = "스티브"
} else {
    name = "팀쿡"
}

###실제사용예시
let result = score >= 70? "pass" : "Fail"
#####################################################################################2021.09.10_1
Tuple and switch
#튜플의 매칭(Mathching)
let iOS = (language: "Swift", version: "5")

// 이런 코드를 아래의 스위치문을 이용하면 단순해짐
if iOS.0 == "Swift" && iOS.1 == "5" {
    print("스위프트 버전 5입니다.")
}

if iOS == ("Swift", "5") {
    print("스위프트 버전 5입니다.")
}

// 스위프트의 switch문은 튜플 매칭을 지원 ===> 코드를 단순한 형태로 표현 가능

switch iOS {
case ("Swift", "5"):
    print("스위프트 버전 5입니다.")
case ("Swift", "4"):
    print("스위프트 버전 4입니다.")
default:
    break
}

#튜플의 활용
// 튜플의 바인딩

var coordinate = (0, 5)   // 좌표계

switch coordinate {
case (let distance, 0), (0, let distance):   // x축이나 y축에 있으면 출력하라는 코드
    print("X 또는 Y축 위에 위치하며, \(distance)만큼의 거리가 떨어져 있음")
default:
    print("축 위에 있지 않음")
}



// 튜플의 where절 활용

coordinate = (5, 0)


switch coordinate {
case (let x, let y) where x == y:      //일단 x, y를 상수로 지정해주고, 그리고 나서 비교한다.
    print("(\(x), \(y))의 좌표는 y = x 1차함수의 그래프 위에 있다.")
    
case let (x, y) where x == -y:
    print("(\(x), \(y))의 좌표는 y = -x 1차함수의 그래프 위에 있다.")
    
case let (x, y):
    print("(\(x), \(y))의 좌표는 y = x, 또는 y = -x 그래프가 아닌 임의의 지점에 있다.")
}

#####################################################################################2021.09.10
Part4 - Tuple
#1) 튜플(Tuples)
2개이상의 연관된 데이터(값)를 저장하는 Compound(복합/혼합) 타입

// 특별하게 타입이 정해져 있지 않음
// 포함될 데이터 갯수를 마음대로 정의하기 나름

let twoNumbers: (Int, Int) = (1, 2)
//type(of: twoNumbers)

let threeNumbers = (1, 2, 5)
//type(of: threeNumbers)

var threeValues = ("홍길동", 20,  "서울")      // 멤버(데이터의 종류 및 갯수)는 튜플을 만들때 결정되므로 "추가"/"삭제" 불가
//type(of: threeValues)

연관된 값(튜플)의 각각의 데이터의 접근

threeValues.0
threeValues.1
threeValues.2

#Named Tuple(이름이 매겨진 튜플)
// 일반적으로 위처럼 사용하면, 혼동할 가능성이 큼

let iOS = (language: "Swift", version: "5")

iOS.0
iOS.1
// 코드의 가독성이 높아짐

iOS.language
iOS.version

#튜플의 분해(Decomposition)
// 튜플의 데이터 묶음을 각 한개씩 분해해 상수나 변수에 저장 가능


let (first, second, third) = threeNumbers
first
second
third
// 모아놓았던 데이터를 분해해서 사용하고 싶을 경우

#튜플의 값의 비교 - 실제 사용하는 경우는 흔하지는 않음
// 두개의 튜플 비교 가능 ===> 왼쪽 멤버부터 한번에 하나씩 비교하고, 같을 경우 다음 멤버를 비교함
// 튜플은 최대 7개 요소 미만만 비교 가능(애플의 라이브러리 기능)


(1, "zebra") < (2, "apple")   // true, 1이 2보다 작고; zebra가 apple은 비교하지 않기 때문
(3, "apple") < (3, "bird")    // true 왼쪽 3이 오른쪽 3과 같고; apple은 bird보다 작기 때문
(4, "dog") == (4, "dog")




("blue", -1) < ("purple", 1)            // 비교가능, 결과: true
//("blue", false) < ("purple", true)    // 에러발생 ===> Bool 값은 비교 불가능




#####################################################################################2021.09.09
#연습문제(가위바위보,랜덤빙고)
#가위바위보
// 조건
// 1) 가위 => 0
// 2) 바위 => 1
// 3) 보  => 2
var computerChoice = Int.random(in: 0...2)
var myChoice = 2

switch computerChoice {
case 0:
    print("컴은 가위.")
case 1:
    print("컴은 바위.")
case 2:
    print("컴은 보.")
default:
    break
}

switch myChoice {
case 0:
    print("나는 가위.")
case 1:
    print("나는 바위.")
case 2:
    print("나는 보.")
default:
    break
}

if myChoice == 0 {
    if computerChoice == 0 {
        print("비겼습니다.")
    }
    else if computerChoice == 1 {
        print("졌습니다.")
    }
    else if computerChoice == 2 {
        print("이겼습니다.")
    }
}
else if myChoice == 1 {
    if computerChoice == 0 {
        print("이겼습니다.")
    }
    if computerChoice == 1 {
        print("비겼습니다.")
    }
    if computerChoice == 2 {
        print("졌습니다.")
    }
}
else if myChoice == 2 {
    if computerChoice == 0 {
        print("졌습니다.")
    }
    if computerChoice == 1 {
        print("이겼습니다.")
    }
    if computerChoice == 2 {
        print("비겼습니다.")
    }
}



if myChoice == computerChoice {  // 무승부의 경우를 먼저 정의 ===> 이긴 경우 ===> 나머지
    print("무승부 입니다.")
} else if myChoice == 0 && computerChoice == 2 {
    print("당신이 이겼습니다.")
} else if myChoice == 1 && computerChoice == 0 {
    print("당신이 이겼습니다.")
} else if myChoice == 2 && computerChoice == 1 {
    print("당신이 이겼습니다.")
} else {
    print("당신은 졌습니다.")
}



#랜덤 빙고
var guest: Int = Int.random(in: 1...10)
var me: Int = 8

if guest > me {
    print("업")
} else if guest < me {
    print("다운")
} else {
    print("빙고")
}

#####################################################################################2021.09.08_2
#Switch문의 활용
스위치문과 밸류바인딩(Value Binding)
// 바인딩의 일반적인 의미
var a = 7
let b = a     // 바인딩을 한다. (다른 변수/상수의 새로운 식별자로 할당한다.)

바인딩: 다른 새로운 변수/상수 식별자로 할당

// 스위치문에서의 바인딩

var num = 6


switch num {
case let a:      // let a = num
    print("숫자: \(a)")
    default:
    break
}

스위치문과 where절 (스위치문에서 조건을 확인하는 방식)
// 일단 다른 상수 값에 바인딩한(넣은) 후, 조건절(참/거짓 문장)을 통해 다시 한번 더 조건 확인
// (바인딩 된 상수는 케이스블럭 내부에서만 사용가능하고, 상수 바인딩은 주로 where절하고 같이 사용됨)

num = 7

switch num {
case let x where x % 2 == 0:      // let x = num
    print("짝수 숫자: \(x)")
case let x where x % 2 != 0:
    print("홀수 숫자: \(x)")
default:
    break
}



switch num {
case let n where n <= 7:         // let n = num
   print("7이하의 숫자: \(n)")
default:
   print("그 이외의 숫자")
}



switch num {
case var x where x > 5:       // 변수로 바인딩도 가능 var x = num
    x = 7
    print(x)
default:
    print(num)
}



// where절은 대부분 밸류바인딩 패턴과 함께 사용 (여러 강의에서 또 다룰 예정)
where키워드는 조건을 확인하는 키워드
#####################################################################################2021.09.08_1
조건문(Switch)
2) Switch문
표현식/변수를 (매칭시켜) 분기처리할때 사용하는 조건문
if문보다 한정적인 상황에서 사용

var choice: String = "안녕하세요"


// 조건을 부등식이 아닌 "=="와만 비교
// 변수가 어떤값을 가지냐에 따라 실행문을 선택하고 진행


switch choice {   // 변수(표현식)
case "가위":       // "가위" == "가위"
    print("가위 입니다.")
case "바위":
    print("바위 입니다.")
case "보":
    print("보 입니다.")
default:
    break
}


/**=======================================================
 [스위치문의 특징]
 - 1) 스위치문에서 케이스의 ,(콤마)는 또는의 의미로 하나의 케이스에
      여러 매칭값을 넣을 수 있음
 - 2) switch 문은 (비교하고 있는)값의 가능한 모든 경우의 수를 반드시
      다루어야 함 (exhaustive: 하나도 빠뜨리는 것 없이 철저한)
      모든 사례를 다루지 않았을 때에는 디폴트 케이스가 반드시 있어야 한다.
 - 3) 각 케이스에는 문장이 최소 하나 이상 있어야 하며 만약 없다면 컴파일
      에러 발생(의도하지 않은 실수를 방지 목적)
      실행하지 않으려면, break를 반드시 입력해야함 (if문에서는 실행문을
      입력안해도 괜찮지만, 스위치문에서는 필요함)
=========================================================**/

switch choice {  // 문자열
case "가위":
    print("가위 입니다.")
case "바위", "보":
    print("바위 또는 보 입니다.")
default:
    break
}


var isTrue = true

switch isTrue {
case true:
    print("true")
case false:
    print("false")
}

#fallthrough 키워드의 사용
var num1 = 10

switch num1 {
case ..<10:
    print("1")        // 매칭된 값에 대한 고려없이 무조건 다음블럭을 실행함
    fallthrough
case 10:
    print("2")
    fallthrough
default:
    print("3")
}


#switch문의 범위 매칭 - 패턴 매칭 연산자와 관련
// ⭐️ 잘못 작성된 예시 =====================


// 비교연산자와 값을 넣으면 안되고, 비교하려는 값이 와야함

//switch temperature {
//case  < 0 :    //이런식으로 작성하면 안된다. ==>   ..<0
//    print("영하 - 0미만")
//case >= 0 && <= 18 :     //이런식으로 작성하면 안된다. ==>   0...
//    print("0이상 무덥지 않은 날씨")
//default :
//    break
//}





// 부등식을 사용될 수 없는 대신에, 범위 매칭을 지원


var num = 30



// ⭐️ 범위연산자, 패턴매칭 연산자 (참과 거짓의 결과가 나옴)

0...50 ~= num
51...100 ~= num




switch num {
case 0...50:      // 0...50 ~= 30 내부적으로 패턴매칭으로 확인
    print("숫자의 범위: 0 ~ 50")
case 51...100:
    print("숫자의 범위: 51 ~ 100")
default:
    print("그 외의 범위")
}




var temperature = 19

switch temperature {
case ..<0:
    print("영하 - 0도 미만")
case 0...18:
    print("0도 이상 무덥지 않은 날씨")
case 19...:
    print("여름 날씨")
default:
    break
}


##########이해보다는 여러번 안보고 직접 작성해보는 것이 중요 ⭐️##############
#####################################################################################2021.09.08
Part3 - 프로그래밍의 기본 원리와 조건문
#1) 조건문(if문)
참(true) 또는 거짓(false)의 특정 조건에 따라 특정 코드만 실행하게 할 수 있는 문장

// 조건문 (if문)
var number = 10
if number <= 10 {
    print("10보다 작거나 같다.")

"조건"의 자리에는 결과가 참 또는 거짓이 나와야함

// 조건문(if - else)
number = 20

if number <= 10 {
    print("10보다 작거나 같다.")
} else {
    print("10보다 크다.")
}

// if - else if - else
number = 40

if number <= 10 {
    print("10보다 작거나 같다.")
} else if number >= 30 {
    print("30보다 크거나 같다.")
} else {
    print("10보다 크고 30보다 작거나 같다.")
}


// if - else if
number = 72

if number <= 10 {
    print("10보다 작거나 같다.")
} else if number >= 30 {
    print("30보다 크거나 같다.")
}

1) if문에서 논리적인 구조 및 조건의 순서가 중요

// 논리적인 오류 없도록 구성해야함 ==========
var num = 8

if num >= 0 {
    print("0 또는 양수입니다.")
} else if num % 2 == 0 {
    print("양의 짝수입니다.")
} else if num % 2 == 1 {
    print("양의 홀수입니다.")
} else {
    print("음수입니다.")
}



// 올바르게 수정해 본다면? ================
if num >= 0 {
    print("0 또는 양수입니다.")
    
    if num % 2 == 0 {
        print("짝수입니다.")
    } else if num % 2 == 1 {
        print("홀수입니다.")
    }
    
} else {
    print("음수입니다.")
}


// 조건의 확인 순서를 잘 고려해야함 ==========
var score = 100


if score >= 70 {
    print("70점이상입니다.")
} else if score >= 80 {
    print("80점이상입니다.")
} else if score >= 90 {
    print("90점이상입니다.")
} else {
    print("70점미만입니다.")
}


// 올바르게 수정해 본다면 ================
if score >= 90 {                // 범위가 작은 조건이 먼저 와야함
    print("90점이상입니다.")
} else if score >= 80 {
    print("80점이상입니다.")
} else if score >= 70 {
    print("70점이상입니다.")
} else {
    print("70점미만입니다.")
}

2)조건을 &&(and), 또는 ||(or)로 연결하는 것도 가능
var email = "a@gmail.com"
var password = "1234"

if email == "a@gmail.com" && password == "1234" {
    print("메인페이지로 이동")
}


if email != "a@gmail.com" || password != "1234" {
    print("경고메세지 띄우기")
    print("이메일주소 또는 패스워드가 올바르지 않습니다.")
}


3)중첩 사용 가능
var score1 = 81;

if score1 >= 70 {
    
    if score1 == 100 {
        print("만점")
    } else {
        print("70점이상")
    }
    
}
프로그래밍에서는 타입만 일치하면 언제든지 중첩이 가능(2중, 3중 상관없음)



참고 - 접근 연산자 (.)
// 한식.볶음밥.당근

// 중식.짜장면.춘장

var id = "abc"

id.count

"abcdef".count


id.isEmpty

id.dropFirst()


조건문(if문)의 활용
언제 사용할까? 활용예시
// 사용자의 아이디가 일치하고, 비밀번호도 일치 한다면
// 입력된 아이디의 글자수가 6자리 이상이라면

if id.count >= 6 {          //  .count는 내장된 기능 (지금은 몰라도 됨)
    print("아이디가 6글자 이상이네요. 다음 화면으로 넘어가겠습니다.")
}



// 가위 / 바위 / 보
var choice = 1    // 0: 가위, 1: 바위, 2: 보

if choice == 0 {
    print("가위입니다.")
} else if choice == 1 {
    print("바위입니다")
} else if choice == 2 {
    print("보입니다.")
}

#####################################################################################2021.09.07_4
기본연산자(Basic Operators)
Part2 - 기본연산자(Basic Operators)
#1) 연산자 기초
연산자 기초: 연산자란? 연산자의 종류
/**=======================================================================
 연산자(operator)
 - 값을 검사, 바꾸거나, 또는 조합하기 위해 사용하는 특수한 ‘기호(symbol)’나 ‘구절(phrase)’임
 
 [피연산자의 갯수에 따른 연산자의 구분]
 - 1.단항연산자: 단일 대상의 바로 앞 또는 바로 뒤에 위치하는 연산자
     (예시) -a ; +b ; !a ; a... 등이 존재
 - 2.이항연산자: 두개의 대상의 가운데 위치하여 검사 및 계산. (대부분 이항연산자 형태로 사용)
     (예시) a + b ; a - b ; a >= b
 - 3.삼항영산자: 세개의 대상을 조합하여 특수한 계산을 함. (단 한가지의 삼항연산자가 존재)
     (예시) a ? b : c
==========================================================================**/

#2) 기본 연산자
할당 연산자(Assignment Operator)
// 할당연산자: 오른쪽의 값을 왼쪽에 대입
// (왼쪽의 값을 오른쪽의 값으로 초기화 하거나 업데이트 함)
let num2 = 10
var num1 = 5
num1 = num2 //같다가 아니라 -> num2를 num1에 넣는다
print(num1) // num1 = 10


산술 연산자(Arithmetic Operator): 사칙 연산 등 기본적으로 스위프트에 내장되어 있는 기능
/**====================================
 [산술 (이항) 연산자]
 - + : 더하기 연산자      (단항 사용도 가능: +a)
 - - : 빼기 연산자       (단항 사용도 가능: -a)
 - * : 곱하기 연산자(별표)
 - / : 나누기 연산자(슬래시)
 - % : 모듈로(나머지) 연산자 ⭐️
=======================================**/

var a = 456
var b = 123

a + b
a - b
a * b

// ================================

b / a   // 몫 구하기(정수끼리) 반대로 말하면 몫을 구하는 연산자이다
b % a   // 나머지 구하기(정수끼리)
모듈로(%)연산자:  비전공자에게 익숙하지 않지만, 정말 많이 사용하는 개념 ⭐️

모듈로(%)의 사용 (🔸 Int 일때만 사용) ➞ 주로 사용하는 패턴의 예시
// 1) 첫번째 패턴
var yourWatchingTime: Int = 70  // 70분, ====> (예) 1시간 10분

var hour = yourWatchingTime / 60
var minute = yourWatchingTime % 60

print("당신은 \(yourWatchingTime)분. 즉, 총 \(hour) 시간 \(minute) 분을 시청 하셨습니다.")


// 2) 두번째 패턴 (감만 익히기)
var num = 100

var array = ["1", "2", "3"]        // 배열이라는 것 (뒤에서 자세히 배움)
array[0] // = "1"
array[num % 3] // 0, 1, 2



#나누기 사용은 항상 주의
프로그래밍에서 나누기 사용은 항상 주의 (한번 더 생각!)
a = 4
b = 5

var newResult: Double

//newResult = a / b

newResult = Double(a / b) // 0

newResult = Double(a) / Double(b) // 0.8


#사칙연산 및 모듈로 사용 연습
let a1 = 6
let b1 = 2
var result: Int

result = a1 + b1
print(result)

result = a1 - b1
print(result)

result = a1 * b1
print(result)

result = a1 / b1
print(result)

result = a1 % b1
print(result)


#복합 할당 연산자(Compound Assignment Operators)
var value = 0


//value = value + 10
value += 10

//value = value - 5
value -= 5

//value = value * 2
value *= 2

//value = value / 2
value /= 2

//value = value % 2
value %= 2

//value++    //다른 언어에서 1을 증가시키는 방법(스위프트에서 지원하지 않음)
//스위프트에서의 올바른 방식
value += 1


#비교연산자(Comparison Operators): 결과적으로 문장의 평가값은 참/거짓으로 도출
a = 456
b = 123

// 같다(Equal to operator)
a == b

// 같지 않다(Not equal to operator)
a != b

// 크다(Greater than operator)
a > b

// 크거나 같다(Greater than or equal to operator)
a >= b

// 작다(Less than operator)
a < b

// 작거나 같다(Less than or equal to operator)
a <= b

var c = (b == 123) // = true, = var c: Bool = true
// if문 하고 결합되어서 주로 사용

#논리 연산자(Logical Operators)
// ⭐️ Logical NOT Operator = 결과를 뒤집는 연산자(참이면 거짓, 거짓이면 참)
!true
!false

// Logical AND Operator(앤드, 그리고) = $$
true && true
true && false
false && true
false && false

// Logical OR Operator(또는) = ||
true || true
true || false
false || true
false || false


// 아이디도 6자리 이상이고, 비밀번호도 6자리 이상이다.


c = !true


#연산(계산)의 우선순위(Precedence) 지정 / 기본적으로 곱하기 우선
1 + 2 * 3 + 3
1 * (2 - 3)

/**===================================
 연산의 우선순위
 - 1. * /  %         곱하기/나누기/모듈로(나머지)
 - 2. + -              더하기/빼기
 - 3. <=  >  ==  !=    비교
 - 4. &&  ||           논리
 - 5. 삼항연산자
 - 6. = +=             할당, 복합할당
 ===================================*/

// 연산의 우선 순위 참고
// https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations
연산자에는 더 깊은 여러가지 개념이 있으나, 심화(Advanced Operators)에서 다룰예정


#2)접근연산자
접근연산자 - (.)점
//하위개념 ex)한식.김치볶음밥.김치

Int.random(in: 1...3)

var number = Int.random(in: 1...5)


var name = "스티브"

print(name.count)

#####################################################################################2021.09.07_3
프로그래밍 관련 용어 정리
#1) 키워드(Keyword)
약속어 (스위프트에서 특별한 의미로 사용하겠다고 미리 정해놓은 단어)
//var
//let
//if
//true

#2) 리터럴(Literals)
코드에서 고정된 값으로 표현되는 문자 (데이터) 그 자체(Int / Double / String / Character / Bool 리터럴 등)
var a = 4    // "오른쪽에는 정수 4를 넣었다."라고 할 수도 있지만, "오른쪽에는 할당하기 위해 <정수 리터럴>값인 정수4를 넣었다."

var b: Int = 8

var name = "홍길동"      // "문자열 리터럴" 값을 넣어야해.

var double = 3.14      //  "더블 리터럴" 값 3.14

"안녕"

4.5

#3) 식별자(Identifier)
변수, 상수, 함수, 사용자 정의 타입의 이름
var name1 = "전지현"
let name2 = "임꺽정"

#4) 토큰(Token)
코드의 가장 작은 단위: 코드에서 더이상 쪼갤 수 없는 최소의 단위 (식별자, 키워드, 구두점, 연산자, 리터럴)
//var
//!=
//123
// 토큰은 사이에 빈칸을 추가해선 안됨. (다만, 빈칸을 없애는 것은 때때로 괜찮음)
// 프로그래밍에서는 줄바꿈/탭도 빈칸(공백)으로 인식함. 즉, 빈칸이 여러개 띄어있어도 컴퓨터가 인식하기에는 1개의 빈칸으로 봄
//var aaa = 5

#5) 표현식(Expression)
값, 변수, 연산자의 조합으로 하나의 결과값으로 평가되는 코드 단위
// 하나의 값이 나오는 코드

var n = 5   //       ====> 문 장 (할당하는 작업)

17          // 17    ====> 표현식

n           // 5     ====> 표현식

n + 7       // 12    ====> 표현식

n < 5      // false  ====> 표현식

#6) 문장(Statement)
문장 또는 구문: 특정작업을 실행하는 코드 단위
var n2 = 3    // ====> 문장

print(n)      // ====> 문장

print("안녕")  // ====> 문장

// 토큰(키워드) + 표현식(값) ====> 문장(작업을 명령)
#####################################################################################2021.09.07_2
변수(Variable)/데이터타입_타입_Alias
타입애일리어스(Type Alias)
별칭 붙이기

// 기존에 선언되어있는 타입에 새로운 별칭을 붙여 코드 가독성을 높이는 문법
// (수학에서 치환과 유사)


// 왼쪽에 치환된 별칭이 위치
typealias Name = String



// Name타입이 의미하는 것은 String과 완전히 동일
let name: Name = "홍길동"



// 스위프트에서는 어떤 형태든 치환이 가능

typealias Something = (Int) -> String


func someFunction(completionHandler: (Int) -> String) {
 
}


func someFunction2(completionHandler: Something) {
 
}

#####################################################################################2021.09.07_1
변수(Variable)/데이터타입_타입
#변수 선언의 정식 문법
변수의 선언과 저장
var a: Int = 3     // 변수를 선언하면서 저장      (메모리 공간을 먼저 생성하는 동시에 데이터를 저장)

#스위프트의 데이터타입(Data Types)
1) 데이터 타입(Data Types)의 이해
타입이 왜 필요할까?
// 타입(Type) ?
// 컴퓨터는 사람의 뇌와 다르다.
데이터를 얼마 만큼의 크기, 그리고 어떤 형태로 저장할 것인지에 대해 약속이 필요
var i: Int = 4
var j: Int = 3

//i = 3.4       // 소수점 타입 할당이 안됨

var k = i + j
print(k)
// 타입은 메모리 공간의 크기와 연관이 있다.

###스위프트(Swift)의 데이터 타입
wift에서 사용하는 데이터타입
- 1) Int: 정수(Integer) 🔸
- 2) Float: 실수(부동소수점) Floating-point Number  6자리 소수점
- 3) Double: 실수(부동소수점) 15자리 소수점 🔸
- 4) Character: 문자(글자 한개)
- 5) String: 문자열 🔸
- 6) Bool: 참과 거짓 🔸
- 7) 기타: UInt, UInt64, UInt32, UInt16, UInt8:  0, 그리고 양의 정수

// Int : ... -5 -4, -3, -2, -1, 0, 1, 2, 3, 4, 5 ...
// Double: ... -3.145673, ... ,-2.2315, ... , 0 , ... , 0.453255, ..., 7.45678, ...


var b: Int = 7

var c: Double = 3

let chr: Character = "1"
type(of: chr)           // 타입을 확인하는 방법



//let chr2: Character = "aa"


let chr3: Character = " "      // 빈문자는 에러발생 그러나 공백문자는 가능


let str: String = ""   // 빈문자열 저장가능


let str1: String = "안녕하세요"


#2) 타입 주석(Type Annotation)
변수를 선언하면서, 타입도 명확하게 지정하는 방식

var number: Int      //  1) 변수를 선언 (타입 선언)     (메모리 공간을 먼저 생성하고,
number = 10          //  2) 값을 저장 (초기화)          데이터를 저장)

print(number)        //  3) 값을 읽기


// 자료형을 명확하게 지정

var a1: Int = 3
var b1: Int = 4

// 타입 선언과 초기화

var value: Double = 5.345

value = 12.3    //값 바꾸기

var value2 = value

#3) 타입 추론(Type Inference)
타입을 지정하지 않아도, 컴파일러가 타입을 유추해서 (알아서 알맞는 타입으로 저장하는) 방식
// 값을 보고, 어떤 타입인지를 컴파일러가 추론해서 사용함

var name = "홍길동"
type(of: name)

var num1 = 2
var num2 = 1.2
var num3: String = "Hello"
var num4 = true

type(of: num1)

#4) 타입 안정성(Type Safety)
스위프트는 데이터 타입을 명확하게 구분하여 사용하는 언어
스위프트는 다른 타입끼리 계산할 수 없다.

let num5 = 7
//let num6: Double = num5   //호환되지 않음(메모리 공간의 크기가 다름)


let d = 12
let e = 3.14

//let result = d + e   //정상적인 계산 불가능


//  소수 + 정수를 더 할 수 없다.
// "안녕" + 5 를 더할 수 없다.

#5) 타입(형) 변환(Type Conversion)
타입을 변환해서 사용할 수 있는 방법은 있다!

//기존에 메모리에 저장된 값을 다른 형식으로 바꿔서, 새로운 값을 생성해서 다른 메모리 공간에 다시 저장


let str2 = "123"
let number1 = Int(str2)

print(number1)


let str3 = "123.4"
let number2 = Int(str3)           // 타입컨버전이 실패했을 때 ====> nil(값이 없음)이 리턴될 수 있다.

print(number2)

let n = 2
let n2 = Double(n)

print(n2)


let n3: Int = Int(2.4)
print(n3)

#####################################################################################2021.09.07
변수(Variable)/데이터타입_변수와 상수
Part1 - 변수와 상수
1) 변수(Variables)
변수의 의미
프로그램 동작의 첫번째 단계 ➞ 메모리에 값(데이터)을 저장 (변수)

var a = 3     // 변수를 선언하면서 저장, 왼쪽에 저장
var b = 7

b = 9
b = b + 2

var c = a + b

print(a + b)
//print(c)

// 변수를 여러개 한꺼번에 선언하는 방법: ,(콤마)로 연결
var x = 1, y = 2, z = 3

// 새로운 공간을 만들고 값을 복사(Copy)해서 저장

var newRoom = b

#변수의 이름 / 이름 짓기 규칙
var nameOfYou = "임꺽정"
var realName = "쾌걸조로"

// 변수의 이름은 소문자로시작(대문자로 시작하는 것은 권장하지 않음), 중간에 숫자들어가는 것은 Ok. (숫자를 첫글자로 시작하는 것은 금지)

var π = 3.1415926
var 你好 = "你好世界"
var 🐶🐮 = "dogcow"
var 변수 = "안녕하세요"


// 특수문자, 한자, 한글 등 사용가능 하지만, 관습적으로 잘 사용하지는 않음

var number1 = 5
var number2 = 7
var number3 = number1 + number2

number3

print(number3)


#변수는 실제 어떻게 사용될까?
var name = "홍길동" //글자를 넣을땐 "..."
var age = 20
var address = "서울 강남구"

//print(name, age)
//print(name, age, address)

name = "전지현"

print(name, age)


print("저의 이름은 \(name)입니다.") //변수를 출력하기 위한 약속 \() <- 스트링인터폴레이션:문자열 보간법

age = 30

// 사용 예시
print("저의 이름은 \(name)입니다. 저의 나이는 \(age)살 입니다. 그리고 \(address)에 살고 있습니다.")


#String Interpolation(스트링 인터폴레이션): 문자열 보간법
// "\(삽입할변수)" ➡︎ 문자열 중간에 삽입할때 사용


2) 상수(Constants)
상수의 의미 (변하지 않는 데이터)
//var = 변수(variable) mutable
//let = 상수(constants) immutable

let name2 = "김철수"

name2
//name2 = "이나영"

print(name2)

// 변수와 상수를 통틀어, 변수(저장된 데이터라는 관점에서)라고 일반적으로 부르기도 함

#####################################################################################2021.09.06_1
본격적인 수업에 앞서 사전 준비
Programming Basic
1) ⭐️ 프로그래밍에서 사용하는 = (등호)의 의미
제 1원칙
프로그래밍에서 사용하는 = (equal)은 할당의 의미이다. (할당연산자)

//: >  = (등호)는 같다는 뜻이 아니다.
// = (등호)를 기준으로 오른쪽에 있는 무언가를 왼쪽에 담는다는 의미(할당)

var a = 5

a = a + 7
// 프로그래밍에서 같다는 것은 == 를 사용
// ==  (같다)
// !=  (같지 않다)


2) 대문자와 소문자의 엄격한 구분
대부분의 첫글자는 소문자로 시작한다. (예외적으로 대문자 시작)

// 중간에는 대문자/숫자가 쓰일 수 있다. 다만, 시작은 소문자
// 캐멀케이스(camel: 낙타)

var nameOfYou = "홍길동"


3) 키워드(Keyword)
약속어 (스위프트에서 특별한 의미로 사용하겠다고 미리 정해놓은 단어)

// 약 70여개의 키워드 존재
// 참고 https://www.tutorialkart.com/swift-tutorial/swift-keywords/
// 키워드는 다른 의미로 사용 불가능

//var
//func
//if


4) 주석(Comment)
컴퓨터가 코드를 읽지 않아도 된다고(무시해도 된다고) 알려주는 부분
//  : 한 줄 주석,  /* */ : 여러줄 주석, 단축키 commd+/

print("Hello, Swift!")
//print("Hello, Swift!")
// 여기는 주석을 표시하고 있습니다.
/*
 print("Hello, Swift!")
 print("Hello, world!")
 */
/* 저도 이제 개발자가 되고 싶어요
 개발자가 되는 방법을 알려주세요. */

5) 세미콜론(;)규칙 (Semicolon)
스위프트(Swift)에서 각 라인의 마지막에 붙는 세미콜론(;)은 선택사항
//  (대부분의 프로그래밍 언어는 세미콜론 필수)이지만  swift는 사용x
//  하나의 라인에 여러가지 명령문을 사용하고 싶을 경우에는 필수

var name = "스위프트"
print("Hello, world")

//print("안녕"); print("드디어"); print("스위프트 공부를 시작한다.");
//print("");
//print("");
//print("");


#####################################################################################2021.09.06
Inflearn_Allen Swift
CS101
컴퓨터의 동작원리
CPU와 RAM
메모리의 저장방식
메모리에서 음수의 표현

#####################################################################################2021.09.05
geocoding

//파라미터로 전달된 좌표를 주소문자열로 바꾸는걸 지오코딩이라고 한다
//1. 주소를 좌표로 지오코딩,포워드지오코딩 2. 좌표를 주소로 리버스지오코딩

//
//  LocationManager.swift
//  KXCWeatherApp
//
//  Created by 송결 on 2021/09/04.
//

import Foundation
import CoreLocation

class LocationManager: NSObject {
    static let shared = LocationManager()
    private override init() {
        manager = CLLocationManager()
        manager.desiredAccuracy = kCLLocationAccuracyKilometer
        
        super.init()
        
        manager.delegate = self
    }
    
    let manager: CLLocationManager
    
    var currentLocationTitle: String?
    
    func updateLocation() {
        let status: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            status = manager.authorizationStatus
        } else {
            status = CLLocationManager.authorizationStatus()
        }
        
        switch status {
        case .notDetermined:
            requestCurrentLocation()
        case .authorizedAlways, .authorizedWhenInUse:
            requestCurrentLocation()
        case .denied, .restricted:
            print("not available")
        default:
            print("unknown")
        }
    }
}
extension LocationManager: CLLocationManagerDelegate {
    private func requestAuthorization() {
        manager.requestWhenInUseAuthorization()
    }
    
    private func requestCurrentLocation() {
        //manager.startUpdatingLocation()
        manager.requestLocation()
    }
    
    private func updateAddress(from location: CLLocation) {
    //파라미터로 전달된 좌표를 주소문자열로 바꾸는걸 지오코딩 -> 1. 주소를 좌표로 지오코딩,포워드지오코딩 2. 좌표를 주소로 리버스지오코딩
            let geocoder = CLGeocoder()
        geocoder.reverseGeocodeLocation(location) { [weak self] (placemarks, error) in
            if let error = error {
                print(error)
                self?.currentLocationTitle = "Unknown"
                return
            }
    
            if let placemark = placemarks?.first {
                if let gu = placemark.locality, let dong = placemark.subLocality {
                    self?.currentLocationTitle = "\(gu) \(dong)"
                } else {
                    self?.currentLocationTitle = placemark.name ?? "Unknown"
                }
            }
            print(self?.currentLocationTitle)
        }
    }
    
    @available(iOS 14.0, *)
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        switch manager.authorizationStatus {
        case .authorizedAlways, .authorizedWhenInUse:
            requestCurrentLocation()
        case .notDetermined, .denied, .restricted:
            print("not available")
        default:
            print("unknown")
        }
    }
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status:
                            CLAuthorizationStatus) {
        switch status {
        case .authorizedAlways, .authorizedWhenInUse:
            requestCurrentLocation()
        case .notDetermined, .denied, .restricted:
            print("not available")
        default:
            print("unknown")
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        print(locations.last)
        
        if let location = locations.last {
            updateAddress(from: location)
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    
    }
}
```

#####################################################################################2021.09.04_1
Double+Formatter
import Foundation

fileprivate let temperatureFormatter: MeasurementFormatter = {
    let f = MeasurementFormatter()
    f.locale = Locale(identifier: "ko_kr")
    f.numberFormatter.maximumFractionDigits = 1
    f.unitOptions = .temperatureWithoutUnit
    return f
    
}()

extension Double {
    var temperatureString: String {
        let temp = Measurement<UnitTemperature>(value: self, unit: .celsius)
        return temperatureFormatter.string(from: temp)
    }
}

#####################################################################################2021.09.04
import UIKit
import CoreLocation

class ViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let location = CLLocation(latitude: 37.498206, longitude: 127.02716)
        WeatherDataSource.shared.fetch(location: location) {
            self.listTableView.reloadData()
        }
        
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell", for: indexPath) as! SummaryTableViewCell
            
            if let weather = WeatherDataSource.shared.summary?.weather.first, let main = WeatherDataSource.shared.summary?.main {
                cell.weatherImageView.image = UIImage(named: weather.icon)
                cell.StatusLabel.text = weather.description
                cell.minMaxLabel.text = "최고 \(main.temp_max.temperatureString) 최소 \(main.temp_min.temperatureString)"
                cell.currentTemperatureLabel.text = "\(main.temp.temperatureString)"
            }
            
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as! ForecastTabelViewCell
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
}


#####################################################################################2021.09.03
Step15. 현재 날씨 출력
Step16. 예보출력

#####################################################################################2021.09.02_2
Step14. 날씨 데이터 소스 구현
import Foundation
import CoreLocation

class WeatherDataSource {
    static let shared = WeatherDataSource()
    private init() { }
    
    var summary: CurrentWeather?
    var forecast: Forecast?
    
    let apiQueue = DispatchQueue(label: "ApiQueue", attributes: .concurrent)
    
    let group = DispatchGroup()
    
    func fetch(location: CLLocation, completion: @escaping () -> ()) {
        group.enter()
        apiQueue.async {
            self.fetchCurrentWeather(location: location) { (result) in
                switch result {
                case .success(let data):
                    self.summary = data
                default:
                    self.summary = nil
                }
                
                self.group.leave()
            }
        }
        
        group.enter()
        apiQueue.async {
            self.fetchForecast(location: location) { (result) in
                switch result {
                case .success(let data):
                    self.forecast = data
                default:
                    self.forecast = nil
                }
                
                self.group.leave()
            }
        }
        
        group.notify(queue: .main) {
            completion()
        }
    }
}


extension WeatherDataSource {
    private func fetch<ParsingType: Codable>(urlStr: String, completion: @escaping (Result<ParsingType, Error>) -> ()) {
    guard let url = URL(string: urlStr) else {
        //fatalError("URL 생성 실패")
        completion(.failure(ApiError.invalidUrl(urlStr)))
        return
    }

    let task = URLSession.shared.dataTask(with: url) { (data,response, error) in

        if let error = error {
            //fatalError(error.localizedDescription)
            completion(.failure(error))
            return
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            //fatalError("invalid response")
            completion(.failure(ApiError.invalidResponse))
            return
        }

        guard httpResponse.statusCode == 200 else {
            //fatalError("failed code \(httpResponse.statusCode)")
            completion(.failure(ApiError.failed(httpResponse.statusCode)))
            return
        }

        guard let data = data else {
            //fatalError("empty data")
            completion(.failure(ApiError.emptyData))
            return
        }

        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(ParsingType.self, from: data)
            
            completion(.success(data))
           
        } catch {
            completion(.failure(error))
            //print(error)
            //fatalError(error.localizedDescription)
            }

        }
    task.resume()

    }
   private func fetchCurrentWeather(cityName: String, completion: @escaping (Result<CurrentWeather,Error>) -> ()) {
        let urlStr = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=\(apiKey)&units=metric&lang=kr"
        
        fetch(urlStr: urlStr, completion: completion)
        
    }

    private func fetchCurrentWeather(cityId: Int, completion: @escaping (Result<CurrentWeather,Error>) -> ()) {
        let urlStr = "http://api.openweathermap.org/data/2.5/weather?id=\(cityId)&appid=\(apiKey)&units=metric&lang=kr"
        
        fetch(urlStr: urlStr, completion: completion)
    }

    private func fetchCurrentWeather(location: CLLocation, completion: @escaping (Result<CurrentWeather,Error>) -> ()) {
        let urlStr = "http://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&units=metric&lang=kr"
        
        fetch(urlStr: urlStr, completion: completion)
    }
}


extension WeatherDataSource {
   private func fetchForecast(cityName: String, completion: @escaping (Result<Forecast,Error>) -> ()) {
        let urlStr = "http://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=\(apiKey)&units=metric&lang=kr"
        
        fetch(urlStr: urlStr, completion: completion)
        
    }

   private func fetchForecast(cityId: Int, completion: @escaping (Result<Forecast,Error>) -> ()) {
        let urlStr = "http://api.openweathermap.org/data/2.5/forecast?id=\(cityId)&appid=\(apiKey)&units=metric&lang=kr"
        
        fetch(urlStr: urlStr, completion: completion)
    }

   private func fetchForecast(location: CLLocation, completion: @escaping (Result<Forecast,Error>) -> ()) {
        let urlStr = "http://api.openweathermap.org/data/2.5/forecast?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=\(apiKey)&units=metric&lang=kr"
        
        fetch(urlStr: urlStr, completion: completion)
    }
}



#####################################################################################2021.09.02_1
Step13. 예보 API#2
import UIKit
import CoreLocation

struct Forecast: Codable {
    let cod: String
    let message: Int
    let cnt: Int
    
    struct ListItem: Codable {
        let dt: Int
        struct Main: Codable {
            let temp: Double
        }
        
        let main: Main
        
        struct Weather: Codable {
            let description: String
            let icon: String
        }
        let weather: [Weather]
    }
    
    let list: [ListItem]
    
}


enum ApiError: Error {
    case unknown
    case invalidUrl(String)
    case invalidResponse
    case failed(Int)
    case emptyData
}

func fetch<ParsingType: Codable>(urlStr: String, completion: @escaping (Result<ParsingType, Error>) -> ()) {
    guard let url = URL(string: urlStr) else {
        //fatalError("URL 생성 실패")
        completion(.failure(ApiError.invalidUrl(urlStr)))
        return
    }

    let task = URLSession.shared.dataTask(with: url) { (data,response, error) in

        if let error = error {
            //fatalError(error.localizedDescription)
            completion(.failure(error))
            return
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            //fatalError("invalid response")
            completion(.failure(ApiError.invalidResponse))
            return
        }

        guard httpResponse.statusCode == 200 else {
            //fatalError("failed code \(httpResponse.statusCode)")
            completion(.failure(ApiError.failed(httpResponse.statusCode)))
            return
        }

        guard let data = data else {
            //fatalError("empty data")
            completion(.failure(ApiError.emptyData))
            return
        }

        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(ParsingType.self, from: data)
            
            completion(.success(data))
           
        } catch {
            completion(.failure(error))
            //print(error)
            //fatalError(error.localizedDescription)
        }

    }
    task.resume()

}
//opt + comm + F = replace(찾아바꾸기)

func fetchForecast(cityName: String, completion: @escaping (Result<Forecast,Error>) -> ()) {
    let urlStr = "http://api.openweathermap.org/data/2.5/forecast?q=\(cityName)&appid=7321aa59b6ca9072137e5b4b951757aa&units=metric&lang=kr"
    
    fetch(urlStr: urlStr, completion: completion)
    
}

func fetchForecast(cityId: Int, completion: @escaping (Result<Forecast,Error>) -> ()) {
    let urlStr = "http://api.openweathermap.org/data/2.5/forecast?id=\(cityId)&appid=7321aa59b6ca9072137e5b4b951757aa&units=metric&lang=kr"
    
    fetch(urlStr: urlStr, completion: completion)
}

func fetchForecast(location: CLLocation, completion: @escaping (Result<Forecast,Error>) -> ()) {
    let urlStr = "http://api.openweathermap.org/data/2.5/forecast?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=7321aa59b6ca9072137e5b4b951757aa&units=metric&lang=kr"
    
    fetch(urlStr: urlStr, completion: completion)
}

let location = CLLocation(latitude: 37.498206, longitude: 127.02761)
fetchForecast(location: location) { (result) in
    switch result {
    case .success(let weather):
        dump(weather)
    case .failure(let error):
        print(error)
    }
}


//fetchForecast(cityName: "seoul") { _ in }
//
//
//fetchForecast(cityId: 1835847) { (result) in
//    switch result {
//    case .success(let weather):
//        dump(weather)
//    case .failure(let error):
//        print(error)
//    }
//}



#####################################################################################2021.09.02
Step11. 현재날씨 API#2
import UIKit
import CoreLocation
struct CurrentWeather: Codable {
    let dt: Int
    
    struct  Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    let weather: [Weather]
    
    struct Main: Codable {
        let temp: Double
        let temp_min: Double
        let temp_max: Double
    }
    
    let main: Main
}

enum ApiError: Error {
    case unknown
    case invalidUrl(String)
    case invalidResponse
    case failed(Int)
    case emptyData
}

func fetch<ParsingType: Codable>(urlStr: String, completion: @escaping (Result<ParsingType, Error>) -> ()) {
    guard let url = URL(string: urlStr) else {
        //fatalError("URL 생성 실패")
        completion(.failure(ApiError.invalidUrl(urlStr)))
        return
    }

    let task = URLSession.shared.dataTask(with: url) { (data,response, error) in

        if let error = error {
            //fatalError(error.localizedDescription)
            completion(.failure(error))
            return
        }

        guard let httpResponse = response as? HTTPURLResponse else {
            //fatalError("invalid response")
            completion(.failure(ApiError.invalidResponse))
            return
        }

        guard httpResponse.statusCode == 200 else {
            //fatalError("failed code \(httpResponse.statusCode)")
            completion(.failure(ApiError.failed(httpResponse.statusCode)))
            return
        }

        guard let data = data else {
            //fatalError("empty data")
            completion(.failure(ApiError.emptyData))
            return
        }

        do {
            let decoder = JSONDecoder()
            let data = try decoder.decode(ParsingType.self, from: data)
            
            completion(.success(data))
           
        } catch {
            completion(.failure(error))
            //print(error)
            //fatalError(error.localizedDescription)
        }

    }
    task.resume()

}

func fetchCurrentWeather(cityName: String, completion: @escaping (Result<CurrentWeather,Error>) -> ()) {
    let urlStr = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=7321aa59b6ca9072137e5b4b951757aa&units=metric&lang=kr"
    
    fetch(urlStr: urlStr, completion: completion)
    
}

func fetchCurrentWeather(cityId: Int, completion: @escaping (Result<CurrentWeather,Error>) -> ()) {
    let urlStr = "http://api.openweathermap.org/data/2.5/weather?id=\(cityId)&appid=7321aa59b6ca9072137e5b4b951757aa&units=metric&lang=kr"
    
    fetch(urlStr: urlStr, completion: completion)
}

func fetchCurrentWeather(location: CLLocation, completion: @escaping (Result<CurrentWeather,Error>) -> ()) {
    let urlStr = "http://api.openweathermap.org/data/2.5/weather?lat=\(location.coordinate.latitude)&lon=\(location.coordinate.longitude)&appid=7321aa59b6ca9072137e5b4b951757aa&units=metric&lang=kr"
    
    fetch(urlStr: urlStr, completion: completion)
}

let location = CLLocation(latitude: 37.498206, longitude: 127.02761)
fetchCurrentWeather(location: location) { (result) in
    switch result {
    case .success(let weather):
        dump(weather)
    case .failure(let error):
        print(error)
    }
}


//fetchCurrentWeather(cityName: "seoul") { _ in }
//
//
//fetchCurrentWeather(cityId: 1835847) { (result) in
//    switch result {
//    case .success(let weather):
//        dump(weather)
//    case .failure(let error):
//        print(error)
//    }
//}
#####################################################################################2021.09.01
step by step_Weather App
현재날씨 Api#2

#####################################################################################2021.08.31_1
import UIKit

struct CurrentWeather: Codable {
    let dt: Int
    
    struct  Weather: Codable {
        let id: Int
        let main: String
        let description: String
        let icon: String
    }
    
    let weather: [Weather]
    
    struct Main: Codable {
        let temp: Double
        let temp_min: Double
        let temp_max: Double
    }
    
    let main: Main
}

func fetchCurrentWeather(cityName: String) {
    let urlStr = "http://api.openweathermap.org/data/2.5/weather?q=\(cityName)&appid=7321aa59b6ca9072137e5b4b951757aa&units=metric&lang=kr"
    
    guard let url = URL(string: urlStr) else {
        fatalError("URL 생성 실패")
    }
    
    let task = URLSession.shared.dataTask(with: url) { (data,response, error) in
        
        if let error = error {
            fatalError(error.localizedDescription)
            return
        }
        
        guard let httpResponse = response as? HTTPURLResponse else {
            fatalError("invalid response")
        }
        
        guard httpResponse.statusCode == 200 else {
            fatalError("failed code \(httpResponse.statusCode)")
        }
        
        guard let data = data else {
            fatalError("empty data")
        }
        
        do {
            let decoder = JSONDecoder()
            let weather = try decoder.decode(CurrentWeather.self, from: data)
            
            weather.weather.first?.description
            
            weather.main.temp
        } catch {
            print(error)
            fatalError(error.localizedDescription)
        }
        
    }
    task.resume()
}

fetchCurrentWeather(cityName: "seoul")

#####################################################################################2021.08.31
_JSON
{
    "coord": {
        "lon": 126.9778,
        "lat": 37.5683
    },
    "weather": [
        {
            "id": 501,
            "main": "Rain",
            "description": "보통 비",
            "icon": "10n"
        },
        {
            "id": 701,
            "main": "Mist",
            "description": "박무",
            "icon": "50n"
        }
    ],
    "base": "stations",
    "main": {
        "temp": 18.75,
        "feels_like": 19.13,
        "temp_min": 18.66,
        "temp_max": 19.71,
        "pressure": 1011,
        "humidity": 94
    },
    "visibility": 5000,
    "wind": {
        "speed": 3.09,
        "deg": 10
    },
    "rain": {
        "1h": 0.51
    },
    "clouds": {
        "all": 90
    },
    "dt": 1630420368,
    "sys": {
        "type": 1,
        "id": 8105,
        "country": "KR",
        "sunrise": 1630357285,
        "sunset": 1630404241
    },
    "timezone": 32400,
    "id": 1835848,
    "name": "Seoul",
    "cod": 200
}
#####################################################################################2021.08.30_3
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var listTableView: UITableView!
  
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }


}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 1
        case 1:
            return 0
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SummaryTableViewCell", for: indexPath) as! SummaryTableViewCell
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: "ForecastTableViewCell", for: indexPath) as! ForecastTabelViewCell
        
        return cell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
}

#####################################################################################2021.08.30_2
ForecastTableViewCell
import UIKit

class ForecastTabelViewCell: UITableViewCell {

    static let identifier = "ForecastTableViewCell"
    
    @IBOutlet weak var dateLable: UILabel!
    
    @IBOutlet weak var timeLabel: UILabel!
    
    @IBOutlet weak var weaterImageView: UIImageView!
    
    @IBOutlet weak var statusLabel: UILabel!
    
    
    @IBOutlet weak var temperatureLabel: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        // Inatialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

}

#####################################################################################2021.08.30
SummaryTableViewCell
import UIKit

class SummaryTableViewCell: UITableViewCell {

    static let identifier = "SummaryTableViewCell"
    
    @IBOutlet weak var weatherImageView: UIImageView!
    
    @IBOutlet weak var StatusLabel: UILabel!
    
    @IBOutlet weak var minMaxLabel: UILabel!
    
    @IBOutlet weak var currentTemperatureLabel: UILabel!
    
    
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()

        //Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }

#####################################################################################2021.08.29
//섭씨로 변경, units = metric
//언어 변경, lang = kr

//이미지_icon다운로드 https://www.flaticon.com/free-icon/sun_861059

//아이콘이미지로변경 https://makeappicon.com(오류)

//앱 배경화면은 투명사용 불가, 불투명한 색을 사용해야 한다.

#####################################################################################2021.08.28_2
Weather API
//https://openweathermap.org
//songgyeol@kakao.com / song167855 / IOS
//weather dater code :7321aa59b6ca9072137e5b4b951757aa
let apikey = "7321aa59b6ca9072137e5b4b951757aa"


#####################################################################################2021.08.28
KXCWeatherApp
import UIKit

@available(iOS 13.0, *)
class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}
#####################################################################################2021.08.27
2021.08.27
Mentor_Mentee Day
선배님들 졸업식
준하,민희 실무자 1개월차
[Allern 문법 study]
[앱 만들어보기]


#####################################################################################2021.08.26
class TableViewBasicsViewController: UIViewController {
    
    let list = ["iPhone", "iPad", "Apple Watch", "iMac Pro", "iMac 5K", "Macbook Pro", "Apple TV"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension TableViewBasicsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("#1", #function)
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("#2", #function, indexPath)
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        //cell.textLabel?.text = list[indexPath.row]
        
        cell.textLabel?.text = "\(indexPath.section) - \(indexPath.row)"
        return cell
    }
    
    
}

#####################################################################################2021.08.24
Table View Basic
//Delegate Pattern을 활용해서 테이블 뷰를 구현하는 방법
class TableViewBasicsViewController: UIViewController {
    
    let list = ["iPhone", "iPad", "Apple Watch", "iMac Pro", "iMac 5K", "Macbook Pro", "Apple TV"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}
#####################################################################################2021.08.15_2
commit erreor 403??????????????
#Table View Basic = Delegate Pattern을 활용해서 테이블 뷰를 구현하는 방법
#Multi Section#1,#2 = 테이블 뷰에서 두 개 이상의 섹션을 표시하는 방법
#Separator = 셀을 구분하는 Separator
#Table View Cell = 테이블 뷰 셀 구조와 기본 스타일


#####################################################################################2021.08.15_1
#Table View Basic = Delegate Pattern을 활용해서 테이블 뷰를 구현하는 방법
#Multi Section#1,#2 = 테이블 뷰에서 두 개 이상의 섹션을 표시하는 방법
#Separator = 셀을 구분하는 Separator
#Table View Cell = 테이블 뷰 셀 구조와 기본 스타일



#####################################################################################2021.08.11
#Table View Over
#Table View Basic

#####################################################################################2021.08.10
#ISO8601DateFormatter
let str = "2017-09-02"

let formatter = ISO8601DateFormatter()
formatter.formatOptions = [.withYear, .withMonth, .withDay, .withDashSeparatorInDate] // =[withFullDate]

if let date = formatter.date(from: str) {
    formatter.formatOptions = [.withInternetDateTime]
    print(formatter.string(from: date))
    
} else {
    print("inavalid format")
}


#DateIntervalFormatter
let startDate = Date()
let endDate = startDate.addingTimeInterval(3600 * 24 * 3)

let formatter = DateFormatter()
formatter.locale = Locale(identifier: "ko_KR")
formatter.dateStyle = .long
formatter.timeStyle = .short

print("\(formatter.string(from: startDate)) - \(formatter.string(from: endDate))")

let intervalFormatter = DateIntervalFormatter()
intervalFormatter.locale = Locale(identifier: "ko_KR")
//intervalFormatter.dateStyle = .long
//intervalFormatter.timeStyle = .short
intervalFormatter.dateTemplate = "yyyyMMMdE"



print(intervalFormatter.string(from: startDate, to: endDate))



#DateComponentsFormatter
let startDate = Date()
let endDate = startDate.addingTimeInterval(3600 * 24 * 30)

let formatter = DateComponentsFormatter()
formatter.unitsStyle = .full

if let result = formatter.string(from: startDate, to: endDate) {
    print(result)
}

var comps = DateComponents()
comps.day = 0
comps.hour = 1
comps.minute = 30
comps.minute = 0
comps.second = 7

formatter.unitsStyle = .positional //재생시간같이 표기 코드 ex)1:00:07
formatter.zeroFormattingBehavior = .pad  //4 weeks, 2 days 0d 01:00:07


//ex)90분으로 설정코드 = formatter.allowedUnits = [.minute]
//반올림 코드 = formatter.maximumUnitCount = 1
//remaining 남은시간 표시코드 = formatter.includesTimeRemainingPhrase = true
//remaining랑 같이 사용하는 코드 about = formatter.includesApproximationPhrase = true

if let result = formatter.string(from: comps) {
    print(result)
}


#####################################################################################2021.08.09
#ISO8601Date~
#Table View

#####################################################################################2021.08.08_5
#Date String Parsing
let str = "2017-09-02T09:30:00Z"
let formatter = DateFormatter()

formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss'Z'"

if let date = formatter.date(from: str) {
    formatter.dateStyle = .full
    formatter.timeStyle = .full
    
    print(formatter.string(from: date))
    
} else {
    print("invalid format")
    
}
#####################################################################################2021.08.08_4
#Symbols
#Symbols 
let now = Date()
let weekdaySymbols = ["☀️", "🌕", "🔥", "💧", "🌲", "🥇", "🌏"]
let am = "🌅"
let pm = "🌇"

let formatter = DateFormatter()
formatter.dateStyle = .full
formatter.timeStyle = .full

formatter.amSymbol = am
formatter.pmSymbol = pm

print(formatter.string(from: now))

formatter.weekdaySymbols = weekdaySymbols

print(formatter.string(from: now))




#####################################################################################2021.08.08_3
#Relative Date Formatting
let now = Date()
let yesterday = now.addingTimeInterval(3600 * -24)
let tomorrow = now.addingTimeInterval(3600 * 24)

let formatter = DateFormatter()
formatter.locale = Locale(identifier: "ko_KR")
formatter.dateStyle = .full
formatter.timeStyle = .none
formatter.doesRelativeDateFormatting = true


print(formatter.string(from: now))
print(formatter.string(from: yesterday))
print(formatter.string(from: tomorrow))
formatter.doesRelativeDateFormatting = true


#####################################################################################2021.08.08_2
#Custom Format
NSDateFormatter.com

let now = Date()
let formatter = DateFormatter()

formatter.locale = Locale(identifier: "en_US")
formatter.setLocalizedDateFormatFromTemplate("yyyyMMMMdE")
var result = formatter.string(from: now)
print(result, formatter.dateFormat)

formatter.locale = Locale(identifier: "ko_KR")
formatter.setLocalizedDateFormatFromTemplate("yyyyMMMMdE")
result = formatter.string(from: now)
print(result, formatter.dateFormat)

formatter.dateFormat = "yyyyMMMMdE"
result = formatter.string(from: now)
print(result)


#Relative Date Formatting
let now = Date()
let yesterday = now.addingTimeInterval(3600 * -24)
let tomorrow = now.addingTimeInterval(3600 * 24)

let formatter = DateFormatter()
formatter.locale = Locale(identifier: "ko_KR")
formatter.dateStyle = .full
formatter.timeStyle = .none
formatter.doesRelativeDateFormatting = true


print(formatter.string(from: now))
print(formatter.string(from: yesterday))
print(formatter.string(from: tomorrow))
formatter.doesRelativeDateFormatting = true


#####################################################################################2021.08.08
#DateFormatter
//문자를 날짜로 날짜를 문자로
let now = Date()
//print(now)

let formatter = DateFormatter()
formatter.dateStyle = .full
formatter.timeStyle = .medium
formatter.locale = Locale(identifier: "ko_kr")


var result = formatter.string(from: now)
print(result)

//formatter.string(for: <#T##Any?#>)

result = DateFormatter.localizedString(from: now, dateStyle: .long, timeStyle: .short)
print(result)



#####################################################################################2021.08.07_2
CountDown Timer
class CountDownTimerViewController: UIViewController {
    
    @IBOutlet weak var timeLabel: UILabel!
    
    
    @IBOutlet weak var picker: UIDatePicker!
    
    @IBAction func start(_ sender: Any) {
        timeLabel.text = "\(Int(picker.countDownDuration))"
    
            remainingSeconds = Int(picker.countDownDuration)
    
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { (timer) in
            self.remainingSeconds -= 1
            self.timeLabel.text = "\(self.remainingSeconds)"
            
            if self.remainingSeconds == 0 {
                timer.invalidate()
                AudioServicesPlaySystemSound(1315)
            }
        }
    }
    
    var remainingSeconds = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.countDownDuration = 60//원하는 시간을 초 단위로
        
        
    }
}



#####################################################################################2021.08.07
Date Picker
class DatePickerModeViewController: UIViewController {
    
    @IBOutlet weak var picker: UIDatePicker!
    
    @IBAction func dateChanged(_ sender: UIDatePicker) {
        
        print(sender.date)
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if #available(iOS 13.4, *) {
            picker.preferredDatePickerStyle = .wheels
        } else {
            // Fallback on earlier versions
        }
        
        picker.datePickerMode = .dateAndTime
        picker.locale = Locale(identifier: "ko_kr")
        
        picker.minuteInterval = 1
        
        picker.date = Date()
        picker.setDate(Date(), animated: true)
        
//        picker.minimumDate = Date()
//        picker.maximumDate = Date()
        
        picker.calendar = Calendar.current
        picker.timeZone = TimeZone.current
        
        
    }
}


#####################################################################################2021.08.06
Handling Date
#Date Picker

#####################################################################################2021.08.05_2
Calendar and Date Components
#Calendar
//국가별 달력이 다양하기 때문에 특정해서 사용해야 함.
Calendar.Identifier.gregorian//comm+cont+클릭(Identifier)

Calendar.current //아이폰설정상, 설정 바꿔도 최초달력 유지
Calendar.autoupdatingCurrent //아이폰설정상, 바꾼 달력으로 유지



#DateComponents
let now = Date()

let calendar = Calendar.current

let components = calendar.dateComponents([.year, .month, .day], from: now)
components.year
components.month
components.day
//여러가지를 볼 때

let year = calendar.component(.year, from: now)
//하나의 값만 볼 때

//새로운 날짜
var memorialDayComponents = DateComponents()
memorialDayComponents.year = 2014
memorialDayComponents.month = 4
memorialDayComponents.day = 16

let memorialDay = calendar.date(from: memorialDayComponents)


#Date Calculation
extension Date {
    init?(year: Int, month: Int, day: Int, hour: Int = 0, minute: Int = 0, second: Int = 0, calendar: Calendar = .current) {
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        components.hour = hour
        components.minute = minute
        components.day = day
        
        guard let date = calendar.date(from: components) else {
            return nil
        }
        
        self = date
    }
}

let calendar = Calendar.current
let worldCup2002 = Date(year: 2002, month: 5, day: 31)!

//100일 뒤 날짜 설정
let now = Date()
let today = calendar.startOfDay(for: now) //기준날짜 설정 00:00분

var comps = DateComponents()
comps.day = 100 //100일 전 날짜를 하고 싶으면 -100
comps.hour = 12 // 시간부분을 생각해서 계산해야 된다.  하루 차이가 날 수 있음

calendar.date(byAdding: comps, to: now)
calendar.date(byAdding: comps, to: today) //시간 뺀 날짜만

comps = calendar.dateComponents([.day], from: worldCup2002, to: today)
comps.day


#TimeZone
//한국 Korean Standard Time(KST)
let calendar = Calendar.current
var components = DateComponents()
components.year = 2014
components.month = 4
components.day = 16
//서울/아시아로 타임존 설정
components.timeZone = TimeZone(identifier: "Asia/Seoul")
calendar.date(from: components)

components.timeZone = TimeZone(identifier: "America/Los_Angels")
calendar.date(from: components)



for name in TimeZone.knownTimeZoneIdentifiers {
    print(name)
}//Asia/Seoul




#####################################################################################2021.08.05
Date
#Date Type and Reference Date
Reference date: 2001-01-01 00:00:00 / UTC

let now = Date()
print(now)

var dt = Date(timeIntervalSinceReferenceDate: 60 * 60)
print(dt)

dt = Date(timeIntervalSinceReferenceDate: -60 * 60)
print(dt)


#TimeInterval
let oneSec = TimeInterval(1)

let oneMillisecond = TimeInterval(0.001)

let oneMin = TimeInterval(60)
let oneHour = TimeInterval(oneMin * 60) //= (60 * 60)
let oneDay = TimeInterval(oneHour * 24)

Date(timeIntervalSinceNow: oneDay)





#####################################################################################2021.08.04_3
Input View& Input Accessory View
class InputViewViewController: UIViewController {
    
    
    @IBOutlet var accessoryBar: UIToolbar!
    
    
    @IBOutlet var pickerContainerView: UIView!
    
    
    @IBOutlet var buttonContainerView: UIView!
    
    
    @IBAction func selectGender(_ sender: UIButton) {
        
        genderField.text = sender.tag == 0 ? "M" : "F"
        
        UIDevice.current.playInputClick()
    }
    
    @IBAction func movePrevious(_ sender: Any) {
        if genderField.isFirstResponder {
            ageField.becomeFirstResponder()
        } else if ageField.isFirstResponder {
            nameField.becomeFirstResponder()
        }
    }
    
    @IBAction func moveNext(_ sender: Any) {
        if nameField.isFirstResponder {
            ageField.becomeFirstResponder()
        } else if ageField.isFirstResponder {
            genderField.becomeFirstResponder()
        }
    }
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var ageField: UITextField!
    
    @IBOutlet weak var genderField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ageField.inputView = pickerContainerView
        genderField.inputView = buttonContainerView
        
        
        nameField.inputAccessoryView = accessoryBar
        ageField.inputAccessoryView = accessoryBar
        genderField.inputAccessoryView = accessoryBar
    }
}


class GenderInputView: UIView, UIInputViewAudioFeedback {
    var enableInputClicksWhenVisible: Bool {
        return true
    }
}





extension InputViewViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return 100
    }
}

extension InputViewViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return "\(row + 1)"
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        ageField.text = "\(row + 1)"
    }
}


#####################################################################################2021.08.04
Text Delegates #1~#3
//Name,Age,Gender,Email

class TextDelegateViewController: UIViewController {
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var ageField: UITextField!
    
    @IBOutlet weak var genderField: UITextField!
    
    @IBOutlet weak var emailField: UITextField!
    
    let regex = "^([a-z0-9_\\.-]+)@([\\da-z\\.-]+)\\.([a-z\\.]{2,6})$"
    lazy var charSet = CharacterSet(charactersIn: "0123456789").inverted
    lazy var invalidGenderCharSet = CharacterSet(charactersIn: "MF").inverted
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        nameField.becomeFirstResponder()
    }
}

extension TextDelegateViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case nameField:
            ageField.becomeFirstResponder()
        case ageField:
            genderField.becomeFirstResponder()
        case genderField:
            emailField.becomeFirstResponder()
        case emailField:
            emailField.resignFirstResponder()
        default:
            break
    }
        
        return true
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        
        print("current: \(textField.text ?? "")")
        print("string: \(string)")
        
        let currentText = NSString(string: textField.text ?? "")
        let finalText = currentText.replacingCharacters(in: range, with: string)
        
        switch textField {
        case nameField:
            if finalText.count > 10 {
                return false
            }
        case ageField:

            if let _ = string.rangeOfCharacter(from: charSet) {
                return false
            }
                    if let age = Int(finalText), !(1...100).contains(age) {
                        return false
                    }
        case genderField:
            if let _ = string.rangeOfCharacter(from: invalidGenderCharSet) {
                return false
            }
            
            if finalText.count > 1 {
                return false
            }
            
        default:
            break
        }
        
        
        return true
        
    }
    
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        
        if textField == emailField {
            guard let email = textField.text, let _ = email.range(of: regex, options: .regularExpression) else {
                alert(message: "invalid email")
                return false
            }
            }
        
        
        return true
    }

    }

extension TextDelegateViewController {
    func alert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        
        let ok = UIAlertAction(title: "확인", style: .default, handler: nil)
        alert.addAction(ok)
        
        present(alert, animated: true, completion: nil)
    }
}

#####################################################################################2021.08.04
Software Keyboard #3
//Notification 이름을 주석으로 추가해둠
// UIResponder.keyboardDidHideNotification
// UIResponder.keyboardDidShowNotification
// UIResponder.keyboardWillHideNotification
// UIResponder.keyboardWillShowNotification
// UIResponder.keyboardWillChangeFrameNotification
// UIResponder.keyboardDidChangeFrameNotification


class KeyboardNotificationViewController: UIViewController {
    
    @IBOutlet var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillShowNotification, object: nil, queue: .main) { (noti) in
            
            guard let userInfo = noti.userInfo else { return }
            
            guard let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as?
                    CGRect else { return }
            
            var inset = self.textView.contentInset
            inset.bottom = frame.height
            self.textView.contentInset = inset
            
            self.textView.scrollIndicatorInsets = inset
        }
        NotificationCenter.default.addObserver(forName: UIResponder.keyboardWillHideNotification, object: nil, queue: .main) { (noti) in
            
            var inset = self.textView.contentInset
            inset.bottom = 8
            self.textView.contentInset = inset
            
            self.textView.scrollIndicatorInsets = inset
        }
        
    }
}



#####################################################################################2021.08.03
Software Keyboard #2
class ReturnKeyViewController: UIViewController {
    
    @IBOutlet weak var firstInputField: UITextField!
    
    @IBOutlet weak var secondInputField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //리턴키 코드
        secondInputField.enablesReturnKeyAutomatically = true
        
    }
}

extension ReturnKeyViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        switch textField {
        case firstInputField:
            secondInputField.becomeFirstResponder()
        case secondInputField:
            guard let keyword = secondInputField.text, keyword.count > 0 else {
                return true
            }
            let encodeKeyword = keyword.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? keyword
            let urlStr = "http://www.google.com/m/search?q=\(encodeKeyword)"
            guard let url = URL(string: urlStr) else {
                return true
            }
            
            if UIApplication.shared.canOpenURL(url) {
                UIApplication.shared.open(url, options: [:], completionHandler: nil)
            }
        default:
            break
        }
        return true
        //델리게이트에서 구현하면 리턴키를 탭할때마다 반복적으로 호출한다
    }
}



#####################################################################################2021.08.02
Software Keyboard #1
_FirstResponderViewController
class FirstResponderViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextField!
    
    
    @IBAction func startEditing(_ sender: Any) {
        inputField.becomeFirstResponder()
    }
    
    @IBAction func endEditing(_ sender: Any) {
        if inputField.isFirstResponder {
            inputField.resignFirstResponder()
        }
    }
    //will로 열었으면, dis로 닫아준다 짝을 맞추듯
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        inputField.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
//        if inputField.isFirstResponder {
//            inputField.resignFirstResponder()
//        }
        view.endEditing(true) //위 주석이랑 같은 효과
    }
}

_KeyboardTypesViewController.swift
class KeyboardTypesViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var btn: UIButton!
    
    @IBAction func changeKeyboardType(_ sender: Any) {
        inputField.resignFirstResponder()
        
        let sheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let types: [UIKeyboardType] = [.default, .asciiCapable, .numbersAndPunctuation, .URL, .numberPad, .phonePad, .namePhonePad, .emailAddress, .decimalPad, .twitter, .webSearch, .asciiCapableNumberPad]
        let typeNames = ["Default", "ASCII Capable", "Numbers And Punctuation", "URL", "Number Pad", "Phone Pad", "Name Phone Pad", "E-mail Address", "Decimal Pad", "Twitter", "Web Search", "ASCII Capable Number Pad"]
        
        (0..<types.count).forEach {
            let type = types[$0]
            let name = typeNames[$0]
            
            let action = UIAlertAction(title: name, style: .default, handler: { (action) in
                self.inputField.keyboardType = type
                self.inputField.becomeFirstResponder()
            })
            sheet.addAction(action)
        }
        
        let cancel = UIAlertAction(title: "Cancel", style: .destructive, handler: nil)
        sheet.addAction(cancel)
        
        if let pc = sheet.popoverPresentationController {
            pc.sourceView = btn
        }
        
        present(sheet, animated: true, completion: nil)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        inputField.becomeFirstResponder()
    }
}

_KeyboardAppearanceViewController
class KeyboardAppearanceViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBAction func appearanceChanged(_ sender: UISegmentedControl) {
        let appearance = UIKeyboardAppearance(rawValue: sender.selectedSegmentIndex) ?? .default
        inputField.keyboardAppearance = appearance
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        inputField.becomeFirstResponder()
    }
}



#####################################################################################2021.08.01_2
#😎Text Input Traits #1~#2
#1
텍스트 입력
class CapitalizationViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBAction func capitalizationChanged(_ sender: UISegmentedControl) {
        
        inputField.resignFirstResponder()
        
        let type = UITextAutocapitalizationType(rawValue: sender.selectedSegmentIndex) ?? .none
        inputField.autocapitalizationType = type
        
        inputField.becomeFirstResponder()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
              
    }
}

class CorrectionViewController: UIViewController {
    @IBOutlet weak var inputField: UITextField!
    
    @IBAction func correctionChanged(_ sender: UISegmentedControl) {
        //편집종료
        inputField.resignFirstResponder()
        
        let type = UITextAutocorrectionType(rawValue: sender.selectedSegmentIndex) ?? .default
        inputField.autocorrectionType = type
        //편집다시시작
        inputField.becomeFirstResponder()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

#2
#SpellChecking
//오타 밑줄 빨간색
class SpellCheckingViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    @IBAction func spellCheckingChanged(_ sender: UISegmentedControl) {
    
        let type = UITextSpellCheckingType(rawValue: sender.selectedSegmentIndex) ?? .default
        textView.spellCheckingType = type
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}


#SecureTextEntry
class SecureTextEntryViewController: UIViewController {
    
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        passwordField.isSecureTextEntry = true
        
    }
}

#https://ko.wikipedia.org/wiki/줄표#엠_대시(em_dash,_—)
엠대시, 엔대시



#####################################################################################2021.08.01_1

#3😎 Text View #3 Data Detections
class DataDetectionViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.dataDetectorTypes = [.link, .address, .phoneNumber]
        
    }
}


#####################################################################################2021.07.31_3
Text Field#1~#2
#1😎 Basic
class TextFieldViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var valueLabel: UILabel!
   
    @IBAction func report(_ sender: Any) {
        
        guard let text = inputField.text, text.count > 0 else {
            return
        }
        valueLabel.text = text
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        inputField.placeholder = "Input Value"
    }
}


#2😎
Border Style
class TextFieldBorderStyleViewController: UIViewController {
    
    @IBOutlet weak var inputField: UITextField!
    
    @IBOutlet weak var borderStyleControl: UISegmentedControl!
    
    @IBAction func borderStyleChanged(_ sender: UISegmentedControl) {
        
        let index = sender.selectedSegmentIndex
        let style = UITextField.BorderStyle(rawValue: index) ?? .roundedRect
        inputField.borderStyle = style
    }
    
    
    @IBOutlet weak var enabledSwitch: UISwitch!
    
    @IBAction func toggleEnabled(_ sender: UISwitch) {
        inputField.isEnabled = sender.isOn
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

#####################################################################################2021.07.31_2
Color#1,#2
_Color#1 Color Basic
class CGColorCIColorViewController: UIViewController {
    
    @IBOutlet weak var blueView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blueView.layer.borderWidth = 10
        blueView.layer.borderColor = UIColor.systemYellow.cgColor
        
    }
}


_Color#2 Pattern
#1😎 UIColor
class UIColorViewController: UIViewController {
    
    @IBOutlet weak var targetView: UIView!
    
    @IBOutlet weak var redSlider: UISlider!
    
    @IBOutlet weak var blueSlider: UISlider!
    
    @IBOutlet weak var greenSlider: UISlider!
    
    @IBAction func sliderChanged(_ sender: UISlider) {
        let r = CGFloat(redSlider.value)
        let g = CGFloat(redSlider.value)
        let b = CGFloat(redSlider.value)
        
        targetView.backgroundColor = UIColor(displayP3Red: r, green: g, blue: b, alpha: 1.0)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var r = CGFloat(0)
        var g = CGFloat(0)
        var b = CGFloat(0)
        var a = CGFloat(0)
        
        targetView.backgroundColor?.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        redSlider.value = Float(r)
        greenSlider.value = Float(g)
        blueSlider.value = Float(b)
        
        
//        targetView.backgroundColor = UIColor.systemBlue
//
//        let color = UIColor(red: 29.0 / 255.0, green: 161.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
//
//        UIColor(displayP3Red: 29.0 / 255.0, green: 161.0 / 255.0, blue: 242.0 / 255.0, alpha: 1.0)
//
//        UIColor.systemRed.withAlphaComponent(0.5)
//
//        UIColor.clear
        
    }
}


#2😎 CGColor
class CGColorCIColorViewController: UIViewController {
    
    @IBOutlet weak var blueView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        blueView.layer.borderWidth = 10
        blueView.layer.borderColor = UIColor.systemYellow.cgColor
        
    }
}

#3😎 Pattern
class PatternImageViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let img = UIImage(named: "pattern") {
            let patternColor = UIColor(patternImage: img)
            view.backgroundColor = patternColor
        }
    }
}


#4😎 Color Literal
class ColorSetViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let c = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        view.backgroundColor = UIColor(named: "PrimaryColor") ?? UIColor.white
        
    }
}

#5😎
Custom Drawing
class ColorSetViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let c = #colorLiteral(red: 0.1019607857, green: 0.2784313858, blue: 0.400000006, alpha: 1)
        view.backgroundColor = UIColor(named: "PrimaryColor") ?? UIColor.white
        
    }
}



#####################################################################################2021.07.31
Image#3~#4
#3_Image#3 Template Images
class RenderingModeViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let img = UIImage(named: "clover")?.withRenderingMode(.alwaysTemplate) {
            imageView.image = img
        }
    }

#4_Image#4 Custom Drawing and Resizing
import UIKit
import CoreGraphics

class ImageResizingViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let targetImage = UIImage(named: "photo") {
            let size = CGSize(width: targetImage.size.width / 5, height: targetImage.size.height / 5)
            
            imageView.image = resizingWithImageContext(image: targetImage, to: size)
        }
    }
}




extension ImageResizingViewController {
    func resizingWithImageContext(image: UIImage, to size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContextWithOptions(size, true, 0.0)
        
        let frame = CGRect(origin: CGPoint.zero, size: size)
        image.draw(in: frame)
        
        let resultImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndPDFContext()
        
        return resultImage
        
    }
}



extension ImageResizingViewController {
    func resizingWithBitmapContext(image: UIImage, to size: CGSize) -> UIImage? {
        return nil
    }
}






#####################################################################################2021.07.30
Image#1~#2
_#1 Image Basic
class ImageViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img1 = UIImage(named: "moongchi")
        let img2 = #imageLiteral(resourceName: "photo") //Image Litera
        
        imageView.image = img1   //nil
        
        if let ptSize = img1?.size {
            print("Image Size: \(ptSize)")
        }
        
        if let ptSize = img1?.size, let scale = img1?.scale {
            let px = CGSize(width: ptSize.width * scale, height: ptSize.height * scale)
            print("Image Size(px): \(px)")
        }
        //유형
        img1?.cgImage
        img1?.ciImage
        
        //다른곳으로 전송 및 파일저장
        let pngData = img1?.pngData()
        let jpgData = img1?.jpegData(compressionQuality: 1.0)//1.0이 가장 높은품질
        
    }
}

_#2 Image #2 Resizable Image&Vector Image
class ResizableImageViewController: UIViewController {
    
    @IBOutlet weak var btn: UIButton!
    
    let btnImage = UIImage(named: "btn")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let img = btnImage {
            let capInset = UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
            
            let bkgImage = img.resizableImage(withCapInsets: capInset, resizingMode:  .stretch)
            btn.setBackgroundImage(bkgImage, for: .normal)
        }
        
    }


#####################################################################################2021.07.29_2
Handling Image and Color
_Image View
class ImageAnimationViewController: UIViewController {
    
    let images = [
        UIImage(systemName: "speaker")!,
        UIImage(systemName: "speaker.1")!,
        UIImage(systemName: "speaker.2")!,
        UIImage(systemName: "speaker.3")!
    ]
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBAction func startAnimation(_ sender: Any) {
        imageView.startAnimating()
    }
    
    @IBAction func stopAnimation(_ sender: Any) {
        if imageView.isAnimating {
            imageView.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imageView.animationImages = images
        
        imageView.animationDuration = 1.0
        imageView.animationRepeatCount = 3
    }
}

#####################################################################################2021.07.29
Alert#3😎
#3😎
class ActionSheetViewController: UIViewController {
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBAction func show(_ sender: UIButton) {
        let controller = UIAlertController(title: "Languages", message: "Choose one", preferredStyle: .actionSheet)
        
        let swiftAction = UIAlertAction(title: "Swift", style: .default) { [weak self] (action) in
            self?.resultLabel.text = action.title
        }
        controller.addAction(swiftAction)
        
        let javaAction = UIAlertAction(title: "Java", style: .default) { [weak self] (action) in
            self?.resultLabel.text = action.title
        }
        controller.addAction(javaAction)
        
        let pythonAction = UIAlertAction(title: "Python", style: .default) { [weak self] (action) in
            self?.resultLabel.text = action.title
        }
        controller.addAction(pythonAction)
        
        let cSharpAction = UIAlertAction(title: "C#", style: .default) { [weak self] (action) in
            self?.resultLabel.text = action.title
        }
        controller.addAction(cSharpAction)
        
        let clearAction = UIAlertAction(title: "Clear", style: .destructive) { [weak self] (action) in
            self?.resultLabel.text = nil
        }
        controller.addAction(clearAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
   
        
        if let pc = controller.popoverPresentationController {
            //pc.barButtonItem
            pc.sourceView = view
            pc.sourceRect = sender.frame
        }
        
        for action in controller.actions {
            if action.title == resultLabel.text {
                action.isEnabled = false
            }
        }
        
        present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}

#####################################################################################2021.07.28
_Alert Controller#1~#2
#1😎
class AlertViewController: UIViewController {
    
    @IBAction func show(_ sender: Any) {
        let controller = UIAlertController(title: "Hello", message: "Have a nice day", preferredStyle: .alert)
     //얼러트에는 반드시 액션이 들어가야 함
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            print(action.title)                 //style메세지에는 .누르면 확인가능 3개(cancel:닫기, destructive:빨간색(주의), default: 기본)
        }
        controller.addAction(okAction)
        
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (action) in
            print(action.title)
        }
        controller.addAction(cancelAction)
        
        let destructiveAction = UIAlertAction(title: "Destructive", style: .destructive) { (action) in
            print(action.title)
        }
        controller.addAction(destructiveAction)
        
        controller.preferredAction = okAction
        //prefeerd는 present 전에 지정해줘야 한다, alert에서만 사용.
            present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

#2😎
//[경고창에 텍스트 필드 추가]
class AddTextFieldViewController: UIViewController {
    
    @IBOutlet weak var idLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    
    @IBAction func show(_ sender: Any) {
        let controller = UIAlertController(title: "Sign Un to iTunes Store", message: nil, preferredStyle: .alert)
        
        controller.addTextField { (idField) in
            idField.placeholder = "Apple ID"
        }
        

        controller.addTextField { (passwordField) in
            passwordField.placeholder = "Input Password"
            passwordField.isSecureTextEntry = true   //password는 마스킹
        }
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { [weak self] (action) in
            if let fieldList = controller.textFields {
                if let idField = fieldList.first {
                    self?.idLabel.text = idField.text
                }
                
                if let passwordField = fieldList.last {
                    self?.passwordLabel.text = passwordField.text
                }
            }
        }
        controller.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        controller.addAction(cancelAction)
        
        present(controller, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }
}




#####################################################################################2021.07.26
_Progress View
class ProgressViewViewController: UIViewController {
  
    @IBOutlet weak var progress: UIProgressView!
    
    
    
    @IBAction func update(_ sender: Any) {
        //progress.progress = 0.8 애니메이션 없이 바로 로드됨
        progress.setProgress(0.8, animated: true) // 애니메이션 효과
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        progress.progress = 0.0
        progress.trackTintColor = UIColor.systemGray
        progress.progressTintColor = .systemRed
        
    }
}



#####################################################################################2021.07.25_3
_Switch
class SwitchViewController: UIViewController {
    
    @IBOutlet weak var bulbImageView: UIImageView!
    
    @IBOutlet weak var testSwitch: UISwitch!
    
    
    @IBAction func stateChanged(_ sender: UISwitch) {
        bulbImageView.isHighlighted = sender.isOn
        
    }
    
    
    
    
    @IBAction func toggle(_ sender: Any) {
        //testSwitch.isOn.toggle()
        
        testSwitch.setOn(!testSwitch.isOn, animated: true)
        stateChanged(testSwitch)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        testSwitch.isOn = bulbImageView.isHighlighted
    }
}

_Stepper
class StepperViewController: UIViewController {
    
    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var valueStepper: UIStepper!
    @IBOutlet weak var autorepeatSwitch: UISwitch!
    @IBOutlet weak var continuousSwitch: UISwitch!
    @IBOutlet weak var wrapSwitch: UISwitch!
    
    @IBAction func valueChanged(_ sender: UIStepper) {
        valueLabel.text = "\(sender.value)"
    }
    
    
    
    @IBAction func toggleAutorepeat(_ sender: UISwitch) {
        valueStepper.autorepeat = sender.isOn
        
    }
    
    @IBAction func toggleContinuous(_ sender: UISwitch) {
        valueStepper.isContinuous = sender.isOn
        
    }
    
    @IBAction func toggleWrap(_ sender: UISwitch) {
        valueStepper.wraps = sender.isOn
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        autorepeatSwitch.isOn = valueStepper.autorepeat
        continuousSwitch.isOn = valueStepper.isContinuous
        wrapSwitch.isOn = valueStepper.wraps
        
    }
}

_Activity Indicator View
class ActivityIndicatorViewViewController: UIViewController {
    
    @IBOutlet weak var loader: UIActivityIndicatorView!
    
    @IBOutlet weak var hiddenSwitch: UISwitch!
    
    @IBAction func toggleHidden(_ sender: UISwitch) {
        loader.hidesWhenStopped = sender.isOn
    }
    
    @IBAction func start(_ sender: Any) {
        if !loader.isAnimating {
        loader.startAnimating()
        }
    }
    
    @IBAction func stop(_ sender: Any) {
        if loader.isAnimating {
            loader.stopAnimating()
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        hiddenSwitch.isOn = loader.hidesWhenStopped
        loader.startAnimating()
        
    }
}

#####################################################################################2021.07.25_2
_Slider#1
class SimpleSliderViewController: UIViewController {
    
    @IBOutlet weak var redSlider: UISlider!
    
    @IBOutlet weak var greenSlider: UISlider!
    
    @IBOutlet weak var blueSlider: UISlider!
    
    
    @IBAction func sliderChanged(_ sender: Any) {
        
        let r = CGFloat(redSlider.value)
        let g = CGFloat(greenSlider.value)
        let b = CGFloat(blueSlider.value)
        
        let color = UIColor(red: r, green: g, blue: b, alpha: 1.0)
        view.backgroundColor = color
        
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        redSlider.value = 1.0
        greenSlider.value = 1.0
        blueSlider.value = 1.0
        
        //애니메이션 효과 넣기
        //redSlider.setValue(, animated: <#T##Bool#>)
        
        redSlider.minimumValue = 0.0
        redSlider.maximumValue = 1.0
    }
}

_Slider#2
Custom Slider
class CustomSliderViewController: UIViewController {
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(systemName: "Lightbuld")
        
        slider.setThumbImage(img, for: .normal)
        
        slider.minimumTrackTintColor = UIColor.systemRed
        slider.maximumTrackTintColor = UIColor.black
        
        //틴트컬러 이미지
        //slider.thumbTintColor
        
//        slider.setMinimumTrackImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
//        slider.setMaximumTrackImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
//
        
    }
}


non-continuous Slider
class CustomSliderViewController: UIViewController {
    @IBOutlet weak var slider: UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let img = UIImage(systemName: "Lightbuld")
        
        slider.setThumbImage(img, for: .normal)
        
        slider.minimumTrackTintColor = UIColor.systemRed
        slider.maximumTrackTintColor = UIColor.black
        
        //틴트컬러 이미지
        //slider.thumbTintColor
        
//        slider.setMinimumTrackImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
//        slider.setMaximumTrackImage(<#T##image: UIImage?##UIImage?#>, for: <#T##UIControl.State#>)
//
        
    }
}




#####################################################################################2021.07.25
_Page Control#1
class PageControlViewController: UIViewController {
    @IBOutlet weak var listCollectionView: UICollectionView!
    
    
    @IBOutlet weak var pager: UIPageControl!
    
    
    let list = [UIColor.red, UIColor.green, UIColor.blue, UIColor.gray, UIColor.black]
    
    
    @IBAction func pageChanged(_ sender: UIPageControl) {
        let indexPath = IndexPath(item: sender.currentPage, section: 0)
        listCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        pager.numberOfPages = list.count
        pager.currentPage = 0
        
        pager.pageIndicatorTintColor = UIColor.systemGray3
        pager.currentPageIndicatorTintColor = UIColor.systemRed
        
    }
}


extension PageControlViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let width = scrollView.bounds.size.width
        let x = scrollView.contentOffset.x + (width / 2.0)
        
        let newPage = Int(x / width)
        if pager.currentPage != newPage {
            pager.currentPage = newPage
        }
    }
}





extension PageControlViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        cell.backgroundColor = list[indexPath.item]
        return cell
    }
}


extension PageControlViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return collectionView.bounds.size
    }
}

#####################################################################################2021.07.24_3
_Picker View#1. Text Picker
//Picker View = 슬롯머신형태
1. Date Picker(날짜 등)
2. Picker View(범용적)

class TextPickerViewController: UIViewController {
    let devTools = ["Xcode", "Postman", "SourceTree", "Zeplin", "Android Studio", "SublimeText"]
    let fruits = ["Apple", "Orange", "Banana", "Kiwi", "Watermelon", "Peach", "Strawberry"]
    
    
    @IBOutlet weak var picker: UIPickerView!
    

    @IBAction func report(_ sender: Any) {
        
        let firstSelectedRow = picker.selectedRow(inComponent: 0)
        let secondSelectedRow = picker.selectedRow(inComponent: 1)
        
        if firstSelectedRow >= 0 {
           print(devTools[firstSelectedRow])
        }
        
        if secondSelectedRow >= 0 {
            print(fruits[secondSelectedRow])
        }
        
        
        
//       let row = picker.selectedRow(inComponent: 0)
//
//        guard row >= 0 else {
//            print("not found")
//            return
//        }
//        print(devTools[row])
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}



extension TextPickerViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return devTools.count
        case 1:
            return fruits.count
        default:
            return 0
        }
    }
}

extension TextPickerViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String? {
        switch component {
        case 0:
            return devTools[row]
        case 1:
            return fruits[row]
        default:
            return nil
        }
    }
    
    
    private func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        switch component {
        case 0:
            print(devTools[row])
        case 1:
            return(fruits[row])
        default:
            break
            
        
    }
}



#####################################################################################2021.07.24_2
_Button #2. Text Button
class ImageButtonViewController: UIViewController {
    
    @IBOutlet weak var btn: UIButton!
    d
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let normalImage = UIImage(named: "plus-normal")
        let highlightedImage = UIImage(named: "plus-highlighted")
        
        btn.setImage(normalImage, for: .normal)
        btn.setImage(highlightedImage, for: .highlighted)
        
        btn.setBackgroundImage
//이미지?,,,,상태,,,???
    }
}

#####################################################################################2021.07.24_1
_Button #1. Text Button
class TextButtonViewController: UIViewController {
    
    @IBOutlet weak var btn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    //버튼을 타이틀레이블에 직접 접근해서 바꾸는것을 허용x
        //UI버튼이 제공하는 메소드를 사용해야 한다.
//        btn.titleLabel?.text = "Hello"
//        btn.titleLabel?.textColor = .systemRed
        
       //-->>> 
        btn.setTitle("Hello", for: .normal)
        btn.setTitle("Haha", for: .highlighted)
        
        btn.setTitleColor(.systemRed, for: .normal)
        btn.setTitleColor(.systemPurple, for: .highlighted)
        
        btn.titleLabel?.backgroundColor = .systemYellow
    }
}



#####################################################################################2021.07.24
System View & Control
_UIControl & Target-Action
_Button#1 Text Button
_Button#2 Image Button



#####################################################################################2021.07.22_2
View & Window
_UIView#3
class InteractionViewController: UIViewController {
    
    @IBOutlet weak var interactionSwitch: UISwitch!
    
    @IBOutlet weak var multiTouchSwitch: UISwitch!
    
    @IBOutlet weak var touchView: TouchView!
    
    
    @IBAction func switchInteractionEnabled(_ sender: UISwitch) {
        touchView.isUserInteractionEnabled = sender.isOn
    }
    
    
    @IBAction func switchMultiTouch(_ sender: UISwitch) {
        touchView.isMultipleTouchEnabled = sender.isOn
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        interactionSwitch.isOn = touchView.isUserInteractionEnabled
        multiTouchSwitch.isOn = touchView.isMultipleTouchEnabled
    }   
}

#####################################################################################2021.07.22
View & Window
_UIView#2
//option + 클릭
class ContentModeViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var modeLabel: UILabel!
    
    @IBAction func switchMode(_ sender: Any) {
        let currentMode = imageView.contentMode.rawValue
        
        let newMode =  UIView.ContentMode(rawValue: currentMode + 1) ?? . scaleAspectFill
        imageView.contentMode = newMode
        
        updateModeLabel()
        
    }
    
    func updateModeLabel() {
        switch imageView.contentMode {
        case .scaleToFill:
            modeLabel.text = "Scale to fill"
        case .scaleAspectFit:
            modeLabel.text = "Aspect fit"
        case .scaleAspectFill:
            modeLabel.text = "Aspect fill"
        case .redraw:
            modeLabel.text = "Redraw"
        case .center:
            modeLabel.text = "Center"
        case .top:
            modeLabel.text = "Top"
        case .bottom:
            modeLabel.text = "Bottom"
        case .left:
            modeLabel.text = "Left"
        case .right:
            modeLabel.text = "Right"
        case .topLeft:
            modeLabel.text = "Top left"
        case .topRight:
            modeLabel.text = "Top right"
        case .bottomLeft:
            modeLabel.text = "Bottom left"
        case .bottomRight:
            modeLabel.text = "Bottom right"
        @unknown default:
            fatalError()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.layer.borderColor = UIColor.blue.cgColor
        imageView.layer.borderWidth = 2
        
        updateModeLabel()
    }
}

#####################################################################################2021.07.21
2021.07.21
단축키
option + del : 단어지우기
comm + del : 문단지우기
contr + del : 대소문자 지우기 
comm + option + [] : 줄내리기 올리기
com + 0, com+option + 0 : 좌우 닫기열기

현재창 빼고 닫기 : comm+option+w
현재창 닫기 : comm+w
*코드자동정렬 : contr+I
*comm+, : 설정
줄지우기 설정하기" : comm+option+del
같은단어 수정 : comm+클릭 리네임
같은 글쓰기 : comm+Shift
단어 첫줄끝줄 : option+방향키
문단 첫줄끝줄 : comm+방향키 

단어블록 : option+shift 방향키
문단블록 : comm+shift 방향키

인터넷
-comm+space bar 검색
-comm+L 주소창검색

파일
space bar "미리보기"

응용프로그램종료(작업관리자) : option+comm+esc

커맨트 엘 숫자 : 코드숫자 바로가기
커맨드 시프트 4 : 캡쳐
커맨드 시프트 5 : 녹화


다운로드 원할 때, 드래그 해서 독에 있는 다운로드로 



#####################################################################################2021.07.20
System View & control


#####################################################################################2021.07.19
View & Window
_UIView

System View & Control



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
