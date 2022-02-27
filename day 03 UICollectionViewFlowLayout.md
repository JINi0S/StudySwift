UICollectionViewFlowLayout

:그리드 혹은 라인기반(lined-based)레이아웃을 구현하는 데 사용되는 UICollectionViewFlowLayout

# 목차

- 플로우 레이아웃 스크롤
- 플로우 레이아웃의 구성 단계
- 플로우 레이아웃 속성
- 플로우 레이아웃의 셀 크기와 셀 및 행의 간격 지정 방법
- UICollectionViewDelegateFowLayout의 주요 선택 메서드

## UICollctionViewFLowLayout

UICollctionViewFlowLayout 클래스를 사용하면 컬렉션뷰의 셀을 원하는 형태로 정렬할 수 있습니다. 

플로우 레이아웃은 레이아웃 객체가 셀을 선형 경로에 배치하고 최대한 이 행을 따라 많은 셀을 채우는 것을 의미합니다.

현재 행에서 레이아웃 객체의 공간이 부족하면 새로운 행을 생성하고 거기에서 레이아웃 프로세스를 계속 진행합니다

![Untitled](https://s3-us-west-2.amazonaws.com/secure.notion-static.com/fc3df588-ef75-4e05-9997-028e5f26d5cd/Untitled.png)
