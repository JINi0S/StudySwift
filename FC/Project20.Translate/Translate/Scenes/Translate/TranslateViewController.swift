//
//  TranslateViewController.swift
//  Translate
//
//  Created by 이진희 on 2022/09/30.
//

import SnapKit
import UIKit

final class TranslateViewController: UIViewController {
    
    private var translatorManager = TranslatorManager()
   
    
    private lazy var sourceLanguageButton: UIButton = {
        let button  = UIButton()
        button.setTitle(translatorManager.sourceLanguage.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15.0, weight: .semibold)
        button.setTitleColor(.label, for: .normal)
        button.backgroundColor = .systemBackground
        button.layer.cornerRadius = 9.0
        
        button.addTarget(self, action: #selector(didTapSourceLanguageButton), for: .touchUpInside)
        return button
    }()
    
    private lazy var targetLanguageButton: UIButton = {
        let button = UIButton()
        button.setTitle(translatorManager.targetLanguage.title, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .semibold)
        button.layer.cornerRadius = 9.0
        button.backgroundColor = .systemBackground
        button.setTitleColor(.label, for: .normal)

        button.addTarget(self, action: #selector(didTapTargetLanguageButton), for: .touchUpInside)

        return button
    }()
    

    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.spacing = 8.0
        
        [sourceLanguageButton, targetLanguageButton]
            .forEach {stackView.addArrangedSubview($0)}
        
        //stackView.addArrangedSubview(sourceLanguageButton) //위에랑 동일한 기능의 코드
        //stackView.addArrangedSubview(targetLanguageButton)

        return stackView
    }()
    
    private lazy var resultBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        
        return view
    }()
    
    private lazy var resultLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 23.0, weight: .bold)
        label.textColor = UIColor.mainTintColor
        label.numberOfLines = 0

        return label
    }()
    
    private lazy var bookmarkButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "bookmark"), for: .normal)
        button.addTarget(self, action: #selector(didTapBookmarkButton), for: .touchUpInside)
        
        return button
    }()
    
    @objc func didTapBookmarkButton() {
        guard let sourceText = sourceLabel.text,
              let translatedText = resultLabel.text,
              bookmarkButton.imageView?.image == UIImage(systemName: "bookmark") //bookmark.fill == 북마크가 된 상태
        else { return }
        
        bookmarkButton.setImage(UIImage(systemName: "bookmark.fill"), for: .normal)
        
        let currentBookmarks: [Bookmark] = UserDefaults.standard.bookmarks
        let newBookmark = Bookmark(
            sourceLanguage: translatorManager.sourceLanguage,
            translatedLanguage: translatorManager.targetLanguage,
            sourceText: sourceText,
            translatedText: translatedText
        )
        
        UserDefaults.standard.bookmarks = [newBookmark] + currentBookmarks //이 순서로 해야 새로운 북마크가 상위로 뜸
        print(UserDefaults.standard.bookmarks)
        //Userdefaults에 저장하는 타이밍
    }
    
    private lazy var copyButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "doc.on.doc"), for: .normal)
        button.addTarget(self, action: #selector(didTapCopyButton), for: .touchUpInside)
        return button
    }()
    
    @objc func didTapCopyButton() {
        UIPasteboard.general.string = resultLabel.text
    }
    
    private lazy var sourceLabelBaseButton: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        let tabGesture = UITapGestureRecognizer(target: self, action: #selector(didTabSourceLabelBaseButton))
        view.addGestureRecognizer(tabGesture)
        
        return view
    }()
    
    private lazy var sourceLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("Enter_text", comment: "텍스트 입력")
        label.textColor = .tertiaryLabel
        label.numberOfLines = 0 //제한 없음 : 0
        label.font = .systemFont(ofSize: 23.0, weight: .semibold)
        
        return label
    }()
    
    override func viewDidLoad() {
        view.backgroundColor = .secondarySystemBackground
        
        setupViews()
    }
}

extension TranslateViewController: SourceTextViewControllerDelegate {
    func didEnterText(_ sourceText: String) {
        if sourceText.isEmpty { return }
        sourceLabel.textColor = .label
        sourceLabel.text = sourceText
        
        bookmarkButton.setImage(UIImage(systemName: "bookmark"), for: .normal)
        
        translatorManager.translate(from: sourceText){ [weak self] translatedText in
            
            self?.resultLabel.text = translatedText
        }
    }
}


private extension TranslateViewController {
    func setupViews() {
        [
            buttonStackView,
            resultBaseView,
            resultLabel,
            bookmarkButton,
            copyButton,
            sourceLabelBaseButton,
            sourceLabel
        ].forEach { view.addSubview($0)}
        
        let defaultSpacing: CGFloat = 16.0
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview().inset(defaultSpacing)
            $0.height.equalTo(50.0)
        }
        
        resultBaseView.snp.makeConstraints {
            $0.top.equalTo(buttonStackView.snp.bottom).offset(defaultSpacing)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bookmarkButton.snp.bottom).offset(defaultSpacing)
        }
        
        resultLabel.snp.makeConstraints {
            $0.leading.equalTo(resultBaseView.snp.leading).inset(24.0)
            $0.trailing.equalTo(resultBaseView.snp.trailing).inset(24.0)
            $0.top.equalTo(resultBaseView.snp.top).inset(24)

        }
        
        bookmarkButton.snp.makeConstraints {
            $0.leading.equalTo(resultLabel.snp.leading)
            $0.top.equalTo(resultLabel.snp.bottom).offset(24.0)
            $0.width.height.equalTo(40.0)
        }
        
        copyButton.snp.makeConstraints {
            $0.leading.equalTo(bookmarkButton.snp.trailing).inset(8)
            $0.top.equalTo(bookmarkButton.snp.top)
            $0.width.height.equalTo(40.0)
        }

        sourceLabelBaseButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(resultBaseView.snp.bottom).offset(defaultSpacing)
            $0.bottom.equalToSuperview().inset(tabBarController?.tabBar.frame.height ?? 0.0)
        }
        
        sourceLabel.snp.makeConstraints {
            $0.leading.equalTo(sourceLabelBaseButton.snp.leading).inset(24.0)
            $0.trailing.equalTo(sourceLabelBaseButton.snp.trailing).inset(24.0)
            $0.top.equalTo(sourceLabelBaseButton.snp.top).inset(24.0)

        }
    }
    
    @objc func didTabSourceLabelBaseButton() {
        let viewController = SourceTextViewController(delegate: self)
        present(viewController, animated: true)
    }
    
    
    @objc func didTapSourceLanguageButton() { didTapLanguageButton(type: .source)}
    
    @objc func didTapTargetLanguageButton() { didTapLanguageButton(type: .target)}
    
    func didTapLanguageButton(type: Type) {
        let alertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        Language.allCases.forEach { language in
            let action = UIAlertAction(title: language.title, style: .default, handler: { _ in
                switch type {
                case .source:
                    self.translatorManager.sourceLanguage = language
                    self.sourceLanguageButton.setTitle(language.title, for: .normal)
                case .target:
                    self.translatorManager.targetLanguage = language
                    self.targetLanguageButton.setTitle(language.title, for: .normal)

                }
                
            })
            alertController.addAction(action)

        }
        let cancelAction = UIAlertAction(title: NSLocalizedString("Cancel", comment: "취소"), style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        present(alertController, animated: true)
    }
}
