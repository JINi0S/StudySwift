# 브루어리 소개 앱

URL Session을 이용한 HTTP 통신

OSI 모델: Open Systems Imterconnection의 약자 (개방형 시스템 상호 연결)

1레벨: 물리계층 Physical

- 전압 레벨, 데이터 속도, 최대 전송 거리, 커넥터..
- 케이블, 모뎀, 리피터

2레벨: 데이터 링크 계층 Data Link

- 데이터 오류 감지, 복구
- MAC 주소

3레벨: 네트워크 계층 Network

- 논리 주소 정의
- IP 주소

4레벨: 전송 계층 Transport

- 데이터 흐름 제어
- TCP/ UDP
- TCP(대상에게 데이터를 전달했을 때 전달되었는지 안되었는지를 확인하고 결과를 보장해줌. 제어나 관리를 해줌. 책임감 있음)
- UDP(한 번 소스와 목적지를 적고 끝, 잘 갔는지 안갔는지 확인 안 함, 무책임함)

5레벨: 세션 계층 Session

- 통신 장치간의 상호작용 설정, 유지, 관리

6레벨: 표현 계층 Presentation

- 7레벨에 적용되는 데이터 형식, 코딩, 변환 기능
- 파일 확장자

7레벨: 응용 계층 Application

- 앱 상의 네트워크
- HTTP

---

### URL

http://www.naver.com:8080/ios.html

- http://
프로토콜
예) htp, mailto
- www.naver.com
웹 서버명 → DNS명 → IP 주소
layer3: 네트워크 계층(IP)
- :8080
포트명
layer4: 전송 계층(port)
- /ios.html
데이터 출처(리소스)경로
layer7: 응용 계층

### HTTP

[http://는](http://는) Request요청과 Response응답의 메시지 형태가 있음. 요청은 우리가 작성, 응답은 서버가 답을 하는 것

1) Request(요청)

Method + URL + Header + Body로 구성되어 있음

Method(무언가를 하세요) + URL(리소스에 대해서) + (Header + Body)(구체적으로 어떻게)

**Method**

- Get 식별된 데이터 가져오기 (”치킨 그림 좀 보내주세요”, “🍗”)
- Post 새 데이터를 추가 (”치킨 그림 좀 저장해주세요”, “네 잘 저장했어요”)
- Put 식별된 기존의 데이터 수정(업데이트)
- Patch PUT과 동일하지만 데이터의 일부를 수정
- Delete 식별된 데이터 삭제
- Head GET과 동일하지만 메시지 헤더만 반환
- Connect 프락시 기능 요청
- Options 웹서버에서 지원하는 메소드 확인
- Trace 원격 서버 테스트용 메시지 확인

2) Response(응답)

Status Code + Message + Header + Body로 구성되어있음

TCP의 구성과 유사

**StatusCode**

- **1xx: 정보 전달** - ****리퀘스트 수신, 진행 중
- **2xx: 성공** - ****리퀘스트 성공적으로 수신, 해석, 승인
- **3xx: 리다이렉션**
- **4xx: 클라이언트 에러**
- **5xx: 서버 에러**

---

### URLSession

URL 로딩 시스템을 구현할수 있게 하는 객체

**URLSessionTask**

- URLSessionDataTask
- URLSessionUploadTask
- URLSessionDownloadTask
- URLSessionStreamTask
- URLSessionWebSocketTask

**URLSession Life Cycle**

(URLSession) — Creates → (URLSessionDataTask) — send data, request, error parameters→ (CompletionHandler)

---

**GCD**

Grand Central Dispatch
