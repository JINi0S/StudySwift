//
//  MainViewController.swift
//  SearchDaumBlog
//
//  Created by 이진희 on 2022/09/06.
//
import RxSwift
import RxCocoa
import UIKit

class MainViewController: UIViewController {
    let disposeBag = DisposeBag()
   
    let searchBar = SearchBar()
    let listView = BlogListView()

    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super .init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        attribute()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func bind(_ viewModel: MainViewModel) {
        listView.bind(viewModel.blogListViewModel)
        searchBar.bind(viewModel.searchBarViewModel)
        
        viewModel.shouldPresentAlert
            .flatMapLatest { alert -> Signal<AlertAction> in //alert를 받아서 alertaction을 가지는 signal로 바꿔줄 것이다.
                let alertController = UIAlertController(title: alert.title, message: alert.message, preferredStyle: alert.style)
                return self.presentAlertController(alertController, actions: alert.actions)
            }
            .emit(to: viewModel.alertActionTapped) //alertActionTapped와 연결
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
            .create {[unowned self] observer in
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
