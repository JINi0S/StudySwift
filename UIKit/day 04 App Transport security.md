day 04 - 22/02/28
App Transport security

: 애플리케이션과 웹 서비스 사이에 통신 보안 향상을 위한 기능인 ATS(App Transport Security)

# 목차

- ATS가 무엇인지
- ATS의 동작과 용어
- ATS 기능의 예외사항과 비활성화 방법

## ATS란?

ATS는 애플리케이션과 웹 서비스 사이에 통신 시 보안 향상을 위한 기능으로 iOS 9.0, macOS 10.11부터 적용 가능합니다. 

모든 인터넷 통신 시 안전한 프로토콜을 사용하도록 보장하는 것으로 사용자의 민감한 정보가 유출되는 것을 방지합니다.

## ATS 등장 배경

다양한 종류의 애플리케이션이 개인의 여러 가지 정보(연락처, 사진, 건강정보, 메시지, 메일 등)를 다루게 되면서 사용자 정보보호에 대한 중요성이 한층 부각되었습니다. 그런데 기존의 보안/암호 기술은 오래되어 공격에 취약해졌지만, 컴퓨터 성능은 점점 발전하면서 새롭게 등장하는 네트워크 공격이 강력해지자 이에 대응하기 위해 2015년 ATS를 도입하게 되었습니다.

2016년부터 새롭게 만들어지는 애플리케이션은 반드시 ATS를 사용해야 하며, 기존에 개발된 애플리케이션은 ATS를 사용할 수 있도록 네트워크 보안을 강화해야 합니다

## ATS 동작

- URLSession, CFURL 그리고 NSURLConnection API를 이용해 데이터를 주고받을 때 ATS 기능을 기본적으로 사용하게 됩니다.
- ATS 가 활성화되어있을 때는 HTTP 통신을 할 수 없으며 애플에서 권장하는 아래 요구 사항을 충족하지 않은 네트워크는 연결에 실패할 수 있습니다
    - 서버는 TLS(Transport Layer Security) 프로토콜 버전 1.2 이상을 지원해야 합니다.
    - 적어도 2048비트 이상의 RSA 키 또는 256비트 이상의 ECC(Elliptic-Curve) 키가 있는 SHA256을 인증서에 사용해야 합니다.
    - 암호 연결은 아래 허용된 암호 목록으로 제한합니다.
        - TLS_ECDHE_ECDSA_WITH_AES_256_GCM_SHA384
        - TLS_ECDHE_ECDSA_WITH_AES_128_GCM_SHA256
        - TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA384
        - TLS_ECDHE_ECDSA_WITH_AES_256_CBC_SHA
        - TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA256
        - TLS_ECDHE_ECDSA_WITH_AES_128_CBC_SHA
        - TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        - TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        - TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384
        - TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256
        - TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA
        

## 용어 정리

### 전송 계층 보안(Transport Layer Security - TLS)

암호 프로토콜입니다. 서버와 클라이언트 애플리케이션이 네트워크로 통신하는 과정에서 도청, 간섭, 위조를 방지하기 위해서 설계되었습니다.

### HTTPS(Hypertext Transfer Protocol Secure)

TLS를 사용해 암호화된 연결을 하는 HTTP(Hypertext Transfer Protocol)를 HTTPS라고 합니다.

<생각해보기>

- TLS는 다양한 종류의 보안 통신을 하려는 프로토콜이고, HTTPS는 TLS 위에 HTTP 프로토콜을 얹어 보안된 HTTP통신을 하는 프로토콜입니다.

## 예외 사항

- 애플리케이션이 ATS가 요구하는 사항을 충족하기 힘든 경우, ATS 기능을 비활성화할 수 있습니다. 아래는 ATS 기능을 사용하지 않을 수 있는 예외사항입니다.
    - AVFoundation 프레임워크를 통한 스트리밍 서비스
    - WebKit을 통한 콘텐츠 요청
    - 로컬 네트워크 연결
    - 그 외에는 서버가 최신 TLS 버전으로 업그레이드 할 때까지 애플리케이션의 유지 보수를 위해 일시적으로 ATS 기능을 사용하지 않는 것이 가능하며, App Store 심사 시 정당한 이유를 설명하는 문서가 필요할 수도 있습니다.
- ATS 기능 비활성화 방법: 해당 프로젝트의 info.plist 파일에서 설정합니다,
    - 모든 HTTP 통신 허용: 암호화하지 않은 통신이므로 불가피한 때 외에는 사용하지 않는 것이 좋습니다
    
    ```swift
    <key>NSAppTransportSecurity</key>
    <dict>
    	<key>NSAllowsArbitaryLoads</key>
    <true/>
    </dict>
    ```
    
    ![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/4b41dc18-317f-4cc3-b0d2-e665f9ddff12/Untitled.png)
    
    [https://cphinf.pstatic.net/mooc/20180210_268/1518244340474rR1r2_PNG/177_0.png](https://cphinf.pstatic.net/mooc/20180210_268/1518244340474rR1r2_PNG/177_0.png)
    
- ATS에서 제외할 특정 도메인 지정

```swift
<key>NSAppTransportSecurity</key>
<dict>
	<key>NSExceptionDomains</key>
	<dict>
		<key>www.abc.com</key>
		<dict>
			<key>NSTemporaryExceptionAllowsInsecureHTTPLoads</key>
			<true/>
		</dict>
	</dict>
</dict>
```

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/5e5ad882-3214-4683-b89f-9744b0341d99/Untitled.png)

[https://cphinf.pstatic.net/mooc/20180210_17/1518244457629IaNHV_PNG/177_1.png](https://cphinf.pstatic.net/mooc/20180210_17/1518244457629IaNHV_PNG/177_1.png)
