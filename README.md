# TIL
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
