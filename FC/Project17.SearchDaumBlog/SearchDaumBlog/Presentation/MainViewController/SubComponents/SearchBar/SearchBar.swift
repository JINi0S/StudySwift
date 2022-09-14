//
//  SearchBar.swift
//  SearchDaumBlog
//
//  Created by 이진희 on 2022/09/06.
//

import UIKit
import RxSwift
import RxCocoa
import SnapKit
class SearchBar: UISearchBar {
    let disposeBag = DisposeBag()
    
    let searchButton = UIButton()
    
    //SearchBar 버튼 탭 이벤트
    let searchButtonTapped = PublishRelay<Void>() //onNext이벤트만 받음, 에러는 받지않음, 별다른 값이 전달되지 않고 탭이벤트만 전달되기때문에 Void
    
    //SearchBar 외부로 내보낼 이벤트
    var shouldLoadResult = Observable<String>.of("") //초기엔 아무값도 없기떄문에 of로 표현
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        bind()
        attribute()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() { //어떤 순간을 탭 되었다 할 수 있는가
        //searchVar search button tapped = 키보드의 엔터버튼
        //button tapped
        //위의 두가지는 동일하게 검색을 실행하므로 컴바인 오퍼레이터의 머지로 구현
        //옵져버블의 순서와 상관없이 어떤 옵져버블이든 발생되면 탭이벤트라고 봐야하기 떄문에 머지로 구현.
        Observable
            .merge(
                self.rx.searchButtonClicked.asObservable(), //asObservable로 옵져버블로 타입 변환
                searchButton.rx.tap.asObservable()
            )
            .bind(to: searchButtonTapped)
            .disposed(by: disposeBag)
        
        //이 탭 이벤트가 발생하면 어떠한 상황이 벌어지면 될까?
        //서치바의 이벤트의 경우 endEditing
        searchButtonTapped
            .asSignal()
            .emit(to: self.rx.endEditing)
            .disposed(by: disposeBag)
        
        //서치바가 트리거
        self.shouldLoadResult = searchButtonTapped
            .withLatestFrom(self.rx.text) {$1 ?? ""} //서치바의 텍스트를 내보내. 막약 없다면 nil값을 보내줘
            .filter{ !$0.isEmpty } //빈 값을 보내지 않도록 필터링
            .distinctUntilChanged() //동일한 조건을 계속해서 검색해서 불필요한 네트워크가 발생하지 않도록
    }
    
    private func attribute() {
        searchButton.setTitle("검색", for: .normal)
        searchButton.setTitleColor(.systemBlue, for: .normal)
        
    }
    
    private func layout() {
        addSubview(searchButton)
        searchTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.trailing.equalTo(searchButton.snp.leading).offset(-12)
            $0.centerY.equalToSuperview()
        }
        
        searchButton.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(12)
        }
    }
    
    
}
 
extension Reactive where Base: SearchBar { //키보드가 내려가게 해줌
    var endEditing: Binder<Void> {
        return Binder(base) { base, _ in
            base.endEditing(true)
            
        }
    }
}
