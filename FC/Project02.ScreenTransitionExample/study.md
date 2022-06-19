# project02, 03

Content View Controller

- 화면을 구성하는 뷰를 직접 구현하고 관련된 이벤트를 처리하는 뷰 컨트롤러

Container View Controller

- 하나 이상의 Child View Controller를 가지고 있다.
- 하나 이상의 Chile View Controller를 관리하고 레이아웃과 화면 전환을 담당한다.
- 화면 구성과 이벤트 관리는 Child View Controller에서 한다.
- Container View Controller는 대표적으로 Navigation Controller와 TabBar Controller가 있다.

Navigation Controller

- 계층구조로 구성된 content를 순차적으로 보여주는 container view controller
- ex) 설정 앱
- 스택 구조 - 자식 컨트롤러로 갈수록 네비게이션 스택에 쌓임. 이전화면으로 가는 건 ‘팝’되었다고 한다.선입후출.

TabBar Controller

화면 전환방법

1) 소스코드를 통해 전환하는 방식

2) Storyboard를 통해 전환하는 방식

---

1) View Controller의 View 위에 다른 View를 가져와 바꿔치기

2) View Controller에서 다른 View Controller를 호출하여 전환하기

3) Navigation Controller를 사용하여 화면 전환하기

4) 화면 전환용 객체 세그웨이(Segueway)를 사용하여 화면 전환하기

View Controller에서 다른 View Controller를 호출하여 전환하기

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/ccf3d55e-c9c8-4a89-8ca4-7945d656a430/Untitled.png)

Navigation Controller를 사용하여 화면 전환하기

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/b17b50ee-3435-4ba5-be80-71947c13aa4f/Untitled.png)

화면 전환용 객체 세그웨이(Segueway)를 사용하여 화면 전환하기

Action Segueway: 출발점이 버튼, 셀 등인 경우

Manual Seguway: 출발점이 뷰 컨트롤러 자체

Action Segueway 종류

- show: 네비게이션 컨트롤러를 사용하는 경우 화면전환 시 뷰컨트롤러가 네비게이션 스택에 싸이게 되고 사용하지 않는 경우 뷰 컨트롤러 present 됩니다
- show detail - split 구조에서 사용, show와 똑같이 사용되지만 아이패드에서 사용되면 split구조의 마스터 슬레이브 구조로 보인다.
- present modally: 이전 뷰컨트롤러를 덮으면서 새로운 화면이 나타나게 됨. presentation 방식으로 화면이 전환됨
- present as popover: 아이패드에서 사용되는 것으로 팝업창을 띄울 때 사용. 아이폰에선 사용되지 않음
- custom: 사용자가 원하는 방식으로 커스텀 할 때 사용.

---

viewController Life Cycle

- Appearing: 뷰가 화면에 나타나는 중
- Appeard: 뷰가 화면에 나타나는게 완료된 상태
- Disappearing: 뷰가 화면에서 사라지는 중
- Disappeared: 뷰가 화면에서 사라진 상태

viewDidLoad()

- 뷰 컨트롤러의 모든 뷰들이 메모리에 로드됐을 때 호출
- 메모리에 처음 로드될 때 한 번만 호출
- 보통 딱 한번 호출될 행위들을 이 메소드 안에 정의 함
- 뷰와 관련된 추가적인 초기화 작업, 네트워크 호출 —일회성 작업들

viewWillAppear()

- 뷰가 뷰 계층에 추가되고, 화면에 보이기 직전에 매 번 호출
- 다른 뷰로 이동했다가 돌아오면 재호출
- 뷰와 관련된 추가적인 초기화 작업

viewDidAppear()

- 뷰 컨트롤러의 뷰가 뷰 계층에 추가된 후 호출됩니다.
- 뷰를 나타낼 때 필요한 추가 작업
- 애니메이션을 시작하는 작업

viewWillDisappear()

- 뷰 컨트롤러의 뷰가 뷰 계층에서 사라지기 전에 호출됩니다.
- 뷰가 생성된 뒤 작업한 내용을 되돌리는 작업
- 최종적으로 데이터를 저장하는 작업

viewDidDisappear()

- 뷰 컨트롤러의 뷰가 뷰 계층에서 사라진 뒤에 호출
- 뷰가 사라지는 것과 관련된 추가 작업

---

 

delegate 사용할때는 변수 앞에 weak를 붙여주어야 함

붙이지 않으면 강한 순한?? 참조가 메모리 누수가 발생할 수 있다.
