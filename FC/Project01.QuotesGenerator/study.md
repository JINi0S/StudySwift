UIKit:UIKit 프레임워크는 사용자 인터페이스를 관리하고 이벤트를 처리하는게 주 목적인 프레임 워크. 어플리케이션의 화면 을 구성하는 많은 요소들이 이 프레임워크에 포함되어있다. 그렇기 떄문에 UI가 붙는 클래스들을 사용하려면 반드시 UIKit를 임포트 시켜줘야합니다.

UIView: 화면을 구성하는 요소의 기본 클래스. 여러 UI 컴포넌트들이 UIView를 상속받고 있습니다.

UIViewController: 앱의 근간을 이루는 객체. 전체적인 인터페이스의 레이아웃을 관리하고 다른 뷰 컨트롤러와 함께 앱을 구성한다. 화면 하나를 관리하는 단위

AutoLayout: 아이폰의 다양한 해상도 비율에 대응하기 위한 개념으로, 제약조건을 이용해서 뷰의 위치나 크기를 지정

IBOutlet: 스토리보드에 등록한 UI 오브젝트를 코드에 변수로 접근할 수 있게 만들어주는 것

IBAction: 버튼과 연결시켜 이벤트를 처리하는 함수를 만들어주는 것

Content Hugging& Content Compression Resistance: UILabel과 UIButton 들과 같은 뷰의 속성 텍스트나 이미지에 따라 크기가 결정되는 뷰가 있는데, 이러한 뷰들은 다른 뷰들과의 걸린 제약에 의해 본래의 콘텐츠 고유 사이즈보다 더 늘어나거나 줄어든다. 이 때 더 늘어나느 것에 대해 저항하는 것이 Content Hugging. 더 줄어드는 것에 대해 저항하는 것을 Content Compression Resistance.
Content Hugging: 우선순위가 높을 수록 크기를 유지하고, 낮으면 크기가 늘어난다.
Content Compression Resistance: 우선순위가 높으면 자신의 크기를 유지하고, 낮으면 크기가 줄어든다.
