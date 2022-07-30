# 넷플릭스 스타일의 앱

**UICollectionView를 구현하기 위한 Class와 Protocol**

| Purpose | Classes/Protocol |
| --- | --- |
| Top-level containment and management | UICollectionView
UICollectionViewController |
| Content management | UICollectionViewDataSource
UICollectionViewDelegate |
| Presentation | UICollectionReusableView
UICollectionViewCell |
| Layout | UICollectionViewLayout
UICollectionViewLayoutAttributes
UICollectioniewUpdateItem |
| Flow layout | UICollectionViewFlowLayout
UICollectionViewDelegateFlowLayout |

**Top-level containment and management** 

1) UICollectionView

2) UICollectionViewController

- 시각적인 요소 정의
- UIScrollView 상속
- Layout 정보 기반 데이터 표시

**Content management**

1) UICollectionViewDataSource: 필수요소이며, Content 관리 및 Content 표시에 필요한 View 생성

2) UICollectionViewDelegate: 선택요소이며, 특정 상황에서 View 동작 custom

**Presentation**

1) UICollectionReusableView

2) UICollectionViewCell

- Header, Footer
- 재사용 가능

**Layout**

1) UICollectionViewLayout

2) UICollectionViewLayoutAttributes

3) UICollectioniewUpdateItem

- 각 항목 배치 등 시각적 스타일 담당
- View를 직접 소유하지 않는 대신 Attributes 생성
- 데이터 항목 수정시 UpdateItem 인스턴스 수신

**Flow layout**

1) UICollectionViewFlowLayout

2) UICollectionViewDelegateFlowLayout

- Grid, line-based layout 구현
- 레이아웃 정보를 동적으로Custom

---

**Compositional Layout**

구성 가능하게 - 복잡한 결과를 단순한 것으로 구성하기

유연하게 - 이 것만으로 모든 레이아웃을 작성 가능하게 하기

빠르게 - 프레임워크에서 자체 성능 최적화 수행

**LayoutItem, LayoutGroup, LayoutSection**

```swift
let size = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.3), heightDimension: .fractionalHeight(0.75))
let item = NSCollectionLayoutItem(layoutSize: size)
let group = NSCollectionLayoutGroup.horizontal(layoutSize: size, subitem: item, count: 3)
let section = NSCollectionLayoutSection(group: group)
let layout = NSCollectionVIewCOmpositionalLayout(section: section)
```

**Size**

Absolute: 정확한 치수

```swift
let absoluteSize = NSCollectionLayoutSize(widthDimension: .absolute(44), heightDimension: .absolute(44))
```

Estimate: 데이터가 로드되거나 시스템 글꼴 크기가 변형된 경우와 같이 런타임에 컨텐츠 크기가 변형될 수 있는 경우

```swift
let estimatedSize = NSCollectionLayoutSize(widthDimension: .estimated(200), heightDimension: .estimated(200))
```

Fractional: 비율, 분수값을 사용해서 아이템 컨테이너를 기준으로 사용
