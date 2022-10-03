//
//  SourceTextViewController.swift
//  Translate
//
//  Created by 이진희 on 2022/10/01.
//

import UIKit

protocol SourceTextViewControllerDelegate: AnyObject {
    func didEnterText(_ sourceText: String)
}


final class SourceTextViewController: UIViewController  {
    private let placeholderText = NSLocalizedString("Enter_text", comment: "텍스트 입력")
    
    private weak var delegate: SourceTextViewControllerDelegate?
    
    private lazy var textView: UITextView = {
       
        let textView = UITextView()
        textView.text = placeholderText
        textView.textColor = .secondaryLabel
        textView.font = .systemFont(ofSize: 16, weight: .semibold)
        textView.returnKeyType = .done
        textView.delegate = self
        return textView
    }()
    init(delegate: SourceTextViewControllerDelegate? ){
        self.delegate = delegate
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        view.addSubview(textView)
        
        textView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(16)
        }
    }
}

extension SourceTextViewController: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        guard textView.textColor == .secondaryLabel else { return }//텍스트 컬러가 세컨더리라벨컬러가 아니면 리턴 그냥 라벨이면 맞으면 아래 라인..
        textView.text = nil
        textView.textColor = .label
    }
        
    //완료 키 값이 들어왔을 때 viewController dismiss
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        guard text == "\n" else { return true }
        delegate?.didEnterText(textView.text)
        dismiss(animated: true)
        return true
    }
    
}
