//
//  BookmarkCollectionViewCell.swift
//  Translate
//
//  Created by 이진희 on 2022/10/03.
//

import SnapKit
import UIKit

final class BookmarkCollectionViewCell: UICollectionViewCell {
    static let identifier = "BookmarkCollectionViewCell"
    
    //private var sourceBookmarkTextStackView = BookmarkTextStackView(language: .ko, text: "ㅣㅣ", type: .source)
    //private var targetBookmarkTextStackView = BookmarkTextStackView(language: .ko, text: "ㅎㅎ", type: .source)
    
    private var sourceBookmarkTextStackView : BookmarkTextStackView!
    private var targetBookmarkTextStackView : BookmarkTextStackView!
    
    private lazy var stackView : UIStackView = {
        let inset = CGFloat(16.0)
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        stackView.spacing = inset
        stackView.layoutMargins = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        stackView.isLayoutMarginsRelativeArrangement = true
        return stackView
    }()
    
    func setup(from bookmark: Bookmark ) {
        backgroundColor = .systemBackground
        layer.cornerRadius = 12.0
        addSubview(stackView)
        
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalTo(UIScreen.main.bounds.width - 32.0)
        }
        
        
        
        sourceBookmarkTextStackView = BookmarkTextStackView(
            language: bookmark.sourceLanguage,
            text: bookmark.sourceText,
            type: .source)
        targetBookmarkTextStackView = BookmarkTextStackView(
            language: bookmark.translatedLanguage,
            text: bookmark.translatedText,
            type: .target)
        
        //cell을 재사용하는 과정에서 잔상이 남아 collection뷰가 제대로 표시 되지 않는 문제를 해결하기 위해 서브뷰들을 지우고 다시 그린다
        stackView.subviews.forEach { $0.removeFromSuperview() }
        [sourceBookmarkTextStackView, targetBookmarkTextStackView].forEach { stackView.addArrangedSubview($0) }

    
        layoutIfNeeded()
    }
}
