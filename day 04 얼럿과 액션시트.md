day 04 - 22/02/28

# 얼럿과 액션시트

얼럿과 액션시트는

: 사용자에게 경고 또는 알림 메시지를 표시하기 위한 얼럿과 액션시트

[https://www.boostcourse.org/mo326/lecture/16864?isDesc=false](https://www.boostcourse.org/mo326/lecture/16864?isDesc=false)

# 목차

- 얼럿과 액션시트의 구성요소
- 얼럿과 액션시트의 주요 프로퍼티와 주요 메서드
- 얼럿과 액션시트의 스타일
- 얼럿과 액션시트가 사용되는 경우

## 얼럿과 액션시트

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/655a481e-9a89-4d94-b421-0db37500f013/Untitled.png)

## UIAlertController 클래스

UIAlertController 클래스는 사용자에게 표시할 얼럿 또는 액션시트의 구성에 관한 메서드와 프로퍼티를 포함하고 있습니다. UIAlertController 클래스를 통해 얼럿 또는 액션시트를 구성한 후 UIViewController의 present(_ :animated:completion:) 메서드를 사용하여 사용자에게 얼럿 또는 액션시트를 모달로 보여줍니다.

### UIAlertController의 주요 메서드

- init(title: message:preferredStyle:) : 얼럿 뷰 컨트롤러의 객체를 초기화합니다.
- func addAction(UIAlertAction) : 얼럿이나 액션시트에 액션을 추가합니다.
- func addTextField(configurationHandler: ((UITextField) -> Void)? = nil) : 얼럿을 통해 텍스트를 입력받고자 하는 경우 텍스트 필드를 추가합니다.

### UIAlertController의 주요 프로퍼티

- var title: String?: 얼럿의 제목입니다
- var message: String? : 얼럿에 대해 좀 더 자세히 설명하는 텍스트입니다.
- var actions: [UIAlertAction]: 사용자가 얼럿 또는 액션시트에 응답하여 실행할 수 있는 액션입니다.
- var preferredStyle: [UIAlertController.Style](http://UIAlertController.Style) : 얼럿 컨트롤러의 스타일입니다. 얼럿과 액션시트가 있습니다.

## UIAlertAction 클래스

사용자가 얼럿 또는 액션시트에서 사용할 버튼과 버튼을 탭 했을 때 수행할 액션(작업)을 구성할 수 있습니다. UIAlertAction 클래스를 사용하여 버튼을 구성한 후 UIAlertController 객체에 추가하여 사용합니다

### UIAlertAction의 주요 프로퍼티

- var title: String? : 액션 버튼의 타이틀입니다.
- var isEnabled: Bool: 액션이 현재 사용 가능한지를 나타냅니다.
- var style: UIAlertAction.Style: 액션 버튼에 적용될 스타일입니다.

## UIAlertAction.Style

- default: 액션 버튼의 기본 스타일입니다.
- cancel: 액션 작업을 취소하거나 상태 유지를 위해 변경사항이 없을 경우 적용하는 스타일입니다.
- destructive: 취하게 될 액션이 데이터를 변경되거나 삭제하여 돌이킬 수 없는 상황이 될 수 있음을 나타낼 때 사용하는 스타일입니다.

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/fc65ff20-b52a-4457-a9f0-5a401a6f6587/Untitled.png)

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/3e39c622-2145-4ad9-9570-7536754b1fbe/Untitled.png)

## 얼럿과 액션시트는 언제 사용할까?

### 얼럿

- 중요한 액션을 하기 전 경고가 필요한 경우
- 액션을 취소할 기회를 제공해야 하는 경우
- 사용자의 작엽을 한 번 더 확인하거나 삭제 등의 작업을 수행하거나 문제 사항을 알릴 때
- 결정이 필요한 중요 정보를 표시할 경우

### 액션시트

- 사용자가 고를 수 있는 액션 목록이 여러 개일 경우
- 새 작업 창을 열거나, 종료 여부 확인 시
- 사용자의 결정을 되돌리거나 그 동작이 중요하지 않은 경우
