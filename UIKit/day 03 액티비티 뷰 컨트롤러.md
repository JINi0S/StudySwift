day 03 - 22/02/27


액티비티 뷰 컨트롤러

: 애플리케이션 내에서 특정 아이템을 복사하거나 외부 SNS로 공유하는 내보내기 서비스를 사용하기 위한 액티비티 뷰 컨트롤러

# 목차

- 액티비티의 아이템과 타입
- 액티비티 뷰 컨트롤러 클래스의 주요 메서드와 프로퍼티

## UIActivityViewController

애플리케이션 내에서 특정 아이템을 복사하거나 외부 SNS로 공유하는 내보내기 서비스는 사용자가 아이템을 다양한 방식으로 활용하도록 도와줍니다. 

iOS 6 이상부터 사용 가능한 UIActivityViewController 클래스는 아래 이미지와 같은 내보내기 서비스를 손쉽게 사용할 수 있도록 해줍니다. 이번 문서에서는 UIActivityViewController 클래스에서 제공하는 서비스 및 사용 방법에 대해 알아봅시다

### Activity Item

UIActivityViewController 클래스를 이용해 아래 아이템을 공유할 수 있습니다.

- 문자열 String
- URL 링크 String
- 이미지 UIImage
- UIActivityItemSource 프로토콜을 따르는 커스텀 타입의 인스턴스

### Activity Type

UIActivityViewController 클래스가 기본적으로 제공하는 내보내기 서비스의 UIActivity에는 아래와 같은 종류가 있습니다

```swift
//읽기 목록에 추가
static let addToReadingList: UIActivityType

//에어드롭으로 공유하기
static let airDrop: UIActivityType

//연락처에 저장
static let assignToContact: UIActivityType

//Paste Board에 복사
static let copyToPasteboard: UIActivityType

//메일 보내기
static let mail: UIActivityType

//메시지 보내기
static let message: UIActicityType

//iBooks에서 열기
static let openInIBooks: UIActivityType

//페이스북에 공유하기
static let postToFacebook: UIActivityType

//Flickr에 공유하기
static let postToFlickr: UIActivityType

//Tencent Weibo에 공유하기
static let postToTencentWeibo: UIActivityType

//트위터에 공유하기
static let postToTwitter: UIActivityType

//Vimeo에 공유하기
static let postToVimeo: UIActivityType

//SinaWeibo에 공유하기
static let postToWeibo: UIActivityType

//프린트
static let print: UIActivityType

//카메라 롤에 저장하기
static let saveToCameraRoll: UIActivityType

//PDF 생성(iOS 11부터 사용 가능)
static let makeupPDF: UIActivityType
```

## 메서드 및 프로퍼티

UIActivityViewController의 메서드와 프로퍼티에는 어떤 것이 있으며 어떤 역할을 하는지 알아봅시다

```swift
//초기화 메서드로, UIActivityViewController 객체를 반환합니다.
init(activityItems: [Any], applicationActivities:[UIActivity]?)
//activityItems:[Any] 공유하려는 아이템으로 UIActivityItemSource 프로토콜을 준수하는 객체를 배열 형태로 넣어줄 수 있습니다
//applicationActivities:[UIActivity]? 애플리케이션이 지원하는 커스텀 서비스를 나타내는 UIActivity 객체의 배열로, nil값이 될 수 있습니다.

//컨트롤러를 닫은 후 실행할 완료 핸들러입니다.
var completionWithItemshandler: UIActivityViewControllerCompletionWithItemHandler?

//UIActivityType 중 사용하지 않을 서비스를 지정합니다.
var excludedActivityTypes: [UIActivityType]?
```

## 샘플 코드

```swift
//1. UIActivityViewController 초기화, 공유 아이템 지정
let imageToShare: UIImage = UIImage(named: "image.png")
let urlToShare: String = "http://www.naver.com"
let textToShare: String = "안녕하세여"

let activityViewController = UIActivityViewController(activityItems: [imageToShare, urlToShare, textToShare], applicationActivities: nil)

//2. 기본으로 제공되는 서비스 중 사용하지 않을 UIActivityType 제거(선택사항)
activityViewController.excludeActivityTypes = [UIActivityType.addToReadingList, UIActivityType.assignToContact] 

//3. 컨트롤러를 닫은 후 실행할 완료 핸들러 지정
activityViewController.completionWithItemsHandler = {(activity, success, item, error) in
	if success{
		//성공했을 때 작업
	} else{
		//실패했을 때 작업
	}
}

//4. 컨트롤러 나타내기(iPad에서는 팝오버로, iPhone과 iPod에서는 모달로 나타냅니다.)
self.present(activityViewController, animated: true, completion: nil)
```
