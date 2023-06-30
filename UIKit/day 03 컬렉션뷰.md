day 03 - 22/02/27

# 컬렉션뷰

# 목표

- 컬렉션뷰
- 컬렉션뷰의 구성요소
- 컬렉션뷰 구현을 이루기 위한 클래스 및 프로토콜

## 컬렉션뷰

컬렉션뷰는 유연하고 변경 가능한 레이아웃을 사용하여 데이터 아이템의 정렬된 세트를 표시하는 수단입니다.

컬렉션뷰의 가장 일반적인 용도는 데이터 아이템을 그리드와 같은 형태로 표현합니다.

더불어 다양한 방법으로 컬렉션뷰의 레이아웃을 사용자 정의할 수 있습니다.

## 컬렉션뷰의 구성 요소

- 셀(Cell): 컬렉션뷰의 주요 콘텐츠를 표시합니다. 컬렉션뷰는 컬렉션뷰 데이터 소스 객체에서 표시할 셀에 대한 정보를 가져옵니다. 각 셀은 UICollectionViewCell 클래스의 인스턴스 또는 UICellectionViewCell을 상속받은 클래스의 인스턴스입니다.
- 보충뷰(Supplementary views) : 섹션에 대한 정보를 표시합니다. 셀과 달리 보충 뷰는 필수는 아니며, 사용법과 배치 방식은 사용되는 레이아웃 객체가 제어합니다. 헤더와 푸터를 예로 들 수 있습니다
- 레이아웃 객체( Layout Object) : 레이아웃 객체는 컬렉션뷰 내의 아이템 배치 및 시각적 스타일을 결정합니다. 컬렉션부 데이터 소스 객체가 뷰와 표시할 콘텐츠를 제공한다면, 레이아웃 객체는 크기, 위치 및 해당 뷰의 레이아웃과 관련된 특성들을 결정합니다.

## 컬렉션뷰 구현을 이루기 위한 클래스 및 프로토콜

컬렉션뷰를 사용하여 콘텐츠를 화면에  표시하기 위해서 컬렉션뷰는 여러 가지 다른 객체들과 협력합니다. 예를 들어 컬렉션뷰는 컬렉션뷰 데이터 소스 객체로부터 표시할 콘텐츠의 정보를 얻어오고, 사용자와의 상호작용을 처리하기 위해 컬렉션뷰 델리게이트 객체를 사용합니다.

- 최상위 포함 및 관리 (Top level containment)

UICollectionView/UICollectionViewController: UICellectionView는 컬렉션뷰의 콘텐츠가 보이는 영역을 정의합니다. UICollectionViewController는 컬렉션뷰를 관리하는 뷰 컨트롤러입니다. UICollectionViewController는 선택적으로 사용가능합니다.

- 콘텐츠 관리

UICollectionViewDataSource protocol / UICollectionViewDelegate protocol: 데이터 소스 객체는 컬렉션뷰와 관련된 중요한 객체이며, 필수적으로 제공해야 합니다. 데이터 소스는 컬렉션뷰의 콘텐츠를 관리하고 해당 콘텐츠를 표시하기 위한 뷰를 제공합니다. 컬렉션뷰 델리게이트 객체는 사용자와의 상호작용과 셀 강조 표시 및 선택 등을 관리합니다.

- 표시 (Presentation)

UICollectionReusableView / UICollectionViewCell : 컬렉션에 표시된 모든 뷰는 UICollectionReusableVeiw 클래스의 인스턴스여야 합니다. 이 클래스는 컬렉션뷰에서 사용중인 뷰 재사용 메커니즘을 지원합니다. 새로운 뷰를 만드는 대신, 뷰를 재사용하여 성능을 향상시킵니다.

- 레이아웃(Layout)

UICollectionViewLayout/UICollectionViewLayoutAttribute/UICollectionViewUpdateItem: UICollectionViewLayout의 서브 클래스는 레이아웃 객체라고 하며 컬렉션 뷰 내부의 셀 및 재사용 가능한 뷰의 위치, 크기 및 시각적 속성을 정의합니다. UICollectionViewLayoutAttributes는 레이아웃 프로세스 중에 컬렉션뷰에 셀과 재사용가능한 뷰를 표시하는 위치와 방법을 알려줍니다. 레이아웃 객체 아이템이 삽입, 삭제, 혹은 컬렉션뷰 내에서 이동할 때마다 레이아웃 객체는 UICollectionViewUpdateItem 클래스의 인스턴스를 받습니다

- 플로우 레이아웃(Flowlayout)

UICollectionViewFLowLayout/UICollectionViewDelegateFlowLayout protocol: 그리드 혹은 다른 라인기반(lined-based) 레이아웃을 구현하는 데 사용됩니다. 클래스를 그대로 사용하거나 동적으로 커스터마이징 할 수 있는 플로우 델리게이트 객체와 함께 사용할 수 있습니다

## 컬렉션뷰와 관련된 클래스 및 프로토콜

- UICollectionView: 사용자에게 보여질 컬렉션 형태의 뷰입니다.
- UICollectionViewCell: UICellectionView 인스턴스에 제공되는 데이터를 화면에 표시하는 역할을 담당합니다.
- UICollectionReusableView: 뷰 재사용 메커니즘을 지원합니다.
- UICollctionViewFlowLayout: 컬렉션뷰를 위한 디폴트 클래스로, 그리드 스타일로 셀들을 배치하도록 설계되어있습니다. scrollDirection 프로퍼티를 통해 수평 및 수직 스크롤을 지원합니다.
- UICollectionViewLayoutAttributes: 컬렉션뷰 내의 지정된 아이템의 레이아웃 관련 속성을 관리합니다.
- UICollectionBiewDataSource 프로토콜: 컬렉션뷰에 필요한 데이터 및 뷰를 제공하기 위한 기능을 정의한 프로토콜입니다.
- UICollectionViewDelegate 프로토콜: 컬렉션뷰에서 아이템의 선택 및 강조 표시를 관리하고 해당 아이템에 대한 작업을 수행할 수 있는 기능을 정의한 프로토콜입니다.
- UICollectionViewDelegateFlowLayout 프로토콜: UICollectionViewLayout 객체와 함께 그리드 기반 레이아웃을 구현하기 위한 기능을 정의한 프로토콜입니다.
