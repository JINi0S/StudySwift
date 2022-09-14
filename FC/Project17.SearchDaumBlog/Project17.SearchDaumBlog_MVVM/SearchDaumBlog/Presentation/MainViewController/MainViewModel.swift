//
//  MainViewModel.swift
//  SearchDaumBlog
//
//  Created by 이진희 on 2022/09/14.
//

import RxSwift
import RxCocoa

struct MainViewModel {
    let disposeBag = DisposeBag()
    
    let blogListViewModel = BlogListViewModel()
    let searchBarViewModel = SearchBarViewModel()
    
    let alertActionTapped = PublishRelay<MainViewController.AlertAction>()
    let shouldPresentAlert: Signal<MainViewController.Alert>
    
    init(model: MainModel = MainModel()) {
        let blogResult = searchBarViewModel.shouldLoadResult
            .flatMapLatest(model.searchBlog)
            .share()
        
        let blogValue = blogResult
            .compactMap(model.getBlogValue)
        
        let blogError = blogResult
            .compactMap(model.getBlogError)
        
        //네트워크를 통해 가져온 값을 cellData로 변환
        let cellData = blogValue
            .map(model.getBlogListCellData)
                
        //FilterView를 선택했을 때 나오는 alert sheet를 선택했을 때 type
        let sortedType = alertActionTapped
            .filter {
                switch $0 {
                case .title, .datetime:
                    return true
                default:
                    return false
                }
            }
            .startWith(.title) //아무도 저 필터를 건드리지 않으면 초기값은 타이틀 값이다
        
        //MainViewController -> ListView
        Observable
            .combineLatest(
                sortedType,
                cellData,
                resultSelector: model.sort
            )
            .bind(to: blogListViewModel.blogListCellData)
            .disposed(by: disposeBag)

        
        //리스트의 헤더뷰의 버튼이 탭되었을 때 우리가 원하는 방식으로 알럿이 표현 될 것
        let alertSheetForSorting = blogListViewModel.filterViewModel.sortButtonTapped
            .map { _ -> MainViewController.Alert in
                return (title: nil, message: nil, actions: [.title, .datetime, .cancel], style: .actionSheet)
            }
        
        let alertForErrorMessage = blogError
            .map { message -> MainViewController.Alert in
                return (
                    title: "앗!",
                    message: "예상치 못한 오류가 발생했습니다. 잠시 후 다시 시도해주세요. \(message)",
                    actions: [.confirm],
                    style: .alert
                )
            }
        self.shouldPresentAlert = Observable
            .merge(alertSheetForSorting, alertForErrorMessage)
            .asSignal(onErrorSignalWith: .empty())
        
    }
}
