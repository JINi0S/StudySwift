# Project8. URLSession을 이용한 HTTP 통신

**웹 통신과 Protocol**

- 인터넷 상에서의 통신을 말한다
- 많은 정보들이 주고 받기에 인터넷에는 엄격한 규약이 존재한다. 이것을 Protocol이라고 부른다

**HTTP: Hyper Text Transfer Protocol**

Hyper Text를 전송하기 위한 프로토콜

**HTTP 통신**

Client에서 서버에 요청을 하면 그에 맞는 응답결과를 돌려주고, 클라이언트는 사용자에게 서버로부터 응답받은 결과를 보여줍니다

계속 연결되어있지 않다는 것이 특징임

**Http 패킷**

Header와 Body로 이루어짐.

Header: 보내는 사람의 주소, 받는 사람의 주소, 패킷의 생명시간

Body:전하고자하는 실제 내용

**Http Method**

- GET: 클라이언트가 서버에 리소스를 요청할 때 사용
- POST: 클라이언트가 서버의 리소스를 새로 만들 때 사용
- PUT: 클라이언트가 서버의 리소스를 전체 수정할 때 사용
- PATCH: 클라이언트가 서버의 리소스를 일부 수정할 때 사용
- DELETE: 클라이언트가 서버의 리소스를 삭제할 때 사용
- HEAD: 클라이언트가 서버의 정상 작동 여부를 확인할 때 사용
- OPTIONS: 클라이언트가 서버에서 해당 URL이 어떤 메소드를 지원하는 지 확인할 때 사용
- CONNECT: 클라이언트가 프록시를 통하여 서버와 SSL 통신을 하고자 할 때 사용
- TRACE: 클라이언트와 서버간 통신 관리 및 디버깅을 할 때 사용

**Http Status** 
서버는 클라이언트의 요청에 응답하면서 요청이 성공적으로 완료되었는지를 알려주는 상태코드를 함께 보냄

- 100번대 Infomational: 현재는 거의 사용x
- 200번대 Success: 요청을 정상적으로 처리함
- 300번대 Redirection: 요청을 완료하기 위해 추가 동작 필요
- 400번대 Client Error: 서버가 요청을 이해하지 못함
- 500번대 Server Error: 서버가 요청 처리 실패함

**URLSession**
특정한 url을 이용하여 데이터를 다운로드하고 업로드하기 위한 API

URLSessionConfiguration을 통해 생성할 수 있다

생성된 URLSession을 통해 한 개 이상의 URLSessionTask를 생성할 수 있으며, 이 URLSessionTask을 통해 실제 서버와 통신할 수 있다

- 공유세션(Shrared Session) 
URLSession.shared()
싱글톤. 기본 요청을 하기 위한 세션. 맞춤 설정은 못하지만 쉽게 사용 가능

- 기본 세션(Default Session)
URLSession(configuration: .default)
공유세션과 유사하게 작동하지만 직접 원하는 설정을 할 수 있고, 캐시와 쿠키 인증 등을 디스크에 저장합니다
순차적으로 데이터를 처리하기 위해 델리게이트를 지정할 수 있다

- 임시 세션(Ephemeral Session)
URLSession(configuration: .ephemeral)
공유세션과 비슷하지만 캐시, 쿠키, 사용자 인증정보를 디스크에 저장하지 않습니다
메모리 올려서 세션에 연결하고 세션만료시 데이터가 삭제됩니다

- 백그라운드 세션(Background Session)
URLSession(configuration: .background)
앱이 실행되지 않는 동안 백그라운드에서 컨텐츠 업로드 및 다운로드를 수행할 수 있습니다

**URLSessionTask**

URLSession이 구성되면 URLSessionTask를 이용해서 각 세션 내에 작업을 추가할 수 있습니다

- URLSessionDataTask: 데이터 객체를 사용하여 데이터를 요청하고 응답받음. 주로 짧고 빈번하게 요청되는 경우에 사용됨
- URLSessionUploadTask: 데이터 객체 또는 파일 형태의 데이터를 업로드하는 작업을 수행. 앱이 실행되지 않았을 때 백그라운드 업로드를 지원
- URLSessionDownloadTask: 데이터를 다운로드받아서 파일형태로 저장하는 작업을 수행. 앱이 실행중이지 않을 경우 백그라운드 다운로드를 지원
- URLSessionStreamTask: TCP/IP 연결을 생성할 떄 사용되는 작업
- URLSessionWebSocketTask: 웹소캣 프로토콜 표준을 통해 통신하는 작업

**URLSession Life Cycle**

URLSession은 다음과 같은 순서로 진행됨.

1. SessionConfiguration 을 결정하고, Session을 생성
2. 통신할 URL과 Request 객체를 설정
3. 사용할 Task를 결정하고 그에 맞는 Completion Handler나 Delegate 메소드들을 작성
4. 해당 Task를 실행
5. Task 완료 후 Completion Handler 클로저가 호출 됨
6. 클로저 안에서 작업에 대한 결과값을 받아 올 수 있음

**Codable**

자신을 변환하거나 외부표현으로 변환할 수 있는 타입

객체에서 Codable을 채택하게 되면 Codable을 채택한 객체는 Json으로 만들 수 있고 JsonData를 객체로 변환할 수 있습니다
