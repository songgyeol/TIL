# TIL
#####################################################################################2022.02.20
BMI_MVC
SecondViewController

import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var bmiNumberLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    // 전화면에서 전달받은 BMI를 저장하기 위한 변수
    var bmi: BMI?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
    }
    
    func configureUI() {
        // 전화면에서 전달받은 BMI를 통해 셋팅
        bmiNumberLabel.text = "\(bmi!.value)"
        bmiNumberLabel.backgroundColor = bmi?.matchColor
        adviceLabel.text = bmi?.advice
        
        // UI셋팅
        bmiNumberLabel.clipsToBounds = true
        bmiNumberLabel.layer.cornerRadius = 8

        backButton.layer.cornerRadius = 5
    }
    
    // 다시 계산하기 버튼 눌렀을때
    @IBAction func backButtonTapped(_ sender: UIButton) {
        // 전화면으로 돌아가는 메서드
        self.dismiss(animated: true, completion: nil)
    }
}

#####################################################################################2022.02.19
BMI_MVC
ViewController

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    //비즈니스로직 담당 인스턴스 - BMI계산과 관련된 모든 것
    var bmiManager = BMICalculatorManager()
    
    //var bmi: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // 텍스트필드의 대리자 설정 (대리자: 뷰컨트롤러)
        heightTextField.delegate = self
        weightTextField.delegate = self
        configureUI()
    }
    
    // UI셋팅 (스토리보드 이외)
    func configureUI() {
        mainLabel.text = "키와 몸무게를 입력해 주세요"
        calculateButton.layer.cornerRadius = 5
        heightTextField.placeholder = "cm단위로 입력해주세요"
        weightTextField.placeholder = "kg단위로 입력해주세요"
    }
    
    // BMI계산하기 - 버튼 누르면(다음화면)
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        print(#function)

    }
    
    // 조건에 따라 다음화면 이동할지/말지
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        print(#function)
        if heightTextField.text == "" || weightTextField.text == "" {
            mainLabel.text = "키와 몸무게를 입력하셔야만 합니다!!!"
            mainLabel.textColor = UIColor.red
            return false
        }
        mainLabel.text = "키와 몸무게를 입력해 주세요"
        mainLabel.textColor = UIColor.black
        return true
    }
    
    // 다음화면 넘어가기 전에 준비 (일반적으로 데이터 전달)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(#function)
        // 항상 식별자 먼저 확인
        if segue.identifier == "toSecondVC" {
            let secondVC = segue.destination as! SecondViewController
            secondVC.modalPresentationStyle = .fullScreen
            
            //비즈니스로직 담당 인스턴스에서 BMI얻어서
            let bmi = bmiManager.getBMI(height: heightTextField.text!, weight: weightTextField.text!)
            
            // (다음화면으로 데이터 전달) BMI 전달
            secondVC.bmi = bmi
        }
        // 다음화면으로 가기전에 텍스트필드 비우기
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
}

extension ViewController: UITextFieldDelegate {
    // 입력하거나 (지우거나) 할때마다 (한글자 한글자 입력하는 순간마다) 호출되는 메서드
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(string)
        // "숫자"인 경우와 "지우는 경우"만 (글자입력을) 허용 하는 논리
        // (숫자로 변환이 된다면) || (지울때)
        if Int(string) != nil || string == "" {
            return true  // 글자 입력을 허용
        }
        return false  // 글자입력 허용하지 않음
    }
    
    // 키보드 엔터키가 눌렸을때 (다음 동작을 허락할 것인지)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 두개의 텍스트필드를 모두 종료 (키보드 내려가기)
        if heightTextField.text != "", weightTextField.text != "" {
            weightTextField.resignFirstResponder()
            return true
        // 두번째 텍스트필드로 넘어가도록
        } else if heightTextField.text != "" {
            weightTextField.becomeFirstResponder()
            return true
        }
        return false
    }
    
    // 텍스트필드 이외의 영역을 눌렀을때 키보드 내려가도록
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
    
}


#####################################################################################2022.02.18
BMI_MVC_2
import UIKit

// BMI는 하나의 데이터 묶음 - (데이터) 모델
struct BMI {
    let value: Double
    let advice: String
    let matchColor: UIColor
}

#####################################################################################2022.02.17
BMI_MVC
import UIKit

// 비즈니스 로직 담당 모델 - BMI계산과 관련된 모든 것
struct BMICalculatorManager {
    
    // BMI 저장변수
    private var bmi: BMI?
    
    // BMI얻기 메서드
    mutating func getBMI(height: String, weight: String) -> BMI {
        // BMI만들기 메서드 호출
        calculateBMI(height: height, weight: weight)
        // BMI리턴
        return bmi ?? BMI(value: 0.0, advice: "문제발생", matchColor: UIColor.white)
    }
    
    // BMI만들기 메서드(BMI수치 계산해서, BMI구조체 인스턴스 만드는 메서드)
    mutating private func calculateBMI(height: String, weight: String) {
        guard let h = Double(height), let w = Double(weight) else {
            bmi = BMI(value: 0.0, advice: "문제발생", matchColor: UIColor.white)
            return
        }
        
        var bmiNum = w / (h * h) * 10000
        bmiNum = round(bmiNum * 10) / 10
        
        switch bmiNum {
        case ..<18.6:
            let color = UIColor(displayP3Red: 22/255,
                                green: 231/255,
                                blue: 207/255,
                                alpha: 1)
            bmi = BMI(value: bmiNum, advice: "저체중", matchColor: color)
            
        case 18.6..<23.0:
            let color = UIColor(displayP3Red: 212/255,
                                green: 251/255,
                                blue: 121/255,
                                alpha: 1)
            bmi = BMI(value: bmiNum, advice: "표준", matchColor: color)
            
            
        case 23.0..<25.0:
            let color = UIColor(displayP3Red: 218/255,
                                green: 127/255,
                                blue: 163/255,
                                alpha: 1)
            bmi = BMI(value: bmiNum, advice: "표준", matchColor: color)
        case 25.0..<30.0:
            let color = UIColor(displayP3Red: 255/255,
                                green: 150/255,
                                blue: 141/255,
                                alpha: 1)
            bmi = BMI(value: bmiNum, advice: "표준", matchColor: color)
        case 30.0...:
            let color = UIColor(displayP3Red: 255/255,
                                green: 100/255,
                                blue: 78/255,
                                alpha: 1)
            bmi = BMI(value: bmiNum, advice: "표준", matchColor: color)
        default:
            bmi = BMI(value: 0.0, advice: "문제발생", matchColor: UIColor.white)
        }
    }
    
    
//    func getBMIValue() -> Double {
//        return bmi?.value ?? 0.0
//    }
//
//    func getAdviceString() -> String {
//        return bmi?.advice ?? "문제발생"
//    }
//
//    func getColor() -> UIColor {
//        return bmi?.matchColor ?? #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
//    }
    
}

#####################################################################################2022.02.15
//화면이동_BMI2
SecondViewController
import UIKit

class SecondViewController: UIViewController {

    @IBOutlet weak var bmiNumberLabel: UILabel!
    @IBOutlet weak var adviceLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    // 전화면에서 전달받은 데이터들
    var bmiNumber: Double?
    var adviceString: String?
    var bmiColor: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // 전화면에서 전달받은 데이터들을 통해 셋팅
        bmiNumberLabel.text = "\(bmiNumber!)"
        bmiNumberLabel.backgroundColor = bmiColor
        adviceLabel.text = adviceString
        
        configureUI()
    }
    
    // UI셋팅
    func configureUI() {
        bmiNumberLabel.clipsToBounds = true
        bmiNumberLabel.layer.cornerRadius = 8
        //bmiNumberLabel.backgroundColor = UIColor.brown

        backButton.layer.cornerRadius = 5
    }
    
    // 다시 계산하기 버튼 눌렀을때
    @IBAction func backButtonTapped(_ sender: UIButton) {
        // 전화면으로 돌아가는 메서드
        self.dismiss(animated: true, completion: nil)
    }
    


}

#####################################################################################2022.02.14
//화면이동_BMI
import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    @IBOutlet weak var calculateButton: UIButton!
    @IBOutlet weak var heightTextField: UITextField!
    @IBOutlet weak var weightTextField: UITextField!
    
    // BMI계산 결과값 보관위한 변수
    var bmi: Double?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        heightTextField.delegate = self
        weightTextField.delegate = self
        configureUI()
    }
    
    func configureUI() {
        mainLabel.text = "키와 몸무게를 입력해 주세요"
        calculateButton.layer.cornerRadius = 5
        heightTextField.placeholder = "cm단위로 입력해주세요"
        weightTextField.placeholder = "kg단위로 입력해주세요"
    }
    
    // BMI계산하기 - 버튼 누르면(다음화면)
    @IBAction func calculateButtonTapped(_ sender: UIButton) {
        print(#function)
        bmi = calculateBMI(height: heightTextField.text!, weight: weightTextField.text!)
        
        
        // 필요없음(버튼에서 직접 연결)
        //performSegue(withIdentifier: "toSecondVC", sender: self)
    }
    
    // 조건에 따라 다음화면 이동할지/말지
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        print(#function)
        if heightTextField.text == "" || weightTextField.text == "" {
            mainLabel.text = "키와 몸무게를 입력하셔야만 합니다!!!"
            mainLabel.textColor = UIColor.red
            return false
        }
        mainLabel.text = "키와 몸무게를 입력해 주세요"
        mainLabel.textColor = UIColor.black
        return true
    }
    
    // 다음화면 넘어가기 전에 준비 (일반적으로 데이터 전달)
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        print(#function)
        // 항상 식별자 먼저 확인
        if segue.identifier == "toSecondVC" {
            let secondVC = segue.destination as! SecondViewController
            secondVC.modalPresentationStyle = .fullScreen
            
            // 다음화면으로 데이터 전달
            secondVC.bmiNumber = bmi
            secondVC.bmiColor = getBackgroundColor()
            secondVC.adviceString = getBMIAdviceString()
        }
        // 다음화면으로 가기전에 텍스트필드 비우기
        heightTextField.text = ""
        weightTextField.text = ""
    }
    
    // BMI계산 메서드
    func calculateBMI(height: String, weight: String) -> Double {
        guard let h = Double(height), let w = Double(weight) else { return 0.0 }
        var bmi = w / (h * h) * 10000
        bmi = round(bmi * 10) / 10
        print("BMI결과값: \(bmi)")
        return bmi
    }
    
    // 색깔 얻는 메서드
    func getBackgroundColor() -> UIColor {
        guard let bmi = bmi else { return UIColor.black }
        switch bmi {
        case ..<18.6:
            return UIColor(displayP3Red: 22/255, green: 231/255, blue: 207/255, alpha: 1)
        case 18.6..<23.0:
            return UIColor(displayP3Red: 212/255, green: 251/255, blue: 121/255, alpha: 1)
        case 23.0..<25.0:
            return UIColor(displayP3Red: 218/255, green: 127/255, blue: 163/255, alpha: 1)
        case 25.0..<30.0:
            return UIColor(displayP3Red: 255/255, green: 150/255, blue: 141/255, alpha: 1)
        case 30.0...:
            return UIColor(displayP3Red: 255/255, green: 100/255, blue: 78/255, alpha: 1)
        default:
            return UIColor.black
        }
    }
    
    // 문자열 얻는 메서드
    func getBMIAdviceString() -> String {
        guard let bmi = bmi else { return "" }
        switch bmi {
        case ..<18.6:
            return "저체중"
        case 18.6..<23.0:
            return "표준"
        case 23.0..<25.0:
            return "과체중"
        case 25.0..<30.0:
            return "중도비만"
        case 30.0...:
            return "고도비만"
        default:
            return ""
        }
    }
    
}

extension ViewController: UITextFieldDelegate {
    // 입력하거나 (지우거나) 할때마다 (한글자 한글자 입력하는 순간마다) 호출되는 메서드
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(string)
        // "숫자"인 경우와 "지우는 경우"만 (글자입력을) 허용 하는 논리
        // (숫자로 변환이 된다면) || (지울때)
        if Int(string) != nil || string == "" {
            return true  // 글자 입력을 허용
        }
        return false  // 글자입력 허용하지 않음
    }
    
    // 키보드 엔터키가 눌렸을때 (다음 동작을 허락할 것인지)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        // 두개의 텍스트필드를 모두 종료 (키보드 내려가기)
        if heightTextField.text != "", weightTextField.text != "" {
            weightTextField.resignFirstResponder()
            return true
        // 두번째 텍스트필드로 넘어가도록
        } else if heightTextField.text != "" {
            weightTextField.becomeFirstResponder()
            return true
        }
        return false
    }
    
    // 텍스트필드 이외의 영역을 눌렀을때 키보드 내려가도록
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        heightTextField.resignFirstResponder()
        weightTextField.resignFirstResponder()
    }
    
}

#####################################################################################2022.02.13
import UIKit

class ViewController: UIViewController {
    //클로저 실행문(코드가 길때 클로저 실행문으로 하면 가독성 및 바로바로 확인 가능)
    let emailTextFieldView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.darkGray
        //코너를 둥글게
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        
        return view
        
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       makeUI()
        
        
        
    }
    
    func makeUI() {
      
        view.addSubview(emailTextFieldView)
        
        //오토레이아웃을 수동으로 설정하겠다 = 오토레이아웃을 자동으로 설정하는걸 끄겠다
        emailTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        
        emailTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        emailTextFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        
        emailTextFieldView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }

}

#####################################################################################2022.02.13
LoginProject_Programmatically
import UIKit

class ViewController: UIViewController {

    let emailTextFieldView = UIView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
       makeUI()
        
        
        
    }
    
    func makeUI() {
        emailTextFieldView.backgroundColor = UIColor.darkGray
        
        view.addSubview(emailTextFieldView)
        
        //오토레이아웃을 수동으로 설정하겠다 = 오토레이아웃을 자동으로 설정하는걸 끄겠다
        emailTextFieldView.translatesAutoresizingMaskIntoConstraints = false
        
        emailTextFieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        
        emailTextFieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        
        emailTextFieldView.topAnchor.constraint(equalTo: view.topAnchor, constant: 200).isActive = true
        
        emailTextFieldView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        
    }

}

#####################################################################################2022.02.12
SecondNewApp_Email
import UIKit

class ViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        textField.placeholder = "email"
        
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.clearButtonMode = UITextField.ViewMode.always
        textField.keyboardType = .emailAddress
        textField.returnKeyType = .next
        
        // 최초응답자 설정(responder) (뷰마다 특성이 조금 다름) (UIResponder)
        // 전체화면이 터치를 입력받을 수 있는 상태 ==> 텍스트필드가 가장 먼저 입력받는 상태
        // 키보드가 올라옴 (손가락 터치로 직접 최초응답자 설정도 가능)
        textField.becomeFirstResponder()
        //textField.resignFirstResponder()
        
        // 텍스트필드의 대리자가 뷰컨트롤러가됨
        // (텍스트필드에서 일어나는 일을 전달받음)
        textField.delegate = self
    }
    
    @IBAction func doneButtonTapped(_ sender: UIButton) {
        textField.resignFirstResponder()
        //self.view.endEditing(true)
    }
    
    
    // 텍스트필드의 입력을 시작할때 호출 (시작할지 말지를 물어보는 것)
    func textFieldShouldBeginEditing(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    // 텍스트필드의 입력이 시작되면 호출 (시점)
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print(#function)
    }
    
    // 텍스트필드 내용을 삭제할 때 호출 (삭제할지 말지를 물어보는 것)
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    // 텍스트필드에 글자내용이 (한글자 한글자) 입력되거나 지워질때 호출 (허용할지 말지를 물어보는 것)
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        print(#function)
        print("텍스트필드의 입력값: \(string)")
        
        // 입력되고 있는 글자가 "숫자"인 경우 입력을 허용하지 않는 논리
        if Int(string) != nil {  // (숫자로 변환이 된다면 nil이 아닐테니)
            return false
        } else {
            // 10글자이상 입력되는 것을 막는 코드
            guard let text = textField.text else { return true }
            let newLength = text.count + string.count - range.length
            return newLength <= 10
        }
        
        // 10글자이상 입력되는 것을 막는 코드 (또다른 구현법)
        if (textField.text?.count)! + string.count > 10 {
            return false
        } else {
            return true
        }
        
        //return true
    }
    
    // 텍스트필드의 엔터키가 눌러졌을때 호출 (동작할지 말지 물어보는 것)
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        print(#function)
        return true
    }
    
    // 텍스트필드의 입력이 끝날때 호출 (끝낼지 말지를 물어보는 것)
    func textFieldShouldEndEditing(_ textField: UITextField) -> Bool {
        print(#function)
        
        // 실제 텍스트필드에 아무것도 입력이 되어 있지 않으면, 입력을 끝내지 못하게
        if textField.text == "" {
            textField.placeholder = "Type Something!"
            return false
        } else {
            return true
        }
        //return true
    }
    
    // 텍스트필드의 입력이 (실제) 끝났을때 호출 (시점)
    func textFieldDidEndEditing(_ textField: UITextField) {
        print(#function)
        textField.text = ""
    }
    
    // 화면에 탭을 감지(UIResponder)하는 메서드
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        textField.resignFirstResponder()
        //self.view.endEditing(true)
    }
    
}



#####################################################################################2022.02.11
FirstNewApp_Timer
import UIKit
import AVFoundation


class ViewController: UIViewController {

    @IBOutlet weak var mainLabel: UILabel!
    
    @IBOutlet weak var slider: UISlider!
    
    // 숫자(선택된 초)를 관리하기 위한 변수
    var number = 0
    // 타이머 객체를 담기 위한 변수
    var timer: Timer?
    
    // 앱의 화면에 들어오면 처음 실행시키는 함수
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // UI셋팅 함수
    func configureUI() {
        mainLabel.text = "초를 선택하세요"
        slider.value = 0.5
    }
    
    // 슬라이더 값이 바뀔때마다 호출되는 함수
    @IBAction func sliderChanged(_ sender: UISlider) {
        let seconds = Int(sender.value * 60)
        mainLabel.text = "\(seconds) 초"
        number = seconds
    }
    
    // 스타트버튼을 누르면 실행하는 함수
    @IBAction func startButtonTapped(_ sender: UIButton) {
        timer?.invalidate()
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(doSomethingAfter1Second), userInfo: nil, repeats: true)
    }
    
    
    
    // 다음 동작의 실행 함수
    @objc func doSomethingAfter1Second() {
        if number > 0 {
            number -= 1
            print(Float(number) / Float(60))
            slider.value = Float(number) / Float(60)
            mainLabel.text = "\(number) 초"
        } else {
            mainLabel.text = "초를 선택하세요"
            number = 0
            //print(number)
            timer?.invalidate()
            AudioServicesPlaySystemSound(SystemSoundID(1000))
        }
    }
    
    // 리셋버튼이 눌리면 실행되는 함수
    @IBAction func resetButtonTapped(_ sender: UIButton) {
        timer?.invalidate()
        mainLabel.text = "초를 선택하세요"
        slider.value = 0.5
        number = 0
    }
    
}


#####################################################################################2022.02.10
SwiftStudy - DominoFinal, DelegateTextField

코드 다중선택해서 글쓰기 : contr + shift + 클릭 또는 화살표


#####################################################################################2022.02.09
View에게 터치이벤트 주기
- button, stepper 등과 다르게 label, view, imageView 등은 터치 이벤트를 못 받음
- 그럴 때 `UIGestureRecognizer`를 이용해주면 됨

- 터치 이벤트 못 받는 이미지뷰 선언

```swift
let myImgView = UIImageView()
```

- `UIGestureRecognizer` 객체 찍어낸 후, 이벤트 부여

```swift
func setGesture() {
        let gestureRecognizer = UIGestureRecognizer()
        myImgView.isUserInteractionEnabled = true
        myImgView.addGestureRecognizer(gestureRecognizer)
        gestureRecognizer.addTarget(self, action: #selector(imgTappe(_:)))
    }
```

- `UIGestureRecognizer` 말고도 여러가지 recognizer가 있으니, 원하는 것 사용하면 됨


#####################################################################################2022.02.08
이를 해결하려면 ImageLoader 인스턴스를 생성한 후
인스턴스를 사용하는 클래스/구조체 변수에 인스턴스에 대한 참조를 유지하고
동일한 캐시가 필요한 다른 소비자에게 전달해야 합니다
 (종속성 주입 기술은 이에 대한 좋은 접근 방식입니다).
따라서 일정량의 항목이 있는 하나의 캐시가 존재하고 작동합니다.

또는 가장 간단한 방법은 ImageLoader의 공유 인스턴스를 만들어 사용하는 것이므로
하나의 채워진 캐시로 하나의 인스턴스도 보장합니다.


[https://namu.wiki/w/캐시 메모리](https://namu.wiki/w/%EC%BA%90%EC%8B%9C%20%EB%A9%94%EB%AA%A8%EB%A6%AC)

[https://sihyungyou.github.io/iOS-dependency-injection/](https://sihyungyou.github.io/iOS-dependency-injection/)

[https://youtu.be/sHLd1BuW0aU](https://youtu.be/sHLd1BuW0aU)

무슨 방식을 한건지 모르겠지만 그냥 한마디로 똑같은 메모리 주소 계속 전달하라는 뜻이야

#####################################################################################2022.02.07
extension위치
### `extension`으로 보통 클래스를 확장하여 오토레이아웃 등을 잡는데, 이벤트 메서드 등의 위치는 기본 레이아웃 전이 나은지 후가 나은지?
- 나중에 코드 짜는 게 익숙해지면 레이아웃은 한 번 짠 후로는 잘 보지 않기 때문에 맨 밑으로 내려두고 더 자주 보게 되는 코드들을 위에 두는 게 좋다

Core Location
### `MapView`와 `Core Location`의 차이가 뭔지?
- `MapView`는 말 그대로 지도 그 자체
- `Core Location`은 유저의 위치와 관련됨
- 예를 들어 지도에서 신림역을 찾는다면, `MapView`만 있으면 되지만, 내위치에서 신림역을 찾을 때는 `Core Location`을 함께 사용

delegate (protocol)
### Delegate를 생성하는 뷰

- 텍스트필드 값 입력받는 뷰컨 (여기서는 `secondViewController.swift`)
1. **Protocol** 을 생성하고, 요구사항을 **method** 로 생성

```swift
protocol CustomTextFieldDelegate: class {
    func textDidInput(didInput text: String)
}
```

1. Protocol 을 Type 으로 갖는 **Delegate** 인스턴스 생성

```swift
weak var delegate: CustomTextFieldDelegate?
```

1. 생성한 method 가 **동작해야하는 상황**에 코드 작성
- 버튼을 누르면 텍스트필드에 입력된 값이 text라는 상수에 할당
- 할당된 text상수를 delegate 변수의 파라미터로 넣기
- 두번째 뷰 닫기

```swift
@objc private func handleButton(_ sender: UIButton) {
        let text = textField.text ?? ""
        self.delegate?.textDidInput(didInput: text)
        self.dismiss(animated: true, completion: nil)
    }
}
```

---

### **Delegate 를 위임받는 뷰**

- 여기서는 `FirstViewController.swift`
1. ViewController 에 **Delegate Protocol** 채택 & Protocol **필수 method** 구현

```swift
extension FirstViewController: CustomTextFieldDelegate {
    func textDidInput(didInput text: String) { // 프로토콜의 요구사항(필수 메서드)
        label.text = text
    }
}
```

1. Delegate 위임

```swift
@objc private func handleButton(_ sender: UIButton) {
    let nextVC = SecondViewController()
    nextVC.delegate = self
    self.present(nextVC, animated: true, completion: nil)
}
```


#####################################################################################2022.02.04
링크모음
TableView Cell UiButton 연결 - [https://leechamin.tistory.com/500](https://leechamin.tistory.com/500)

Navigation 화면전환하기 - [https://0urtrees.tistory.com/43](https://0urtrees.tistory.com/43)

UinNavigationController에 대해 - [UINavigationController 에 대해](https://tong94.tistory.com/26?category=1065924)

Design Pattern [https://refactoring.guru/refactoring/what-is-refactoring](https://refactoring.guru/refactoring/what-is-refactoring)

#####################################################################################2022.02.03
앱 만들기 TIP
검색
구글검색 -> 스택오버플로우 및 블로그 -> 애플공식문서

*코드로 구현 법 검색단어 : "programmatically"
ex) "how to implement tableview programmatically in swift(코드로 구현)



#####################################################################################2022.01.31
Allen_App Develop

#####################################################################################2022.01.30
유용한 앱
UIKIt Viewer

UIKit Lab

SF Symbols browser

#####################################################################################2022.01.27
Decodable

#####################################################################################2022.01.24
Design Pattern https://refactoring.guru/refactoring/what-is-refactoring


#####################################################################################2022.01.22
Label Layout Test

import UIKit

class ViewController: UIViewController {
    
    let redLabel = UILabel()
    let orangeLabel = UILabel()
    let yellowLabel = UILabel()
    let greenLabel = UILabel()
    let blueLabel = UILabel()
    let manLabel = UILabel()
    let purpleLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
    }
    
    func setUI() {
        
        setBasic()
        setLayout()
        
    }
    
    func setBasic() {
        
        //let safeArea = view.safeAreaLayoutGuide
        //                //모서리 굴곡률
        //                btn.layer.cornerRadius = 10
        //                //테두리 굵기
        //                btn.layer.borderWidth = 2
        //                //테두리 색상
        //                btn.layer.borderColor = UIColor.red.cgColor
        [redLabel, blueLabel, orangeLabel, yellowLabel, greenLabel, blueLabel, manLabel, purpleLabel].forEach {[
            view.addSubview($0),
            $0.translatesAutoresizingMaskIntoConstraints = false,
            $0.layer.cornerRadius = 5,
            $0.layer.borderWidth = 2,
            $0.layer.borderColor = UIColor.black.cgColor,
        ]}
        redLabel.text = "외않되?"
        //redLabel.font = .systemFont(ofSize: 10)
        redLabel.textAlignment = .center
        //redLabel.textColor = .black
        
        orangeLabel.text = "왜절해?"
        orangeLabel.textAlignment = .center
        
        yellowLabel.text = "스냅킷?"
        yellowLabel.textAlignment = .center
        
        greenLabel.text = "코코아팟?"
        greenLabel.textAlignment = .center
        
        blueLabel.text = "스코프?"
        blueLabel.textAlignment = .center
        
        manLabel.text = "도미노?"
        manLabel.textAlignment = .center
        
        manLabel.text = "API?"
        manLabel.textAlignment = .center
        
        purpleLabel.text = "Decodable?"
        purpleLabel.textAlignment = .center
        
        redLabel.backgroundColor = .red
        orangeLabel.backgroundColor = .orange
        yellowLabel.backgroundColor = .yellow
        greenLabel.backgroundColor = .green
        blueLabel.backgroundColor = .blue
        manLabel.backgroundColor = UIColor.systemCyan
        purpleLabel.backgroundColor = .purple
        
        
    }
    
    func setLayout() {
        NSLayoutConstraint.activate([
            redLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 50),
            redLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            redLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -200),
            redLabel.heightAnchor.constraint(equalToConstant: 30),
            
            orangeLabel.topAnchor.constraint(equalTo: redLabel.bottomAnchor, constant: 0),
            orangeLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            orangeLabel.heightAnchor.constraint(equalToConstant: 30),
            orangeLabel.widthAnchor.constraint(equalToConstant: 200),
            
            yellowLabel.topAnchor.constraint(equalTo: orangeLabel.bottomAnchor, constant: 0),
            yellowLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 200),
            yellowLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            yellowLabel.heightAnchor.constraint(equalToConstant: 30),
            
            greenLabel.topAnchor.constraint(equalTo: yellowLabel.bottomAnchor, constant: 0),
            greenLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            greenLabel.heightAnchor.constraint(equalToConstant: 30),
            greenLabel.widthAnchor.constraint(equalToConstant: 200),
            
            blueLabel.topAnchor.constraint(equalTo: greenLabel.bottomAnchor, constant: 0),
            blueLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            blueLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -200),
            blueLabel.heightAnchor.constraint(equalToConstant: 30),
           
            manLabel.topAnchor.constraint(equalTo: blueLabel.bottomAnchor, constant: 0),
            manLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            manLabel.heightAnchor.constraint(equalToConstant: 30),
            manLabel.widthAnchor.constraint(equalToConstant: 200),
            
            purpleLabel.topAnchor.constraint(equalTo: manLabel.bottomAnchor, constant: 0),
            purpleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 200),
            purpleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            purpleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
    }
    
}




#####################################################################################2022.01.21
        //                //모서리 굴곡률
        //                btn.layer.cornerRadius = 10
        //                //테두리 굵기
        //                btn.layer.borderWidth = 2
        //                //테두리 색상
        //                btn.layer.borderColor = UIColor.red.cgColor

import UIKit

class ViewController: UIViewController {
    
    let mainLabel = UILabel()
    let subLabel = UILabel()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUI()
    }
    
    func setUI() {
        
    }
    
    func setBasic() {
        //                //모서리 굴곡률
        //                btn.layer.cornerRadius = 10
        //                //테두리 굵기
        //                btn.layer.borderWidth = 2
        //                //테두리 색상
        //                btn.layer.borderColor = UIColor.red.cgColor
        [mainLabel, subLabel].forEach {[
            view.addSubview($0),
            $0.translatesAutoresizingMaskIntoConstraints = false,
            $0.layer.cornerRadius = 4,
            $0.layer.borderWidth = 2,
            $0.layer.borderColor = UIColor.black.cgColor
        ]}
        mainLabel.text = "dddd"
        mainLabel.font = .systemFont(ofSize: 10)
        mainLabel.textAlignment = .center
        mainLabel.textColor = .black
        mainLabel.backgroundColor = .red
        
    }
    
    func setLayout() {
        NSLayoutConstraint.activate([
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 10),
            mainLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            mainLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            mainLabel.heightAnchor.constraint(equalToConstant: 200),
            
            subLabel.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 40),
            subLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            subLabel.heightAnchor.constraint(equalToConstant: 38),
            subLabel.widthAnchor.constraint(equalToConstant: 140)
            //
            //            subtractButton.topAnchor.constraint(equalTo: quantityLabel.topAnchor),
            //            subtractButton.trailingAnchor.constraint(equalTo: quantityLabel.leadingAnchor),
            //            subtractButton.bottomAnchor.constraint(equalTo: quantityLabel.bottomAnchor),
            //            subtractButton.widthAnchor.constraint(equalToConstant: 20),
            //
            //            addButton.topAnchor.constraint(equalTo: quantityLabel.topAnchor),
            //            addButton.leadingAnchor.constraint(equalTo: quantityLabel.trailingAnchor),
            //            addButton.bottomAnchor.constraint(equalTo: quantityLabel.bottomAnchor),
            //            addButton.widthAnchor.constraint(equalToConstant: 20),
            
        ])
    }
    
}

#####################################################################################2022.01.19
Weather.Temperature#1
import UIKit

class ViewController: UIViewController {
    
    let mainLabel = UILabel()
    let mainButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUI()
        mainLabel.text = "aaa"
        mainLabel.layer.cornerRadius = 5
        
    }
    
    func setUI() {
        setBasic()
        setLayout()

    }
    
    func setBasic() {
        [mainLabel, mainButton].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    func setLayout() {
        NSLayoutConstraint.activate([
            
            mainLabel.topAnchor.constraint(equalTo: view.topAnchor),
            mainLabel.leftAnchor.constraint(equalTo: view.leftAnchor),
            mainLabel.rightAnchor.constraint(equalTo: view.rightAnchor),
            mainLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            
            //mainLabel.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainLabel.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            mainLabel.widthAnchor.constraint(equalToConstant: 120),
            mainLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
}




#####################################################################################2021.12.26
스위치문으로 화면 넘기기
extension TabOneViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return user.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: CustomCell.cellId, for: indexPath) as! CustomCell
        
        cell.mainMenu.image = user[indexPath.row].mainMenu
        // cell.name.text = user[indexPath.row].name
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row{
        case 0:
            let nextVC = SuperSeedViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        case 1:
            let nextVC = PremiumViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        case 2:
            let nextVC = ClasicViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        case 3:
            let nextVC = SideDishViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        case 4:
            let nextVC = DrinkViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)
        case 5:
            let nextVC = SauceViewController()
            self.navigationController?.pushViewController(nextVC, animated: true)

        default:
            break
        }
    }
#####################################################################################2021.12.24
국내IT기업목록
[https://techcompanies.kr](https://techcompanies.kr/)

[https://docs.google.com/spreadsheets/d/1U28rQ6j0_byb1Tola_ZB8xsDsV1MlH1M66Sex6Qk3oM/edit#gid=0](https://docs.google.com/spreadsheets/d/1U28rQ6j0_byb1Tola_ZB8xsDsV1MlH1M66Sex6Qk3oM/edit#gid=0)

#####################################################################################2021.12.23
무료 웹디자인툴 5가지
https://www.youtube.com/watch?v=0Pwxh1XL-Fk

#####################################################################################2021.12.22
웹개발 트렌드(개발자라면 알아두면 돈이되는 트렌드)
https://youtu.be/CFITb_7Duxs


#####################################################################################2021.12.19
99.9%를 압축해버리는 동영상 압축 원리
https://youtu.be/itdPTcBHRbM

#####################################################################################2021.12.18
Label, Button
//main view
import UIKit

class ViewController: UIViewController {

     
    let redButton = UIButton()
    let blueButton = UIButton()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //$0 하는 법
//        [redButton, blueButton].forEach {
//            $0.setTitle("", for: .normal)
//        }
        view.addSubview(redButton)
        redButton.frame.size = CGSize(width: 60, height: 30)
        redButton.layer.cornerRadius = 10
        
        //redButton.setTitle("", for: .normal)
        redButton.backgroundColor = UIColor.systemRed
        redButton.addTarget(self, action: #selector(redBtTapped(_:)), for: .touchUpInside)

        view.addSubview(blueButton)
        blueButton.frame.size = CGSize(width: 60, height: 30)
        blueButton.layer.cornerRadius = 10
        //blueButton.setTitle("", for: .normal)
        blueButton.backgroundColor = UIColor.systemBlue
        blueButton.addTarget(self, action: #selector(blueBtTapped(_:)), for: .touchUpInside)
        
        //[뷰를 유연하게 표현] 생성된 제약을 적용 isActive = true
        redButton.translatesAutoresizingMaskIntoConstraints = false
        blueButton.translatesAutoresizingMaskIntoConstraints = false
        
        //아이폰 m자 탈모라인 안쪽으로
        let safeArea = view.safeAreaLayoutGuide
        //중심
        redButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        blueButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        
        //상단에서부터
        redButton.topAnchor.constraint(equalTo: safeArea.topAnchor, constant: 300).isActive = true
        blueButton.topAnchor.constraint(equalTo: redButton.topAnchor, constant: 200).isActive = true
        
    
    }

    @objc func redBtTapped(_ button: UIButton) {
        //코드로 뷰 연결하는 법
        let redVC = FIrstViewController()
        redVC.modalPresentationStyle = .fullScreen
        self.present(redVC, animated: true)
        
        
    }
    //스토리보드 뷰 이미지 연결하는 법
//        guard let redViewVC = storyboard?.instantiateViewController(identifier: "redView") else { return }
//        redViewVC.modalPresentationStyle = .fullScreen
//        self.present(redViewVC, animated: true, completion: nil)
//    }
    
    
    @objc func blueBtTapped(_ button: UIButton) {
     //코드로 뷰 연결하는 법
        let blueVC = SecondViewController()
        blueVC.modalPresentationStyle = .fullScreen
        self.present(blueVC, animated: true)
        
        
    }
        //스토리보드 뷰 이미지 연결하는 법
//        guard let blueViewVC = storyboard?.instantiateViewController(identifier: "blueView") else { return }
//        blueViewVC.modalPresentationStyle = .fullScreen
//        self.present(blueViewVC, animated: true, completion: nil)
//    }
}




//sub view
import UIKit

class FIrstViewController: UIViewController {

    
    let redBackBt = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.systemRed
        view.layer.cornerRadius = 10
        view.addSubview(redBackBt)
        
        redBackBt.setTitle("뒤로", for: .normal)
        redBackBt.setTitleColor(.black, for: .normal)
        redBackBt.backgroundColor = UIColor.white
        redBackBt.addTarget(self, action: #selector(whiteBackTapped), for: .touchUpInside)
        redBackBt.translatesAutoresizingMaskIntoConstraints = false
        redBackBt.layer.cornerRadius = 10
        
        
        let safeArea = view.safeAreaLayoutGuide
        
                
        redBackBt.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor).isActive = true
        redBackBt.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor).isActive = true
        redBackBt.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 150).isActive = true
        redBackBt.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -150).isActive = true
        // Do any additional setup after loading the view.
    }
    

    @objc func whiteBackTapped(_ button: UIButton) {
        self.presentingViewController?.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

#####################################################################################2021.12.17
날짜와 시간다루기
실제 프로젝트에서 활용 방식

DateComponents를 활용해, 원하는 특정날짜/시간 생성하기

var components = DateComponents()    // 구조체 (날짜/시간의 요소들을 다룰 수 있는)
components.year = 2021
components.month = 1
components.day = 1

components.hour = 12
components.minute = 30
components.second = 0


let specifiedDate: Date = Calendar.current.date(from: components)!
print(specifiedDate)





// 조금 더 세련된 방식으로 구현
// 구조체의 확장이용해서 Date에 생성자 구현

extension Date {
    // 구조체 실패가능 생성자로 구현
    init?(y year: Int, m month: Int, d day: Int) {
        
        var components = DateComponents()
        components.year = year
        components.month = month
        components.day = day
        
        guard let date = Calendar.current.date(from: components) else {
            return nil  // 날짜 생성할 수 없다면 nil리턴
        }
        
        self = date      //구조체이기 때문에, self에 새로운 인스턴스를 할당하는 방식으로 초기화가능
    }
}




let someDate = Date(y: 2021, m: 1, d: 1)      // 특정날짜(시점) 객체 생성
let someDate2 = Date(y: 2021, m: 7, d: 10)

#####################################################################################2021.12.16
Alert#1😎
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




#####################################################################################2021.11.12
NavigationView #1 [view vs nvview]
//viewcontroller와 navigationview

//일반적인 뷰의 사례
import UIKit

class RootViewController: UIViewController {
    ...
    
    func showFirstViewController() {
        // 선언
        let firstVC = UIViewController()
        
        // 화면 띄우기
        self.present(firstVC, animated: true)
    }
    
    ...
}

//네비게이션뷰의 루트뷰컨트롤러 설정
import UIKit

class RootViewController: UIViewController {
    ...
    
    func showNavigationController() {
        // 선언
        let firstVC = UIViewController()
        let naviC = UINavigationController(rootViewController: firstVC)
        
        // 화면 띄우기
        self.present(naviC, animated: true)
    }
    
    ...
}




#####################################################################################2021.11.02_3
Memory Safety_2
###싱글쓰레드에서도 메모리에 동시에 접근하는 경우가 발생
###그런 개념이 메모리가 안전하지 않은 개념이다.

구조체의 인스턴스에서의 메모리 안전

메서드에서 self에 대한 접근
func balance(_ x: inout Int, _ y: inout Int) { // 평균값 설정하는 함수
    let sum = x + y
    x = sum / 2
    y = sum - x
}



/**======================================================
 - 구조체 등의 메서드에서 self(동일한 인스턴스)에 접근하는 경우 접근 충돌
 - 값 타입은 속성 하나가 아닌, 인스턴스 전체에 대한 읽고/쓰기로 접근 ⭐️
 ========================================================**/


// 구조체 정의
struct Player {
    var name: String
    var health: Int
    var energy: Int
    
    // 타입 속성
    static let maxHealth = 10
    
    // health값을 바꾸는 메서드 (self.health에 접근)
    mutating func restoreHealth() {
        health = Player.maxHealth
    }
}

// 확장
extension Player {
    // 자신의 체력과, 동료의 체력을 공유해서 평균 설정
    mutating func shareHealth(with teammate: inout Player) {   // 메모리 장기적 접근
        balance(&teammate.health, &health)
    }
}


var mario = Player(name: "마리오", health: 10, energy: 10)
var luigi = Player(name: "루이지", health: 5, energy: 10)



// "마리오"와 "루이지"의 체력을 공유
mario.shareHealth(with: &luigi)   // 괜찮음


// "마리오"와 "마리오"의 체력을 공유하려면 에러 ⭐️
//mario.shareHealth(with: &mario)


#속성에 대한 접근 충돌의 예시
// 튜플 만들기
var playerInformation = (health: 10, energy: 20)

// 튜플에 대한 동시접근 문제
//balance(&playerInformation.health, &playerInformation.energy)





// 새로운 플레이어 생성
var yosi = Player(name: "요시", health: 10, energy: 10)

// 하나의 인스턴스(요시)의 체력과 에너지를 평균만들려고 하면?
//balance(&yosi.health, &yosi.energy)   // 에러 발생


// 전역이 아닌 "지역 변수"로 만들어서 접근하는 것은 괜찮음
func someFunction() {
    var yosi2 = Player(name: "요시2", health: 10, energy: 10)
    balance(&yosi2.health, &yosi2.energy)   //
}

// 컴파일러가 안전하다는 것을 판단

#####################################################################################2021.11.02_2
Memory Safety_1
###싱글쓰레드에서도 메모리에 동시에 접근하는 경우가 발생
###그런 개념이 메모리가 안전하지 않은 개념이다.

Part26 - 메모리 안전


메모리 안전(Memory Safety)의 개념

메모리 접근에 대한 충돌(confilct) 이해하기


멀티쓰레드(Multi Thread)의 환경에서만 메모리 충돌이 일어나는건 아님
var stepConflict = 1


// 변수 stepConfilt에 장기적인 쓰기 접근 (입출력 파라미터)
func increment(_ number: inout Int) {
    number += stepConflict    // 변수 stepConfilt에 읽기 접근  // number = number + stepConflict
}

//increment(&stepConflict)   // 메모리에 동시접근으로 인한 문제 발생가능





/**=================================
 - 위와 같은 문제는 다른 변수를 만들어서 해결
 ===================================**/


var stepSize = 1
var copyOfStepSize = stepSize    // 명시적으로 복사본 변수를 만들어서 해결


// 변수 stepSize에 장기적인 쓰기 접근 (입출력 파라미터)
func incrementing(_ number: inout Int) {
    number += stepSize         // 변수 stepSize에 읽기 접근       // number = number + stepSize
}



incrementing(&copyOfStepSize)


// 원본을 다시 바꾸기 ⭐️
stepSize = copyOfStepSize



동일한 함수의 여러 '입-출력 매개변수'로 단일 변수를 전달하는 것도 에러
func balance(_ x: inout Int, _ y: inout Int) {  // 평균값 설정하는 함수
    let sum = x + y
    x = sum / 2
    y = sum - x
}

var playerOneScore = 42
var playerTwoScore = 30


// 입출력 파라미터로 동일한 변수를 전달하고 있음
//balance(&playerOneScore, &playerOneScore)   // 에러 발생 ⭐️


balance(&playerOneScore, &playerTwoScore)   // 에러 발생하지 않음

#####################################################################################2021.11.02_1
#참고) 연산의 우선순위 그룹
연산의 우선순위 그룹

우선순위 그룹 - 우선순위와 결합성(Precedence and Associativity)
// 우선 순위 그룹의 선언

precedencegroup MyPrecedence {            // higherThan 또는 lowerThan 둘중에 하나는 반드시 지정해야함
    higherThan: AdditionPrecedence        // ~보다 높은(higherThan): 지정하려는 그룹보다 순위가 낮은 그룹
    lowerThan: MultiplicationPrecedence   // ~보다 낮은(lowerThan): 지정하려는 그룹보다 순위가 높은 그룹
    associativity: left          // 결합성 ===> left / right / none
}




// 우선순위와 결합성의 선언
// https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations

#####################################################################################2021.11.02
사용자 정의 연산자의 구현
사용자 정의 연산자

스위프트가 제공하는 연산자 이외의 연산자 구현

// 조금 더 깊게 연산자에 대해 이해해보기
// (연산자도 사실은 내부적으로 다 구현이 되어있는 타입 메서드임)


// 앞 강의 (연산자 메서드) 예시 =========================================

struct Vector2D {
    var x = 0.0, y = 0.0
}


extension Vector2D {
    static func + (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y + right.y)
    }
}


extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}

// ================================================================




#infix(중위) 연산자의 경우, 연산자의 "우선 순위 그룹"을 지정해야함 (우선 순위, 결합성)
// 중위연산자가 아닌 경우는 지정할 필요없음


/**======================================================
 - 1) 우선순위 그룹의 선언 (우선순위, 결합성 설정)
========================================================**/

precedencegroup MyPrecedence {
    higherThan: AdditionPrecedence
    lowerThan: MultiplicationPrecedence
    associativity: left                   // 결합성 ===> left / right / none
}



/**======================================================
 - 2) (전역의 범위에서) 정의하려는 연산자를 선언하고, 우선순위 그룹을 지정
 - 단항 ==> 전치(prefix), 후치(postfix) / 이항 ==> infix
   키워드를 앞에 붙여야 함
 ========================================================**/


infix operator +-: MyPrecedence



// "우선 순위와 결합성"을 지정은 새로운 우선순위 그룹을 선언하거나, 이미 존재하는 우선 순위 그룹을 사용하는 것도 가능
// 우선순위 그룹을 지정하지 않으면 "DefaultPrecedence"라는 기본 그룹에 속하게 됨
// (삼항연산자보다 한단계 높은 우선순위가 되며, 결합성은 none설정되어 다른 연산자와 결합 사용은 불가능)



/**======================================================
 - 3) 연산자의 실제 정의
 - 해당 연산자를 구현하려는 타입에서 타입메서드로 연산자 내용을 직접 구현
 ========================================================**/

extension Vector2D {
    static func +- (left: Vector2D, right: Vector2D) -> Vector2D {
        return Vector2D(x: left.x + right.x, y: left.y - right.y)
    }
}



// 커스텀 연산자의 사용

let firstVector = Vector2D(x: 1.0, y: 2.0)
let secondVector = Vector2D(x: 3.0, y: 4.0)
let plusMinusVector = firstVector +- secondVector

print(plusMinusVector)                             // Vector2D(x: 4.0, y: -2.0)




// 우선순위와 결합성의 선언
// https://developer.apple.com/documentation/swift/swift_standard_library/operator_declarations




#중위연산자가 아닌 경우의 예시
// 1) 연산자의 선언

prefix operator +++


// 2) 연산자의 실제 정의

extension Vector2D {
    static prefix func +++ (vector: inout Vector2D) -> Vector2D {
        vector += vector   // 복합할당 연산자는 이미 구현되어있기 때문에 사용 가능
        return vector
    }
}


// 커스텀 연산자의 사용

var toBeDoubled = Vector2D(x: 1.0, y: 4.0)
let afterDoubling = +++toBeDoubled
// toBeDoubled 의 값은 이제 (2.0, 8.0) 입니다.
// afterDoubling 도 값이 (2.0, 8.0) 입니다.





// 조금 더 쉬운 예시 =======================================

// 1) 연산자 (위치) 선언

prefix operator ++


// 2) 연산자의 실제 정의

extension Int {
    static prefix func ++(number: inout Int) {
        number += 1
    }
}


var a = 0
++a   // +1
++a   // +1
++a   // +1
print(a)

#####################################################################################2021.11.01_3
연산자 메서드의 직접 구현
연산자 메서드

연산자 메서드? 커스텀 타입에도 메서드의 형태로 연산자(+, -, == 등)를 구현 가능
// 조금 더 깊게 연산자에대해 이해해보기
// (연산자도 사실은 내부적으로 다 구현이 되어있는 타입 메서드임)

"Hello" + ", Swift!"     // "Hello, Swift!"


var a = ""
a += "!"


/**==================================================
 - String 구조체 내부에 타입 메서드로 정의되어 있음
 
 [문자열 더하기]
 static func + (lhs: String, rhs: String) -> String
 
 [문자열 복합할당 연산자]
 static func += (lhs: inout String, rhs: String)
 ==================================================**/


#연산자: 타입.함수이름(파라미터: 타입) 형태로 실행하지 않는.. 특별한 형태의 타입 메서드
//String.+(lhs: "Hello", rhs: ", Swift!")


#연산자 메서드의 구현
// 스위프트 공식 문서의 예제

struct Vector2D {
    var x = 0.0
    var y = 0.0
}


// 1) 산술 더하기 연산자의 구현 (infix 연산자)

//infix operator + : AdditionPrecedence       // 연산자 선언

extension Vector2D {
    static func + (lhs: Vector2D, rhs: Vector2D) -> Vector2D {
        return Vector2D(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}


let vector = Vector2D(x: 3.0, y: 1.0)
let anotherVector = Vector2D(x: 2.0, y: 4.0)

let combinedVector = vector + anotherVector
//print(combinedVector)



// 2) 단항 prefix 연산자의 구현 (전치연산자)

extension Vector2D {
    static prefix func - (vector: Vector2D) -> Vector2D {
        return Vector2D(x: -vector.x, y: -vector.y)
    }
}


let positive = Vector2D(x: 3.0, y: 4.0)
let negative = -positive
//print(negative)
let alsoPositive = -negative
//print(alsoPositive)




// 3) 복합할당 연산자의 구현

extension Vector2D {
    static func += (left: inout Vector2D, right: Vector2D) {
        left = left + right
    }
}



#비교연산자 - 연산자 메서드(==, !=)의 직접적인 구현
"swift" == "Swift"   // false
"swift" == "swift"   // true
"swift" != "swift"   // false

"swift" < "Swift"    // false
"swift" >= "Swift"   // false




/**==================================================
 - String 구조체 내부에 타입 메서드로 정의되어 있음
 
 [Equatable 동일성비교에 관한 프로토콜]
 static func == (lhs: String, rhs: String) -> Bool
 static func != (lhs: String, rhs: String) -> Bool
 
 [Comparable 크기, 순서비교에 관한 프로토콜]
 static func < (lhs: String, rhs: String) -> Bool
 static func > (lhs: String, rhs: String) -> Bool
 static func <= (lhs: String, rhs: String) -> Bool
 static func >= (lhs: String, rhs: String) -> Bool
 ==================================================**/

// Comparable 프로토콜을 채택한 타입에서는 모두 위와 같은 메서드가 구현되어 있음
// (Comparable프로토콜은 Equatable프로토콜을 상속 - 동일성 비교가 가능해야, 크기도 비교 가능)



let vector1 = Vector2D(x: 1.0, y: 2.0)
let vector2 = Vector2D(x: 2.0, y: 3.0)

vector1 == vector2


// "비교 연산자 메서드"를 구현하는 것이 왜 필요할까?
// 같은지 비교를 할 수 없음(비교할 수 있는 연산자 메서드가 구현되어 있지 않기 때문)
// ===> 컴파일러는 어떤 규칙으로 두 인스턴스를 비교해야할지 모름



#Equatable 프로토콜을 채택해야함
/**========================================================================
 - Equatable 프로토콜을 채택하기만 하면
   (이 경우) 컴파일러가 연산자 메서드 구현 내용 자동 추가해줌
   1) 열거형 - 연관값이 있으면서, 모든 연관값이 Equatable 프로토콜을 준수하는 경우
   2) 구조체 - '저장속성'만 가지며, 저장속성의 타입이 Equatable 프로토콜을 준수하는 경우
 
 - == (Equal to operator)를 구현하면 != (Not equal to operator) 자동구현
   (두 연산자를 모두 구현할 필요 없음)
 ==========================================================================**/


// 연산자 메서드를 구현하면 비교가 가능해짐
// Equatable 프로토콜을 채택 후, 구현

extension Vector2D: Equatable {
    
    // 직접구현
    static func ==(lhs: Vector2D, rhs: Vector2D) -> Bool {
        return (lhs.x == rhs.x) && (lhs.y == rhs.y)
    }
    
//    static func !=(lhs: Vector2D, rhs: Vector2D) -> Bool {
//        return (lhs.x != rhs.x) || (lhs.y != rhs.y)
//    }
}


vector1 == vector2
vector1 != vector2


let twoThree = Vector2D(x: 2.0, y: 3.0)
let anotherTwoThree = Vector2D(x: 2.0, y: 3.0)

if twoThree == anotherTwoThree {
    print("두 개의 벡터값은 동일함.")
}



#(참고) 열거형의 경우, 연관값이 없다면 원칙적으로 동일성 비교 가능
/**===========================================================
 *(연관값이 전혀 없는) 열거형의 경우 굳이 Equatable프로토콜을 채택하지 않아도,
  연산자(==) 메서드 자동 채택/구현
 =============================================================**/

#####################################################################################2021.11.01_2
비트연산자

비트 연산자(Bitwise Operators)

#비트 연산자 ➞ 실제 앱개발에서 사용되는 경우는 거의 없음
/**============================================================
 [비트 연산]
  - 메모리 비트 단위로 직접적인 논리연산을 하거나, 비트 단위 이동시에 사용하는 연산
 
  - 주로, 어떤 하드웨어적인 처리(예, 장치 드라이버 생성)나 그래픽 프로그래밍과
    임베디드 프로그래밍, 암호화처리, 게임 등 아주 한정적으로 쓰이는 이론적인 내용
    (프로그래밍을 배우고 있다는 목적아래, 이론적으로 듣고 지나치면 됨)
 
  - 장점: 1) 연산속도가 빠름 - 직접적으로 메모리의 실제 비트를 컨트롤
         2) 짧은 코드로 복잡한 로직을 구현 가능한 경우가 있음
 =============================================================**/


/**==========================================================
 [스위프트 비트연산자 종류 6가지]
 (비트 논리 연산자)
 1)  ~  : Bitwise NOT Operator(비트와이즈 낫 연산자)
 2)  &  : Bitwise AND Operator(비트와이즈 앤드 연산자)
 3)  |  : Bitwise OR Operator(비트와이즈 오어 연산자)
 4)  ^  : Bitwise XOR Operator(비트와이즈 엑스오어 연산자)
 
 (비트 이동 연산자)
 5)  << : Bitwise Left Shift Operator(비트와이즈 레프트 시프트 연산자)
 6)  >> : Bitwise Right Shift Operator(비트와이즈 라이트 시프트 연산자)
 ===========================================================**/

#비트 논리 연산자

Bitwise NOT Operator(비트와이즈 낫 연산자)

// ~a
// 비트 논리 부정 연산자라고도 함, 단항연산자의 형태로 사용
// 기존의 메모리의 비트를 반전 시킴
// (0은 1로, 1은 0으로 반전)
let a1: UInt8 = 0b0000_1111    // 15
let b1 = ~a1  // 0b1111_0000   // 240

#Bitwise AND Operator(비트와이즈 앤드 연산자)
// a & b  (앰퍼샌드 기호를 사용)
// 비트 논리 곱 연산자라고도 함, 이항연산자의 형태로 사용
// 두개의 메모리의 비트 중 모두가 1이면 1을 반환
// 두개의 메모리의 비트가 둘 다 1일때만 1로 설정 (true && true)
let a2: UInt8 = 0b1111_1100   // 252
let b2: UInt8 = 0b0011_1111   // 63
let c2 = a2 & b2  // 0b0011_1100      // 60


#Bitwise OR Operator(비트와이즈 오어 연산자)
// a | b  (버티컬 바 기호를 사용)
// 비트 논리 합 연산자라고도 함, 이항연산자의 형태로 사용
// 두개의 메모리의 비트 중 하나라도 1이면 1을 반환
// (true || true)

let a3: UInt8 = 0b1011_0010   // 178
let b3: UInt8 = 0b0101_1110   // 94
let c3 = a3 | b3  // 0b1111_1110      // 254



#Bitwise XOR Operator(비트와이즈 엑스오어 연산자)
// a ^ b  (캐럿 기호를 사용)
// 비트 논리 배타 연산자(또는 익스클루시브 OR 연산자)라고도 함, 이항연산자의 형태로 사용
// 두개의 메모리의 비트 중 둘을 비교해서 서로 다르면 1을 반환
// (서로 다르면 ===> 1을 반환, 서로 같으면 ===> 0을 반환)
let a4: UInt8 = 0b0001_0100    // 20
let b4: UInt8 = 0b0000_0101    // 5
let c4 = a4 ^ b4  // 0b0001_0001    // 17


#비트 이동 연산자

비트 이동 연산자
/**==========================================================
 (비트 이동 연산자의 기본 원리)
 - 모든 비트를 정해진 값만큼 왼쪽이나 오른쪽으로 이동
 - 비트를 이동하는 것은 2를 곱하거나, 나누는 효과를 가짐
 
 (예) 정수 비트를 왼쪽으로 1칸 이동하면 값이 2배가 됨
 ===========================================================**/


#부호가 있을때만 주의
1) 부호가 없는(Unsigned) 비트 이동 연산자

부호가 없는 경우의 비트 이동 연산자


/**==========================================================
 (부호가 없는 비트 이동 연산자의 경우) - Unsigned
 - 1) 기존 비트를 요청된 값만큼 왼쪽이나 오른쪽으로 이동
 - 2) 정수(integer)의 수용 범위를 넘어서는 비트는 어떤 것이든 버림
 - 3) 비트를 왼쪽이나 오른쪽으로 이동하면서 남는 공간에는 0을 삽입
 ===========================================================**/


Bitwise Left Shift Operator(비트와이즈 레프트 시프트 연산자)
let leftShiftBits: UInt8 = 4   // 0b0000_0100   //   4
leftShiftBits << 1             // 0b0000_1000   //   8 (곱하기 2)
leftShiftBits << 2             // 0b0001_0000   //  16 (곱하기 2^2승 => 곱하기 4)
leftShiftBits << 5             // 0b1000_0000   // 128 (곱하기 2^5승 => 곱하기 32)


Bitwise Right Shift Operator(비트와이즈 라이트 시프트 연산자)
let rightShiftBits: UInt8 = 32  // 0b0010_0000   //  32
rightShiftBits >> 1             // 0b0001_0000   //  16 (나누기 2)
rightShiftBits >> 2             // 0b0000_1000   //   8 (나누기 4)
rightShiftBits >> 5             // 0b0000_0001   //   1 (나누기 2^5승)


#2) 부호가 있는(Signed) 비트 이동 연산자

부호가 있는 경우의 비트 이동 연산자
/**==========================================================
 (부호가 있는 비트 이동 연산자의 경우) - Signed
 - 1) 기존 비트를 요청된 값만큼 왼쪽이나 오른쪽으로 이동
 - 2) 정수(integer)의 수용 범위를 넘어서는 비트는 어떤 것이든 버림
 - 3) 비트를 왼쪽으로 이동하면서 남는 공간에는 0을 삽입
 - 4) 비트가 오른쪽으로 이동하면서 남는 공간에는 부호가 없을땐 0 삽입
      부호가 있을때만 1 삽입 ⭐️ (원래의 부호 유지를 위한 삽입) (오른쪽 이동시만 주의하면됨)
 ===========================================================**/



#Bitwise Left Shift Operator(비트와이즈 레프트 시프트 연산자)
let shiftBits: Int8 = 4    // 0b0000_0100   //   4
shiftBits << 1             // 0b0000_1000   //   8 (곱하기 2)
shiftBits << 2             // 0b0001_0000   //  16 (곱하기 4)

shiftBits << 5             // 0b1000_0000   //-128 (곱하기 2^5승, 다만 여기선 범위초과로 오버플로우)



#Bitwise Right Shift Operator(비트와이즈 라이트 시프트 연산자)
부호 유지를 위한 삽입! 이라고 기억 (용어 - Arithmetic 산술 시프트)

let shiftSignedBits: Int8 = -2   // 0b1111_1110   //  -2
shiftSignedBits >> 1             // 0b1111_1111   //  -1 (나누기 2) 몫
shiftSignedBits >> 2             // 0b1111_1111   //  -1 (나누기 4) 몫

shiftSignedBits >> 5             // 0b1111_1111   //  -1 (나누기 2^5승) 몫

#####################################################################################2021.11.01_1
논리연산자와 단락평가

논리 연산자(Logical Operators)
// 1) Logical NOT Operator
!true
!false


// 2) Logical AND Operator(앤드, 그리고)
true && true
true && false
false && true
false && false


// 3) Logical OR Operator(또는)
true || true
true || false
false || true
false || false


/**======================================================================================
 - false && true 에서 false만 확인 (항상 false) ====> 왜냐하면, 2번째 결과에 상관없이 false로 평가되기 때문
 - true || false 에서 true만 확인 (항상 true) ====> 왜냐하면, 2번째 결과에 상관없이 true로 평가되기 때문
=========================================================================================**/


#단락 평가(Short-circuit Evaluation)
/**===========================================================
 - 스위프트의 논리 평가식은 "단락 평가" 방식을 사용
 - 단락평가: 논리 평가식에서 결과도출에 필요한 최소한의 논리식만 평가
          (예: 참을 찾을때 까지만 실행하고, 참을 찾으면 나머지 표현식은 평가하지 않음)
          (최소한의 코드만 실행 - Short-circuit evaluation)
 - 참고: 논리연산자 우선순위 1) && 2) ||
 =============================================================**/


var num = 0


func checking() -> Bool {
    print(#function)
    num += 1
    return true
}



// if문의 조건식에서 함수를 호출하는 경우

if checking() || checking() {    // &&으로 바꿔보기
             // &&
    
}


num



#단락 평가에서 발생할 수 있는 문제 경우의 예시
var doorCheck = 0
var passwordCheck = 0

func doorCodeChecking() -> Bool {
    doorCheck += 1
    print(#function)
    return true
}

func passwordCodeChecking() -> Bool {
    passwordCheck += 1
    print(#function)
    return true
}



// 아래 3개의 케이스에서 returnTrue 메서드는 각각 몇 번씩 호출될까?

print("\n[ 첫번째 케이스 ] =============")
if doorCodeChecking() && passwordCodeChecking() && false || true && doorCodeChecking() && passwordCodeChecking() {
    
}
print("Door: \(doorCheck), Password: \(passwordCheck)")




print("\n[ 두번째 케이스 ] =============")
doorCheck = 0
passwordCheck = 0

if doorCodeChecking() && false && passwordCodeChecking() || doorCodeChecking() || passwordCodeChecking() {
    
}
print("Door: \(doorCheck), Password: \(passwordCheck)")




print("\n[ 세번째 케이스 ] =============")
doorCheck = 0
passwordCheck = 0

if doorCodeChecking() || passwordCodeChecking() && doorCodeChecking() || false && passwordCodeChecking() {
    
}
print("Door: \(doorCheck), Password: \(passwordCheck)")





/**===========================================================
 - 단락 평가로 인한 주의 ⭐️
 - 사이드 이팩트 발생시는 반드시 주의
   일부 변수가 표현식의 평가 결과로 값이 변경되는 것 (여기서는 doorCheck += 1)
   논리평가식에서 사이드 이펙트가 발생하는 경우, 단락평가로 인해 함수 등의
   실행횟수의 차이로 인해 의도치 않은 결과가 도출될 수 있음
 
   ===> 논리적인 오류가 없도록 표현식을 미리 실행하도록 코드 수정
 =============================================================**/




print("\n[ 세번째 케이스를 수정한다면 ] =============")
doorCheck = 0
passwordCheck = 0


let doorResult1 = doorCodeChecking()
let passwordResult1 = passwordCodeChecking()
let doorResult2 = doorCodeChecking()
let passwordResult2 = passwordCodeChecking()


if doorResult1 || passwordResult1 && doorResult1 || false && passwordResult2 {
    
}
print("Door: \(doorCheck), Password: \(passwordCheck)")

#####################################################################################2021.11.01
Overflow
오버플로우

오버플로우의 개념
/**==============================================================
 [오버플로우(overflow)]
 - C언어나 Objective-C언어의 산술연산자에서는 값이 넘침(overflow)을 허락했지만
   (예를 들어, 8비트 값을 담을 수 있는 숫자에서 255를 넘어가면 다시 0으로 순환)
   스위프트에서는 오버플로우를 기본적으로 허락하지 않음 ===> 에러발생(크래시)
 - 오버플로우의 방향은 양(positive)의 방향, 음(nagative)의 방향을 모두 의미
 
 - 특정한 경우에, 특정패턴을 구현하기 위해 오버플로우를 허용하는 경우가 필요한데,
   이런 경우 활용을 위해 "오버플로우 연산자"를 마련해 놓았음
================================================================**/


UInt8.max   // UInt8(8비트의 값을 담을 수 있음)의 최대값 255
UInt8.min   // UInt8(8비트의 값을 담을 수 있음)의 최소값 0

//let num: UInt8 = 300



#오버플로우 연산자

스위프트의 3가지 오버플로우 연산자

#스위프트에서는 오버플로우 연산자 따로 존재
/**===========================
 [오버플로우 연산자]
 - &+ : 오버플로우 더하기 연산자
 - &- : 오버플로우 빼기 연산자
 - &* : 오버플로우 곱하기 연산자
 
 - 앰퍼샌드(&)기호가 붙어있음
=============================**/


#부호가 없는 경우(Unsigned)의 오버플로우
/**=========================
 - UInt8타입의 범위: 0 ~ 255
 ===========================**/


// &+ : 오버플로우 더하기 연산자

var a = UInt8.max  // 현재 변수 a에 UInt8타입의 최대값이 들어있음(255)
a = a &+ 1         // 오버플로우 더하기 연산자로 1을 더하기 ==========> 최소값(0)으로 이동

//a = 0b11111111 &+ 0b00000001




// &- : 오버플로우 빼기 연산자

var b = UInt8.min  // 현재 변수 b에 UInt8타입의 최소값이 들어있음(0)
b = b &- 1         // 오버플로우 빼기 연산자로 1을 빼기 ==========> 최대값(255)으로 이동

//b = 0b00000000 &- 0b00000001



#부호가 있는 경우(Signed)의 오버플로우
/**=========================
 - Int8타입의 범위: -128 ~ 127
 ===========================**/


// &+ : 오버플로우 더하기 연산자

var a1 = Int8.max   // 현재 변수 a1에 Int8타입의 최대값이 들어있음(127)
a1 = a1 &+ 1        // 오버플로우 더하기 연산자로 1을 더하기 ==========> 최소값(-128)으로 이동

//a1 = 0b01111111 &+ 0b00000001


// &- : 오버플로우 빼기 연산자

var b1 = Int8.min   // 현재 변수 b1에 Int8타입의 최소값이 들어있음(-128)
b1 = b1 &- 1        // 오버플로우 빼기 연산자로 1을 빼기 ==========> 최대값(127)으로 이동


//b1 = -0b10000000 &- 0b00000001



// &* : 오버플로우 곱하기 연산자

var c1 = Int8.max   // 현재 변수 c에 Int8타입의 최대값이 들어있음(127)
c1 = c1 &* 2        // 오버플로우 곱하기 연산자로 2 곱하기 ==========> 비트 한칸씩 이동


//c = 0b01111111 &* 2

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
