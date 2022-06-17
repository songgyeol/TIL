# TIL
****App Lifecycle****
앱 생명주기는 앱이 화면상에 보이는 foreground 상태, 보이지 않는 background 상태 등과 같은 상태를 정의한 것 입니다.  홈버튼을 누르거나, 전화가 와서 화면이 전환되는 등 앱의 상태변화를 이해하기 위해서는 앱 생명주기를 이해할 필요가 있습니다.

아래 이미지는 애블 개발자센터에서 제공하는 앱 상태 전환에 대한 이미지입니다.

![app-state2x.png](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/3ddd5ea3-0392-44c1-8f2d-da6278a78e09/app-state2x.png)

각 상태에 대한 설명 입니다.

Not Running: 앱이 실행되지 않은 상태

***(Inactive와 Active 상태를 합쳐서 Foreground 라고 함)***

Inactive: 앱이 실행중인 상태 그러나 아무런 이벤트를 받지 않는 상태

Active: 앱이 실행중이며 이벤트가 발생한 상태

Background: 앱이 백그라운드에 있는 상태 그러나 실행되는 코드가 있는 상태

Suspened: 앱이 백그라운드에 있고 실행되는 코드가 없는 상태

AppDelegate.swift에 아래와 같이 앱의 상태에 따라 실행되는 delegate 함수들이 정의되어 있기때문에 함수안에 코드를 작성 함으로써 앱의 특정 상태에서 동작하는 로직을 구현 할 수 있습니다.

**application(_didFinishLaunching) :** 앱이 처음 시작될 때 실행

**applicationWillResignActive :**  앱이 active 에서 inactive로 이동될 때 실행

**applicationDidEnterBackground :** 앱이 background 상태일 때 실행

**applicationWillEnterForeground :** 앱이 background에서 foreground로 이동 될때 실행 (아직 foreground에서 실행중이진 않음)

**applicationDidBecomeActive :** 앱이 active상태가 되어 실행 중일 때

**applicationWillTerminate :** 앱이 종료될 때 실행

위 함수를 모두 구현할 필요는 없고, 상황에 맞춰 필요한 함수만 구현해서 사용할수도 있고 위 함수에 포함되지 않더라고 원하는 delegate를 추가해서 사용할 수도 있습니다.

ViewController's Life Cycle
1. loadView
view controller의 view property를 불렀는데 아직 nil 상태일 때 불리는 메소드에요.
만약 루트 뷰를 직접 만들고 있다면 이 메소드를 override해서 꼭 view property에 assign 해주셔야 합니다.
 
* 주의 *
- 절대 loadView( )를 직접 호출하면 안됩니다!!
- 만약 interface builder를 통해 뷰를 만들고 있다면 loadView를 override 하면 안됩니다. 
- view에 대한 추가적인 초기화를 진행하고 싶다면 viewDidLoad에서 하는 것이 권장되고 있습니다.
 
2. viewDidLoad
스토리보드의 view나 코드로 작성한 view가 메모리에 올라온 직후 불리는 메소드 입니다. 
IBOutlet을 연결할 때 @IBOutlet private var titleLabel: UILabel! 처럼 force unwrapping 해 본 경험이 있으실겁니다.
흔히 force unwrapping은 권장되지 않는 방법이지만, IBOutlet에서 가능한 이유는 viewDidLoad가 불리면 이 변수들에 값이 있음을 보장할 수 있기 때문입니다.
화면에 디스플레이 되는 것과는 별개인 메소드이므로 화면이 보이기 전에 처리하면 좋을 백그라운드 작업(ex. network call)을 하면 좋겠죠?
 
3. viewWillAppear
view가 view hierarchy에 추가되기 직전에 불리는 메소드입니다. 다른말로, 화면에 보여지기 직전에 불리는 메소드입니다.
하지만 항상 사용자가 보는 화면에 보일 필요는 없는 것이 view.isHidden = true 로 프로퍼티가 설정이 되어 있다면 안보이겠죠.
그러니 실제로 보이는 것과 별개로 view가 view hierarchy에 추가되기 직전임을 알고 있으면 좋을 것 같네요.
 
**viewDidLoad vs viewWillAppear**
간단한 예시로 살펴보도록 하겠습니다.
navigationController?.setNavigationBarHidden(true, animated: true) 코드를 짜보신적 있으신가요?
Navigation Controller는 상단에 위치해서 공간을 차지하는데요, navigation이 가능한 화면일지라도 첫 화면은 navigation bar가 없기를 바랄 때가 있죠. 그래서 navigation bar를 숨기기 위해 setNavigationBarHidden(true, animated: true) 을 사용하게 되는데,
viewDidLoad에서 작업을 하게 되면, 제일 처음에는 불려서 원하는 화면을 볼 수 있겠지만, 화면 전환 이후 다시 돌아오면 viewDidLoad는 불리지 않아서 navigation bar가 보이게 됩니다. 따라서 사용자에게 화면이 나타날 떄마다 실행되었으면 하는 작업이 있다면 viewWillAppear에서 해주면 됩니다.
 
4. viewDidAppear
view가 view hierarchy에 추가된 직후에 불리는 메소드입니다. 이 메소드가 불리고 나면 사용자는 화면을 보고 있을겁니다.
이제 사용자가 화면을 볼 수 있으니 이 메소드에서 animation을 시작하거나, 음악 재생, 사용자 데이터 수집 등을 시작하면 좋을
이 때 animation을 시작하거나, 음악을 재생하거나, 수집하는 사용자 데이터가 있다면 이 때부터 수집을 시작하면 됩니다.
 
5. viewWillDisappear
content view가 view hierarchy에서 제거되기 직전에 불리는 메소드입니다. 이 메소드가 불릴 때 까지는 사용자에게 화면이 보이기 때문에 UITextField 등을 사용해서 값을 입력받고 있었다면 저장을 하는 등의 작업을 해주면 좋습니다.
 
6. viewDidDisappear
content view가 view hierarchy에서 제거된 직후에 불리는 메소드입니다. 완전히 사라지고 난 후에 불리는 메소드이므로 화면이 없어지면 응당 멈춰야 할 작업들을 멈춰주면 됩니다. Notification을 삭제할 수도 있고, 다른 객체를 관찰 중이었다면 중단하고, 자이로스코프 센서 등의 시스템 센서를 사용하고 있었다면 중단할 수 있겠죠?


DelegatePattern2
# **Delegate Pattern**

iOS 개발 패턴중 가장 중요한 패턴이다. Apple framework를 사용하기 위해서는 반드시 알아야할 패턴이다.

- 어떤 객체와, 객체의 기능을 대신 수행할 델리게이트 객체가 필요하다.
- 예를들면, 상품을 표시하는 TableView를 터치하면, 상세 페이지로 이동하는 기능이 있다고 한다. 이때, 사용자가 TableView를 선택했을때, TableView객체는 어떤 기능을 실행해야 할지 모른다. 따라서 델리게이트 객체가 이(상세 페이지로 이동하는 기능)를 수행한다.
- 델리게이트를 사용하는 TableView 객체는 `...dataSource` 혹은 `...delegate` 라는 접미어를 가진다.
- 사용자가 TableView를 터치하게 되면, TableView는 직접 기능을 수행하지 못하므로, 대리자의 함수를 호출하고, 이때 대리자(델리게이트 객체)가 대신 기능을 수행한다.
- 특정 이벤트 때 호출되는 메소드는 프로토콜에 선언되어있어야 한다.
- 그리고 당연히 프로토콜에 선언되어있는것과 일치하게 메소드를 구현해야한다.

(테이블뷰같은 경우에는, 보통 자신을 포함하고 있는 뷰컨트롤러를 대리자로 지정한다.)

### 델리게이트 패턴을 사용하는 이유

**iOS에서 프로토콜을 사용하여 델리게이션을 구현하는 것은 클래스가 단일 상속만을 지원하기 때문이다. 즉, 하나의 부모 클래스를 상속받고 나면 더는 다른 클래스를 상속받을 수 없으므로 기능을 덧붙이기에는 제한적이다. 이를 극복하기 위해 구현 개수에 제한이 없는 프로토콜을 이용하여 필요한 기능 단위별 객체를 작성한다.**

= 개발의 유연성이 증가한다.

### 

### 델리게이트 구현 순서

ios에서 델리게이트의 역할은 크게 두가지이다.

1. 데이터 공급 (이러한 경우에는 `...DataSource` 라는 접미어를 가진다.)
2. 이벤트 처리 (`...Delegate` 접미어를 가진다.)

그리고 **모든 컨트롤에서 델리게이트를 필요로 하는것이 아니다.** 예를들어 `TextField`에서는 데이터를 공급할 필요가 없기 때문에, `...DataSource`는 필요하지 않다.

1. 어떤 객체를 생성할때, Delegate가 필요한 객체인지 먼저 개발자 문서에서 확인한다.
2. 필요하다면, 구현하고자 하는 메소드의 프로토콜을 확인한다. (이때 개발자 문서에`required`라고 표시된 메소드는 반드시 구현해야하는 메소드이다.)
3. `구현하고자 하는 객체` - `Delegate 객체` 를 연결해준다.
4. `Delegate 객체`에서 프로토콜을 구현해준다.

## TableView Delegate Pattern (코드 구현)

```swift
import UIKit

classViewController:UIViewController {

// MARK: 프로퍼티let myTableView =UITableView()
let items = ["swift", "iOS", "TableView"]

// MARK: ViewController override methodoverridefuncviewDidLoad() {
super.viewDidLoad()

self.myTableView.dataSource =selfself.myTableView.delegate =selfself.myTableView.register(UITableViewCell.self,
                            forCellReuseIdentifier: "cell")
self.view.addSubview(self.myTableView)

self.myTableView.translatesAutoresizingMaskIntoConstraints = false
self.view.addConstraint(NSLayoutConstraint(item:self.myTableView,
      attribute: .top, relatedBy: .equal, toItem:self.view, attribute: .top,
      multiplier: 1.0, constant: 0))
self.view.addConstraint(NSLayoutConstraint(item:self.myTableView,
      attribute: .bottom, relatedBy: .equal, toItem:self.view,
      attribute: .bottom, multiplier: 1.0, constant: 0))
self.view.addConstraint(NSLayoutConstraint(item:self.myTableView,
      attribute: .leading, relatedBy: .equal, toItem:self.view,
      attribute: .leading, multiplier: 1.0, constant: 0))
self.view.addConstraint(NSLayoutConstraint(item:self.myTableView,
      attribute: .trailing, relatedBy: .equal, toItem:self.view,
      attribute: .trailing, multiplier: 1.0, constant: 0))
  }

}

// MARK: UITableViewDelegateextensionViewController :UITableViewDelegate {

functableView(_ tableView:UITableView, didSelectRowAt indexPath:IndexPath) {
    print(items[indexPath.row])
  }
}

// MARK: UITableViewDataSourceextensionViewController:UITableViewDataSource {

functableView(_ tableView:UITableView,
                  numberOfRowsInSection section:Int) ->Int {
returnself.items.count
  }

functableView(_ tableView:UITableView,
                  cellForRowAt indexPath:IndexPath) ->UITableViewCell {

let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        cell.textLabel?.text = items[indexPath.row]

return cell
  }
}

```

## Text Field Delegate Pattern

- 델리게이트 지정은 보통 viewDidLoad() 안에서 한다.
- `UITextFieldDelegate` 에는 필수 메소드가 없다.
- 단순히 입력값을 받는 것은 델리게이트가 필요없지만, 특정 기능을 사용하려면 필수적이다.
- 특정 기능은 숫자만 입력값으로 받기, 입력 문자의 개수를 제한하기, 등등의 제어기능을 말한다.

```swift
import UIKit

classTextFieldViewController :UIViewController{

@IBOutletweakvar inputField :UITextField!

overridefuncviewDidLoad(){
super.viewDidLoad()
    inputField.delegate =self
  }
}

extensionTextFieldViewController:UITextFieldDelegate {

}
```

## 

## Protocol Extension

### 델리게이트를 이용해서 이전 화면으로 값 전달하기

> ComposeDelegate.swift  ( 프로토콜 선언 파일 )
> 

```swift
import UIKit

protocolComposeDelegate {
funccomposer(_ vc:UIViewController, didInput value :String?)
funccomposerDidCancel(_ vc:UIViewController)
}
```

- delegate 속성은 대부분 옵셔널 프로토콜 형식으로 선언한다.

> CustomDelegateViewController.swift (이전 화면)
> 

```swift
import UIKit

classCustomDelegateViewController:UIViewController {

@IBOutletweakvar valueLabel:UILabel!

overridefuncprepare(for segue:UIStoryboardSegue, sender:Any?) {
iflet vc = segue.destination.children.firstas?ComposeViewController {
            vc.delegate =self
        }
    }
@objcfuncpresentComposeVC() {
        performSegue(withIdentifier: "ComposeSegue", sender: nil)
    }
overridefuncviewDidLoad() {
super.viewDidLoad()

        navigationItem.rightBarButtonItem =UIBarButtonItem(barButtonSystemItem: .add, target:self, action: #selector(presentComposeVC))
    }
}
extensionCustomDelegateViewController :ComposeDelegate {
funccomposer(_ vc:UIViewController, didInput Value:String?) {
        valueLabel.text =Value
    }
funccomposerDidCancel(_ vc:UIViewController) {
        valueLabel.text = "Cancel"
    }
}
```

> ComposeViewController.swift (다음화면)
> 

```swift
import UIKit

classComposeViewController:UIViewController {

var delegate :ComposeDelegate?

@IBOutletweakvar inputField:UITextField!

@IBActionfuncperformCancel(_ sender:Any) {
        delegate?.composerDidCancel(self)
        dismiss(animated: true, completion: nil)
    }

@IBActionfuncperformDone(_ sender:Any) {
        delegate?.composer(self, didInput: inputField.text)
        dismiss(animated: true, completion: nil)
    }

overridefuncviewDidLoad() {
super.viewDidLoad()
self.inputField.delegate =selfif#available(iOS 13.0, *) {
            isModalInPresentation = true
        }
    }
}

extensionComposeViewController :UITextFieldDelegate {
functextFieldShouldReturn(_ textField:UITextField) ->Bool {
        delegate?.composer(self, didInput:self.inputField.text)
        dismiss(animated: true, completion: nil)
return true
    }
}
```


DelegatePattern
> Delegation은 상속만큼 재사용을위한 구성을 강력하게 만드는 방법입니다. Delegation에서 요청을 처리하는 데 두 가지 개체가 포함됩니다. 받는 개체(receiving object)는 작업을 대리자(delegate)에게 위임(delegate)합니다. 이것은 부모 클래스에 대한 요청을 연기하는 서브 클래스와 유사합니다. .... 위임과 동일한 효과를 얻기 위해 수신자는 위임 된 작업이 수신자를 참조하도록 대리자에게 자신을 전달합니다.
> 

정의의 내용을 정리해 보면 Delegate를 위해선 세 가지가 필요 합니다.1. 수신자      *Receiver*2. 대리자      *Delegate*3. 대리자에게 수신자 자신을 전달

간단히 설명하면 대리자는 수신자로 부터 수신자 자신의 객체를 전달 받고, 그 객체를 이용한 행동을 취했들 때(메소드 호출 등) 수신자는 그 결과를 받게됩니다. 말로만 설명하면 무슨 말인지 모르겠으니 코드를 통해 보겠습니다.

```swift
class Receiver {
    let button = Delegate()

    init() {
        button.delegate = self  //대리자에게 자신을 전달
    }

    func helloWorld() {
        print("Hello World")
    }
}

class Delegate {
    weak var delegate: Sender?

    func didTapButton() {
        delegate?.helloWorld()
    }
}
```

수신자는 위임자에게 self로 자기 자신을 넘겨주고 위임자는 수신자 객체의 메소드를 '대신' 실행하는 것을 보실 수 있습니다. 그리고 위임자에서 메소드가 호출 되면 수신자에 정의된 함수가 실행됩니다.

하지만 여기엔 한 가지 문제가 있습니다. 지금 처럼 class 형태로 객체를 넘겨주게 되면 동일한 delegate를 사용하기 위해선 반드시 상속을 받아야 한다는 것이지요. 이렇게 되면 기능 확장에 큰 걸림돌이 됩니다.

따라서 swift에선 대부분 protocol을 이용해 delegate 패턴을 구현합니다.

```swift
protocol TapDelegate: class {
    func helloWorld()
}

class Receiver: TapDelegate {
    let button = Delegate()

    init() {
        button.delegate = self
    }

    func helloWorld() {
        print("Hello World")
    }
}

class Delegate {
    weak var delegate: TapDelegate?

    func didTapButton() {
        delegate?.helloWorld()
    }
}
```

수신자는 원하는 기능을 포함한 Delegate Protocol을 구현합니다. 그리고 자기 자신을 Protocol의 형태로 전달해 주게 되면 동일한 기능을 수행해내면서 여러가지 Delegate들을 이용할 수 있게 됩니다.







AppDelegate vs SceneDelegate

iOS 13 이전에는 AppDelegate가 app의 launch, foregrounding, backgrounding 등 App Life-Cycle을 관리하는 책임을 갖고 있었습니다. 그러나 iOS 13부터는 일부 역할을 SceneDelegate에게 넘겨주었습니다. 그러면 현재의 AppDelegate 역할을 무엇일까요?

# AppDelegate

**AppDelegate**은 iOS 버전에 무관하게 **application의 entry point** 역할과 **application level의 life-cycle을 관리**하는 역할을 합니다. Apple은 AppDelegate.swift에 기본적으로 중요하다고 여기는 3개의 method들을 구현해 놓았습니다. 설명이 주석으로 매우 잘 적혀있긴 하지만 간단히 살펴보도록 합시다.

**1. func application(_: didFinishLaunchingWithOptions: ) -> Bool**

application의 setup을 이 메소드 안에서 진행하게 됩니다. iOS 12 이하 버전은 multiple window를 지원하지 않았어서 UIWindow 객체에 대한 configuration도 진행했었는데 이제는 multiple window를 지원하기 때문에 하나의 window 객체만 관리하는게 말이 되지 않죠.

**2. func application(_: configurationForConnecting:options: ) -> UISceneConfiguration**

application이 새로운 scene/window를 제공하려고 할 때 불리는 메소드입니다. (최초 launch 때 불리는 메소드 아님)

**3. func application(_: didDiscardSceneSessions: )**

사용자가 scene을 버릴 때 불립니다. 버리는 상황이려면 swipe로 multitasking windwo를 없앤다던지, 코드로서 없애는 경우가 있습니다.

### 기타 역할

- URL 열기
- memory warning wkqrl
- 언제 종료(terminate) 될 지 잡기 등

# SceneDelegate

간단히 말해서 SceneDelegate은 **화면에 무엇(scene/window)을 보여줄지 관리하는 역할**을 합니다. Apple이 기본적으로 제공해주는 메소드와 주석을 통해 조금 더 알아보겠습니다.

**1. scene(_: willConnectTo: options: )**

UISceneSession lifecycle에서 제일 처음 불리는 메소드로 첫 content view, 새로운 UIWindow를 생성하고 window의 rootViewController를 설정합니다. 이 때 헷갈리지 말아야 할 것은 'window'가 사용자가 보는 window가 아니라 app이 작동하는 viewport를 나타낸다는 것이죠. 첫 view를 만드는데 쓰이기도 하지만 과거에 disconnected 된 UI를 되돌릴 때도 쓰기도 합니다.

**2. sceneWillEnterForeground(_ :)**

위 과정이 끝나면 sceneWillEnterForeground가 불리게 되는데 scene이 foreground로 전환될 때 불리는 데 두가지 경우가 있겠죠? 1) background → foreground 가 되었을 때 2) 그냥 처음 active 상태가 되었을 때

**3. sceneDidBecomeActive(_ :)**

다음으로 불리는 메소드는 sceneDidBecomeActive(_ :)로 scene이 setup 되고 화면에 보여지면서 사용 될 준비가 완료 된 상태입니다. inactive → active로 전환 될 때도 불리겠죠. 그래서 inactive상태가 되면서 멈춘 task를 재실행할 수도 있고 만약 처음 불렸다면 사용 준비가 완료되었으니 사용하면 됩니다.

**4. sceneWillResignActive(_ :)**

active한 상태에서 inactive 상태로 빠질 때 불리는데 사용 중 전화가 걸려오는 것 처럼 임시 interruption 때문에 발생할 수 있습니다.

**5. sceneDidEnterBackground(_ :)**

scene이 foreground에서 background로 전환 될 때 불리게 되므로 다음에 다시 foreground에 돌아 올 때 복원할 수 있도록 state 정보를 저장하거나, 데이터를 저장, 공유 자원 돌려주는 등의 일을 하도록 하면 됩니다.

**6. sceneDidDisconnect(_ :)**

scene이 background로 들어갔을 때 시스템이 자원을 확보하기 위해 disconnect하려고 할 수도 있습니다. (disconnect는 app을 종료시킨 것과는 다르다고 합니다! scene이 이 메소드로 전달되면 session에서 끊어진다는 것 뿐입니다.) 이 메소드 내에서 해야 할 가장 중요한 작업은 필요 없는 자원은 돌려주는 것입니다. 가령 디스크로나 네트워크를 통해 쉽게 불러올 수 있거나 생성이 쉬운 데이터들은 돌려주고, 사용자의 input과 같이 재생성이 어려운 데이터는 갖고 있게끔 하는 작업을 해주어야 합니다.

# **iOS 13 이후 버전의 AppDelegate**

그러나 iOS 13으로 넘어오면서 **1 process & multiple user interface(= scene sessions)** 를 지원하게 되었다. 실제로 plist의 Application Scene Manifest를 보면 기존에는 없던 Enable Multiple Windows가 포함되어 있다.기존에는 AppDelegate에서 UIWindow 객체에 대한 configuration도 진행했었는데 이제는 하나의 window 객체만 관리하지 못한다.AppDelegate의 일부 역할을 SceneDelegate에게 넘겨주었고, AppDelegate은 새로운 역할을 하나 더 맡게 되었다.

1. process level의 이벤트 발생을 알려주고 (그대로)
2. session life-cycle을 application에게 알려주게 되었다. (신규)

# **SceneDelegate**

**UI의 상태변화를 메소드들을 통해 application에게 알리는 역할**을 한다. 기존 AppDelegate들이 갖고 있던 메소드들과 거의 1:1 mapping이 가능하다.SceneDelegate은 아래의 메소드를 갖고 있다.

- `scene(_: willConnectTo: options:)`
- `sceneWillEnterForeground(_ :)`
- `sceneDidBecomeActive(_ :)`
- `sceneWillResignActive(_ :)`
- `sceneDidEnterBackground(_ :)`
- `sceneDidDisconnect(_ :)`

### **실제 call stack 따라가보기**

1. AppDelegate: didFinishLaunching → UI와 무관한 일회성 setup을 이곳에서 해도 무방하다
2. system이 scene session을 생성했다. (UI Scene 아님)
3. AppDelegate: UISceneConfiguration
4. SceneDelegate: scene willConnectTo

**User가 Home 화면으로 돌아갔다**

1. SceneDelegate: willResignActive
2. SceneDelegate: didEnterBackground
3. SceneDelegate: didDisconnect

> didDisconnect 살펴보기 system은 한정 된 자원을 가지고 있기 때문에 자원을 언젠가는 회수를 해야 한다. 따라서 scene이 background에 들어간 후 어느 시점에 scene을 memory로부터 해제시킨다. 즉,
> 
> 1. scene delegate이 메모리에서 해제됨
> 2. scene delegate이 관리하던 window 및 view 계층 메모리에서 해제됨

> 따라서 didDisconnect코드 내부에서는 scene과 관련된 불필요한 자원을 돌려주는 작업을 해주면 된다. 가령 디스크나 네트워크를 통해 쉽게 데이터를 다시 불러올 수 있다거나재생성이 쉬운 데이터는 돌려주는게 좋지만 scene이 다시 reconnect 될 수 있으므로 사용자의 input과 같이 재생성이 어려운 데이터는 가지고 있어야 하니 데이터를 무조건적으로 영구삭제하면 안된다.
> 

**User가 app switcher틑 통해 app 종료**

1. AppDelegate: didDiscardSceneSessions → 이 곳에서 user data, state 등 scene과 관련된 모든 데이터를 지우는 작업을 해주면 된다.


Struct vs Class
# **Class와 Struct의 차이점?**

아주 간단하게 차이점을 보자면 **"Class는 참조타입이고 ARC로 메모리 관리를 한다. Struct는 값 타입이다."**
 정도로 표현 할 수 있을 거 같습니다. 이 질문을 통해 ARC를 통한 메모리 관리, 참조 타입과 값 타입의 차이점 등을 함께 답변할 수 있을 거 같습니다.

저는 이 iOS 개발자 면접에서 자주 등장하는 해당 질문이 iOS 개발자에게 어떤 의미를 갖는지 좀 더 생각하게 되었고 좀 더 깊이 공부하게 되었습니다. 공부를 하다 보니 깨달은 것은 **"개발자가 가장 중요하게 고려해야 할 것 중 하나는 성능이며 Class, Struct의 차이점을 확실히 알고 있다면 성능개선을 할 수 있다"**
 였습니다.

즉 면접 질문에서 "Class, Struct의 차이점은 무엇인가요?"를 묻는 것은 단순히 **Swift 공식문서에 나와있는 기본적인 내용뿐만 아니라 좀 더 깊은 내용에도 관심이 있고 공부를 했는지, 그리고 결국 그렇게 깊이 공부를 했다면 성능 개선을 할 수 있는 개발자가 될 수 있다고 생각할 수 있기에 묻는다고 개인적으로 생각**
하게 되었습니다. 실제로 저도 이 질문을 여러 면접에서 받았는데, 이 글을 작성하기 위해 공부하기 전 까지는 항상 기본적인 내용만 답변을 해왔던 터라 아쉽기도 합니다.

# Class, Struct의 공통점

- 값을 저장할 프로퍼티를 선언할 수 있습니다.
- 함수적 기능을 하는 메서드를 선언 할 수 있습니다.
- 내부 값에. 을 사용하여 접근할 수 있습니다.
- 생성자를 사용해 초기 상태를 설정할 수 있습니다.
- extension을 사용하여 기능을 확장할 수 있습니다.
- Protocol을 채택하여 기능을 설정할 수 있습니다.

그럼 공식문서에서 제공하는 Class, Struct의 **차이점**도 살펴보겠습니다.

# Class (클래스)

- 참조 타입입니다.
- ARC로 메모리를 관리합니다.
- 같은 클래스 인스턴스를 여러 개의 변수에 할당한 뒤 값을 변경시키면 할당한 모든 변수에 영향을 줍니다. (메모리만 복사)
- 상속이 가능합니다.
- 타입 캐스팅을 통해 런타임에서 클래스 인스턴스의 타입을 확인할 수 있습니다.
- deinit을 사용하여 클래스 인스턴스의 메모리 할당을 해제할 수 있습니다.

# Struct (구조체)

- 값 타입입니다.
- 구조체 변수를 새로운 변수에 할당할 때마다 새로운 구조체가 할당됩니다.
- 즉 같은 구조체를 여러 개의 변수에 할당한 뒤 값을 변경시키더라도 다른 변수에 영향을 주지 않습니다. (값 자체를 복사)

그래서 언제 클래스를 쓰고 언제 구조체를 쓰는 것이 좋을까요?

- 단순한 데이터 값을 보유하기 위해서는 구조체가 낫습니다.
- 메모리의 스택은 크기가 크지 않기 때문에 작은 값을 갖는 데이터를 처리할 때 구조체를 사용합니다.
- Objectice-C와 상호 운용성을 원할 때는 클래스를 사용합니다.


참고링크 https://ios-development.tistory.com/62

cocoapods
1. CocoaPods 이란?

- "코코아 프로젝트"에 대한 의존성 패키지를 관리 도구
   Cocoa : 코코아 개발 환경
   pod : 라이브러리를 의미
    -> CocoaPods : 코코아 개발 환경에서의 라이브러리들
 
*CocoaPods이 없다면?
 github에 있는 라이브러리들은 자동 업데이트가 이루어지지 않기 때문에 버전관리가 힘듦
 
 1. Alamofire

- HTTP네트워크 통신을 위한 스위프트 기반으로 개발된 비동기 라이브러리
2. Alamofire를 이용한 요청과 응답

 1) 요청(request) : Alamofire.request(...)
 // import Alamofire
let param: Parameters = [
    "userId" : "imustang",
    "name" : "iOS개발 블로거"
]
 
let headers: HTTPHeaders = [
    "Authorization" : "123",
    "Accept" : "application/json"
]
 
let req = Alamofire.request("호출할 URL",
                              method: .post,
                              parameters: param,
                              encoding: JSONEncoding.default,
                              headers: headers)

 - Parameters 자료형은 Alamofire프레임워크 속 자료형 [String : Any]
 - 안에 들어갈 Key값은 서버에서 제공하는 API문서를 보고 확인
 - 단, 12번라인에서 요청을 하는 동시에 req에 응답이 들어옴
 * 파라미터 
 - method : 생략할 시 GET방식
 - parameters : 항상 딕셔너리형태
 - encoding : .methodDependent (메소드에 따라 인코딩 타입이 자동으로 결정)
                     .JSONEncoding.default (JSON파일)
                     .queryString (GET 전송에서 사용되는 방식)
                     .httpBody (POST 전송에서 사용되는 방식)
 - headers : 딕셔너리형태
 2) 응답(response)
- 응답되는 형식은 API문서를 보고 확인
1
2
3
4
5
6
7
8
9
req.responseJSON() {res in
    print(response.result.value!)
    
    guard let jsonObj = res.result.value as? [String: Any] else {return}
 
    let v1 = jsonObj["userId"]!
    let v2 = jsonObj["name"]!
}
 
 
 
 - 1번째 줄에, 응답으로 받을 자료형을 구분해줄 수 있음
 responseString()
 responseJSON()
 responseData() // 응답 메시지의 본문을 바이너리 데이터로 반환하여 전달



프레임워크의 특징과 프레임워크와 라이브러리 차이점은 무엇인지 설명하시오.👉🏻 Framework란 소프트웨어 환경에서 복잡한 문제를 해결하거나 서술하는데 사용되는 기본 개념 구조입니다. 뼈대가 되는 부분을 미리 구현한 클래스, 인터페이스 , 메소드 등의 모음이라고 할 수 있습니다. 프레임워크는 설계자가 의도한 여러 디자인 패턴으로 구성되어 있습니다. 따라서 개발자가 에플리케이션의 구조적 설계를 신경 쓸 필요가 없습니다. 또한 일정 수준 이상의 품질을 보증하는 코드를 비교적 빠르고 편하게 완성 및 유지보수할 수 있는 솔루션이라고 할 수 있습니다.👉🏻 라이브러리와 프레임워크는 애플리케이션의 틀과 구조를 결정한다는 측면에서 활용도가 상당히 유사하나 라이브러리는 특정 기능이 필요할 때 호출해서 쓰는 도구 모음입니다. 프레임워크가 큰 뼈대는 이미 잡혀있고 그 안의 내용물을 채우는 느낌이라면 라이브러리는 개발자가 호출해서 능동적으로 사용하는 것이라고 볼 수 있습니다. 즉, 프레임워크는 꼭 써야되는 것과 지켜야되는 룰이 있는 반면 라이브러리는 쓰든 안쓰든 개발자 마음대로 할 수 있다는 점에서 차이가 있습니다.(+) Spring Framework자바(JAVA) 플랫폼을 위한 오픈소스 애플리케이션 프레임워크자바 엔터프라이즈 개발을 편하게 해주는 오픈소스 경량급 애플리케이션 프레임워크자바 개발을 위한 프레임워크로 종속 객체를 생성해주고, 조립해주는 기구자바로 된 프레임워크로 JavaSE로 된 자바 객체(POJO)를 JavaEE에 의존적이지 않게 연결해주는 역할특징크기와 부하의 측면에서 경량제어 역행(IOC)이라는 기술을 통해 애플리케이션의 느슨한 결합을 도모.관점 지향 프로그래밍(AOP)을 위한 풍부한 자원애플리케이션 객체의 생명주기와 설정을 포함하고 관리한다는 점에서 일종의 컨테이너라고 할 수 있음간단한 컴포넌트로 복잡한 애플리케이션을 구성하고 설정할 수 있음

**- REST 의 정의**    - Representational State Transfer (대표적인 상태 전달)의 약자    - 월드 와이드 웹(www)과 같은 분산 하이퍼미디어 시스템을 위한 소프트웨어 개발 아키텍처의 한 형식        - REST 는 기본적으로 웹의 기존 기술과 HTTP 프로토콜을 그대로 활하기 때문에 웹의 장점을 최대한 활용할 수 있는 아키텍처 스타일이다        - REST는 네트워크 상에서 Client 와 Server 사이의 통신 방식 중 하나이다

**- 구체적인 개념**      - HTTP URI (Uniform Resource Identifier) 를 통해 자원 (Resource)을 명시하고, HTTP Method(Post, Get, Put, Delete) 를 통해 해당 자원에 대한 CRUD Operation 을 적용하는 것을 의미한다.      - 즉, REST 는 자원 기반의 구조(ROA, Resource Oriented Architecture) 설계의 중심에 Resource 가 있고, HTTP Method 를 통해 Resource 를 처리하도록 설계된 아키텍처를 의미한다      - 웹 사이트의 이미지, 텍스트 DB 내용 등의 모든 자원에 고유한 ID 인 HTTP URI 를 부여한다

**- REST 장단점**    - 장점      - 여러 가지 서비스 디자인에서 생길 수 있는 문제를 최소화 해준다      - Hypermedia API 의 기본을 충실히 지키면서 범용성을 보장한다      - HTTP 프로토콜 표준을 최대한 활용하여 여러 추가적인 장점을 함께 가져갈 수 있게 해준다.    - 단점      - 브라우저를 통해 테스트할 일이 많은 서비스라면 쉽게 고칠 수 있는 URI 보다 Header 값이 어렵게 느껴짐      - 구형 브라우저가 아직 제데로 지원해주지 못하는 부분이 존재한다        -  PUT, DELETE 를 사용하지 못하는 점 (form 에 경우 <input type="hidden" name="_method" /> 로 줄 수 있다        -  pushState 를 지원하지 않는 점 ( history.pushState - 뒤로가기 )          - **URI 를 통한 ServerSide Rendering 방식을 이용하게 된다면**            - 메인 페이지 -> 보드 1 페이지 -> 보드 5 페이지 클릭 -> 뒤로가기 -> **보드 1 페이지          - REST 방식을 이용하게 된다면**            - 메인 페이지 -> 보드 1 페이지 -> 보드 5 페이지 클릭 -> 뒤로가기 -> **메인 페이지       - REST 특징**         - Server-Client(서버 클라이언트 구조)         - Stateless (무상태성)           (cookie 를 이용해 session 을 서버에 저장했다면, rest 는 header 에 token 을 넣어 인증하고 세션을 저장하지 않는다)         - Cacheable(캐시 처리 가능)

- **REST 가 필요한 이유 -** 애플리케이션 분리 및 통합 (MSA = Micro Soft Service Application)  - 다양한 클라이언트의 등장 - 즉, 최근의 서버 프로그램은 다양한 브라우저와 안드로이드폰, 아이폰과 같은 모바일 디바이스에서도 통신을 할 수 있어야 한다 - MSA (Micro Service Application) 분산 서비스와 관련되어있다 ( api call 을 통한 데이터 처리 )
- **REST 구성 요소** A. 자원 (Resource) URI - 모든 자원에 고유한 id 가 존재하고, 이 자원은 Server 에 존재한다 - 자원을 구별하는 id 는 'localhost:8080/user/:userId' 와 같은 HTTP URI 이다 - Client 는 URI 를 이용해서 자원을 지정하고 해당 자원의 상태(정보)에 대한 조작을 Server 에 요청한다

B. 행위 (Verb) : Http Method     - HTTP 프로토콜의 Method 를 사용한다     - HTTP 프로토콜은 GET, POST, PUT, DELETE, HEAD 와 같은 메서드를 제공한다

C. 표현 (Representation of Resource)      - Client 가 자원의 상태(정보)에 대한 조작을 요청하면 Server 는 이에 적절한 응답표현(Representation) 을 보낸다      - REST 에서 하나의 자원은 JSON, XML, TEXT, RSS 등 여러 형태의 Representation 으로 나타내어 질 수 있다      - 옛날에는 XML 이였지만 현대에는 JSON 으로 표현하고 있다

**- REST 의 특징**    a. Server-Client (서버, 클라이언트 구조)    b. Stateless (무상태성)    c. Cacheable (캐시 처리 가능)    d. Layered System (계층화)    e. Code On Demand (option)    f. Uniform Interface (인터페이스 일관성)

- API 는 해당 어플리케이션을 제어할 수 있게 해주는 중간 인터페이스(연결점입니다)예를들어 키보드라는 인터페이스를 통해 하드웨어어 입력을 해주는 기능을 해주는 것과 같습니다영화 조회 서비스 API 를 통해 특정 명령만 내리면 해당 어플리케이션이 그에 맞는 기능을 수행줍니다
- 정의 - REST 를 기반으로 서비스 API 를 구현한 것 - 최근 OpenAPI(누구나 사용할 수 있도록 공개된 API: 구글 맵, 공공 데이터 등), 마이크로 서비스(하나의 큰 애플리케이션을 여러 개의 작은 애플리케이션으로 쪼개어 변경과 조합이 가능하도록 만든 아키텍처) 등을 제공하는 업체 대부분은 REST API를 제공한다.
- 특징 - REST 기반으로 시스템을 분산해 확장성과 재사용을 높여 유지보수 및 운용을 편리하게 할 수 있다 - REST 는 HTTP 표준을 기반으로 구현하므로, HTTP 를 지원하는 프로그래밍언어로 클라이언트, 서버를 구현할 수 있다기본 설계 규칙 A. URI는 자원(Resource) 를 표현해야 한다 1. resource 는 명사 2. 소문자 복수형 3. GET /members/1 B. 자원에 대한 행위는 HTTP Method (GET, PUT, PATCH, DELETE, POST 등)으로 표현한다 1. URI 에 HTTP Method 가 들어가면 안된다  - GET /members/delete/1 -> DELETE /members/1 2. 어떤 행위(Behavior)나 행동(Action) 에 관해서 동사 표현이 들어가면 안된다 - GET /members/insert/2 -> POST /members/2 - GET /members/show/1 -> GET /members/1
- **REST API 설계 규칙** - **슬래시 구분자(/) 는 계층 관계를 나타내는데 사용된다** - **URI 마지막 문자로 슬래시(/) 를 포함하지 않는다** - **대소문자 구분으로서 kebab case 형식을 사용한다 (team-board)** - **밑줄(_ )은 URI에 사용하지 않는다.**  - 밑줄은 보기 어렵거나 밑줄 때문에 문자가 가려지기도 하므로 가독성을 위해 밑줄은 사용하지 않는다.  - **URI 경로에는 소문자가 적합하다.**  -URI 경로에 대문자 사용은 피하도록 한다. RFC 3986(URI 문법 형식)은 URI 스키마와 호스트를 제외하고는 대소문자를 구별하도록 규정하기 때문  - **파일확장자는 URI에 포함하지 않는다.**  - REST API에서는 메시지 바디 내용의 포맷을 나타내기 위한 파일 확장자를 URI 안에 포함시키지 않는다.  - Accept header를 사용한다.  - Ex) [http://restapi.example.com/members/soccer/345/photo.jpg](http://restapi.example.com/members/soccer/345/photo.jpg) (X)  - Ex) GET / members/soccer/345/photo HTTP/1.1 Host: restapi.example.com Accept: image/jpg (O)  - **리소스 간에는 연관 관계가 있는 경우**  - /리소스명/리소스 ID/관계가 있는 다른 리소스명  - Ex) GET : /users/{userid}/devices (일반적으로 소유 ‘has’의 관계를 표현할 때)  - **:id는 하나의 특정 resource를 나타내는 고유값**  - Ex) student를 생성하는 route: POST /students  - Ex) id=12인 student를 삭제하는 route: DELETE /students/12
- RESTful의 개념
    - RESTful은 일반적으로 REST라는 아키텍처를 구현하는 웹 서비스를 나타내기 위해 사용되는 용어이다.
        - 즉, REST 원리를 따르는 시스템은 RESTful이란 용어로 지칭된다.
    - RESTful은 REST를 REST답게 쓰기 위한 방법으로, 누군가가 공식적으로 발표한 것이 아니다.
- RESTful의 목적
    - 이해하기 쉽고 사용하기 쉬운 REST API를 만드는 것
    - RESTful API를 구현하는 근본적인 목적이 퍼포먼스 향상에 있는게 아니라, 일관적인 컨벤션을 통한 API의 이해도 및 호환성을 높이는게 주 동기이니, 퍼포먼스가 중요한 상황에서는 굳이 RESTful API를 구현하실 필요는 없습니다.
- RESTful 하지 못한 경우
    - Ex1) CRUD 기능을 모두 POST로만 처리하는 API
    - Ex2) route에 resource, id 외의 정보가 들어가는 경우(/students/updateName)

객체 지향 프로그래밍(Object Oriented Programming)여러 소프트웨어 관련 IT기업 신입사원 기술면접에서 면접자들 긴장을 풀어줄 겸 워밍업으로 자주 나오는 질문이다."객체 지향 프로그래밍에 대해 설명 한번 해주세요"가장 기본인 질문이지만, 이것마저 대답을 못하면 첫인상이 나빠지는 결과를 만들 수 있기에 중요한 질문이다.앞서 워밍업이라 표현했지만 답변에 따라 꼬리에 꼬리를 무는 모든 질문의 시작점이기도 하다.객체 지향 프로그래밍(OOP)이 뭐에요?객체 지향 프로그래밍은 컴퓨터 프로그래밍 패러다임 중 하나로,프로그래밍에서 필요한 데이터를 추상화시켜 상태와 행위를 가진 객체를 만들고 그 객체들 간의 유기적인 상호작용을 통해 로직을 구성하는 프로그래밍 방법이다.
이러면 이제 아까 말했던 꼬리에 꼬리를 무는 질문이 시작된다."객체 지향 프로그래밍을 했을 때 장점이 뭐에요?""객체 지향 프로그래밍의 특징을 말씀해주세요""객체(또는 클래스)가 뭐에요?"=> 결국 객체 지향 키워드 5가지와 관련된 내용과 장단점을 알고 있는지에 대한 질문이다. (객체 지향의 5원칙(SOLID)을 말하는 것은 아니다.)
객체 지향 프로그래밍의 장, 단점 간단하게 설명해주세요-장점▶코드 재사용이 용이남이 만든 클래스를 가져와서 이용할 수 있고 상속을 통해 확장해서 사용할 수 있다.▶유지보수가 쉬움절차 지향 프로그래밍에서는 코드를 수정해야할 때 일일이 찾아 수정해야하는 반면 객체 지향 프로그래밍에서는 수정해야 할 부분이 클래스 내부에 멤버 변수혹은 메서드로 존재하기 때문에 해당 부분만 수정하면 된다.▶대형 프로젝트에 적합클래스 단위로 모듈화시켜서 개발할 수 있으므로 대형 프로젝트처럼 여러 명, 여러 회사에서 프로젝트를 개발할 때 업무 분담하기 쉽다.-단점▶처리 속도가 상대적으로 느림▶객체가 많으면 용량이 커질 수 있음▶설계시 많은 시간과 노력이 필요객체 지향 프로그래밍 키워드 5가지1) 클래스 + 인스턴스(객체)2) 추상화3) 캡슐화4) 상속5) 다형성클래스와 인스턴스(객체)는 무엇인지 설명해주세요.클래스 : 어떤 문제를 해결하기 위한 데이터를 만들기 위해 추상화를 거쳐집단에 속하는속성(attribute)과행위(behavior)를변수와메서드로 정의한 것으로 객체를 만들기 위한 메타정보라고 볼 수 있다.인스턴스(객체):클래스에서 정의한 것을 토대로 실제 메모리에 할당된 것으로 실제 프로그램에서 사용되는 데이터객체 지향 프로그래밍에서 추상화 (자료의 추상화)객체 지향 프로그래밍에서는 '추상화' 라는 단어를 여러 군데 붙일 수 있다.여기서 말하는 추상화는 추상 클래스나 추상 클래스가 갖는 추상 메서드를 의미하기보다는 클래스를 설계하는 것 자체를 의미한다.즉,"공통의" 속성이나 기능을 묶어 이름을 붙이는 것이다.



REST API(RESTful API, 레스트풀 API)란? 구현 및 사용법
요약
REST API(RESTful API, 레스트풀 API)란 REST 아키텍처의 제약 조건을 준수하는 애플리케이션 프로그래밍 인터페이스를 뜻합니다. REST는 Representational State Transfer의 줄임말입니다. Rest API의 개념 및 서버, 구현 등을 이 페이지에서 설명합니다.

API 또는 애플리케이션 프로그래밍 인터페이스(Application Programming Interface)는 애플리케이션 소프트웨어를 구축하고 통합하는 정의 및 프로토콜 세트입니다. 때때로 API는 정보 제공자와 정보 사용자 간의 계약으로 지칭되며 소비자에게 필요한 콘텐츠(호출)와 생산자에게 필요한 콘텐츠(응답)를 구성합니다. 예를 들어 날씨 서비스용 API에서는 사용자는 우편번호를 제공하고, 생산자는 두 부분(첫 번째는 최고 기온, 두 번째는 최저 기온)으로 구성된 응답으로 답하도록 지정할 수 있습니다.  

즉, 컴퓨터나 시스템과 상호 작용하여 정보를 검색하거나 기능을 수행하고자 할 때 API는 사용자가 원하는 것을 시스템에 전달할 수 있게 지원하여 시스템이 이 요청을 이해하고 이행하도록 할 수 있습니다.

API를 사용자 또는 클라이언트, 그리고 사용자와 클라이언트가 얻으려 하는 리소스 사이의 조정자로 생각하면 됩니다. API는 조직이 보안 및 제어를 유지관리(누가 무엇에 액세스할 수 있는지 결정)하면서 리소스와 정보를 공유할 수 있는 방법이기도 합니다. 

API의 또 다른 이점은 리소스 검색 방법 또는 리소스의 출처에 대한 지식 없이도 사용이 가능하다는 점입니다.

REST(RESTful)란 무엇일까요?
REST는 프로토콜이나 표준이 아닌 아키텍처 원칙 세트입니다. API 개발자는 REST를 다양한 방식으로 구현할 수 있습니다.

RESTful API를 통해 요청이 수행될 때 RESTful API는 리소스 상태에 대한 표현을 요청자에게 전송합니다. 이 정보 또는 표현은 HTTP: JSON(Javascript Object Notation), HTML, XLT 또는 일반 텍스트를 통해 몇 가지 형식으로 전송됩니다. JSON은 그 이름에도 불구하고 사용 언어와 상관이 없을 뿐 아니라 인간과 머신이 모두 읽을 수 있기 때문에 가장 널리 사용됩니다. 

API가 RESTful로 간주되려면 다음 기준을 따라야 합니다.

클라이언트, 서버 및 리소스로 구성되었으며 요청이 HTTP를 통해 관리되는 클라이언트-서버 아키텍처
스테이트리스(stateless) 클라이언트-서버 커뮤니케이션: 요청 간에 클라이언트 정보가 저장되지 않으며, 각 요청이 분리되어 있고 서로 연결되어 있지 않음
클라이언트-서버 상호 작용을 간소화하는 캐시 가능 데이터
정보가 표준 형식으로 전송되도록 하기 위한 구성 요소 간 통합 인터페이스. 여기에 필요한 것은 다음과 같습니다.
요청된 리소스가 식별 가능하며 클라이언트에 전송된 표현과 분리되어야 합니다.
수신한 표현을 통해 클라이언트가 리소스를 조작할 수 있어야 합니다(이렇게 할 수 있는 충분한 정보가 표현에 포함되어 있기 때문).
클라이언트에 반환되는 자기 기술적(self-descriptive) 메시지에 클라이언트가 정보를 어떻게 처리해야 할지 설명하는 정보가 충분히 포함되어야 합니다.
하이퍼미디어: 클라이언트가 리소스에 액세스한 후 하이퍼링크를 사용해 현재 수행 가능한 기타 모든 작업을 찾을 수 있어야 합니다.
요청된 정보를 검색하는 데 관련된 서버(보안, 로드 밸런싱 등을 담당)의 각 유형을 클라이언트가 볼 수 없는 계층 구조로 체계화하는 계층화된 시스템.
코드 온디맨드(선택 사항): 요청을 받으면 서버에서 클라이언트로 실행 가능한 코드를 전송하여 클라이언트 기능을 확장할 수 있는 기능. 
이처럼 REST API는 따라야 할 기준이 있지만, 속도를 저하시키고 더 무겁게 만드는 XML 메시징, 빌트인 보안 및 트랜잭션 컴플라이언스처럼 특정 요구 사항이 있는 SOAP(Simple Object Access Protocol) 등의 규정된 프로토콜보다 사용하기 쉬운 것으로 간주됩니다. 

이와 대조적으로 REST는 필요에 따라 구현할 수 있는 일련의 지침으로, 이를 통해 REST API는 더 빨라지고 경량화되며 사물인터넷(IoT) 및 모바일 앱 개발에 가장 적합한 API가 됩니다. 

API 중심 솔루션의 기능과 특징
Red Hat® Integration은 애플리케이션 연결성 및 데이터 트랜스포메이션, 서비스 구성 및 오케스트레이션, 실시간 메시지 스트리밍, 변경 데이터 캡처, API 관리를 한 곳에서 모두 제공하여 하이브리드 인프라 전반의 애플리케이션 및 데이터를 연결하는 API 중심 솔루션입니다. 이 솔루션은 클라우드 네이티브 플랫폼 및 툴체인과 결합되어 현대적인 애플리케이션 개발을 지원합니다. 


App Store Connect

Changes needed.

CollaboGame
iOS

Thank you for submitting CollaboGame for review. During our review, we noticed a few things that you'll need to address before your app can be approved for the App Store.

Understand the Review
To find out why your app wasn't approved, go to Resolution Center in iTunes Connect. Keep in mind that there may be more than one reason why your app was rejected. It's also possible that we need more information about your app.

If you have a question about your app's review, send us a message in Resolution Center. If you would prefer to speak over the phone, just let us know in your message, and we'll schedule a call.

Visit Resolution Center >

Address the Issue
After you understand the review, you'll need to make the necessary changes to fix the issue. If you need help making these changes, you can get advice from fellow developers and Apple experts in the Developer Forums. If you have a technical question that can't be answered in the Developer Forums, you can request code-level technical support by visiting the Code-Level Support page in your account on the Apple Developer website.

Resubmit Your App
Sometimes, we just need some additional information about your app, or your app's metadata needs to be edited. If this is the case, you don't need to resubmit your app. Simply make the changes and send us a message in Resolution Center when you're done.

If other changes need to be made, you'll need to resubmit. After you do, we'll typically respond within 48 hours, unless your app requires extra attention.

After we've completed the review, we'll update your app's status and let you know.

Best regards,

App Store Review

1-1

### **Guideline 1.5 - Safety - Developer Information**

The support URL specified in your app’s metadata,

[https://collabogame.tistory.com/](https://collabogame.tistory.com/)

, does not properly navigate to the intended destination.

- Specifically, link does not provide support contact information.

**Next Steps**

To resolve this issue, please revise your app’s support URL to ensure it directs users to a webpage with support information.

1-2

Guideline 4.0 - Design

We noticed that several screens of your app were crowded or laid out in a way that made it difficult to use your app.

- Specifically, tabs are cut off on the game screens.

Review device details:

- Device type: iPad
- OS version: iOS 15.5

==

iOS 앱 1.0앱 버전
거절 사유:

1.5.0 Safety: Developer Information

4.0.0 Design: Preamble


[AppStore]
리젝[https://imjeongwoo.tistory.com/51](https://imjeongwoo.tistory.com/51)

[https://blog.naver.com/PostView.nhn?blogId=y2kelvin&logNo=220421796782](https://blog.naver.com/PostView.nhn?blogId=y2kelvin&logNo=220421796782)

아카이브 활성화 [https://ithub.tistory.com/255](https://ithub.tistory.com/255)

[앱출시][https://ios-development.tistory.com/299](https://ios-development.tistory.com/299)

[https://hsdev.tistory.com/entry/iOS-앱-배포-5-xcode-Archive-하기](https://hsdev.tistory.com/entry/iOS-%EC%95%B1-%EB%B0%B0%ED%8F%AC-5-xcode-Archive-%ED%95%98%EA%B8%B0)

[앱출시필요][https://ios-development.tistory.com/382](https://ios-development.tistory.com/382)

등록 xcode,archive [https://blog.naver.com/ohhorala/222146216018](https://blog.naver.com/ohhorala/222146216018)

[개인정보처리방침]

[https://blog.naver.com/shinequasar/222476235631](https://blog.naver.com/shinequasar/222476235631), [https://blog.naver.com/yshan1008/222084179151](https://blog.naver.com/yshan1008/222084179151)

[앱출시변경사항] [https://docko.tistory.com/772](https://docko.tistory.com/772)


Reject - Re-registration
# 1. **Your App Review Feedback**

App Store Connect

Changes needed.

CollaboGame
iOS

Thank you for submitting CollaboGame for review. During our review, we noticed a few things that you'll need to address before your app can be approved for the App Store.

Understand the Review
To find out why your app wasn't approved, go to Resolution Center in iTunes Connect. Keep in mind that there may be more than one reason why your app was rejected. It's also possible that we need more information about your app.

If you have a question about your app's review, send us a message in Resolution Center. If you would prefer to speak over the phone, just let us know in your message, and we'll schedule a call.

Visit Resolution Center >

Address the Issue
After you understand the review, you'll need to make the necessary changes to fix the issue. If you need help making these changes, you can get advice from fellow developers and Apple experts in the Developer Forums. If you have a technical question that can't be answered in the Developer Forums, you can request code-level technical support by visiting the Code-Level Support page in your account on the Apple Developer website.

Resubmit Your App
Sometimes, we just need some additional information about your app, or your app's metadata needs to be edited. If this is the case, you don't need to resubmit your app. Simply make the changes and send us a message in Resolution Center when you're done.

If other changes need to be made, you'll need to resubmit. After you do, we'll typically respond within 48 hours, unless your app requires extra attention.

After we've completed the review, we'll update your app's status and let you know.

Best regards,

App Store Review

1-1

### **Guideline 1.5 - Safety - Developer Information**

The support URL specified in your app’s metadata,

[https://collabogame.tistory.com/](https://collabogame.tistory.com/)

, does not properly navigate to the intended destination.

- Specifically, link does not provide support contact information.

**Next Steps**

To resolve this issue, please revise your app’s support URL to ensure it directs users to a webpage with support information.

1-2

Guideline 4.0 - Design

We noticed that several screens of your app were crowded or laid out in a way that made it difficult to use your app.

- Specifically, tabs are cut off on the game screens.

Review device details:

- Device type: iPad
- OS version: iOS 15.5

==

iOS 앱 1.0앱 버전
거절 사유:

1.5.0 Safety: Developer Information

4.0.0 Design: Preamble



# 1-2. We noticed an issue with your submission.

Hello,

Thank you for submitting your items for review. We noticed an issue with your submission that requires your attention.
Submission ID: 
App Name: CollaboGame

We look forward to working with you to resolve the issues with the following items:

App Version
1.0 for iOS

For details, next steps, and to ask questions about these issues, please visit the App Review page in App Store Connect.

Best regards,
App Store Review
