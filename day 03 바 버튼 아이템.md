day 03 - 22/02/27

# 바 버튼 아이템

# 목차

- 바 버튼 아이템의 스타일
- 바 버튼 아이템의 주요 프로퍼티와 주요 메서드

## 바 버튼 아이템

바 버튼 아이템은 UIToolbar 또는 UINavigationBar (backBarButtonItem, leftBarButtonItem, rightBarButtonItem 등) 에 배치할 수 있는 특수한 버튼입니다.

제목이나 이미지를 보여줄 수 있고 미리 UIBarButton.SystemItem 열거형에 정의된 여러 스타일 중 하나의 스타일로 선택할 수도 있습니다

//Tip: iOS 11에서는 UIBarButtonItem을 오토레이아웃 제약 없이 내비게이션 아이템으로 추가하면 바 버튼 아이템의 프레임이 예상치 못한 크기로 나올 수 있습니다. 이럴 땐 UIBarButtonItem객체에 적절한 오토레이아웃 제약을 추가한 후 내비게이션 아이템으로 설정하면 설정한 제약에 따라 알맞은 크기로 볼 수 있습니다

### 주요 프로퍼티

- title: 아이템에 표시되는 제목

```swift
var title: String? { get set }
```

- image: 아이템에 표시되는 이미지

```swift
var image: UIImage? { get set }
```

- style: 아이템의 스타일

```swift
var style: UIBarButtonItem.Style { get set }
```

- width: 아이템의 너비 값

```swift
var width: CGFloat { get set }
```

- tintColor: 아이템에 적용할 색상

```swift
var tintColor: UIColor { get set }
```

### 주요 상수

- UIBarButtonItem.Style: 아이템 스타일 정의
- UIBarButtonItem.SystemItem: 바 버튼 아이템에 대한 시스템 제공 스타일

done: 시스템 완료 버튼

add: 더하기 모양 시스템 버튼

edit: 편집 시스템 버튼

cancel: 취소 시스템 버튼

save: 저장 시스템 버튼

reply: 회신 시스템 버튼

action: 동작 시스템 버튼

trash: 휴지통 시스템 버튼

bookmarks: 북마크 시스템 버튼

search: 검색 시스템 버튼

refresh: 새로고침 시스템 버튼

stop: 중지 시스템 버튼

camera: 카메라 시스템 버튼

play: 재생 시스템 버튼

pause: 일시정지 시스템 버튼

fastForward: 빨리감기 시스템 버튼

rewind: 되감기 시스템 버튼
