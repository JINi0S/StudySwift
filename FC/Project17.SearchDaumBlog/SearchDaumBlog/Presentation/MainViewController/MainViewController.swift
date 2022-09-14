//
//  MainViewController.swift
//  SearchDaumBlog
//
//  Created by 이진희 on 2022/09/06.
//
import RxSwift
import RxCocoa
import UIKit
import simd

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
   
    let searchBar = SearchBar()
    let listView = BlogListView()

    let alertActionTapped = PublishRelay<AlertAction>()
    
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super .init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        bind()
        attribute()
        layout()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func bind() {
        //네트워킹 작업
        let blogResult = searchBar.shouldLoadResult
            .flatMapLatest { query in
                SearchBlogNetwork().searchBlog(query: query)
            }
            .share()
        
        let blogValue = blogResult
            .compactMap { data -> DKBlog? in
                guard case .success(let value) = data else {
                    return nil
                }
                return value
            }
        
        let blogError = blogResult
            .compactMap { data -> String? in
                guard case .failure(let error) = data else {
                    return nil
                }
                return error.localizedDescription
            }
        
        //네트워크를 통해 가져온 값을 cellData로 변환
        let cellData = blogValue
            .map { blog -> [BlogListCellData] in
                return blog.documents
                    .map { doc in
                        let thumbnailURL = URL(string: doc.thumbnail ?? "")
                        return BlogListCellData (thumbnailURL: thumbnailURL, name: doc.name, title: doc.title, datetime: doc.datetime)
            }
            
        }
                
                
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
                sortedType, cellData
            ) { type, data -> [BlogListCellData] in
                switch type {
                case .title:
                    return data.sorted { $0.title ?? "" < $1.title ?? "" }
                case .datetime:
                    return data.sorted { $0.datetime ?? Date() > $1.datetime ?? Date()}
                default:
                    return data
                }
                
            }
            .bind(to: listView.cellData)
            .disposed(by: disposeBag)
        
        //리스트의 헤더뷰의 버튼이 탭되었을 때 우리가 원하는 방식으로 알럿이 표현 될 것
        let alertSheetForSorting = listView.headerView.sortButtonTapped
            .map { _ -> Alert in
                return Alert(title: nil, message: nil, actions: [.title, .datetime, .cancel], style: .actionSheet)
            }
        
        let alertForErrorMessage = blogError
            .map { message -> Alert in
                return (
                    title: "앗!",
                    message: "예상치 못한 오류가 발생했습니다. 잠시 후 다시 시도해주세요. \(message)",
                    actions: [.confirm],
                    style: .alert
                )
            }
        
        
        Observable
            .merge(alertSheetForSorting, alertForErrorMessage)
            .asSignal(onErrorSignalWith: .empty())
            .flatMapLatest { alert -> Signal<AlertAction> in //alert를 받아서 alertaction을 가지는 signal로 바꿔줄 것이다.
                let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: alert.style)
                return self.presentAlertController(alertController, actions: alert.actions)
            }
            .emit(to: alertActionTapped) //alertActionTapped와 연결
            .disposed(by: disposeBag)
    }
    
    private func attribute() {
        title = "다음 블로그 검색"
        view.backgroundColor = .white
    }

    private func layout() {
        [searchBar, listView].forEach { view.addSubview($0)}
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
        
        listView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

//Alert
extension MainViewController {
    typealias Alert = (title: String?, message: String?, actions: [AlertAction], style: UIAlertController.Style)
    
    enum AlertAction: AlertActionConvertible {
        case title, datetime, cancel
        case confirm
        
        var title: String {
            switch self {
            case .title:
                return "Title"
            case .datetime:
                return "Datetime"
            case .cancel:
                return "취소"
            case .confirm:
                return "확인"
                
            }
        }
        
        var style: UIAlertAction.Style {
            switch self {
            case .title, .datetime:
                return .default
            case .cancel, .confirm:
                return .cancel
            }
        }
    }
    func presentAlertController<Action: AlertActionConvertible>(_ alertController: UIAlertController, actions: [Action]) -> Signal<Action> {
        if actions.isEmpty {return .empty()} //만약 아무 액션이 없다면 empty 옵져버블을 내뱉어줘
        //그게 아니라면 = 빈 게 아니라면
        return Observable //옵져버블을 create로 만들어줘
            .create {[weak self] observer in
                guard let self = self else { return Disposables.create() }
                for action in actions { //액션을 받을때마다
                    alertController.addAction( //알럿 컨트롤러가 애드액션한다
                        UIAlertAction(
                            title: action.title,
                            style: action.style,
                            handler: { _ in
                                observer.onNext(action)
                                observer.onCompleted()
                            }
                        )
                    )
                }
                //해당 크래이트된 옵져버블이 생성완료된 다음에는 알럿컨트롤러가 사라질 수 있도록 크래이트 핸들러 안에 아래의 함수를 넣어줌
                self.present(alertController, animated: true, completion: nil)
                return Disposables.create {
                    alertController.dismiss(animated: true, completion:  nil)
                }
            }
            .asSignal(onErrorSignalWith: .empty()) //시그널로 바꿔줌
    }
}
