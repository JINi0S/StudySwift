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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        attribute()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: SearchBarViewModel) {
        self.rx.text
            .bind(to: viewModel.queryText)
            .disposed(by: disposeBag)
        Observable
            .merge(
                self.rx.searchButtonClicked.asObservable(), //asObservable로 옵져버블로 타입 변환
                searchButton.rx.tap.asObservable()
            )
            .bind(to: viewModel.searchButtonTapped)
            .disposed(by: disposeBag)
        
        //이 탭 이벤트가 발생하면 어떠한 상황이 벌어지면 될까?
        //서치바의 이벤트의 경우 endEditing
        viewModel.searchButtonTapped
            .asSignal()
            .emit(to: self.rx.endEditing)
            .disposed(by: disposeBag)
        
        //서치바가 트리거
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
