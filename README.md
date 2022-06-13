# TIL
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
